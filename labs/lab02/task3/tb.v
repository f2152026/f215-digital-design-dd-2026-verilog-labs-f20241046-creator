// tb.v

module tb;

  reg [1:0] t_a;
  reg [1:0] t_b;

  wire t_gt;
  wire t_lt;
  wire t_eq;

  reg exp_gt;
  reg exp_lt;
  reg exp_eq;

  integer errors;
  integer total;
  integer i;
  integer j;

  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
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

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin

        t_a = i;
        t_b = j;

        #1;

        // Compute expected results independently
        exp_gt = (i > j);
        exp_lt = (i < j);
        exp_eq = (i == j);

        total = total + 1;

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end

      end
    end

    $display("Summary: %0d passed out of %0d total, %0d errors",
             total - errors, total, errors);

    $finish;
  end

endmodule