//Gear Board

//Gear Radius
GearRadius = 30;

//Gear Height
GearHeight = 3;

//Base Height
BaseHeight = 3;

//Hole Radius
HoleRadius = 5;

//Tolerance
Tolerance = 0.2;

//Base
cube([GearRadius*6,GearRadius*6,BaseHeight]);

//Axle 1
translate([GearRadius,GearRadius,BaseHeight]){
    color("red")
    cylinder(GearHeight*2,HoleRadius-Tolerance,HoleRadius-Tolerance,$fn = 100);
}

//Axle 2
translate([GearRadius*3,GearRadius,BaseHeight]){
    color("orange")
    cylinder(GearHeight*2,HoleRadius-Tolerance,HoleRadius-Tolerance,$fn = 100);
}

//Axle 3
translate([GearRadius*5,GearRadius,BaseHeight]){
    color("yellow")
    cylinder(GearHeight*2,HoleRadius-Tolerance,HoleRadius-Tolerance,$fn = 100);
}

//Axle 4
translate([GearRadius*3,GearRadius*3,BaseHeight]){
    color("green")
    cylinder(GearHeight*2,HoleRadius-Tolerance,HoleRadius-Tolerance,$fn = 100);
}

//Axle 5
translate([GearRadius*3,GearRadius*5,BaseHeight]){
    color("blue")
    cylinder(GearHeight*2,HoleRadius-Tolerance,HoleRadius-Tolerance,$fn = 100);
}

//Axle 6
translate([GearRadius,GearRadius*5,BaseHeight]){
    color("purple")
    cylinder(GearHeight*2,HoleRadius-Tolerance,HoleRadius-Tolerance,$fn = 100);
}

//Axle 7
translate([GearRadius*5,GearRadius*5,BaseHeight]){
    color("pink")
    cylinder(GearHeight*2,HoleRadius-Tolerance,HoleRadius-Tolerance,$fn = 100);
}
