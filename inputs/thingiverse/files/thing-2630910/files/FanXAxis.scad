/*
*** Nema 17 Stepmotor cooling fan Mount ***

You have to slide this mount over the back side of the step motor so the air flows over the whole body.

To use this design you will have to measure a couple of distances on you step motor and cooling fan. You will have to round every measurement off to 0.5, 0.25, 0.125,... . OpenSCAD can't work with other values.
The motor length is the length of the body of the step motor. The motor width is the width of the body. Because these motors are almost always square there is only one parameter. In the zip folder you will  find a schematic of the step motor. On this sheet you will find the same values as in this code file.
The outer fan width is the size of the fan you bought. In most cases if you buy a 40mm fan this is the outer width. The fan diameter is the diameter of the blades, this is a little bit smaller than the outer width. Further you have to measure the bolt hole diameter. The special distance is the distance between the outer edge and the edge of the bolt hole. This is needed to calculate the position of the holes to bolt the fan on the mount.
The last parameters are especially for the mount. You can adjust this to the specifics you want. WallThickness is the thickness of the wall. BottomThickness is the thickness of the bottomplate. Wingheight is the height of each wing.

After adjusting all the different parameters to your own specifications, you press F6 to render the design. Then you can save it to a STL file.

*/
//*** Parameters ***
//[mm]Round off to 0.5, 0.25, 0.125,...
//Motor
MotorLength = 48;           //[mm] Length of the body of the step motor.
MotorWidth = 42.5;          //[mm] Width of the body.

//Fan
FanOuterWidth = 40;         //[mm] Size of the fan
FanDiameter = 37;           //[mm] Diameter of the fan blades
FanHoleDiameter = 3.5;      //[mm] Diameter of the bolt hole
SpecialDist = 2;            //[mm] distance between the outer edge and the edge of the bolt hole

//Mount
WallThickness = 1;          //[mm] Thickness of the wall
BottomThickness = 3;        //[mm] Thickness of the bottomplate
WingHeigth = 4;             //[mm] Height of the wings


//*** Calculated Mount Parameters ***
MountWidth = MotorWidth + 1;
MountLength = MotorLength * (3/4);
FanHolePos = (FanOuterWidth/2) - ((FanHoleDiameter/2)+ SpecialDist);
echo("MountWidth [mm]: ", MountWidth);
echo("MountLength [mm]: ", MountLength);
echo("FanHolePos [mm]: ", FanHolePos);

$fn=100;    //Hole Resolution

//*** Mount ***
color("plum")union(){
    //*** BottomPlate + Holes Fan
    echo("Calculate Bottomplate with fan holes");
    color("salmon")union(){
        //Bottomplate with the holes
        color("blue")translate([0,0,(BottomThickness/2)])difference(){
            cube([MountWidth,MountWidth,BottomThickness], center=true);
            cylinder(h=BottomThickness*2, d=FanDiameter, center=true);
            translate([FanHolePos,FanHolePos,0])cylinder(h=BottomThickness*3, d=FanHoleDiameter, center=true);
            translate([-FanHolePos,FanHolePos,0])cylinder(h=BottomThickness*3, d=FanHoleDiameter, center=true);
            translate([-FanHolePos,-FanHolePos,0])cylinder(h=BottomThickness*3, d=FanHoleDiameter, center=true);
            translate([FanHolePos,-FanHolePos,0])cylinder(h=BottomThickness*3, d=FanHoleDiameter, center=true);
            };
            
        //Extra cilinders above fan bolt holes
        difference(){
            translate([FanHolePos,FanHolePos,BottomThickness])cylinder(h=BottomThickness, d=FanHoleDiameter*2);
            translate([FanHolePos,FanHolePos,0])cylinder(h=BottomThickness+9, d=FanHoleDiameter);
            };
        difference(){
            translate([-FanHolePos,FanHolePos,BottomThickness])cylinder(h=BottomThickness, d=FanHoleDiameter*2);
            translate([-FanHolePos,FanHolePos,0])cylinder(h=BottomThickness+9, d=FanHoleDiameter);
            };
        difference(){
            translate([-FanHolePos,-FanHolePos,BottomThickness])cylinder(h=BottomThickness, d=FanHoleDiameter*2);
            translate([-FanHolePos,-FanHolePos,0])cylinder(h=BottomThickness+9, d=FanHoleDiameter);
            };
        difference(){
            translate([FanHolePos,-FanHolePos,BottomThickness])cylinder(h=BottomThickness, d=FanHoleDiameter*2);
            translate([FanHolePos,-FanHolePos,0])cylinder(h=BottomThickness+9, d=FanHoleDiameter);
            };
        };    
    echo("Done creating the bottom plate with bolt holes");

    //Calculate the body
    echo("Calculate bodyposition");
    tmp = (MountWidth-4)/5;
    x0 = (MountWidth)/2;      y0 = (MountWidth)/2;
    x1 = x0;                y1 = y0 - 2;
    x2 = x1 + WingHeigth;   y2 = y1;
    x3 = x2;                y3 = y1 - tmp;
    x4 = x0;                y4 = y3;
    x5 = x0;                y5 = y4 - tmp;
    x6 = x2;                y6 = y5;
    echo("Done calculating bodyposition");

    //Create the body
    echo("Create the body");
    color("brown")linear_extrude(height = MountLength){
        union(){
            //Top
            color("red")difference(){
                offset(delta=WallThickness){
                    polygon(points=[[-x0,-y0],[-x1,-y1],[-x2,-y2],[-x3,-y3],[-x4,-y4],[-x5,-y5],[-x6,-y6],[-x6,y6],[-x5,y5],[-x4,y4],[-x3,y3],[-x2,y2],[-x1,y1],[-x0,y0],[-x0+1,y0],[-x0+1,-y0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    }
                    polygon(points=[[-x0,-y0],[-x1,-y1],[-x2,-y2],[-x3,-y3],[-x4,-y4],[-x5,-y5],[-x6,-y6],[-x6,y6],[-x5,y5],[-x4,y4],[-x3,y3],[-x2,y2],[-x1,y1],[-x0,y0],[-x0+3,y0],[-x0+3,-y0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    };
            //Bottom
            color("green")difference(){
                offset(delta=WallThickness){
                    polygon(points=[[x0,-y0],[x1,-y1],[x2,-y2],[x3,-y3],[x4,-y4],[x5,-y5],[x6,-y6],[x6,y6],[x5,y5],[x4,y4],[x3,y3],[x2,y2],[x1,y1],[x0,y0],[x0-1,y0],[x0-1,-y0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    }
                    polygon(points=[[x0,-y0],[x1,-y1],[x2,-y2],[x3,-y3],[x4,-y4],[x5,-y5],[x6,-y6],[x6,y6],[x5,y5],[x4,y4],[x3,y3],[x2,y2],[x1,y1],[x0,y0],[x0-3,y0],[x0-3,-y0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    };
            //Left    
            color("lightblue")difference(){
                offset(delta=WallThickness){
                    polygon(points=[[-y0,-x0],[-y1,-x1],[-y2,-x2],[-y3,-x3],[-y4,-x4],[-y5,-x5],[-y6,-x6],[y6,-x6],[y5,-x5],[y4,-x4],[y3,-x3],[y2,-x2],[y1,-x1],[y0,-x0],[y0,-x0+1],[-y0,-x0+1]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    }
                    polygon(points=[[-y0,-x0],[-y1,-x1],[-y2,-x2],[-y3,-x3],[-y4,-x4],[-y5,-x5],[-y6,-x6],[y6,-x6],[y5,-x5],[y4,-x4],[y3,-x3],[y2,-x2],[y1,-x1],[y0,-x0],[y0,-x0+3],[-y0,-x0+3]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    };
            //Right
            color("pink")difference(){
                offset(delta=WallThickness){
                    polygon(points=[[-y0,x0],[-y1,x1],[-y2,x2],[-y3,x3],[-y4,x4],[-y5,x5],[-y6,x6],[y6,x6],[y5,x5],[y4,x4],[y3,x3],[y2,x2],[y1,x1],[y0,x0],[y0,x0-1],[-y0,x0-1]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    }
                    polygon(points=[[-y0,x0],[-y1,x1],[-y2,x2],[-y3,x3],[-y4,x4],[-y5,x5],[-y6,x6],[y6,x6],[y5,x5],[y4,x4],[y3,x3],[y2,x2],[y1,x1],[y0,x0],[y0,x0-3],[-y0,x0-3]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,0]], convexity=10);
                    };
                };
            };
    echo("Done creating the body");
        
    //Fill in the gaps
    echo("Fill in the gaps");
        linear_extrude(height = BottomThickness){
            color("Darkgreen")union(){
                //Top
                color("orange")polygon(points=[[x0,-y0],[x1,-y1],[x2,-y2],[x3,-y3],[x4,-y4],[x5,-y5],[x6,-y6],[x6,y6],[x5,y5],[x4,y4],[x3,y3],[x2,y2],[x1,y1],[x0,y0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12]], convexity=10);
                //Bottom
                color("blue")polygon(points=[[-x0,-y0],[-x1,-y1],[-x2,-y2],[-x3,-y3],[-x4,-y4],[-x5,-y5],[-x6,-y6],[-x6,y6],[-x5,y5],[-x4,y4],[-x3,y3],[-x2,y2],[-x1,y1],[-x0,y0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12]], convexity=10);
                //Left
                color("Purple")polygon(points=[[-y0,-x0],[-y1,-x1],[-y2,-x2],[-y3,-x3],[-y4,-x4],[-y5,-x5],[-y6,-x6],[y6,-x6],[y5,-x5],[y4,-x4],[y3,-x3],[y2,-x2],[y1,-x1],[y0,-x0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12]], convexity=10);
                //Right
                color("gray")polygon(points=[[-y0,x0],[-y1,x1],[-y2,x2],[-y3,x3],[-y4,x4],[-y5,x5],[-y6,x6],[y6,x6],[y5,x5],[y4,x4],[y3,x3],[y2,x2],[y1,x1],[y0,x0]], paths=[[1,2,3,4],[5,6,7,8],[9,10,11,12]], convexity=10);
                };
            };
    echo("Done filling in the gaps");
};