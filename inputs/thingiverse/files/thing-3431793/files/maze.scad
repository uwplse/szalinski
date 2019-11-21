horizontalCells = 8;
verticalCells = 8;
cellSize = 8;
holeSize = 6;
innerWallThickness = 0.75;
innerWallHeight = 8;
outerWallThickness = 2;
outerWallHeight = 8;
baseThickness = 1;
startInset = 0.5;
// set seed to something other than 0 for a repeatable design
seed = 24;

module dummy() {}

$fn = 16;

nudge = 0.001;

// Algorithm:   https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker

// cell structure: [visited, [wall1, wall2, ...]]
// position: [x,y]
// direction: 0,1,2,3

directions = [ [-1,0], [1,0], [0,-1], [0,1] ];
wallCoordinates = [ [ [-0.5,-0.5],[-0.5,0.5] ],
    [ [0.5,-0.5],[0.5,0.5] ],
    [ [-0.5,-0.5],[0.5,-0.5] ],
    [ [-0.5,0.5],[0.5,0.5] ] ];
revDirections = [1,0,3,2];

rs = seed ? rands(0,.9999999,ceil(horizontalCells * verticalCells * len(directions) / 2),seed) : rands(0,.9999999,ceil(horizontalCells * verticalCells * len(directions) / 2));

function inside(pos) = pos[0] >= 0 && pos[1] >= 0 && pos[0] < horizontalCells && pos[1] < verticalCells;
function move(pos,dir) = pos+directions[dir];
function tail(list) = len(list)>1 ? [for(i=[1:len(list)-1]) list[i]] : [];
function visited(cells,pos) = !inside(pos) || cells[pos[0]][pos[1]][0];
function countUnvisitedNeighbors(cells,pos,count=0, dir=0) = dir >= len(directions) ?
        count :
        countUnvisitedNeighbors(cells, pos, count = count + (visited(cells,move(pos,dir))?0:1), dir = dir+1);
function getNthUnvisitedNeighbor(cells,pos,count,dir=0) =
    visited(cells,move(pos,dir)) ?
        getNthUnvisitedNeighbor(cells,pos,count,dir=dir+1) :
    count == 0 ? dir :
    getNthUnvisitedNeighbor(cells,pos,count-1,dir=dir+1);
function getRandomUnvisitedNeighbor(cells,pos,r) =
    let(n=countUnvisitedNeighbors(cells,pos))
    n == 0 ? undef :
        getNthUnvisitedNeighbor(cells,pos,floor(r*n));
function visit(cells, pos, dir) =
    let(newPos=move(pos,dir),
        revDir=revDirections[dir])
    [ for(x=[0:horizontalCells-1]) [ for(y=[0:verticalCells-1])
        let(isNew=[x,y]==newPos,
            isOld=[x,y]==pos)
        [ cells[x][y][0] || isNew,
        [for (i=[0:len(directions)-1])
            cells[x][y][1][i] &&
            ( !isNew || i != revDir )
            && ( !isOld || i != dir)
        ]]]];

function iterateMaze(cells,pos,stack=[],rs=rs) =
    let(unvisited = getRandomUnvisitedNeighbor(cells,pos,rs[0]))
    unvisited != undef ?
        iterateMaze(visit(cells, pos, unvisited), move(pos,unvisited), concat([pos], stack), rs=tail(rs)) :
    len(stack) > 0 ?
        iterateMaze(cells,stack[0],tail(stack), rs=tail(rs)) :
    cells;

function baseMaze(pos) =
    [ for(x=[0:horizontalCells-1]) [ for(y=[0:verticalCells-1])
        [ [x,y] == pos,
        [for (i=[0:len(directions)-1])
            inside(move([x,y],i))] ] ] ];

function walled(cells,pos,dir) =
    cells[pos[0]][pos[1]][1][dir];

function countUnvisitedNeighborsWalled(cells,pos,count=0, dir=0) = dir >= len(directions) ?
        count :
        countUnvisitedNeighborsWalled(cells, pos, count = count + ((walled(cells,pos,dir) || visited(cells,move(pos,dir)))?0:1), dir = dir+1);
function getNthUnvisitedNeighborWalled(cells,pos,count,dir=0) =
    (walled(cells,pos,dir) || visited(cells,move(pos,dir))) ?
        getNthUnvisitedNeighborWalled(cells,pos,count,dir=dir+1) :
    count == 0 ? dir :
        getNthUnvisitedNeighborWalled(cells,pos,count-1,dir=dir+1);

function revisit(maze,pos) =
    [ for(x=[0:horizontalCells-1]) [ for(y=[0:verticalCells-1])
        [ [x,y] == pos,
          maze[x][y][1] ] ] ];

function getLongest(options,pos=0,best=[]) =
        len(options)<=pos ? best :
    getLongest(options,pos=pos+1,best=    best[0]>=options[pos][0] ? best : options[pos]);

function furthest(maze,pos,length=1)
    = let(n=countUnvisitedNeighborsWalled(maze,pos))
      n == 0 ? [length,pos] :
      getLongest([for (i=[0:n-1])
         let(dir=getNthUnvisitedNeighborWalled(maze,pos,i))
         furthest(visit(maze,pos,dir),move(pos,dir),length=length+1)]);


module renderWall(dir,spacing) {
   if (dir<=1) translate([spacing/2, 0, innerWallHeight/2]) cube([innerWallThickness, spacing, innerWallHeight], center = true);
   if (dir>=2) translate([ 0,-spacing/2, innerWallHeight/2]) cube([spacing, innerWallThickness, innerWallHeight], center = true);
}

module renderInside(maze,spacing=10) {
   translate(spacing*[0.5,0.5])
   for (x=[0:len(maze)-1])
       for(y=[0:len(maze[0])-1]) {
           translate([x,y,0]*spacing)
               for(i=[1:2])
                   if (maze[x][y][1][i]) renderWall(i,spacing);
       }
}

module renderOutside(offset, spacing=10) {
    for(wall=wallCoordinates) {
        hull() {
            for(i=[0:1])
            translate([(0.5+wall[i][0])*spacing*horizontalCells+offset*sign(wall[i][0]),(0.5+wall[i][1])*spacing*verticalCells+offset*sign(wall[i][1])]) children();
        }
    }
}

module innerWall() {
    linear_extrude(height=innerWallHeight) circle(d=innerWallThickness, center=true);
}

module mazeBox(h) {
    linear_extrude(height=h) hull() renderOutside(max(0,(outerWallThickness-innerWallThickness)/2),spacing=cellSize) circle(d=outerWallThickness);
}

module holeStart(x,y) {
        holeSize=cellSize-innerWallThickness;
        translate([(x+0.5)*cellSize,(y+0.5)*cellSize,baseThickness+1])
          cylinder(h=outerWallHeight+innerWallHeight+100,d=holeSize,$fn=32);
}

module holeEnd(x,y) {
        holeSize=cellSize-innerWallThickness-nudge;
        translate([(x+0.5)*cellSize,(y+0.5)*cellSize,baseThickness + 101]) {
          cube(size = [holeSize, holeSize, 200],center=true);
        }
}

module smallHole(x,y) {
        translate([(x+0.5)*cellSize,(y+0.5)*cellSize,baseThickness+1]) cylinder(h=100,d=holeSize,$fn=16);
}

module maze() {
    maze = iterateMaze(baseMaze([0,0]), [0,0]);
        union() {
            translate([0,0,baseThickness]) {
                renderInside(maze, spacing=cellSize);
            renderOutside(max(0,(outerWallThickness-innerWallThickness)/2),spacing=cellSize) cylinder(d=outerWallThickness,h=outerWallHeight);
            }

            if(baseThickness>0)
                mazeBox(baseThickness+nudge);
                translate([(horizontalCells+1) * cellSize,0,-50])
                difference() {
              translate([0,0,50]) mazeBox(baseThickness+nudge);
                  options =
                      [for (pos=[[0,0],[horizontalCells-1,0],[horizontalCells-1,verticalCells-1],[0,verticalCells-1]])
                          concat(furthest(revisit(maze,pos),pos), [pos]) ];
                  f = getLongest(options);
                  start = f[2];
                  end = f[1];
                  holeStart(start[0],start[1]);
                  holeEnd(end[0],end[1]);
                  for (x=[0:horizontalCells-1]) {
                    for (y=[0:verticalCells-1]) {
                      smallHole(x,y);
                    }
                  }
            }
        }
    }

maze();
