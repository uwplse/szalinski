//Minutes Mount Diameter
Minutes=5.55;

//Hours Mount Diameter
Hours=3.72;

//Printing Tolerance
Tolerance=0.5;

//Display and Printing
Display=0; //[0:All, 1:Minutes, 2:Hours]

/* [Hidden] */
$fn=60;


difference() {
union() {
if ( Display == 0 || Display == 1 )
translate([0,0,5])
difference()
ClockNeedle(64,10,2,1,1.5,1.5,1,9,8);


if ( Display == 0 || Display == 2 )
translate([0,0,0.8])
//rotate([0,0,90])
ClockNeedle(45,10,2,1,1.5,1.5,1,10,9);
}


translate([0,0,2.75]) {
//Minutes
translate([0,0,3.2])
cylinder(3,Hours/2+Tolerance/2,Hours/2+Tolerance/2,,true);
    

//Hours
translate([0,0,-1.2])
cylinder(6.4,Minutes/2+Tolerance/2,Minutes/2+Tolerance/2,true);
    

//Clock Barrel
translate([0,0,-9.5/2-4/2-0.1])
cylinder(9.5,7.65/2,7.65/2,true);
}
}


module ClockNeedle(Length,Tail,BodyHeight,BodyRounding,ShapeHeight,EndRounding,TailRounding,BodyLowerRounding,BodyUpperRounding) {
hull() {
translate([0,Length,0])
intersection() {
sphere(EndRounding/2,true);
translate([0,0,EndRounding/2])
    cube(EndRounding,true);
}

cylinder(BodyHeight,BodyLowerRounding/2,BodyUpperRounding/2,false);
    

translate([0,-Tail,0])
intersection() {
sphere(TailRounding/2,true);
translate([0,0,TailRounding/2])
    cube(TailRounding,true);
}


translate([0,0,BodyHeight+ShapeHeight])
sphere(BodyRounding/2,true);
}
}















