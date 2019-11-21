/*
Made by Dsphar

All measurments in millimeters

LARGEST_TIRE_DIAMETER: Tire diameter including tread
MM_BETWEEN_AXLES: Distance from center of front axle to center of rear axle
MAX_WHEELBASE_WIDTH: Distance from outside of rear tire to outside of rear tire
MIN_WHEELBASE_WIDTH: Distance from inside of front tire to inside of front tire
SCREW_HOLE_DIAMETER: Mounting screw hole-size. Add 1-2mm to thread diameter
SCREW_HOLE_ANGLE: Mounting screw angle. 0=flat
WALL_THICKNESS: Thickness of all walls
TOTAL_WALL_HEIGHT: Height of outside wall
BASE_PLATE_HEIGHT: Height of crossbeams
*/

////-------------Begin Inputs------------------

LARGEST_TIRE_DIAMETER = 46; 
MM_BETWEEN_AXLES = 130;
MAX_WHEELBASE_WIDTH = 103;
MIN_WHEELBASE_WIDTH = 70;
SCREW_HOLE_DIAMETER = 6;
SCREW_HOLE_ANGLE = 20;
WALL_THICKNESS = 3;
TOTAL_WALL_HEIGHT = 20;
BASE_PLATE_HEIGHT = 5;
TEXT = "My Fast Car!";
FONT_SIZE = 9;
FONT_THICKNESS = 2;

////---------------End Inputs------------------

TireSlotLength = LARGEST_TIRE_DIAMETER*0.8;
OutsideWidth = 2*WALL_THICKNESS+MAX_WHEELBASE_WIDTH + 4;
OutsideLength = MM_BETWEEN_AXLES+TireSlotLength+2*WALL_THICKNESS;
TireSlotWidth = (MAX_WHEELBASE_WIDTH - MIN_WHEELBASE_WIDTH)/2 + 2;

//OutsideCube
difference() {
difference() {
translate([0,0,TOTAL_WALL_HEIGHT/2])
difference() { 
    cube([OutsideLength,OutsideWidth,TOTAL_WALL_HEIGHT],true);
    cube([OutsideLength-2*WALL_THICKNESS,OutsideWidth-2*WALL_THICKNESS,TOTAL_WALL_HEIGHT+0.5],true);
};

translate([OutsideLength/2-SCREW_HOLE_DIAMETER*2-WALL_THICKNESS,OutsideWidth/2+SCREW_HOLE_DIAMETER/2,SCREW_HOLE_DIAMETER*1.1])
rotate([90-SCREW_HOLE_ANGLE,0,0])
cylinder(TOTAL_WALL_HEIGHT*2,SCREW_HOLE_DIAMETER/2,SCREW_HOLE_DIAMETER/2);
};
translate([-(OutsideLength/2-SCREW_HOLE_DIAMETER*2),OutsideWidth/2+SCREW_HOLE_DIAMETER/2,SCREW_HOLE_DIAMETER*1.1])
rotate([90-SCREW_HOLE_ANGLE,0,0])
cylinder(TOTAL_WALL_HEIGHT*2,SCREW_HOLE_DIAMETER/2,SCREW_HOLE_DIAMETER/2);
}


//WheelBase
module buildTireBox(directionX, directionY){
translate(directionX*[MM_BETWEEN_AXLES/2,directionY*((OutsideWidth-TireSlotWidth)/2 - WALL_THICKNESS),0])
 difference() {
    square([TireSlotLength+2*WALL_THICKNESS,TireSlotWidth+2*   WALL_THICKNESS],true);
    square([TireSlotLength+.5,TireSlotWidth+.5],true);
 }
}

module buildCrossBeam(rotateDirection){
    rotate(rotateDirection*atan((OutsideWidth-TireSlotWidth*2-WALL_THICKNESS)/(       MM_BETWEEN_AXLES-TireSlotLength+WALL_THICKNESS*2)))
    square([sqrt(pow(OutsideWidth-TireSlotWidth*2-WALL_THICKNESS*2,2)+pow(MM_BETWEEN_AXLES-TireSlotLength,2))-WALL_THICKNESS,WALL_THICKNESS],true);
}

linear_extrude(BASE_PLATE_HEIGHT, true)
union() {
    buildTireBox(1,1);
    buildTireBox(1,-1);
    buildTireBox(-1,1);
    buildTireBox(-1,-1);
    buildCrossBeam(1);
    buildCrossBeam(-1);
}

translate([0,-OutsideWidth/2+0.5,TOTAL_WALL_HEIGHT/2])
rotate([90,180,0])
linear_extrude(FONT_THICKNESS, true)
text(TEXT, size=FONT_SIZE, halign="center",valign="center" );




 
 