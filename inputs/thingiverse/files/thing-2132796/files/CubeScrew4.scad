/*********************************************************************

    Cube Puzzle
    ===========

        OpenSCAD code by Ronaldo Persiano
        for a 
        Design by George Hart

    The puzzle was designed by Geoge Hart and published in one of 
    his puzzle pages:

        http://georgehart.com/Puzzles/CubePuzzle

    It consists of two identical pieces that match to form a cube
    by turning one piece in respect to the other. The two pieces are
    separated by cutting the cube by a helicoid surface.

    This code models a puzzle cube very similar to the Hart's one 
    but it is based just on his description and images and may be 
    a bit different.

    Code Parameters

    The gap parameter defines the absolute gap in mm between two 
    assembled pieces. The default value is just a guide. Depending 
    on the calibration of the 3D printer, it is possible to reduce 
    the gap to get a better fit. The surface refinements increase 
    as the gap is reduced.

    The code generates 3 different presentations selected by the 
    parameter build. When build=="one_piece", just one piece of the 
    puzzle is generated; this is the usual presentation for producing
    a stl file for 3D printing purposes. When build=="assembled", two 
    pieces in different colors are generated in the assembled position 
    forming the cube. When build=="assembling", it is possible to see
    the assembling in any step by changing the parameter assemblyAngle;
    it also possible to have a dinamic view of the assembling with 
    View/Animate. 

    Some model variations are possible by changing two variables in 
    the section [Model variations]. The variable helixPitchRatio, 
    which defaults is 1, is a factor that defines the pitch of the 
    helicoidal surface that cuts the cube: it is multipied to the nominal
    pitch of sqrt(2)*cubeSize. The helixRotation adds a rotation to the
    helicoid about its axis. Try animate it with build = "assembled" 
    and helixRotation = 360*$t!

    For well calibrated 3D printers, it is possible to print two 
    pieces at a time interlocked in the assembled position. In this 
    case, generate the stl file with build="assembled". Some tests may
    be required to set an appropriate gap. This technique is 
    specially recomended when a value of helixPitchRatio is set well 
    smaller than 1 as a piece printed alone may require support. If a
    double extruder printer is not available, print two cubes with
    different colors and swap two pieces to get two bi-color sets. 
    Give the extra set to a friend!

***********************************************************************/

/* [Cube parameters] */
// Cube puzzle size in mm
    cubeSize = 50;
// to generate a STL for printing choose "one piece"
    build = 1; // [1:one_piece, 2:assembling, 3:assembled]
// rotational angle in "assembling" option
    assemblyAngle = 0; // [-720:720]
// Allowance between two assembled puzzle pieces in mm
    gap = 0.2; // [0.1,0.15,0.2,0.25,0.3,0.35,0.4]
/* [Model variations] */
// Ratio of the helicoid pitch in respect to the nominal
    helixPitchRatio = 1;
// Rotation angle of the helicoid about its own axis [1,-1,0]
    helixRotation = 0;

// Main code starts here

pitch   = sqrt(2)*cubeSize*helixPitchRatio;
refine  = floor(cubeSize/gap/7);

if(build==1) {
    // just one piece to generate stl
    render()
        translate([0,0,cubeSize/2])
            rotate([90,0,0])
                puzzlePiece(cubeSize,pitch,refine);
}
else if(build==3) {
    // two pieces assembled in a cube
    // the render of it may be used to print the two pieces in a go
    color("red") render()
    translate([0,0,cubeSize/2])
        rotate(180,[1,-1,0])
        rotate([90,0,0])
            puzzlePiece(cubeSize,pitch,refine);
    render()
    translate([0,0,cubeSize/2])
        rotate([90,0,0])
            puzzlePiece(cubeSize,pitch,refine);
}
else if(build==2) { 
    // animate to see the assembling twists
    ang = assemblyAngle+360*4*$t*(1-$t)/helixPitchRatio
            - 360*(1/helixPitchRatio-1); 
    color("red") render()
        translate([0,0,cubeSize/2])
            translate([-1,1,0]*pitch*(1/2-ang/360)/sqrt(2))
                rotate(ang,[1,-1,0])
                    rotate([90,0,0])
                        puzzlePiece(cubeSize,pitch,refine);
    render()
        translate([0,0,cubeSize/2])
            rotate([90,0,0])
                puzzlePiece(cubeSize,pitch,refine);
}
else {
    // gap visualization for tests
    color("red") 
        translate([0,-gap/2,0]) 
            cube([gap/10,gap,gap/10]);
    render()
    difference(){
        cube(cubeSize-0.1,center=true);
        puzzlePiece(cubeSize,pitch,refine);
        rotate(180, [1,0,1])
            puzzlePiece(cubeSize,pitch,refine);
        translate([-100,-100,0])   
            cube(200);
    }
}

// Modules and functions

// one piece of the cube puzzle
module puzzlePiece(size, h, refine) {
    r    = size;
    turn = 2*ceil(sqrt(2)*size/h)-1;
    intersection(){
        cube(cubeSize,center=true);
        rotate([0,45,0]) rotate(helixRotation+90)
            translate([0,0,-h*turn/2])
                helicalVolume(r,h,turn, refine, gap); 
    }
}

module helicalVolume(r, h, turn, n, gap)
    linear_extrude(height=turn*h, twist=-360*turn,$fn=n) 
        // scale up the shape to avoid polygon point eliminations
        scale(1/100) polygon(100*shape(r, h/4, n, gap)); 

// horizontal planar shape for extruding
function shape(r, h, n=20, gap) =  
    concat(  [for (i=[n:-1:-n]) hlxpoint(h,gap/2,r*i/n)],  
             [ [r,-r], [r,r]] );

// this computation is needed to have an uniform gap between pieces
// the intersection point of the the XY plane and the helix through 
// point rotY(atan(y*PI/h), [x,y,0])
function hlxpoint(h,x,y) =
    let( b  = atan(y*PI/h),
         cb = cos(b),
         sb = sin(b),
         a  = -x*sb*180/h,
         ca = cos(a),
         sa = sin(a) )
    [ca*(x*cb) - sa*y, sa*(x*cb) + y*ca];

