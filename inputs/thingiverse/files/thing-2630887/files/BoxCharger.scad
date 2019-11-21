/*This file contains the code used to drawn the box that fits a OnePlus X charger. The variables under this text wil adjust the generated design.
*/
//----------Variables----------
//Body
WallThickness = 1.5;
BottomThickness = 2;
BodyHeight = 53;
BodyLength = 24;
BodyWidth = 35.5;
BigHoleWidth = 12;
BigHoleLength = 30;
SmallHoleWidth = 7;
SmallHoleLength = 38;

//Triangle
TriangleWidth=2;
TriangleLength=6;
TriangleThick=3;

//----------Code----------
//Support
translate([BodyLength/2+1+TriangleWidth,0,0])cylinder(BodyHeight-4.5,1,0.75,$fn = 100);
translate([-(BodyLength/2+1+TriangleWidth),0,0])cylinder(BodyHeight-4.5,1,0.75,$fn = 100);

//Total body
color("green")union(){
    //Body
    color("orange")union(){
        //Bottom plate
        color("gray")union(){
            translate([10,0,BottomThickness/2])cube([4, BodyWidth+WallThickness, BottomThickness], center=true);
            translate([-10,0,BottomThickness/2])cube([4, BodyWidth+WallThickness, BottomThickness], center=true);
        };

        
        //Body
        color("lightblue")union(){
            //Front
            color("red")translate([12.5, 0, (BodyHeight+BottomThickness)/2])difference(){
                cube([WallThickness, BodyWidth+(2*WallThickness), BodyHeight+BottomThickness], center=true);
                translate([0,8,BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,8,-BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,8,-2])cube([WallThickness*2, BigHoleWidth, BigHoleLength], center=true);
                translate([0,-8,BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,-8,-BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,-8,-2])cube([WallThickness*2, BigHoleWidth, BigHoleLength], center=true);
                };
                
            //Back
            color("green")translate([-12.5, 0,(BodyHeight+BottomThickness)/2])difference(){
                cube([WallThickness,35.5+(2*WallThickness),BodyHeight+BottomThickness], center=true);
                translate([0,8,BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,8,-BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,8,-2])cube([WallThickness*2,BigHoleWidth,BigHoleLength], center=true);
                translate([0,-8,BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,-8,-BigHoleLength/2-2])rotate([0,90,0])cylinder(WallThickness*2,d=BigHoleWidth,center=true,$fn=100);
                translate([0,-8,-2])cube([WallThickness*2,BigHoleWidth,BigHoleLength], center=true);
                };
            
            //Left
            color("blue")translate([0,(BodyWidth+WallThickness)/2, (BodyHeight+BottomThickness)/2])difference(){
                cube([BodyLength, WallThickness, BodyHeight+BottomThickness], center=true);
                translate([5,0,SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([5,0,-SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([5,0,0])cube([SmallHoleWidth, WallThickness*2, SmallHoleLength], center=true);
                translate([-5,0,SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([-5,0,-SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([-5,0,0])cube([SmallHoleWidth, WallThickness*2, SmallHoleLength], center=true);
                };
            
            //Right
            color("orange")translate([0,-(BodyWidth+WallThickness)/2, (BodyHeight+BottomThickness)/2])difference(){
                cube([BodyLength, WallThickness, BodyHeight+BottomThickness], center=true);
                translate([5,0,SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([5,0,-SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([5,0,0])cube([SmallHoleWidth, WallThickness*2, SmallHoleLength], center=true);
                translate([-5,0,SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([-5,0,-SmallHoleLength/2])rotate([90,0,0])cylinder(WallThickness*2,d=SmallHoleWidth,center=true,$fn=100);
                translate([-5,0,0])cube([SmallHoleWidth,WallThickness*2, SmallHoleLength], center=true);
                };
        };
    };

    //Triangle
    color("pink")translate([16,-1,(BodyHeight-5)])rotate([0,0,90])polyhedron(points=[[0,0,0], [TriangleWidth,0,0], [TriangleWidth,TriangleThick,0], [0,TriangleThick,0], [0,TriangleThick,TriangleLength], [TriangleWidth,TriangleThick,TriangleLength]], faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
    
    color("black")translate([-16,1,(BodyHeight-5)])rotate([0,0,-90])polyhedron(points=[[0,0,0], [TriangleWidth,0,0], [TriangleWidth,TriangleThick,0], [0,TriangleThick,0], [0,TriangleThick,TriangleLength], [TriangleWidth,TriangleThick,TriangleLength]],faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
};