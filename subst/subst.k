module SUBST-SYNTAX
  import INT-SYNTAX
  import BOOL-SYNTAX

  syntax Exp ::= IntExp | BoolExp

  syntax IntExp ::= Int
  syntax IntExp ::= IntExp "+" IntExp [function]
  syntax IntExp ::= IntExp "*" IntExp [function]
  syntax IntExp ::= IntExp "/" IntExp [function]
  syntax IntExp ::= IntExp "-" IntExp [function]
  syntax IntExp ::= IntExp "^" IntExp [function]

  syntax IntExp ::= "(" IntExp ")" [bracket]

  syntax BoolExp ::= Bool
  syntax BoolExp ::= IntExp "<" IntExp [function]
  syntax BoolExp ::= IntExp "<=" IntExp [function]
  syntax BoolExp ::= IntExp ">" IntExp [function]
  syntax BoolExp ::= IntExp ">=" IntExp [function]
  syntax BoolExp ::= IntExp "==" IntExp [function]
  syntax BoolExp ::= IntExp "!=" IntExp [function]

  syntax BoolExp ::= BoolExp "&&" BoolExp [function]
  syntax BoolExp ::= BoolExp "||" BoolExp [function]

  syntax BoolExp ::= "(" BoolExp ")" [bracket]
endmodule

module SUBST
  import SUBST-SYNTAX
  import INT

  configuration
    <k> $PGM:Exp </k>

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