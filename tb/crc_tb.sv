module crc_tb_top();
  
  logic clk;
  logic rst;
  logic [7:0] data;
  logic [3:0] divisor;
  logic [10:0] received_data;
  logic [10:0] transmitted_data;
  logic valid;
  logic error;
  bit stimulus_done;

  crc_top crc_top_inst(
    .clk(clk),
    .rst(rst),
    .data(data),
    .divisor(divisor),
    .received_data(received_data),
    .transmitted_data(transmitted_data),
    .valid(valid),
    .error(error)
  );

  class stimulus_gen;

    task stimulus();

      $display("");
      $display("============================================================");
      $display("                    NORMAL CRC TEST");
      $display("============================================================");

      repeat(100) begin

        @(negedge clk);

        wait(!rst);

        data = $urandom_range(8'h00, 8'hFF);
        divisor = $urandom_range(4'h1, 4'hF);

        @(negedge clk);

        received_data = transmitted_data;

        @(posedge clk);

        #1;

        $display("DATA = %b | DIVISOR = %b | TRANSMITTED = %b | RECEIVED = %b | VALID = %b | ERROR = %b",
                 data,
                 divisor,
                 transmitted_data,
                 received_data,
                 valid,
                 error);

      end

      stimulus_done = 1'b1;

      $display("");
      $display("Stimulus generation completed at time=%0t", $time);

    endtask
  endclass


  class rst_test;

    int rst_on_cycles;
    int rst_off_cycles;

    task reset_test();

      repeat(5) begin

        rst = 1'b0;

        rst_off_cycles = $urandom_range(15,20);

        repeat(rst_off_cycles)
          @(posedge clk);

        rst = 1'b1;

        rst_on_cycles = $urandom_range(8,12);

        repeat(rst_on_cycles)
          @(posedge clk);

      end

      rst = 1'b0;

      $display("Reset test completed at time=%0t",$time);

    endtask
  endclass


  class error_test;

    int error_bit;

    task error_test_run();

      $display("");
      $display("============================================================");
      $display("                    CRC ERROR TEST");
      $display("============================================================");

      repeat(20) begin

        @(negedge clk);

        wait(!rst);

        data = $urandom_range(8'h00, 8'hFF);
        //divisor = $urandom_range(4'h1, 4'hF);
        divisor = 4'b1011;

        @(posedge clk);

        @(negedge clk);

        received_data = transmitted_data;
        error_bit = $urandom_range(0,10);
        received_data[error_bit] = ~received_data[error_bit];
        @(posedge clk);

        #1;

        $display("------------------------------------------------------------");
        $display("TIME              : %0t", $time);
        $display("DATA              : %b", data);
        $display("DIVISOR           : %b", divisor);
        $display("TRANSMITTED_DATA  : %b", transmitted_data);
        $display("ERROR BIT         : %0d", error_bit);
        $display("RECEIVED_DATA     : %b", received_data);
        $display("VALID             : %b", valid);
        $display("ERROR             : %b", error);
        $display("------------------------------------------------------------");

      end

      $display("");
      $display("CRC Error Test Completed at time=%0t", $time);

    endtask
  endclass
  
  
  class coverage;

    parameter int DATA_WIDTH = 8;
    parameter int DIVISOR_WIDTH = 4;
    parameter int TOTAL_WIDTH = DATA_WIDTH + DIVISOR_WIDTH - 1;

    logic [DATA_WIDTH-1:0] cov_data;
    logic [DIVISOR_WIDTH-1:0] cov_divisor;
    logic [TOTAL_WIDTH-1:0] cov_received_data;
    logic [TOTAL_WIDTH-1:0] cov_transmitted_data;
    logic cov_valid;
    logic cov_error;

    covergroup crc_coverage;

      DATA: coverpoint cov_data {
        bins DATA_0 = {[8'h00:8'h3F]};
        bins DATA_1 = {[8'h40:8'h7F]};
        bins DATA_2 = {[8'h80:8'hBF]};
        bins DATA_3 = {[8'hC0:8'hFF]};
      }

      DIVISOR: coverpoint cov_divisor {
        bins DIVISOR_0 = {[4'h1:4'h3]};
        bins DIVISOR_1 = {[4'h4:4'h7]};
        bins DIVISOR_2 = {[4'h8:4'hB]};
        bins DIVISOR_3 = {[4'hC:4'hF]};
      }

      RECEIVED_DATA: coverpoint cov_received_data {
        bins RX_0 = {[11'h000:11'h0FF]};
        bins RX_1 = {[11'h100:11'h1FF]};
        bins RX_2 = {[11'h200:11'h2FF]};
        bins RX_3 = {[11'h300:11'h3FF]};
        bins RX_4 = {[11'h400:11'h7FF]};
      }

      TRANSMITTED_DATA: coverpoint cov_transmitted_data {
        bins TX_0 = {[11'h000:11'h0FF]};
        bins TX_1 = {[11'h100:11'h1FF]};
        bins TX_2 = {[11'h200:11'h2FF]};
        bins TX_3 = {[11'h300:11'h3FF]};
        bins TX_4 = {[11'h400:11'h7FF]};
      }

      VALID: coverpoint cov_valid {
        bins VALID_0 = {0};
        bins VALID_1 = {1};
      }

      ERROR: coverpoint cov_error {
        bins ERROR_0 = {0};
        bins ERROR_1 = {1};
      }

      DATA_X_DIVISOR: cross DATA, DIVISOR;

    endgroup

    function new();
      crc_coverage = new();
    endfunction

    task sample();
      cov_data = data;
      cov_divisor = divisor;
      cov_received_data = received_data;
      cov_transmitted_data = transmitted_data;
      cov_valid = valid;
      cov_error = error;

      crc_coverage.sample();
    endtask
  endclass
  
  
  class final_report;

    coverage coverage_h;

    function new(coverage coverage_h);
      this.coverage_h = coverage_h;
    endfunction

    task report();

      real overall_coverage;
      real data_coverage;
      real divisor_coverage;
      real received_data_coverage;
      real transmitted_data_coverage;
      real valid_coverage;
      real error_coverage;
      real data_divisor_coverage;

      overall_coverage = coverage_h.crc_coverage.get_coverage();
      data_coverage = coverage_h.crc_coverage.DATA.get_coverage();
      divisor_coverage = coverage_h.crc_coverage.DIVISOR.get_coverage();
      received_data_coverage = coverage_h.crc_coverage.RECEIVED_DATA.get_coverage();
      transmitted_data_coverage = coverage_h.crc_coverage.TRANSMITTED_DATA.get_coverage();
      valid_coverage = coverage_h.crc_coverage.VALID.get_coverage();
      error_coverage = coverage_h.crc_coverage.ERROR.get_coverage();
      data_divisor_coverage = coverage_h.crc_coverage.DATA_X_DIVISOR.get_coverage();

      $display("");
      $display("============================================================");
      $display("                 CRC VERIFICATION REPORT");
      $display("============================================================");

      $display("");
      $display("COVERAGE REPORT");
      $display("------------------------------------------------------------");
      $display("DATA                  : %0.2f%%",data_coverage);
      $display("DIVISOR               : %0.2f%%",divisor_coverage);
      $display("RECEIVED_DATA         : %0.2f%%",received_data_coverage);
      $display("TRANSMITTED_DATA      : %0.2f%%",transmitted_data_coverage);
      $display("VALID                 : %0.2f%%",valid_coverage);
      $display("ERROR                 : %0.2f%%",error_coverage);
      $display("DATA_X_DIVISOR        : %0.2f%%",data_divisor_coverage);
      $display("------------------------------------------------------------");
      $display("OVERALL COVERAGE      : %0.2f%%",overall_coverage);

      $display("");
      $display("============================================================");

    endtask
  endclass
  
  
  stimulus_gen stimulus_h;
  error_test error_test_h;
  coverage coverage_h;
  final_report final_report_h;

  initial begin
    clk = 1'b1;
    forever #10 clk = ~clk;
  end

  initial begin
    rst = 1'b1;
    repeat(2)
      @(posedge clk);
    rst = 1'b0;
  end
  

  initial begin
    stimulus_h = new();
    error_test_h = new();
    coverage_h = new();
    
    data = '0;
    divisor = '0;
    received_data = '0;

    wait(!rst);

    stimulus_h.stimulus();

    error_test_h.error_test_run();
    
    repeat(2) @(posedge clk);

    final_report_h = new(coverage_h);
    final_report_h.report();

    $finish;
  end

  always @(posedge clk) begin
    if (!rst)
      coverage_h.sample();
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
