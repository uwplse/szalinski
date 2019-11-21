//total height of the cup
height = 80;
//diameter of the top of the cup
outerTopD = 80;
//diameter of the bottom of the cup
outerBottomD = 60;
//resolution of the render, more = smoother but longer to compute, must be an even number.
Q = 50;

/* [Hidden] */
//how thick the cup wall will be
thickness = 1;
//height of the bottom fold over part of the cup
foldHeight = 7;
//extra render to keep empty edges from displaying weird
skinClear = .001;
 
//radius of the outer top
x1 = outerTopD/2;
//radius of the outer bottom
x2 = outerBottomD/2;
//height of the top of the cup
y1 = height;
//height of the bottom of the cup
y2 = 0;
//slope of the outside edge of the cup
slope = (y1 - y2)/(x1 - x2);
//length of the edge of the cup
b = y2 - slope*x2;
//radius of the cup at the foldHeight
foldHeightRadius = (foldHeight - b)/slope;
echo(foldHeightRadius);
//diameter of the bottom of the inside of the cup (at foldHeight)
foldHeightDiameter = foldHeightRadius*2;
echo(foldHeightDiameter);
//height of the inside of the cup
h2 = height - foldHeight;
//Rim Roll Radius
Rr = 1.25;
 
//inner top and bottom diameters are the same as outside - the thickness of the cup
innerTopD = outerTopD - thickness;
innerBottomD = foldHeightDiameter - thickness;
//Diameter of the outer circle that is the bottom of the cup - the thickness = the inner diameter.
foldBottomD = outerBottomD - thickness;

//This helps set a thickness where the inside of the cup meets the bottom of the cup, a thickness of 1 is too much so this is to make the model render safely.
wiggleRoom = .1;

//this is the Rim Roll seam
//translate([0, (outerTopD/2)+(thickness/2.25), height-Rr/2])
//rotate([0, 90, 0])
//cylinder(d1=Rr*2+thickness/4, d2=Rr-thickness/2, h=8, $fn=Q);
 
//This section creates a tapered cylinder and a rim roll and combines(unions) them. Then it calculates two more cylinders to cut out(differences) of the first cylinder to create the inside of the cup and the turn under area; leaving a base.
color("white"){
difference(){
    union(){
cylinder (d1=outerBottomD, d2=outerTopD, h=height, $fn=Q);
        // This is the rim roll
rotate_extrude(convexity = 10, $fn = Q)
translate([(outerTopD/2)+(thickness/2.25), (height-Rr/2), 0])
    circle(r = Rr, $fn = Q);
    }
    translate([0,0,foldHeight])
cylinder (d1=innerBottomD, d2=innerTopD, h=h2+skinClear, $fn=Q);
    translate([0,0,0-skinClear])
cylinder (d1=foldBottomD-skinClear, d2=innerBottomD, h=foldHeight-wiggleRoom, $fn=Q);
}
}

//This is a triangle to simulate the side seam
p1 = [0, (outerBottomD/2), 0];
p2 = [0, (outerTopD/2), height];
                vector = [p2[0] - p1[0], p2[1] - p1[1], p2[2] - p1[2]];
                distance = sqrt(pow(vector[0], 2) + pow(vector[1], 2) + pow(vector[2], 2));
                translate(vector/2 + p1)
                //rotation of XoY plane by the Z axis with the angle of the [p1 p2] line projection with the X axis on the XoY plane
                rotate([0, 0, atan2(vector[1], vector[0])]) //rotation
                //rotation of ZoX plane by the y axis with the angle given by the z coordinate and the sqrt(x^2 + y^2)) point in the XoY plane
                rotate([0, atan2(sqrt(pow(vector[0], 2)+pow(vector[1], 2)),vector[2]), 0])
    rotate([0,0,90])
    translate([0, .17, 0])
    scale([6,.9,1])
color("WhiteSmoke"){
                cylinder(d1=1, d2=1, h = distance, center = true, $fn=3);
    //linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    //polygon(points=[[outerBottomD/2,0],[outerBottomD/2+thickness,0],[outerBottomD/2,4]], paths=[[0,1,2]]);
}
//end!
 