////////////////////////////////////////////////////////////////////////////////
// Maze Cylinder Box, by William Gardner
//   inspired by https://www.thingiverse.com/thing:6004
//   https://www.thingiverse.com/thing:18469
//   https://www.thingiverse.com/thing:2338724
//   https://www.thingiverse.com/thing:207662
//   and related designs
// Visible Version - maze is visible on the exterior of the inside of the maze
// as the maze is solved.
// Hidden Version - maze is hidden on the interior of the outside of the maze
// as the maze is solved, so the maze can only be viewed after it has been
// completely solved.
////////////////////////////////////////////////////////////////////////////////
// maze notation: rows & cols
// row[0] = top, col[0]=left, under maze entrance (though circular)
// entry to maze is always over cell maze[0][0]
// To specify a maze, only need to specify whether each cell has paths
// leaving to the right or down!
// 0= no right or down path leaving that cell
// 1= path right leaving that cell
// 2= path down leaving that cell
// 3= paths right and down that cell
// paths leaving a cell left and up are noted in the cells those paths end in!
////////////////////////////////////////////////////////////////////////////////
// Example maze: note that the bottom left and right will circularly connect
//  + +-+-+
//  |     |
//  + +-+ +
//    |    
//  +-+-+-+
// 
// The top left cell(0,0) has paths that exit right and down, so it's a "3"
// The top middle cell(0,1) has a path that exits right but not down, so it's a "1"
// The top right cell (0,2) has a path that exits down but not right, to it's a "2"
// Similarly, the bottom row's cells are "0", "1", and "1"
// So this maze can be specified by
// maze=[[3,1,2],[0,1,1]];
////////////////////////////////////////////////////////////////////////////////
// If you want the whole maze to be hidden until it is opened, add an equal number
// of rows of [0]s at the bottom.  Note that this will make the maze twice as high!
// For example, for the maze above with zeros, you'd specify.
// maze=[[3,1,2],[0,1,1],[0,0,0],[0,0,0]];
// which would result in the maze being
//  + +-+-+
//  |     |
//  + +-+ +
//    |    
//  +-+-+-+
//  + + + +
//  +-+-+-+
//  + + + +
//  +-+-+-+
// and only the bottom two rows would be revealed until the maze is fully opened.
////////////////////////////////////////////////////////////////////////////////

/*[Maze Parameters]*/
// Is Maze hidden or visible?
type = "Hidden"; // [Hidden, Visible]
// Part(s) to generate
part = "noring"; // [all, noring, inside, outside, ring, test]
// Scale of Model
mazeScale = 1; //[.75:75%, 1:Full size]
// Maze Model Number
modelNumber="4";//[1,2,3,4,5,6,7,8,9,10]
// number of nubs in outside cylinder
nNubs = 1; //1 nub in outside cylinder for m04
           //3 nubs for m01, m02 and m03
// height of the bases
hBase = 5;					
// inner radius of inside cylinder
riMazeInside = 15;	//15 inner radius of inside cylinder for m04
                    //22 inner radius of inside cylinder for m01-3
// base Shell Thickness
shellThickness = 3;         
// space between inside and outside cylinders
tolerance = .4;  
// Slot for coins
add_bank_slot = 1; //[0:No,1:Yes]
coinWidth = 29; //29 for toonie
coinThickness = 2.8; //2.8 for toonie

/* [Hidden] */
m01=[[3,1,2],
     [0,1,1]];
/* [Hidden] */     
m02=[[2,1,3,2,3,2],
     [1,1,0,1,2,2],
     [1,3,2,1,0,1],
     [0,2,0,3,1,3],
     [1,0,3,1,2,1],
     [1,1,0,1,1,0]];
/* [Hidden] */     
m03=[[2,3,2,3,3,0],
     [0,2,3,0,1,1],
     [1,0,1,0,3,3],
     [1,3,1,2,0,2],
     [1,0,3,1,2,1],
     [0,1,1,0,1,1]];
/* [Hidden] */     
m04=[[2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
     [1,2,1,2,3,2,2,2,0,3,0,2,3,0,3,3],
     [0,3,1,2,2,2,2,1,1,3,1,1,1,1,0,3],
     [1,2,3,3,0,3,0,2,0,1,1,2,1,2,2,2],
     [2,0,2,0,2,0,0,3,0,1,0,1,2,2,1,2],
     [1,1,3,0,2,3,2,2,1,2,0,3,0,1,3,0],
     [0,1,2,3,0,2,0,2,2,2,0,0,3,0,0,3],
     [2,1,3,1,2,2,2,3,0,1,1,0,3,1,1,1],
     [0,2,2,0,0,2,3,3,1,0,0,1,0,3,3,2],
     [1,3,3,0,0,2,0,3,1,3,3,1,3,0,0,1],
     [1,0,1,0,1,1,0,1,0,0,0,1,1,0,1,1]];
     
rMazeThicknessVis = shellThickness + 2;		   // full thickness of inside cylinder
rMazeThicknessHid = shellThickness;			   // full thickness of inside cylinder
rMazeThicknessVisOutside = shellThickness;	   // full thickness of outside cylinder
rMazeThicknessHidOutside = shellThickness + 2; // full thickness of outside cylinder

maze=(modelNumber=="1")?m01:(modelNumber=="2")?m02:(modelNumber=="3")?m03:(modelNumber=="4")?m04:(modelNumber=="5")?m05:(modelNumber=="6")?m06:(modelNumber=="7")?m07:(modelNumber=="8")?m08:(modelNumber=="9")?m09:(modelNumber=="10")?m10:m01;

nRows = len(maze);
nCols = len(maze[0]);

rNubVis = 3*rMazeThicknessVis/5;
rNubHid = 3*rMazeThicknessHidOutside/5;

roMazeInsideVis = riMazeInside+rMazeThicknessVis;
roMazeInsideHid = riMazeInside+rMazeThicknessHid;
riMazeOutsideVis = roMazeInsideVis+tolerance;
riMazeOutsideHid = roMazeInsideHid+tolerance;
roMazeOutsideVis = riMazeOutsideVis+rMazeThicknessVisOutside;
roMazeOutsideHid = riMazeOutsideHid+rMazeThicknessHidOutside;

hRowVis = 6.28*roMazeInsideVis/(nNubs*nCols);
hRowHid = 6.28*roMazeInsideHid/(nNubs*nCols);

hMazeVis=hBase+nRows*hRowVis;
hMazeHid=hBase+nRows*hRowHid;

/* Scheme for creating multiple STLs involves a "part" variable. */
if (type == "Hidden")   {
    echo("Hidden Maze height is", hMazeHid, "mm");
    echo("Model numder ",modelNumber, "coordinates: ",maze);
    if (part == "inside")   { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideHid(); }
    else if (part == "outside") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeOutsideHid(); }
    else if (part == "ring") { 
        scale(mazeScale, mazeScale, mazeScale) 
            testNubRingHid(); }
    else if (part == "noring") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideHid(); 
        translate([0,(roMazeOutsideVis*2*mazeScale+5),0]) 
            scale(mazeScale, mazeScale, mazeScale) 
                mazeOutsideHid();
        }               
    else if (part == "all") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideHid(); 
        translate([0,(roMazeOutsideVis*2*mazeScale+5),0]) 
            scale(mazeScale, mazeScale, mazeScale) 
                mazeOutsideHid();
        translate([0,(roMazeOutsideVis*2*mazeScale+5)*2,0]) 
            scale(mazeScale, mazeScale, mazeScale) 
                testNubRingHid();
        }
    else if (part == "test") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideHid(); 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeOutsideHid();
        }                    
}
else {
    echo("Visible Maze height is ", hMazeVis, "mm");
    echo("Model numder ",modelNumber, "coordinates: ",maze);
    if (part == "inside")   { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideVis(); }
    else if (part == "outside") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeOutsideVis(); }
    else if (part == "ring") { 
        scale(mazeScale, mazeScale, mazeScale) 
            testNubRingVis(); }
     else if (part == "noring") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideVis(); 
        translate([0,(roMazeOutsideVis*2+5),0]) 
            scale(mazeScale, mazeScale, mazeScale) 
                mazeOutsideVis();
        }               
    else if (part == "all") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideVis(); 
        translate([0,(roMazeOutsideVis*2+5),0]) 
            scale(mazeScale, mazeScale, mazeScale) 
                mazeOutsideVis();
        translate([0,(roMazeOutsideVis*2+5)*2,0]) 
            scale(mazeScale, mazeScale, mazeScale) 
                testNubRingVis();
        }
    else if (part == "test") { 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeInsideVis(); 
        scale(mazeScale, mazeScale, mazeScale) 
            mazeOutsideVis();
        }        
}

module mazeInsideVis() {
	difference() {
		union() {
			// hex base
			cylinder(h=hBase, r=roMazeInsideVis, $fn=99);
			// main cylinder
			cylinder(h=hMazeVis, r=roMazeInsideVis, $fn=99);
		}
		// inside of main cylinder
		translate([0,0,hBase])
            cylinder(h=hMazeVis-hBase, r=riMazeInside, $fn=99);
		// grid of nubholes
		for (r=[0:nRows-1]) {
			for (c=[0:(nCols*nNubs-1)]) {
				rotate([0,0,360*c/(nCols*nNubs)])
				translate([0,0,-r*hRowVis])
				nubHoleVis();
			}
		}
		// path in from top
		for (C=[0:nNubs-1]) {
			rotate([0,0,360/nNubs*C+360*(0)/(nCols*nNubs)])
                translate([0,0,-(-1)*hRowVis])
                    nubPathVertVis();
		}
		// paths between nubholes
		for (r=[0:nRows-1]) {
			for (c=[0:(nCols-1)]) {
				if ((maze[r][c]==1)||(maze[r][c]==3)) { // path right
					for (C=[0:nNubs-1]) {
						rotate([0,0,360/nNubs*C+360*(c)/(nCols*nNubs)])
                            translate([0,0,-r*hRowVis])
                                nubPathHorizVis();
					}
				}
				if ((maze[r][c]==2)||(maze[r][c]==3)) { // path down
					for (C=[0:nNubs-1]) {
						rotate([0,0,360/nNubs*C+360*(c)/(nCols*nNubs)])
                            translate([0,0,-r*hRowVis])
                                nubPathVertVis();
					}
				}
			}
		}
	}
}

module testNubRingVis() {
	difference() {
		union() {
			// main cylinder
			cylinder(h=hRowVis, r=roMazeOutsideVis, $fn=99);
		}
		// inside of main cylinder
		translate([0,0,-1])
            cylinder(h=hRowVis+2, r=riMazeOutsideVis, $fn=99);
	}
	// nubs
	for (i=[0:nNubs-1]) {
		rotate([0,0,360*i/nNubs])
            translate([0,0,-(nRows-1)*hRowVis-hBase])
                nubVis();
	}
}

module mazeOutsideVis() {
	difference() {
		union() {
			// hex base
			cylinder(h=hBase, r=roMazeOutsideVis, $fn=99);
			// main cylinder
			cylinder(h=hMazeVis, r=roMazeOutsideVis, $fn=99);
		}
		// inside of main cylinder
        if (add_bank_slot == 1){
            union() {
                cube(size = [coinWidth,coinThickness,(hBase*2+.4)], center = true);
                    translate([0,0,hBase])
                        cylinder(h=hMazeVis-hBase, r=riMazeOutsideVis, $fn=99);
            }
        }
        else {
            translate([0,0,hBase])
                cylinder(h=hMazeVis-hBase, r=riMazeOutsideVis, $fn=99);
        }    
    }
	// nubs
	for (i=[0:nNubs-1]) {
		rotate([0,0,360*i/nNubs])
            nubVis();
	}
}

module nubVis() {
	rad1=6.28*riMazeOutsideVis/(3*nNubs*nCols);
	rad2=(6.28*riMazeOutsideVis/(3*nNubs*nCols)-rNubVis*tan(75/2));
	translate([0,0,hMazeVis-hRowVis/2-(0)*hRowVis])
	intersection() {
		translate([0,riMazeOutsideVis*(1-3.1415*(1/2)/(nNubs*nCols)/(tan(75/2))),0])
		intersection() {
			rotate([0,0,75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate([0,0,180-75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
		}
		rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
            translate([riMazeOutsideVis+0.1,0,0])
		rotate([0,0,90])
            polygon([[-rad1, 0],[-rad2,rNubVis],[rad2,rNubVis],[rad1,0]]);
	}
}

module nubHoleVis() {
	rad1=6.28*riMazeOutsideVis/(3*nNubs*nCols);
	rad2=(6.28*riMazeOutsideVis/(3*nNubs*nCols)-rNubVis*tan(75/2));
	translate([0,0,hMazeVis-hRowVis/2-(0)*hRowVis])
	intersection() {
		translate([0,roMazeInsideVis*(1-3.1415*(2/3)/(nNubs*nCols)/(tan(75/2))),0])
		intersection() {
			rotate([0,0,75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate([0,0,180-75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
		}
		rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
            translate([roMazeInsideVis+0.1,0,0])
		rotate([0,0,90])
            polygon([[-rad1, 0],[-rad2,rNubVis],[rad2,rNubVis],[rad1,0]]);
	}
}

module nubPathHorizVis() {
	rad1=6.28*riMazeOutsideVis/(3*nNubs*nCols);
	rad2=(6.28*riMazeOutsideVis/(3*nNubs*nCols)-rNubVis*tan(75/2));
	translate([0,0,hMazeVis-hRowVis/2-(0)*hRowVis])
	intersection() {
			rotate([0,0,360/(nNubs*nCols)])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate([0,0,180])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
			translate([roMazeInsideVis+0.1,0,0])
                rotate([0,0,90])
                    polygon([[-rad1, 0],[-rad2,rNubVis],[rad2,rNubVis],[rad1,0]]);
	}
}

module nubPathVertVis() {
	rad1=6.28*riMazeOutsideVis/(3*nNubs*nCols);
	rad2=(6.28*riMazeOutsideVis/(3*nNubs*nCols)-rNubVis*tan(75/2));
	translate([0,0,hMazeVis-hRowVis/2-(0)*hRowVis])
	intersection() {
		translate([0,roMazeInsideVis*(1-3.1415*(2/3)/(nNubs*nCols)/(tan(75/2))),0])
		intersection() {
			rotate([0,0,75/2])
			translate([50,0,0])
			cube([100,100,100],center=true);
			rotate([0,0,180-75/2])
			translate([50,0,0])
			cube([100,100,100],center=true);
		}
		rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
            translate([roMazeInsideVis+0.1,0,0])
                rotate([0,0,90])
                    polygon([[-rad1-hRowVis, 0],[-rad2-hRowVis,rNubVis],[rad2,rNubVis],[rad1,0]]);
	}
}

module mazeOutsideHid() {
	difference() {
		union() {
			// hex base
			cylinder(h=hBase, r=roMazeOutsideHid, $fn=99);
			// main cylinder
			cylinder(h=hMazeHid, r=roMazeOutsideHid, $fn=99);
		}
		// inside of main cylinder
        if (add_bank_slot == 1){
            union() {
                cube(size = [coinWidth,coinThickness,(hBase*2+.4)], center = true);
                translate([0,0,hBase])
                    cylinder(h=hMazeHid-hBase, r=riMazeOutsideHid, $fn=99);
            }
        }
        else {
            translate([0,0,hBase])
                cylinder(h=hMazeHid-hBase, r=riMazeOutsideHid, $fn=99);
        }    
		// grid of nubholes
		for (r=[0:nRows-1]) {
			for (c=[0:(nCols*nNubs-1)]) {
				rotate([0,0,360*c/(nCols*nNubs)])
				translate([0,0,-r*hRowHid])
				nubHoleHid();
			}
		}
		// path in from top
		for (C=[0:nNubs-1]) {
			rotate([0,0,360/nNubs*C+360*(0)/(nCols*nNubs)])
                translate([0,0,-(0)*hRowHid])
                    nubPathVertHid();
		}
		// paths between nubholes
		for (r=[0:nRows-1]) {
			for (c=[0:(nCols-1)]) {
				if ((maze[r][c]==1)||(maze[r][c]==3)) { // path right
					for (C=[0:nNubs-1]) {
						rotate([0,0,360/nNubs*C+360*(c)/(nCols*nNubs)])
                            translate([0,0,-r*hRowHid])
                                nubPathHorizHid();
					}
				}
				if ((maze[r][c]==2)||(maze[r][c]==3)) { // path down
					for (C=[0:nNubs-1]) {
						rotate([0,0,360/nNubs*C+360*(c)/(nCols*nNubs)])
                            translate([0,0,-(r+1)*hRowHid])
                                nubPathVertHid();
					}
				}
			}
		}
	}
}

module testNubRingHid() {
	difference() {
		union() {
			// main cylinder
			cylinder(h=hRowHid, r=roMazeInsideHid, $fn=99);
		}
		// inside of main cylinder
		translate([0,0,-1])
            cylinder(h=hRowHid+2, r=riMazeInside, $fn=99);
	}
	// nubs
	for (i=[0:nNubs-1]) {
		rotate([0,0,360*i/nNubs])
            translate([0,0,-(nRows-1)*hRowHid-hBase])
                nubHid();
	}
}

module mazeInsideHid() {
	difference() {
		union() {
			// hex base
			cylinder(h=hBase, r=roMazeInsideHid, $fn=99);
			// main cylinder
			cylinder(h=hMazeHid, r=roMazeInsideHid, $fn=99);
		}
		// inside of main cylinder
		translate([0,0,hBase])
            cylinder(h=hMazeHid-hBase, r=riMazeInside, $fn=99);
	}
	// nubs
	for (i=[0:nNubs-1]) {
		rotate([0,0,360*i/nNubs])
            nubHid();
	}
}

module nubHid() {
	rad1=6.28*roMazeInsideHid/(3*nNubs*nCols);
	rad2=(6.28*roMazeInsideHid/(3*nNubs*nCols)-rNubHid*tan(75/2));
	translate([0,0,hMazeHid-hRowHid/2-(0)*hRowHid])
	intersection() {
		translate([0,50-1+roMazeInsideHid,0])
            cube([100,100,100],center=true);
		translate([0,roMazeInsideHid*(1+3.1415*(1/2)/(nNubs*nCols)/(tan(75/2))),0])
		rotate([0,0,180])
		intersection() {
			rotate([0,0,75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate([0,0,180-75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
		}
		rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
            translate([roMazeInsideHid-0.1,0,0])
		rotate([0,0,-90])
            polygon([[-rad1, 0],[-rad2,rNubHid],[rad2,rNubHid],[rad1,0]]);
	}
}

module nubHoleHid() {
	rad1=6.28*roMazeInsideHid/(3*nNubs*nCols);
	rad2=(6.28*roMazeInsideHid/(3*nNubs*nCols)-rNubHid*tan(75/2));
	translate([0,0,hMazeHid-hRowHid/2-(0)*hRowHid])
	intersection() {
		translate([0,50-1+riMazeOutsideHid,0])
            cube([100,100,100],center=true);
		translate([0,riMazeOutsideHid*(1+3.1415*(2/3)/(nNubs*nCols)/(tan(75/2))),0])
		rotate([0,0,180])
		intersection() {
			rotate([0,0,75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate([0,0,180-75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
		}
		rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
		translate([riMazeOutsideHid-0.1,0,0])
            rotate([0,0,-90])
                polygon([[-rad1, 0],[-rad2,rNubHid],[rad2,rNubHid],[rad1,0]]);// */
	}
}
module nubPathHorizHid() {
	rad1=6.28*roMazeInsideHid/(3*nNubs*nCols);
	rad2=(6.28*roMazeInsideHid/(3*nNubs*nCols)-rNubHid*tan(75/2));
	translate([0,0,hMazeHid-hRowHid/2-(0)*hRowHid])
	intersection() {
			rotate([0,0,360/(nNubs*nCols)])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate([0,0,180])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
			translate([riMazeOutsideHid-0.1,0,0])
                rotate([0,0,-90])
                    polygon([[-rad1, 0],[-rad2,rNubHid],[rad2,rNubHid],[rad1,0]]);
	}
}
module nubPathVertHid() {
	rad1=6.28*roMazeInsideHid/(3*nNubs*nCols);
	rad2=(6.28*roMazeInsideHid/(3*nNubs*nCols)-rNubHid*tan(75/2));
	translate([0,0,hMazeHid-hRowHid/2-(0)*hRowHid])
	intersection() {
		translate([0,50-1+riMazeOutsideHid,0])
            cube([100,100,100],center=true);
		translate([0,riMazeOutsideHid*(1+3.1415*(2/3)/(nNubs*nCols)/(tan(75/2))),0])
		rotate([0,0,180])
		intersection() {
			rotate([0,0,75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
			rotate([0,0,180-75/2])
                translate([50,0,0])
                    cube([100,100,100],center=true);
		}
		rotate_extrude(convexity=10, twist=360/(nNubs*nCols), $fn=100) 
            translate([riMazeOutsideHid-0.1,0,0])
		rotate([0,0,-90])
            polygon([[-rad1-hRowHid, 0],[-rad2-hRowHid,rNubHid],[rad2,rNubHid],[rad1,0]]);
	}
}
