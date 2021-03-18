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
    <mem>
      #token("a", "Id") |-> 23
      #token("b", "Id") |-> 2
      #token("c", "Id") |-> 3
      #token("d", "Id") |-> 2
    </mem>

  rule
    <k> E:IntExp => substInt(M, E) ... </k>
    <mem> M </mem>
    requires notBool isInt(E)

  rule
    <k> E:BoolExp => substBool(M, E) ... </k>
    <mem> M </mem>
    requires notBool isBool(E)

  syntax Int ::= substInt(Map, IntExp) [function]
  rule substInt(_, I:Int) => I
  rule substInt(M, X:Id) => {M[X]}:>Int

  rule substInt(M, X + Y) => substInt(M, X) +Int substInt(M, Y)
  rule substInt(M, X * Y) => substInt(M, X) *Int substInt(M, Y)
  rule substInt(M, X / Y) => substInt(M, X) /Int substInt(M, Y)
  rule substInt(M, X - Y) => substInt(M, X) -Int substInt(M, Y)
  rule substInt(M, X ^ Y) => substInt(M, X) ^Int substInt(M, Y)

  syntax Bool ::= substBool(Map, BoolExp) [function]
  rule substBool(_, B:Bool) => B

  rule substBool(M, X <  Y) => substInt(M, X) <Int   substInt(M, Y)
  rule substBool(M, X <= Y) => substInt(M, X) <=Int  substInt(M, Y)
  rule substBool(M, X >  Y) => substInt(M, X) >Int   substInt(M, Y)
  rule substBool(M, X >= Y) => substInt(M, X) >=Int  substInt(M, Y)
  rule substBool(M, X == Y) => substInt(M, X) ==Int  substInt(M, Y)
  rule substBool(M, X != Y) => substInt(M, X) =/=Int substInt(M, Y)

  rule substBool(M, X && Y) => substBool(M, X) andBool substBool(M, Y)
  rule substBool(M, X || Y) => substBool(M, X) orBool substBool(M, Y)
endmodule