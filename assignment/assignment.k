module ASSIGNMENT-SYNTAX
  import INT-SYNTAX
  import BOOL-SYNTAX
  import ID-SYNTAX

  syntax Exp ::= IntExp | BoolExp

  syntax KResult ::= Int | Bool

  syntax IntExp ::= Int
  syntax IntExp ::= Id
  syntax IntExp ::= "(" IntExp ")" [bracket]

  syntax IntExp ::= IntExp "+" IntExp [seqstrict]
  syntax IntExp ::= IntExp "*" IntExp [seqstrict]
  syntax IntExp ::= IntExp "/" IntExp [seqstrict]
  syntax IntExp ::= IntExp "-" IntExp [seqstrict]
  syntax IntExp ::= IntExp "^" IntExp [seqstrict]

  syntax BoolExp ::= Bool
  syntax BoolExp ::= "(" BoolExp ")" [bracket]

  syntax BoolExp ::= IntExp "<"  IntExp [seqstrict]
  syntax BoolExp ::= IntExp "<=" IntExp [seqstrict]
  syntax BoolExp ::= IntExp ">"  IntExp [seqstrict]
  syntax BoolExp ::= IntExp ">=" IntExp [seqstrict]
  syntax BoolExp ::= IntExp "==" IntExp [seqstrict]
  syntax BoolExp ::= IntExp "!=" IntExp [seqstrict]

  syntax BoolExp ::= BoolExp "&&" BoolExp [seqstrict]
  syntax BoolExp ::= BoolExp "||" BoolExp [seqstrict]

  syntax Stmt ::= Id "=" IntExp ";" [strict(2)]
  syntax Stmt ::= Stmt Stmt [left]

endmodule

module ASSIGNMENT
  import ASSIGNMENT-SYNTAX
  import INT
  import MAP

  configuration
    <k> $PGM:Stmt </k>
    <mem> .Map </mem>

  rule
    <k> ID:Id => {M[ID]}:>Int ... </k>
    <mem> M </mem>

  rule <k> X + Y => X +Int Y ... </k>
  rule <k> X * Y => X *Int Y ... </k>
  rule <k> X / Y => X /Int Y ... </k>
  rule <k> X - Y => X -Int Y ... </k>
  rule <k> X ^ Y => X ^Int Y ... </k>

  rule <k> X <  Y => X   <Int Y ... </k>
  rule <k> X <= Y => X  <=Int Y ... </k>
  rule <k> X >  Y => X   >Int Y ... </k>
  rule <k> X >= Y => X  >=Int Y ... </k>
  rule <k> X == Y => X  ==Int Y ... </k>
  rule <k> X != Y => X =/=Int Y ... </k>

  rule <k> X && Y => X andBool Y ... </k>
  rule <k> X || Y => X  orBool Y ... </k>

  rule
    <k> ID = I:Int ; => . ... </k>
    <mem> M => M[ID <- I] </mem>

  rule
    <k> S1:Stmt S2:Stmt => S1 ~> S2 ... </k>
endmodule