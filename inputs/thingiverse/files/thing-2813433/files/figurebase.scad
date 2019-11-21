// preview[view:south, tilt:top]

// The height of the base plate on which the figure is standing in mm
BASE_HEIGHT = 1.5;

// The diameter of the base plate in mm
BASE_DIAMETER = 20; 

// The percentage that the holder itself shall have in comparison to the base
HOLDER_BASE_RATIO = 60; // [1:100]

// The total height of the holder part in mm
HOLDER_HEIGHT = 7;

// The thickness of the cardboard of which the figure is made in mm
CARDBOARD_STRENGTH = 3;

// Include an additional small nose will be printed on the inside to hold the figure at the bottom
NOSE = 1; // [0: Leave away, 1: include]

// Indicates whether the holder brackets should be tilted or straight
TILT = 1; // [0: No tilting, 1: with tilting]

// Add a small gap between the nose and the base to keep the structure a little more flexible.
NOSE_GAP = 1; // [0: No gap, 1: Print gap]

/* [Hidden] */
cylinderRadius = 1;
noseHeight = 1;
noseWidth = 1;
noseGap = 0.5 * NOSE_GAP;    // Experimental: Should be printable without support...
holderThickness = 1.5;
    
union (){
    offset = CARDBOARD_STRENGTH/2+cylinderRadius;
    base();
    translate ([0, offset, BASE_HEIGHT])
    holder();

    translate ([0,-offset, BASE_HEIGHT])
    rotate([0,0,180])
    holder();
}

module base() 
{
    cylinder (d=BASE_DIAMETER, h=BASE_HEIGHT, $fn=128);
}

module holder()
{
    cubeBase = BASE_DIAMETER * HOLDER_BASE_RATIO/100;
    baseOverlap = BASE_HEIGHT/2;
    
    if (TILT)
        tiltedHolder (cubeBase, baseOverlap);
    else 
        untiltedHolder(cubeBase, baseOverlap);
}

module tiltedHolder (cubeBase, baseOverlap) {
    bendHeight = 1;
    totalHeight = HOLDER_HEIGHT-cylinderRadius/2;    
    
    translate ([-cubeBase/2,-holderThickness/2,0])
        union() {
            translate ([-1,holderThickness/2,HOLDER_HEIGHT-1])
                rotate ([0,90,0])
                    cylinder(r=cylinderRadius, h=cubeBase+2, $fn=64);

    polyhedron(
        points=[[0,holderThickness+noseHeight,-baseOverlap], // 0
                [0,noseHeight,-baseOverlap],  // 1
                [cubeBase,noseHeight,-baseOverlap],    // 2
                [cubeBase,holderThickness+noseHeight,-baseOverlap], // 3
    
                [0,holderThickness+noseHeight,bendHeight],   // 4
                [0,noseHeight,bendHeight],    // 5
                [cubeBase,noseHeight,bendHeight],  // 6
                [cubeBase,holderThickness+noseHeight,bendHeight], // 7
                [0,holderThickness,totalHeight],  // 8
                [0,0,totalHeight], // 9
                [cubeBase,0,totalHeight],   // 10
                [cubeBase,holderThickness,totalHeight],    // 11
    
                // Nose-points
                [cubeBase/2-noseWidth/2, noseHeight, noseGap],          // 12
                [cubeBase/2-noseWidth/2, 0, noseGap],   // 13
                [cubeBase/2+noseWidth/2, 0, noseGap],   // 14
                [cubeBase/2+noseWidth/2,noseHeight, noseGap],          // 15
                [cubeBase/2-noseWidth/2, noseHeight, bendHeight],           // 16
                [cubeBase/2+noseWidth/2, noseHeight, bendHeight],           // 17
                [cubeBase/2-noseWidth/2, 0, totalHeight],    // 18
                [cubeBase/2+noseWidth/2, 0, totalHeight],    // 19
                ], 
        faces = (NOSE) ? getFacesForTiltedNose(): getFacesWithoutTiltedNose()        
    );}
}

function getFacesForTiltedNose() = 
     [[0,3,2,1],   // Bottom
    [0,1,5,4],      // Left bottom
    [4,5,9,8],      // Left top
    [1,12,16,18,9,5],
    [1,2,15,12],
    [2,6,10,19,17,15],
    [12,13,18,16],
    [15,17,19,14],
    [15,14,13,12],
    [13,14,19,18],
    [8,9,18,19,10,11],    // Top
    [2,3,7,6],      // Right Bottom
    [6,7,11,10],    // Right top
    [3,0,4,7],      // Back bottom
    [7,4,8,11],      // Back top
    [5,6,10,9],     // Front top
    ];

function getFacesWithoutTiltedNose() =
    [[0,3,2,1],   // Bottom
    [0,1,5,4],      // Left bottom
    [4,5,9,8],      // Left top
    [1,2,6,5],      // Front bottom
    [5,6,10,9],     // Front top
    [8,9,10,11],    // Top
    [2,3,7,6],      // Right Bottom
    [6,7,11,10],    // Right top
    [3,0,4,7],      // Back bottom
    [7,4,8,11]      // Back top
    ];

module untiltedHolder(cubeBase, baseOverlap){
    translate ([-cubeBase/2,-holderThickness/2,0])
        union() {
            translate ([-1,holderThickness/2,HOLDER_HEIGHT-1])
                rotate ([0,90,0])
                    cylinder(r=cylinderRadius, h=cubeBase+2, $fn=64);
            if (NOSE) {
                translate([0.5+cubeBase/2,0.5,HOLDER_HEIGHT-1])
                    rotate([90,180,0])
                        prism(noseWidth, HOLDER_HEIGHT-1, noseHeight, 0.5);
            }
            translate([0,0,-baseOverlap])
                cube ([BASE_DIAMETER * HOLDER_BASE_RATIO/100, holderThickness, HOLDER_HEIGHT - 1 + baseOverlap]);
        }
}

 module prism(x, y, z, base) {
     polyhedron(
        points=[[0,0,base], [x,0,base], [x,y,z+base], [0,y,z+base], [0,0,0], [x,0,0], [x,y,0], [0,y,0]],
        faces=[[2,6,7,3], [0,1,2,3], [0,3,7,4], [2,1,5,6], [0,4,5,1], [5,4,7,6]]
     );
 } 
 