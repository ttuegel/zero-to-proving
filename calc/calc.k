module CALC-SYNTAX
  import INT-SYNTAX

  syntax Int ::= Int "+" Int [function]
  syntax Int ::= Int "*" Int [function]
  syntax Int ::= Int "/" Int [function]
  syntax Int ::= Int "-" Int [function]
  syntax Int ::= Int "^" Int [function]

  syntax Int ::= "(" Int ")" [bracket]
endmodule

module CALC
  import CALC-SYNTAX
  import INT

  rule X + Y => X +Int Y
  rule X * Y => X *Int Y
  rule X / Y => X /Int Y
  rule X - Y => X -Int Y
  rule X ^ Y => X ^Int Y
endmodule