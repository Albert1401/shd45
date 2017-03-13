{
module Tokens where
}

%wrapper "basic"

$digit = 0-9

tokens :-

  $white+                   ;
  \&                        { \s -> TokenConj }
  \|                        { \s -> TokenDisj }
  \-\>                      { \s -> TokenImpl }
  \(                        { \s -> TokenLParen }
  \)                        { \s -> TokenRParen }
  0                        { \s -> TokenZero }
  [a-z][0-9]*               { \s -> TokenName1 s }
  [A-Z][0-9]*               { \s -> TokenName2 s}
  \+                        { \s -> TokenPlus }
  \*                        { \s -> TokenMult }
  \-                        { \s -> TokenMinus }
  \=                        { \s -> TokenEq }
  \!                        { \s -> TokenNeg }
  \'                        { \s -> TokenInc }
  \@                        { \s -> TokenQtfrAll }
  \?                        { \s -> TokenQtfrOne }
  \,                        { \s -> TokenComma }

{
data Token = TokenConj
           | TokenZero
           | TokenDisj
           | TokenImpl
           | TokenComma
           | TokenNeg
           | TokenLParen
           | TokenRParen
           | TokenName1 String
           | TokenName2 String
           | TokenPlus
           | TokenMinus
           | TokenInc
           | TokenEq
           | TokenQtfrAll
           | TokenQtfrOne
           | TokenMult
           deriving (Eq,Show)

scanTokens = alexScanTokens
}