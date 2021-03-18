module SUBST-SYNTAX
  import INT-SYNTAX
  import BOOL-SYNTAX
  import ID-SYNTAX

  syntax Exp ::= IntExp | BoolExp

  syntax IntExp ::= Int
  syntax IntExp ::= Id
  syntax IntExp ::= "(" IntExp ")" [bracket]

  syntax IntExp ::= IntExp "+" IntExp
  syntax IntExp ::= IntExp "*" IntExp
  syntax IntExp ::= IntExp "/" IntExp
  syntax IntExp ::= IntExp "-" IntExp
  syntax IntExp ::= IntExp "^" IntExp

  syntax BoolExp ::= Bool
  syntax BoolExp ::= "(" BoolExp ")" [bracket]

  syntax BoolExp ::= IntExp "<" IntExp
  syntax BoolExp ::= IntExp "<=" IntExp
  syntax BoolExp ::= IntExp ">" IntExp
  syntax BoolExp ::= IntExp ">=" IntExp
  syntax BoolExp ::= IntExp "==" IntExp
  syntax BoolExp ::= IntExp "!=" IntExp

  syntax BoolExp ::= BoolExp "&&" BoolExp
  syntax BoolExp ::= BoolExp "||" BoolExp

endmodule

module SUBST
  import SUBST-SYNTAX
  import INT
  import MAP

  configuration
    <k> $PGM:Exp </k>
    <mem> .Map </mem>

  rule <k> E:IntExp => substInt(E) ... </k> requires notBool isInt(E)

  syntax Int ::= substInt(IntExp) [function]
  rule substInt(I:Int) => I
  rule substInt(_:Id) => 0

  rule substInt(X + Y) => substInt(X) +Int substInt(Y)
  rule substInt(X * Y) => substInt(X) *Int substInt(Y)
  rule substInt(X / Y) => substInt(X) /Int substInt(Y)
  rule substInt(X - Y) => substInt(X) -Int substInt(Y)
  rule substInt(X ^ Y) => substInt(X) ^Int substInt(Y)

  rule X < Y => X <Int Y
  rule X <= Y => X <=Int Y
  rule X > Y => X >Int Y
  rule X >= Y => X >=Int Y
  rule X == Y => X ==Int Y
  rule X != Y => X =/=Int Y

  rule X && Y => X andBool Y
  rule X || Y => X orBool Y
endmodule