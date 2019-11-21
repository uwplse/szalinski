/* 
    Customizable Curved LEGO Brick
        Steve Medwin
        December 2014
*/

// Parameters
$fn=200*1;       // set print resolution
studDistance = 8*1; // all dimensions in mm
studDiameter = 4.9*1; // 
studHeight = 1.7*1;
clearance = 0.1*1; // degrees
studDiaClearance = 5.0*1;
studHeightClearance = 2.0*1;
minimumWall = 1.0*1;
radialClearance = 0.1 * 1;
chamferBottom = 0.4 * 1;

// number of studs
Radius = 6; // [6,7,8,9,10]
radiusStud = Radius;
radialDist = radiusStud * studDistance;
// number of studs around curve
Tangential_Studs = 4;  // [1,2,3,4,6,9]
tangentialStuds = Tangential_Studs;
// number of studs perpendicular to curve
Radial_Studs = 2;  // [1,2,3,4,5,6]
radialStuds = Radial_Studs;
totalStuds = 36*1; // try 18, 36, 72 but (totalStuds / tangentialStuds) must be an integer
arcStud = 360 / totalStuds;
// set thickness factor
Brick_Thickness = 1; // [0.3333,1,2]
brickHeight = 9.6 * Brick_Thickness;
// print bottom?
Bottom = "Yes"; // [Yes, No]

initialAngle = arcStud/2 - clearance;
initialDist = tan(initialAngle) * radialDist;
edgeDist = initialDist - studDiameter/2;

if (edgeDist < minimumWall) {   
    echo ("Warning: Walls too thin");
    }  

// Create curved solid
insideRadius = radialDist - studDistance/2 + radialClearance;
outsideRadius = radialDist + studDistance * (radialStuds -1) + studDistance/2 - radialClearance;
difference() {
    intersection() {
        rotate_extrude(convexity = 10) 
        translate([insideRadius, 0, 0]) 
        square ([outsideRadius - insideRadius, brickHeight]);
    triangle ();
    }
    if (Bottom == "Yes") {
        bottom();
        chamfer();
    }
}

// Add studs
for (i = [0:tangentialStuds-1]) {      // tangential
    for (j = [0: radialStuds-1])  { // radial
        rotate(a=[0,0, - initialAngle - i * arcStud]) 
        translate([0, radialDist + j * studDistance, brickHeight])  
        cylinder(h = studHeight, r=studDiameter/2);
        }
    }

// Subtract bottom
module bottom(){
    bottomLength = studDistance * (radialStuds - 1) + studDiaClearance + radialClearance*2;
    for (i = [0:tangentialStuds - 1]) {
        rotate(a=[0,0, - initialAngle - i * arcStud])  
        translate([0,radialDist - studDiaClearance/2 + bottomLength/2 - radialClearance, 0.1]) 
        cube(size = [studDiameter, bottomLength,studHeightClearance*2 + 0.1], center = true);
    }
}

// Subtract chamfer
module chamfer(){
    bottomLength = studDistance * (radialStuds - 1) + studDiaClearance + radialClearance*2;
    for (i = [0:tangentialStuds - 1]) {
        rotate(a=[0,0, - initialAngle - i * arcStud])  
        translate([0,radialDist - studDiaClearance/2 + bottomLength/2 - radialClearance, 0.1]) 
        cube(size = [studDiaClearance, bottomLength,chamferBottom*2 + 0.1], center = true);
    }
}
// Triangular solid used to intersect with extruded ring
//   This approach only works for 90 degree bricks with radisu <13
module triangle(){
/* 
    Point map for polyhedron:
         Lower             Upper
        1               4
         |\              |\
         | \             | \
         |__\            |__\
        0    2          3    5
*/
yy = outsideRadius * 1.5;
zz = brickHeight *1.5;
theta = arcStud * tangentialStuds - 2 * clearance;
diff_theta = 90 - theta;
ttx = yy * cos (diff_theta);
tty = yy * sin (diff_theta);
    
//   Note: use "faces" not "triangles" for new version of OpenSCAD
polyhedron(
    points=[[0,0,0],[0,yy,0],[ttx,tty,0],[0,0,zz],[00,yy,zz],[ttx,tty,zz]],
    triangles=[[0,1,4],[0,4,3],[3,4,5],[0,2,1],[0,5,2],[0,3,5],[1,2,4],[2,5,4]]
    );
}


