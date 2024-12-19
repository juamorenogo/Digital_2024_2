/*
 * Generated by Digital. Don't modify this file!
 * Any changes will be lost if this file is regenerated.
 */

module CircuitoFinal_NAND (
  input R,
  input B,
  input S,
  input E,
  output Energia,
  output IBB,
  output IRD,
  output IS,
  output \1_B ,
  output \1_S ,
  output \1_R 
);
  wire s0;
  wire s1;
  wire s2;
  wire s3;
  wire s4;
  wire s5;
  assign Energia = ~ (~ (B & ~ (E & E)) & ~ (~ (E & E) & S) & ~ (~ (E & E) & R));
  assign s0 = ~ (~ (~ (S | B) & ~ (S | B)) & ~ (R & R));
  assign s1 = ~ (~ (S & S) & B);
  assign s2 = ~ (s1 & s1);
  assign s3 = ~ (s0 & s0);
  assign s4 = ~ (s2 & s3);
  assign s5 = ~ (~ (s2 & s2) & s3);
  assign \1_B  = ~ (s4 & s4);
  assign \1_S  = ~ (s5 & s5);
  assign IBB = B;
  assign IRD = R;
  assign IS = S;
  assign \1_R  = R;
endmodule