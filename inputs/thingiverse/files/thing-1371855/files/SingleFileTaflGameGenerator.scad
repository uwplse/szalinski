// ------------------------------------------------- ;
//
//         Single File Tafl Game Generator
//
// ------------------------------------------------- ;

// ------------------------------------------------- ;
//         User Configuration Section
// ------------------------------------------------- ;

// Specific set configuration to print. 1 - Brandubh, 2 - Ard Ri, 3 - Tablut, 4 - Tawlbwrdd, 5 - Hnefatafl, 6 - Alea Evangelii.
SetID = 1;

// What to generate. 1 - Board, 2 - Pieces, 3 - Single Pawn, 4 - Single King.
Generate = 1;

// Specific piece style to print. 1 - Horik, 2 - Forkbeard
PieceID = 1;

// Level of detail for smoothing. Low - 90, Medium - 180, High - 360.
Detail = 180;

// Scale output. Pieces have a 4mm base with varying overhangs and the boards are 4.8mm squares with 0.2mm spacing and margins.
Scale = 1;

// ------------------------------------------------- ;
//         End User Configuration
// ------------------------------------------------- ;

scale(Scale)

if (Generate == 1) {
   
   GenerateBoard(SetID);
   
} else if (Generate == 2) {
   
   GeneratePieces(SetID, PieceID, Detail);
   
} else if (Generate == 3) {
   
   TaflPawn(PieceID, Detail);
   
} else if (Generate == 4) {
   
   TaflKing(PieceID, Detail);
   
}

// Board definition
// 0 - Normal Square
// 1 - Black Square
// 2 - White Square
// 3 - Corner
// 4 - Throne

// Generate tafl board by SetID
module GenerateBoard(SetID) {

   if (SetID == 1) {
      
      // Brandubh
      BoardSize = 7;
      
      Board = [[3, 0, 0, 1, 0, 0, 3],
               [0, 0, 0, 1, 0, 0, 0],
               [0, 0, 0, 2, 0, 0, 0],
               [1, 1, 2, 4, 2, 1, 1],
               [0, 0, 0, 2, 0, 0, 0],
               [0, 0, 0, 1, 0, 0, 0],
               [3, 0, 0, 1, 0, 0, 3]];
      
      TaflBoard(BoardSize, Board);
      
   } else if ((SetID == 2)) {
      
      // Ard Ri
      BoardSize = 7;
      
      Board = [[3, 0, 1, 1, 1, 0, 3],
               [0, 0, 0, 1, 0, 0, 0],
               [1, 0, 2, 2, 2, 0, 1],
               [1, 1, 2, 4, 2, 1, 1],
               [1, 0, 2, 2, 2, 0, 1],
               [0, 0, 0, 1, 0, 0, 0],
               [3, 0, 1, 1, 1, 0, 3]];
      
      TaflBoard(BoardSize, Board);
      
   } else if ((SetID == 3)) {
      
      // Tablut
      BoardSize = 9;
      
      Board = [[3, 0, 0, 1, 1, 1, 0, 0, 3],
               [0, 0, 0, 0, 1, 0, 0, 0, 0],
               [0, 0, 0, 0, 2, 0, 0, 0, 0],
               [1, 0, 0, 0, 2, 0, 0, 0, 1],
               [1, 1, 2, 2, 4, 2, 2, 1, 1],
               [1, 0, 0, 0, 2, 0, 0, 0, 1],
               [0, 0, 0, 0, 2, 0, 0, 0, 0],
               [0, 0, 0, 0, 1, 0, 0, 0, 0],
               [3, 0, 0, 1, 1, 1, 0, 0, 3],];
      
      
      TaflBoard(BoardSize, Board);
      
   } else if (SetID == 4) { 
      
      //Tawlbwrdd
      BoardSize = 11;
      
      Board = [[3, 0, 0, 0, 1, 1, 1, 0, 0, 0, 3],
               [0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0],
               [1, 1, 0, 0, 2, 2, 2, 0, 0, 1, 1],
               [1, 0, 1, 2, 2, 4, 2, 2, 1, 0, 1],
               [1, 1, 0, 0, 2, 2, 2, 0, 0, 1, 1],
               [0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
               [3, 0, 0, 0, 1, 1, 1, 0, 0, 0, 3]];
      
      
      TaflBoard(BoardSize, Board);
      
   } else if ((SetID == 5)) {
      
      // Hnefatafl
      BoardSize = 11;
      
      Board = [[3, 0, 0, 1, 1, 1, 1, 1, 0, 0, 3],
               [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
               [1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1],
               [1, 0, 0, 0, 2, 2, 2, 0, 0, 0, 1],
               [1, 1, 0, 2, 2, 4, 2, 2, 0, 1, 1],
               [1, 0, 0, 0, 2, 2, 2, 0, 0, 0, 1],
               [1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1],
               [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
               [3, 0, 0, 1, 1, 1, 1, 1, 0, 0, 3]];
      
      
      TaflBoard(BoardSize, Board);
      
   } else if (SetID == 6) {
      
      // Alea Evangelii
      BoardSize =19;
      
      Board = [[3, 3, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 3, 3],
               [3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3],
               [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
               [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0],
               [1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1],
               [0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0],
               [0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0],
               [0, 0, 0, 0, 2, 0, 0, 2, 0, 2, 0, 2, 0, 0, 2, 0, 0, 0, 0],
               [0, 0, 0, 1, 0, 0, 2, 0, 2, 4, 2, 0, 2, 0, 0, 1, 0, 0, 0],
               [0, 0, 0, 0, 2, 0, 0, 2, 0, 2, 0, 2, 0, 0, 2, 0, 0, 0, 0],
               [0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0],
               [0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0],
               [1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1],
               [0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0],
               [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
               [3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3],
               [3, 3, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 3, 3]];
      
      
      TaflBoard(BoardSize, Board);
      
   }
   
};

// Create tafl board.
module TaflBoard(BoardSize, Board) {
   
   union() {
      
      cube([(BoardSize * 5) + 0.2, (BoardSize * 5) + 0.2, 1]);
      
      for (x = [0:BoardSize - 1]) {
         
         for (y = [0:BoardSize - 1]) {
            
            translate([(x * 5) + 0.2, (y * 5) + 0.2, 1]) {
              
              cube([4.8 ,4.8 ,(Board[x][y] + 1) * 0.1]);
              
            }
            
         }
         
      }
   
   }
   
};

// Generate set of pieces by SetID.
module GeneratePieces(SetID, PieceID, Detail) {
   
   if (SetID == 1) {
      
      // Brandubh
      TaflPieces(
      KingCount = 1,
      WhiteCount = 4,
      BlackCount = 8,
      GridPadding = 0,
      PieceID = PieceID,
      Detail = Detail);
      
   } else if ((SetID == 2) || (SetID == 3)) {
      
      // Ard Ri/Tablut
      TaflPieces(
      KingCount = 1,
      WhiteCount = 8,
      BlackCount = 12,
      GridPadding = 0,
      PieceID = PieceID,
      Detail = Detail);
      
   } else if ((SetID == 4) || (SetID == 5)) {
      
      // Hnefatafl/Tawlbwrdd
      TaflPieces(
      KingCount = 1,
      WhiteCount = 12,
      BlackCount = 24,
      GridPadding = 1,
      PieceID = PieceID,
      Detail = Detail);
      
   } else if (SetID == 6) {
      
      // Alea Evangelii
      TaflPieces(
      KingCount = 1,
      WhiteCount = 24,
      BlackCount = 48,
      GridPadding = 0,
      PieceID = PieceID,
      Detail = Detail);
      
   }
   
};

// Generate selected piece layout for printing.
module TaflPieces(KingCount, WhiteCount, BlackCount, GridPadding, PieceID, Detail) {
   
   TotalCount = BlackCount + WhiteCount + KingCount;
   
   GridLayout = round(sqrt(TotalCount)) + GridPadding;
   
   for (x = [1:GridLayout]){
      
      for (y = [1:GridLayout]){
         
         CurrentPiece = (((x-1) * GridLayout) + y);
         
         if (CurrentPiece < KingCount + 1) {
            
            color("white")
            translate([(x * 5) - 2.5, (y * 5) - 2.5])
            TaflKing(PieceID, Detail);
            
         } else if ((CurrentPiece > KingCount)&&(CurrentPiece < WhiteCount + KingCount + 1)) {
            
            color("white")
            translate([(x * 5) - 2.5, (y * 5) - 2.5])
            TaflPawn(PieceID, Detail);
            
         } else if ((CurrentPiece < TotalCount + 1)&&(CurrentPiece > WhiteCount + KingCount)) {
            
            color("black")
            translate([(x * 5) - 2.5, (y * 5) - 2.5])
            TaflPawn(PieceID, Detail);
            
         }
         
      }
      
   }
   
};

// Generate pawn of pieces by PieceID.
module TaflPawn(PieceID, Detail) {
   
   if (PieceID == 1) {
      
      HorikTaflPawn(Detail);
      
   } else if (PieceID == 2) {
      
      ForkbeardTaflPawn(Detail);
      
   }
   
};

// Generate Horik style pawn piece.
module HorikTaflPawn(Detail) {
   
   // Join pieces into single manifold mesh.
   union() {
      
      // Rotate extrude base and stem from polygon.
      rotate_extrude($fn=Detail) {
         polygon( points=[ [0, 0], [2, 0], [2.1, 0.2], [1.75, 0.3], [1.5, 0.5], [1.25, 0.8], [1.5, 1], [1.5, 1.1], [1.4, 1.15], [1.2, 1.3], [1, 1.4], [1, 2], [1, 3.4], [1.1, 3.5], [1.1, 3.6], [1, 3.7], [0.5, 5], [0, 5] ] );
      }
      
      // Create head piece and translate.
      translate([0, 0, 5]) {
         sphere(1.25, center=true, $fn=Detail);
      }
      
   };
   
};

// Generate Forkbeard style pawn piece.
module ForkbeardTaflPawn(Detail) {
   
   // Indent base with low poly sphere.
   difference() {
      
      // Rotate extrude base from polygon.
      rotate_extrude($fn=Detail) {
         polygon( points=[ [0, 0], [2, 0], [2.1, 0.2], [2.1, 1], [1.8, 1], [1.8, 0.8], [0, 0.8] ] );
      }
      
      // Indent piece with sphere.
      translate([0, 0, 1.5]) {
         sphere(1, center=true, $fn=6);
      }
      
   };
   
};

// Generate king by PieceID.
module TaflKing(PieceID, Detail) {
   
   if (PieceID == 1) {
      
      HorikTaflKing(Detail);
      
   } else if (PieceID == 2) {
      
      ForkbeardTaflKing(Detail);
      
   }  
   
};

// Generate Horik style king piece.
module HorikTaflKing(Detail = 180) {

   // Join pieces into single manifold mesh.
   union() {
      
      // Rotate extrude base and stem from polygon.
      rotate_extrude($fn=Detail) {
         polygon( points=[ [0, 0], [2, 0], [2.1, 0.2], [1.75, 0.3], [1.5, 0.5], [1.25, 0.8], [1.5, 1], [1.5, 1.1], [1.4, 1.15], [1.2, 1.3], [1, 1.4], [1, 2], [1, 5.4], [1.1, 5.5], [1.1, 5.6], [1, 5.7], [0.5, 7], [0, 7] ] );
      }
      
      // Create head piece and translate.
      translate([0, 0, 7]) {
         sphere(1.25, center=true, $fn=Detail);
      }
      
   };
   
};

// Generate Forkbeard style king piece.
module ForkbeardTaflKing(Detail) {
   
   // Indent base with low poly sphere.
   difference() {
      
      // Rotate extrude base from polygon.
      rotate_extrude($fn=Detail) {
         polygon( points=[ [0, 0], [2, 0], [2.1, 0.2], [2.1, 1.5], [1.8, 1.5], [1.8, 1.3], [0, 1.3] ] );
      }
      
      // Indent piece with sphere.
      translate([0, 0, 1.5]) {
         sphere(1, center=true, $fn=8);
      }
      
   };
   
};
