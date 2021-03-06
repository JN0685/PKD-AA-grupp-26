module Moves
  where

import Data.Char
import Test.HUnit


type Board = [Square]

type Contester = String

type Move = String

data Square = Empty | White Piece | Black Piece
   deriving (Eq, Show)

data Piece = Pawn | Knight | Bishop | Rook | Queen | King
   deriving (Eq, Show)


{- move board int1 int2 
   moves a Square from the position corresponding to int1 to the position corresponding to int2 on the board regradless of whether the move is valid or not.
   RETURNS: a board where the Square on 'int1' has replaced 'int2' and 'int1' is now Empty. 
   EXAMPLES: move newBoard 1 2 = [White Rook,Empty,White Pawn,Empty,Empty,Empty,Black Pawn,Black Rook,White Knight,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Knight,White Bishop,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Bishop,White Queen,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Queen,White King,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black King,White Bishop,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Bishop,White Knight,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Knight,White Rook,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Rook]
             move [White Rook,Empty,White Pawn,Empty,Empty,Empty,Black Pawn,Black Rook,White Knight,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Knight,White Bishop,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Bishop,White Queen,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Queen,White King,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black King,White Bishop,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Bishop,White Knight,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Knight,White Rook,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Rook] 2 3 = [White Rook,Empty,Empty,White Pawn,Empty,Empty,Black Pawn,Black Rook,White Knight,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Knight,White Bishop,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Bishop,White Queen,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Queen,White King,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black King,White Bishop,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Bishop,White Knight,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Knight,White Rook,White Pawn,Empty,Empty,Empty,Empty,Black Pawn,Black Rook]
             move [White Rook,Empty,Empty,White Pawn] 1 2 = [White Rook,Empty,Empty,White Pawn]
             move [White Rook,Empty,Empty,White Pawn] 10 15 = [White Rook,Empty,Empty,White Pawn,Empty,*** Exception: Prelude.!!: index too large
             move [] 1 2 = [Empty,*** Exception: Prelude.!!: index too large
-}
move :: Board -> Int -> Int -> Board
move b int1 int2 = let
              removed
                = (take int1 b) ++ [Empty] ++ (drop (int1 + 1) b)
             in (take int2 removed) ++ ((onSquare b int1) : (drop (int2 + 1) removed))

{- convert input
   converts an input String into a pair of two Int's 
   Returns: (9, 9) if map toUpper input = "CASTLING" or (x, y) where x is an Int from 1 to 8 intead of a Char from 'a' to 'h' and y = digitToInt of y if x and y are positions on a chess board. Otherwise (10, 10)
   Examples: convert "a1" = (1, 1)
             convert "A1" = (1, 1)
             convert "h8" = (8, 8)
             convert "castling" = (9,9)
             convert "i9" = (10,10)
             convert "b6" = (2,6)
-}
convert :: String -> (Int, Int)
convert (x:y:[]) | (isNumber y) && ((digitToInt y) <= 8) && ((digitToInt y) >= 1) = ((convertAux x), (digitToInt y))
                 | otherwise = (10, 10)
convert (x:y:ys) | (map toUpper (x:y:ys)) == "CASTLING" = (9, 9)
                 | otherwise = (10, 10)
convert x = (10,10)


{- convertAux x
   Converts a x between 'a' and 'h' to an Int between 1 and 8
   Returns: An Int between 1 and 8 if the Char is between 'a' and 'h' otherwise 10 
   Example: convertAux 'a'  = 1
            convertAux 'A'  = 1
            convertAux 'h'  = 8
            convertAux 'hk' = 10
            convertAux 'i'  = 10
-}
convertAux :: Char -> Int
convertAux x | (toUpper x) == 'A' = 1
             | (toUpper x) == 'B' = 2
             | (toUpper x) == 'C' = 3
             | (toUpper x) == 'D' = 4
             | (toUpper x) == 'E' = 5
             | (toUpper x) == 'F' = 6
             | (toUpper x) == 'G' = 7
             | (toUpper x) == 'H' = 8
             | otherwise = 10
                 
                 

{- position (a, b)
   converts an input (a, b) to an Int where if a and b represent Squares on a chess board the Int will represent it's position in a list of 64 elements
   RETURNS: an Int where if a and b represent Squares on a chess board the Int will represent it's position in a list of 64 elements
   EXAMPLES: position (1, 1)  = 0
             position (1, 2)  = 1
             position (2, 1)  = 8
             position (8, 8)  = 64
             position (9, 9)  = 72
             position (1, 24) = 23
             position (0, 0)  = -9
-}

position :: (Int, Int) -> Int
position (x, y) = 8 * (x - 1) + y - 1

{- onSquare board int
   converts an int to the Square on the position correspnding to int on the board
   PRE: board cannot be empty and int < length board
   RETURNS: The Square on position int of board
   EXAMPLES: onSquare newBoard 0 = White Rook
             onSquare newBoard 63 = Black Rook
             onSquare newBoard 64 = *** Exception: Prelude.!!: index too large            
-}
onSquare :: Board -> Int -> Square
onSquare board int = board !! int


{- isSameColour square1 square2
   Checks if two Squares are of the same colour
   RETURNS: True if square1 and square2 are the same colour. Otherwise False
   EXAMPLES: isSameColour Empty Empty == False
             isSameColour (White Knight) (White King) == True
             isSameColour (Black Queen) (Black Rook) == True
             isSameColour (White Knight) (Black Knight) == False
             isSameColour (White Knight) Empty == False
-}
isSameColour :: Square -> Square -> Bool  
isSameColour (White _) (White _) = True
isSameColour (Black _) (Black _) = True
isSameColour sq1 sq2             = False

{- isSameColourPlayer player square
   Checks if a player and a square are the same colour
   RETURNS: True if player and square are the same colour. Otherwise False
   EXAMPLES: isSameColourPlayer "White player" (Empty) == False
             isSameColourPlayer "White player" (White King) == True
             isSameColourPlayer "Black player" (Black Rook) == True
             isSameColourPlayer "White player" (Black Rook) == False
             isSameColourPlayer "randomstring" (Black Rook) == False
-}
isSameColourPlayer :: Contester -> Square -> Bool  
isSameColourPlayer "White player" (White _) = True
isSameColourPlayer "Black player" (Black _) = True
isSameColourPlayer player square            = False

{- validMove board player input output
   Checks whether it is valid for player to move the piece on (a, b) to (c, d) on the board
   Returns: True if the move is valid. False if the move is not valid.
-}
validMove :: Board -> Contester -> Move -> Move -> Bool
validMove board player input output | convert output == (9, 9) || convert output == (10, 10) = False
                                    
                                    | isSameColourPlayer player (onSquare board (position (convert input))) == True = validMoveAux board input output
                                    | otherwise = False

{- validMoveAux board input output
   Finds the appropriate validMove function for the piece on the input square
   Returns: If onSquare board (position (convert input)) = White Pawn then validMovePawn board (convert input) (convert output),
if Black Pawn   then validMovePawn board (convert input) (convert output),
if White Rook   then validMoveRook board (convert input) (convert output),
if Black Rook   then validMoveRook board (convert input) (convert output)
if White Knight then validMoveKnight board (convert input) (convert output)
if Black Knight then validMoveKnight board (convert input) (convert output)
if White Bishop then validMoveBishop board (convert input) (convert output)
if Black Bishop then validMoveBishop board (convert input) (convert output)
if White Queen  then validMoveQueen board (convert input) (convert
if Black Queen  then validMoveQueen board (convert input) (convert output)
if White King   then validMoveKing board (convert input) (convert output)
if Black King   then validMoveKing board (convert input) (convert output)
-}
validMoveAux board input output = case onSquare board (position (convert input)) of
                                    White Pawn   -> validMovePawn board (convert input) (convert output)
                                    Black Pawn   -> validMovePawn board (convert input) (convert output)
                                    White Rook   -> validMoveRook board (convert input) (convert output)
                                    Black Rook   -> validMoveRook board (convert input) (convert output)
                                    White Knight -> validMoveKnight board (convert input) (convert output)
                                    Black Knight -> validMoveKnight board (convert input) (convert output)
                                    White Bishop -> validMoveBishop board (convert input) (convert output)
                                    Black Bishop -> validMoveBishop board (convert input) (convert output)
                                    White Queen  -> validMoveQueen board (convert input) (convert output)
                                    Black Queen  -> validMoveQueen board (convert input) (convert output)
                                    White King   -> validMoveKing board (convert input) (convert output)
                                    Black King   -> validMoveKing board (convert input) (convert output)

{- validMovePawn board (a, b) (c, d)
   Checks whether it is valid to move a Pawn from (a, b) to (c, d)
   Pre: a, b, c and d must be between 1 and 8
   Returns: True if the move is valid, otherwise False
   Example: validMovePawn newBoard (1, 2) (1, 3) = True
            validMovePawn newBoard (1, 2) (1, 5) = False
            validMovePawn newBoard (1, 7) (1, 6) = True
-}
validMovePawn :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMovePawn board (a, b) (c, d) | (isSameColour (onSquare board (position (a, b))) (onSquare board (position (c, d)))) = False
                                  | a == c && ((onSquare board (position (c, d))) /= Empty) = False
                                  | (isSameColour (onSquare board (position (a, b))) (White Pawn)) = validMoveWhitePawn board (a, b) (c, d)
                                  | (isSameColour (onSquare board (position (a, b))) (Black Pawn)) = validMoveBlackPawn board (a, b) (c, d)
                                  | otherwise = False


{- validMoveWhitePawn board (a, b) (c, d)
   Checks whether it is a valid to move a White Pawn from (a, b) to (c, d) regardless of whether (a, b) and (c, d) are on the board or not.
   Returns True if the move is valid, otherwise False
   Example: validMoveWhitePawn newBoard (1, 2) (1, 3) = True
            validMoveWhitePawn newBoard (1, 2) (1, 5) = False
            validMoveWhitePawn newBoard (9, 9) (9, 345) = False
-}
validMoveWhitePawn :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveWhitePawn board (a, b) (c, d) | a == c && (d - b == 1) || ((((d - b == 2) && b == 2)) && (onSquare board (position (c, (d-1))) == Empty)) = True
                                       | (abs (a - c)) == 1 && b < d && (onSquare board (position (c, d))) /= Empty = True
                                       | otherwise = False
                                       
                                       

{- validMoveBlackPawn board (a, b) (c, d)
   Checks whether it is a valid to move a White Pawn from (a, b) to (c, d)
   Pre: (a, b) must be a White Pawn
   Returns True if the move is valid, otherwise False
   Example: validMovePawn newBoard (1, 7) (1, 6) = True
            validMovePawn newBoard (1, 7) (1, 4) = False
-}
validMoveBlackPawn :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveBlackPawn board (a, b) (c, d) | a == c && (b - d == 1) || ((((b - d == 2) && b == 7)) && (onSquare board (position (c, (d+1))) == Empty)) = True
                                       | (abs (a - c)) == 1 && b > d && (onSquare board (position (c, d))) /= Empty = True
                                       | otherwise = False

{- validMoveRook board startPos endPos
   checks whether or not a rook can make a move in chess.
   PRE: 
   RETURNS: True if 'square' can make the nove from 'startPos' to 'endPos' on the Board 'board', else False
   SIDE-EFFECTS: 
   EXAMPLES:
DOES NOT WORK WHEN TRYING TO MOVE A ROOK TO A PLACE WHERE YOU CAN MOVE IT
SEEMS TO ALWAYS RETURN FALSE
 -}
validMoveRook :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveRook board (a, b) (c, d) | isSameColour (onSquare board (position (a, b))) (onSquare board (position (c, d))) = False
                                  -- 1 and 8 to check all squares on that line
                                  | a == c = validMoveRookAux board 1 (d-b) (position (a,b)) (position (c,d)) (onSquare board (position (a, b)))
                                  -- 1 and 8 to check horizontal/vertical line
                                  | b == d = validMoveRookAux board 8 (c-a) (position (a,b)) (position (c,d)) (onSquare board (position (a, b)))
                                  ----- board 1 (a-c) instead of (a-d)
                                  | otherwise = False

{- validMoveRookAux b indexchange n indexOfab indexOfcd square
   checks if there is anything in the way when a chess piece moves from one square to another. 
   PRE: 
   RETRUNS: -- Something about square can move to every square with the indexchange to n on b.
   SIDE-EFFECTS: 
   EXAMPLES: 
-}
-- VARIANT: n
validMoveRookAux :: Board -> Int -> Int -> Int -> Int -> Square -> Bool -- tuple might be best if changed to their index in Board.
validMoveRookAux b ic 0 ab cd sq = ((onSquare b ab) == Empty) || (isSameColour (onSquare b ab) sq == False) ------ cd not needed
validMoveRookAux b ic n ab cd sq | (abs n > 1 && n<0) && ((onSquare b (ab-ic)) /= Empty) = False -- change to cd instead of ab? 
                                 | (abs n > 1 && n>0) && ((onSquare b (ab+ic)) /= Empty) = False
                                 | n>0       = validMoveRookAux b ic (n-1) (ab+ic) cd sq
                                 | otherwise = validMoveRookAux b ic (n+1) (ab-ic) cd sq -- n-1 changed to n+1

{- validMoveKnight board (a, b) (c, d)
   Checks whether it is valid to move a Knight from (a, b) to (c, d)
   Pre: (a, b) must be a Knight. (a, b) and (c, d) must be Squares on the board
   Returns: True if the move is valid, otherwise False
   Example: validMovePawn Moves.newBoard (1, 2) (1, 3) = False
            validMovePawn Moves.newBoard (1, 2) (1, 5) = False
            validMovePawn Moves.newBoard (2, 1) (1, 3) = True
-}

validMoveKnight :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveKnight board (a, b) (c, d) | (isSameColour (onSquare board (position (a, b))) (onSquare board (position (c, d)))) = False
                                    | (abs (a-c)) == 1 && (abs (b-d)) == 2 = True
                                    | (abs (a-c)) == 2 && (abs (b-d)) == 1 = True
                                    | otherwise = False


{- validMoveBishop board (a, b) (c, d)
   Checks whether it is a valid to move a Bishop from (a, b) to (c, d)
   Pre: (a, b) must be a Bishop. (a, b) and (c, d) must be on the board.
   Returns True if the move is valid, otherwise False
   Example:
-}
validMoveBishop :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveBishop board (a, b) (c, d) | (isSameColour (onSquare board (position (a, b))) (onSquare board (position (c, d)))) = False
                                    | (abs (a-c)) == 1 && (abs (b-d)) == 1 = True
                                    | (abs (a - c)) == (abs (b - d)) = validMoveBishopAux board (a, b) (c, d)
                                    | otherwise = False

{- validMoveBishopAux board (a, b) (a, b)
   Checks in which direction the recusion for validMoveBishop should continue
   Returnes: validMoveBishope board (a, b) (c, d) where (c, d) is an updated output one step closer to the input.
-}
validMoveBishopAux :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveBishopAux board (a, b) (c, d) | a > c && b > d && (onSquare board (position ((c+1), (d+1)))) == Empty = validMoveBishop board (a, b) ((c+1), (d+1))
                                       | a > c && b < d && (onSquare board (position ((c+1), (d-1)))) == Empty = validMoveBishop board (a, b) ((c+1), (d-1))
                                       | a < c && b < d && (onSquare board (position ((c-1), (d-1)))) == Empty = validMoveBishop board (a, b) ((c-1), (d-1))
                                       | a < c && b > d && (onSquare board (position ((c-1), (d+1)))) == Empty = validMoveBishop board (a, b) ((c-1), (d+1))
                                       | otherwise = False

{- validMoveQueen board (a, b) (c, d)
   Checks whether it is a valid to move a Queen from (a, b) to (c, d)
   Pre: (a, b) must be a Queen. (a, b) and (c, d) must be on the board.
   Returns True if the move is valid, otherwise False
   Example:
-}
validMoveQueen :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveQueen board (a,b) (c,d) = (validMoveRook board (a,b) (c,d) || validMoveBishop board (a,b) (c,d))

{- validMoveKing board (a, b) (c, d)
   Checks whether it is valid to move a King from (a, b) to (c, d)
   Pre: (a, b) must be a King. (a, b) and (c, d) must be Squares on the board
   Returns: True if the move is valid, otherwise False
   Example: validMoveKing Moves.newBoard (3, 2) (3, 3) = True
            validMoveKing Moves.newBoard (1, 2) (1, 5) = False
            validMoveKing [White Rook, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Rook, White Knight, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Knight, White Bishop, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Bishop, White Queen, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Queen, White King, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black King, Black King, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Bishop, White Knight, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Knight, White Rook, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Rook] (5, 1) (6, 1) = True
-}

validMoveKing :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveKing board (a, b) (c, d) | (isSameColour (onSquare board (position (a, b))) (onSquare board (position (c, d)))) = False
                                  | ((abs (a-c)) <= 1 || (abs (a-c)) >= 0) && ((abs(b-d)) <= 1 || (abs (b-d) <= 0)) = True
                                  | otherwise = False
