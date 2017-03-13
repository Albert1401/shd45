module Test where
import Grammar
import Tokens
import qualified Data.HashMap.Strict as Map
import qualified Data.Vector as Vect
import qualified Data.HashSet as Set
import Checker
import Control.Monad.State

parse = parseExpr . scanTokens
mptstbase = Vect.fromList $ zip (map parse["Q(a)->?aQ(a)"
                    ,"(Q(a)->?aQ(a))->P(a)->(Q(a)->?aQ(a))"
                    ]) ([1..] :: [Int])

mptest = parse "P(c)->(Q1(b,h,g,d,q)->?aQ(a))"

mpallbase = Vect.fromList $ zip (map parse["(A->A->A)->P(a)"
                                ]) ([1..] :: [Int])
mpalltest = parse "(A->A->A)->@xP(a)"

is11test = parse "P(a+g+r+j*j*j''')->?xP(x)"

aaa = parse "@b?bP(f(b,b))->?bP(f(a,b))"

aa = parse "?bP(f(b,b))"
aa' = parse "?bP(f(a,b))"