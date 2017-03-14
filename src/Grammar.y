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
    '+'      { TokenPlus }
    '-'     { TokenMinus }
    '='      { TokenEq }
     q        { TokenInc }
    '!'      { TokenNeg }
    '@'      { TokenQtfrAll }
    '?'      { TokenQtfrOne }
    '0'      { TokenZero }
    '*'      { TokenMult }
    ','      { TokenComma }


%right '->'
%left '|'
%left '&'
%right '!'

%nonassoc '='
%left '+' '-'
%left '*'
%right q
%%


Exp : Exp '->' Exp                       { BinOp '>' $1 $3 }
    | Exp '|' Exp                        { BinOp '|' $1 $3 }
    | Exp '&' Exp                        { BinOp '&' $1 $3 }
    | Fact                               { $1 }

Fact : Term '=' Term                      { BinOp '=' $1 $3}
    | '@' lowname Fact                   { Qtfr '@' (Var $2) $3 }
    | '?' lowname Fact                   { Qtfr '?' (Var $2) $3 }
    | upname '(' args ')'                { Funct 'P' $1 $3 }
    | upname                             { Funct 'P' $1 [] }
    | '!' Fact                           { UnOp '!' $2 }
    | '(' Exp ')'                        { $2 }

args : {- empty -}          { [] }
    | Term                  { [$1] }
    | Term ',' args         { $1 : $3 }

Term : Term '+' Term         { BinOp '+' $1 $3 }
    | Term '-' Term          { BinOp '-' $1 $3 }
    | Term '*' Term          { BinOp '*' $1 $3 }
    | Term q                 { UnOp 'q' $1 }
    | lowname '(' args ')'   { Funct 'f' $1 $3 }
    | '(' Term ')'           { $2 }
    | lowname                { Var $1 }
    | '0'                    { Zero }

{

parseError :: [Token] -> a
parseError ts = error $ "Parse error" ++ "\n" ++ show ts

h [a] = show a
h (a:as) = show a ++ "," ++ h as

data Expr = BinOp Char Expr Expr
         | UnOp Char Expr
         | Funct Char String [Expr]
         | Qtfr Char Expr Expr
         | Var String
         | Zero
         deriving Eq

instance Show Expr where
    --lazyness
    show (BinOp '>' a b) = "(" ++ show a ++ "->" ++ show b ++ ")"
    show (BinOp op a b) = "(" ++ show a ++ [op] ++ show b ++ ")"
    show (Funct _ a []) = a
    show (Funct _ a b) = a ++ "(" ++ h b ++ ")"
    show (Qtfr ch a b) = [ch] ++ show a ++ "(" ++ show b ++ ")"
    show (UnOp '!' a) = "!" ++ "(" ++ show a ++ ")"
    show (UnOp 'q' a) = "(" ++ show a ++ ")" ++ "'"
    show (Var a) = a
    show Zero = "0"
}