/* [Maze Size] */
// Width of maze in blocks
mazeWidth = 4; // [4 : 1 : 100]

// Height of maze in blocks
mazeHeight = 4; // [4 : 1 : 100]

/* [Rendering Settings] */
// Size of each block
blockSize = 10; // [0.1 : 0.1 : 100]

// Height of each block
blockDepth = 10; // [0.1 : 0.1 : 100]

// Radius of the groove
grooveRadius = 4; // [0.1 : 0.1 : 100]

// Depth of the groove
grooveDepth = 10; // [0 : 0.1 : 100]

/* [Hidden] */
// Pre-calculated number of cells
blockCount = mazeWidth * mazeHeight;

// Named constant for number of walls
wallCount = 4*1;

// Constant equating to unusable cell-join operation
badCellJoin = [-1, -1, -1];

// Returns a maze initialized with each block being closed off, in a group of its own
function init() = 
  [for (i = [0 : blockCount - 1]) [i, i, [for (w = [0:3]) true] ]];

// Return index of coords
function indexOf(cellJoin) =
  cellJoin[0] + cellJoin[1] * mazeWidth;
  
// Returns the index of the first block in a group of blocks
function firstInGroup(blocks, index) = 
  blocks[index][0] == blocks[index][1] ? index : firstInGroup(blocks, blocks[index][1]);

// Returns the resultant cellJoin of moving in a specific direction
function left(cellJoin) = (cellJoin[0] <= 0) ? badCellJoin : [cellJoin[0]-1, cellJoin[1], 2];
function up(cellJoin) = (cellJoin[1] <= 0) ? badCellJoin : [cellJoin[0], cellJoin[1]-1, 3];
function right(cellJoin) = (cellJoin[0] >= mazeWidth - 1) ? badCellJoin : [cellJoin[0]+1, cellJoin[1], 0];
function down(cellJoin) = (cellJoin[1] >= mazeHeight - 1) ? badCellJoin : [cellJoin[0], cellJoin[1]+1, 1];

// Returns the resultant coords of moving through a specific wall of a cell
function throughWall(cellJoin) = 
  let (wall = cellJoin[2])
  (wall == 0) ? left(cellJoin) : (wall == 1) ? up(cellJoin) : (wall == 2) ? right(cellJoin) : down(cellJoin);

// Returns whether two blocks are in the same group
function sameGroup(blocks, cellJoin1, cellJoin2) = 
  let (index1 = indexOf(cellJoin1), index2 = indexOf(cellJoin2))
  (firstInGroup(blocks, index1) == firstInGroup(blocks, index2));

// Returns a random block coord, and wall index
function randCellJoin() =
  let (x = floor(rands(0, mazeWidth, 1)[0]), y = floor(rands(0, mazeHeight, 1)[0]), wall = floor(rands(0, wallCount, 1)[0]))
  [x, y, wall];

// Checks if the proposed joining is a valid one
function isValidJoin(blocks, cellJoin) = 
  let (destCellJoin = throughWall(cellJoin))
  (destCellJoin != badCellJoin) && (!sameGroup(blocks, cellJoin, destCellJoin));

// Used to iterates through possible joins
function nextJoin(cellJoin) =
  let(x = cellJoin[0], y = cellJoin[1], wall = cellJoin[2])
  (wall < wallCount - 1) ? [x, y, wall+1] : (x < mazeWidth - 1) ? [x + 1, y, 0] : (y < mazeHeight -1) ? [0, y + 1, 0] : [0, 0, 0];

// Iterates through possible joins until a valid one is found
function nextValidJoin(blocks, cellJoin) = 
  isValidJoin(blocks, cellJoin) ? cellJoin : nextValidJoin(blocks, nextJoin(cellJoin));
  
// Actually executes the action to open the wall of a cell
function openWall(walls, cellJoin) =
  [for (i = [0 : wallCount-1]) (i == cellJoin[2]) ? false : walls[i] ];

// Actually executes the action to open the wall between two cells
function openBlockWall(blocks, cellJoin) =
  let (index = indexOf(cellJoin))
  [for (i = [0 : blockCount - 1]) (i == index) ? [blocks[i][0], blocks[i][1], openWall(blocks[i][2], cellJoin)] : blocks [i] ];

// Flags that two groups of cells are in the same group
function joinGroup(blocks, cj1, cj2) = 
  let (i1 = indexOf(cj1), i2 = indexOf(cj2), f1 = firstInGroup(blocks, i1), f2 = firstInGroup(blocks, i2), iSmaller = (f1 < f2) ? i1 : i2, fSmaller = (f1 < f2) ? f1 : f2, iBigger = (f1 < f2) ? i2 : i1, fBigger = (f1 < f2) ? f2 : f1)
  [ for (i = [0 : blockCount - 1]) (i == fBigger) || (i == iBigger) ? [i, fSmaller, blocks[i][2]] : blocks[i] ];

// Merges to cell groups by breaking the specified wall between two cells
function merge(blocks, cellJoin) =
  let (destJoin = throughWall(cellJoin))
  joinGroup(openBlockWall(openBlockWall(blocks, cellJoin), destJoin), cellJoin, destJoin);

// Generates a random maze with exactly one path between any two points
function randomMaze(blocks, remaining) =
  (remaining > 0) ? randomMaze(merge(blocks, nextValidJoin(blocks, randCellJoin())), remaining - 1) : blocks;

// Draw the main block
module mainBlock() linear_extrude(height = blockDepth) square([mazeWidth * blockSize, mazeHeight*blockSize]);

// Draw the sphere in a cell
module ball() sphere(grooveRadius);

// Draw a horizontal cylinder between cells
module hcylinder() rotate([0, 90, 0]) cylinder(h = blockSize, r = grooveRadius);
	
// Draw a vertical cylinder between cells
module vcylinder() rotate([-90, 0, 0]) cylinder(h = blockSize, r = grooveRadius);

// Generate the maze
maze = randomMaze(init(), blockCount-1);

// Draw the maze
translate([mazeWidth * blockSize / -2, mazeHeight * blockSize / -2, 0]) {
  difference() {
	mainBlock();
    union() {
      for (y = [0 : mazeHeight-1]) {
        yy = (y + 0.5) * blockSize;

        for (x = [0 : mazeWidth - 1]) {
          xx = (x + 0.5) * blockSize;

          i = x + y * mazeWidth;

          translate([xx, yy, grooveDepth]) {
            ball();
            if (!maze[i][2][2]) hcylinder();
            if (!maze[i][2][3]) vcylinder();
          }
        }
      }
    }
  }
}
