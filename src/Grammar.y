{
module Grammar where
import Tokens
}

%name parseExpr
%tokentype { Token }
%error { parseError }

%token
    lowname { TokenName1 $$ }
    upname  { TokenName2 $$ }
    '&'     { TokenConj }
    '|'     { TokenDisj }
    '->'    { TokenImpl }
    '('     { TokenLParen }
    ')'     { TokenRParen }
    '+'      { \s -> TokenPlus }
    '-'     { \s -> TokenMinus }
    '='      { \s -> TokenEq }
    '''      { \s -> TokenInc }
    '!'      { \s -> TokenNeg }
    '@'      { \s -> TokenQtfrAll }
    '?'      { \s -> TokenQtfrOne }
    '0'      { \s -> TokenZero}


%%

%right '->'
%left '|'
%left '&'
%right '!'
%nonassoc '@' '?'

%nonassoc '='
%left '+' '-'
%right '''

Exp : '@' lowname Fact                   { QtdrAll (Var $2) $3 }
    | '?' lowname Fact                   { QtdrOne (Var $2) $3 }
    | Term '=' Term                      { Eq $1 $3}
    | Exp '->' Exp                       { Impl $1 $3 }
    | Exp '|' Exp                        { Disj $1 $3 }
    | Exp '&' Exp                        { Conj $1 $3 }

Fact :
    | upname '(' args ')'                { Pred $1 $2 }
    | '!' Fact                           { Neg $2 }
    | '(' Exp ')'                        { $2 }

args : {- empty -}          { [] }
    | Term ',' args         { $1 : $3 }

Term : Term '+' Term         { Plus $1 $3 }
    | Term '-' Term          { Minus $1 $3 }
    | Term '''               { Inc $1 }
    | lowname stub           { Funct }
    | '(' Term ')'           { $2 }
    | '0'                    { Zero }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Expr = Impl Expr Expr
         | Conj Expr Expr
         | Disj Expr Expr
         | Neg Expr
         | Pred [Expr]
         | Funct [Expr]
         | QtfrAll Var Expr
         | QtfrOne Var Expr
         | Eq Expr Expr
         | Inc Expr
         | Plus Expr Expr
         | Minus Expr Expr
         | Var String
         | Zero
         deriving (Show, Eq)
}