module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

  wire [3:0] t_result;

  reg [3:0] expected;

  integer errors;
  integer total;
  integer a_val;
  integer b_val;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  // Waveform dump configuration

  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    total = 0;

    // Test all operand combinations for addition
    for (a_val = 0; a_val < 16; a_val = a_val + 1) begin
      for (b_val = 0; b_val < 16; b_val = b_val + 1) begin

        t_a = a_val;
        t_b = b_val;
        t_op = 0;

        #1;

        expected = a_val + b_val;
        total = total + 1;

        if (t_result !== expected) begin
          $display("FAIL ADD: A=%d B=%d got=%d expected=%d",
                   t_a, t_b, t_result, expected);
          errors = errors + 1;
        end

      end
    end

    // Test all operand combinations for subtraction
    for (a_val = 0; a_val < 16; a_val = a_val + 1) begin
      for (b_val = 0; b_val < 16; b_val = b_val + 1) begin

        t_a = a_val;
        t_b = b_val;
        t_op = 1;

        #1;

        expected = a_val - b_val;
        total = total + 1;

        if (t_result !== expected) begin
          $display("FAIL SUB: A=%d B=%d got=%d expected=%d",
                   t_a, t_b, t_result, expected);
          errors = errors + 1;
        end

      end
    end

    $display("Summary: %0d passed out of %0d total, %0d errors",
             total - errors, total, errors);

    $finish;
  end

endmodule