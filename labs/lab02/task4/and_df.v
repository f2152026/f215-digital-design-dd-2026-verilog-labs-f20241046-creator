module and_df (
  input  a,
  input  b,
  output wire y
);

  assign #3 y = a & b;

endmodule