module CALC-BOOL-SYNTAX
  import INT-SYNTAX
  import BOOL-SYNTAX

  syntax Val ::= Int | Bool

  syntax Int ::= Int "+" Int [function]
  syntax Int ::= Int "*" Int [function]
  syntax Int ::= Int "/" Int [function]
  syntax Int ::= Int "-" Int [function]
  syntax Int ::= Int "^" Int [function]

  syntax Int ::= "(" Int ")" [bracket]

  syntax Bool ::= Int "<" Int [function]
  syntax Bool ::= Int "<=" Int [function]
  syntax Bool ::= Int ">" Int [function]
  syntax Bool ::= Int ">=" Int [function]
  syntax Bool ::= Int "==" Int [function]
  syntax Bool ::= Int "!=" Int [function]

  syntax Bool ::= Bool "&&" Bool [function]
  syntax Bool ::= Bool "||" Bool [function]

  syntax Bool ::= "(" Bool ")" [bracket]
endmodule

module CALC-BOOL
  import CALC-BOOL-SYNTAX
  import INT

  rule X + Y => X +Int Y
  rule X * Y => X *Int Y
  rule X / Y => X /Int Y
  rule X - Y => X -Int Y
  rule X ^ Y => X ^Int Y

  rule X < Y => X <Int Y
  rule X <= Y => X <=Int Y
  rule X > Y => X >Int Y
  rule X >= Y => X >=Int Y
  rule X == Y => X ==Int Y
  rule X != Y => X =/=Int Y

  rule X && Y => X andBool Y
  rule X || Y => X orBool Y
endmodule