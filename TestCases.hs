module TestCases
  where


import Test.HUnit
import Moves


-- Testcases:
--testBoard :: [Square]
testBoard = [Empty, Empty, White Rook, White Pawn, Black Pawn, Empty, Empty, Empty,
             White Knight, White Pawn, Empty, Empty, Black Pawn, Empty, Empty, Empty,
             White Bishop, Empty, White Queen, Empty, Empty, Black Rook, Empty, Empty,
             Empty, Empty, Empty, Empty, Empty, Empty, Black Pawn, Black King, 
             White King, Empty, Empty, White Pawn, Empty, Empty, Empty, Empty, 
             Empty, Empty, Empty, Empty, Empty, Empty, Black King, Empty, 
             Empty, Black Queen, Empty, Empty, White Knight, Black Pawn, Black Rook, 
             Empty, Empty, Empty, White Rook, White Bishop, Empty, Empty, Empty]

--testBishopBoard :: [Square]
testBishopBoard = [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                  Empty, White Pawn, Black Pawn, White Pawn, Black Pawn, Black Rook, Empty, Empty,
                  Empty, Black Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty, 
                  Empty, White Pawn, Empty, White Bishop, Empty, Black Pawn, Empty, Empty,
                  Empty, Black Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty,
                  Empty, Black Pawn, White Pawn, Black Pawn, Black Rook, Black King, Empty, Empty,
                  Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                  Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]

--testQueenBoard :: [Square]
testQueenBoard = [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                  Empty, White Pawn, Black Pawn, White Pawn, Black Pawn, Black Rook, Empty, Empty,
                  Empty, Black Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty, 
                  Empty, White Pawn, Empty, Black Queen, Empty, Black Pawn, Empty, Empty,
                  Empty, Black Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty,
                  Empty, Black Pawn, White Pawn, Black Pawn, Black Rook, Black King, Empty, Empty,
                  Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                  Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]


testKnightBoard1 = [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, White Pawn, Black Pawn, White Pawn, Black Pawn, White Pawn, Empty, Empty,
                   Empty, Black Pawn, Empty, Empty, Empty, Black Pawn, Empty, Empty,
                   Empty, Empty, Empty, White Knight, Empty, Empty, Empty, Empty,
                   Empty, Black Pawn, Empty, Empty, Empty, Black Pawn, Empty, Empty,
                   Empty, Empty, Black Pawn, Empty, Black Pawn, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]

testKnightBoard2 = [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, White Pawn, Black Pawn, White Pawn, Black Pawn, White Pawn, Empty, Empty,
                   Empty, Black Pawn, Empty, Empty, Empty, Black Pawn, Empty, Empty,
                   Empty, Empty, Empty, Black Knight, Empty, Empty, Empty, Empty,
                   Empty, Black Pawn, Empty, Empty, Empty, Black Pawn, Empty, Empty,
                   Empty, Empty, Black Pawn, Empty, Black Pawn, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]

testKnightBoard3 = [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, Black Pawn, White Pawn, Black Pawn, White Pawn, Black Pawn, Empty, Empty,
                   Empty, White Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty,
                   Empty, Empty, Empty, Black Knight, Empty, Empty, Empty, Empty,
                   Empty, White Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty,
                   Empty, Empty, White Pawn, Empty, White Pawn, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]

testKnightBoard4 = [Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, Black Pawn, White Pawn, Black Pawn, White Pawn, Black Pawn, Empty, Empty,
                   Empty, White Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty,
                   Empty, Empty, Empty, White Knight, Empty, Empty, Empty, Empty,
                   Empty, White Pawn, Empty, Empty, Empty, White Pawn, Empty, Empty,
                   Empty, Empty, White Pawn, Empty, White Pawn, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty,
                   Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty]





-- Change Board for Rook
-- Can any of these take a piece?
testvalidMoveRook1 = TestCase (assertEqual "Move from one square to the same square" False (validMoveRook (testBoard) (1,3) (1,3)))

testvalidMoveRook2 = TestCase (assertEqual "Can Rook move down?" True (Moves.validMoveRook testBoard (1,3) (2,3)))

testvalidMoveRook3 = TestCase (assertEqual "Can Rook move up?" True (Moves.validMoveRook testBoard (8,4) (6,4)))

testvalidMoveRook4 = TestCase (assertEqual "Can you move Empty?" False (Moves.validMoveRook testBoard (2,3) (1,1)))

testvalidMoveRook5 = TestCase (assertEqual "Can Rook move right?" True (Moves.validMoveRook testBoard (3,6) (3,8)))

testvalidMoveRook6 = TestCase (assertEqual "Can Rook move left and take out a piece?" True (Moves.validMoveRook testBoard (3,6) (3,3)))

testvalidMoveRook7 = TestCase (assertEqual "Can Rook move through another piece?" False (Moves.validMoveRook testBoard (1,3) (1,6)))

testvalidMoveRook8 = TestCase (assertEqual "Can other Piece than Rook move like a Rook?" True (Moves.validMoveRook testBoard (2,2) (2,5)))


testvalidMoveRook9 = TestCase (assertEqual "Can Rook move diagonal?" False (Moves.validMoveRook testBoard (1,3) (3,5)))

runRookTests = runTestTT $ TestList [testvalidMoveRook1, testvalidMoveRook2, testvalidMoveRook3, testvalidMoveRook4, testvalidMoveRook5, testvalidMoveRook6,
                                     testvalidMoveRook7, testvalidMoveRook8, testvalidMoveRook9]





testvalidMoveBishop1 = TestCase (assertEqual "Move from and to the same square" False (Moves.validMoveBishop testBishopBoard (4, 4) (4,4)))

testvalidMoveBishop2 = TestCase (assertEqual "Bishop Northeast" True (Moves.validMoveBishop testBishopBoard (4,4) (2,6)))

testvalidMoveBishop3 = TestCase (assertEqual "Bishop Northwest" False (Moves.validMoveBishop testBishopBoard (4,4) (2,2)))

testvalidMoveBishop4 = TestCase (assertEqual "Bishop Southwest" True (Moves.validMoveBishop testBishopBoard (4,4) (6,2)))

testvalidMoveBishop5 = TestCase (assertEqual "Bishop Southeast" True (Moves.validMoveBishop testBishopBoard (4,4) (6,6)))

testvalidMoveBishop6 = TestCase (assertEqual "Can another piece move like a Bishop?" True (Moves.validMoveBishop testBishopBoard (4,6) (6,8)))

testvalidMoveBishop7 = TestCase (assertEqual "Move through another piece?" False (Moves.validMoveBishop testBishopBoard (4,4) (1,7)))

testvalidMoveBishop8 = TestCase (assertEqual "Can Bishop move like Rook?" False (Moves.validMoveBishop testBishopBoard (4,4) (4,6)))

runBishopTests = runTestTT $ TestList [testvalidMoveBishop1, testvalidMoveBishop2, testvalidMoveBishop3, testvalidMoveBishop4, testvalidMoveBishop5, testvalidMoveBishop6, testvalidMoveBishop7, testvalidMoveBishop8]


testvalidMoveQueen1 = TestCase (assertEqual "Move from and to the same square" False (Moves.validMoveQueen testQueenBoard (4, 4) (4,4)))

testvalidMoveQueen2 = TestCase (assertEqual "Queen Northeast" False (Moves.validMoveQueen testQueenBoard (4,4) (2,6)))

testvalidMoveQueen3 = TestCase (assertEqual "Queen Northwest" True (Moves.validMoveQueen testQueenBoard (4,4) (2,2)))

testvalidMoveQueen4 = TestCase (assertEqual "Queen Southwest" False (Moves.validMoveQueen testQueenBoard (4,4) (6,2)))

testvalidMoveQueen5 = TestCase (assertEqual "Queen Southeast" False (Moves.validMoveQueen testQueenBoard (4,4) (6,6)))

testvalidMoveQueen6 = TestCase (assertEqual "Can another piece move like a Queen as Bishop?" True (Moves.validMoveQueen testQueenBoard (4,6) (6,8)))

testvalidMoveQueen7 = TestCase (assertEqual "Can another piece move like a Queen as Rook?" True (Moves.validMoveQueen testQueenBoard (4,6) (4,8)))

testvalidMoveQueen8 = TestCase (assertEqual "Move through another piece?" False (Moves.validMoveQueen testQueenBoard (4,4) (1,7)))

testvalidMoveQueen9 = TestCase (assertEqual "Queen West" True (Moves.validMoveQueen testQueenBoard (4,4) (4,2)))

testvalidMoveQueen10 = TestCase (assertEqual "Queen East" False (Moves.validMoveQueen testQueenBoard (4,4) (4,6)))

testvalidMoveQueen11 = TestCase (assertEqual "Queen North" True (Moves.validMoveQueen testQueenBoard (4,4) (2,4)))

testvalidMoveQueen12 = TestCase (assertEqual "Queen South" False (Moves.validMoveQueen testQueenBoard (4,4) (6,4)))

runQueenTests = runTestTT $ TestList [testvalidMoveQueen1, testvalidMoveQueen2, testvalidMoveQueen3, testvalidMoveQueen4, testvalidMoveQueen5, testvalidMoveQueen6, testvalidMoveQueen7, testvalidMoveQueen8, testvalidMoveQueen9, testvalidMoveQueen10, testvalidMoveQueen11]


testvalidMoveKnight1 = TestCase (assertEqual "Knight -2 +1" True (Moves.validMoveKnight testKnightBoard1 (4,4) (2,5)))

testvalidMoveKnight2 = TestCase (assertEqual "Knight -1 +2" True (Moves.validMoveKnight testKnightBoard1 (4,4) (3,6)))

testvalidMoveKnight3 = TestCase (assertEqual "Knight +1 +2" True (Moves.validMoveKnight testKnightBoard1 (4,4) (5,6)))

testvalidMoveKnight4 = TestCase (assertEqual "Knight +2 +1" True (Moves.validMoveKnight testKnightBoard1 (4,4) (6,5)))

testvalidMoveKnight5 = TestCase (assertEqual "Knight +2 -1" True (Moves.validMoveKnight testKnightBoard1 (4,4) (6,3)))

testvalidMoveKnight6 = TestCase (assertEqual "Knight +1 -2" True (Moves.validMoveKnight testKnightBoard1 (4,4) (5,2)))

testvalidMoveKnight7 = TestCase (assertEqual "Knight -1 -2" True (Moves.validMoveKnight testKnightBoard1 (4,4) (3,2)))

testvalidMoveKnight8 = TestCase (assertEqual "Knight -2 -1" True (Moves.validMoveKnight testKnightBoard1 (4,4) (2,3)))

testvalidMoveKnight9 = TestCase (assertEqual "Knight moving like rook" False (Moves.validMoveKnight testKnightBoard1 (4,4) (2,4)))


testvalidMoveKnight10 = TestCase (assertEqual "Knight -2 +1" False (Moves.validMoveKnight testKnightBoard2 (4,4) (2,5)))

testvalidMoveKnight11 = TestCase (assertEqual "Knight -1 +2" False (Moves.validMoveKnight testKnightBoard2 (4,4) (3,6)))

testvalidMoveKnight12 = TestCase (assertEqual "Knight +1 +2" False (Moves.validMoveKnight testKnightBoard2 (4,4) (5,6)))

testvalidMoveKnight13 = TestCase (assertEqual "Knight +2 +1" False (Moves.validMoveKnight testKnightBoard2 (4,4) (6,5)))

testvalidMoveKnight14 = TestCase (assertEqual "Knight +2 -1" False (Moves.validMoveKnight testKnightBoard2 (4,4) (6,3)))

testvalidMoveKnight15 = TestCase (assertEqual "Knight +1 -2" False (Moves.validMoveKnight testKnightBoard2 (4,4) (5,2)))

testvalidMoveKnight16 = TestCase (assertEqual "Knight -1 -2" False (Moves.validMoveKnight testKnightBoard2 (4,4) (3,2)))

testvalidMoveKnight17 = TestCase (assertEqual "Knight -2 -1" False (Moves.validMoveKnight testKnightBoard2 (4,4) (2,3)))

testvalidMoveKnight18 = TestCase (assertEqual "Knight moving like rook" False (Moves.validMoveKnight testKnightBoard1 (4,4) (2,4)))




runKnightTests = runTestTT $ TestList [testvalidMoveKnight1, testvalidMoveKnight2, testvalidMoveKnight3, testvalidMoveKnight4, testvalidMoveKnight5, testvalidMoveKnight6, testvalidMoveKnight7, testvalidMoveKnight8, testvalidMoveKnight9, testvalidMoveKnight10, testvalidMoveKnight11, testvalidMoveKnight12, testvalidMoveKnight13, testvalidMoveKnight14, testvalidMoveKnight15, testvalidMoveKnight16, testvalidMoveKnight17, testvalidMoveKnight18]


-- testvalidMovePawn1 = TestCase (assertEqual "Pawn from 1,1 to 1,1" True (Moves.validMovePawn (1,1) (1,1)))

-- runPawnTests = runTestTT $ TestList []

-- testvalidMoveKing1 = TestCase (assertEqual "King -1 +0" True (Moves.validMoveKing (1,1) (1,1)))

-- runKingTests = runTestTT $ TestList []
