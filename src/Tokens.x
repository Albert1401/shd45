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
  [a-z][0-9]*               { \s -> TokenName1 s }
  [A-Z][0-9]*               { \s -> TokenName2 s}
  \+                        { \s -> TokenPlus }
  \-                        { \s -> TokenMinus }
  \=                        { \s -> TokenEq }
  \!                        { \s -> TokenNeg }
  \'                        { \s -> TokenInc }
  \@                        { \s -> TokenQtfrAll }
  \?                        { \s -> TokenQtfrOne }
  \1                        { \s -> TokenZero}
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
           deriving (Eq,Show)

scanTokens = alexScanTokens
}