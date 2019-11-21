//The filament diameter (use 2.0 for 1.75mm filament)
FILAMENT_DIA = 2.0;

//The Bowden tube diameter (a 4.0mm is usually used for 1.75mm filament, this is used to space out a cylindrical section in the filament guide to guide the bowden tube)
BOWDEN_TUBE_DIA = 4.0;

//The diameter of the filament drive gear (the one that sits on the stepper and drives the filament)
FILAMENT_DRIVE_GEAR_DIA = 11.0;

//Spacing that should be kept around the diameter of the filament drive gear 
FILAMENT_DRIVE_GEAR_SPACING = 1.0;

//The diameter of the filament guiding gear (usually some kind of bearing)
FILAMENT_GUIDE_GEAR = 13.0;

//Spacing that should be kept around the diameter of the filament guiding gear 
FILAMENT_GUIDE_GEAR_SPACING = 0.75;

//The extruder drive type, choose right or left depending on your gear.
EXTRUDE_DRIVE_TYPE = 1; // [1:RIGHT,-1:LEFT]

/* [Hidden] */

$main=0;
$fn=200;

module FilamentGuide() {
    
    MOTOR_SIDE = 42;
    MOTOR_LENGTH = 48;
    MOTOR_CENTER_RING_DIA = 22;
    MOTOR_CENTER_RING_HEIGTH = 2;
    MOTOR_AXIS_DIA = 5;
    MOTOR_AXIS_HEIGTH = 24;
    small_height = 0.0000000000001;
    type = EXTRUDE_DRIVE_TYPE;
    
    module tools() {
        //Stepper model
        translate([0,0,MOTOR_LENGTH/2])cube([MOTOR_SIDE,MOTOR_SIDE,MOTOR_LENGTH],center=true);
        translate([0,0,MOTOR_LENGTH+MOTOR_CENTER_RING_HEIGTH/2])cylinder(d=MOTOR_CENTER_RING_DIA,h=MOTOR_CENTER_RING_HEIGTH,center=true);
        translate([0,0,MOTOR_LENGTH+MOTOR_CENTER_RING_HEIGTH])cylinder(d=MOTOR_AXIS_DIA,h=MOTOR_AXIS_HEIGTH,center=true);
        //filament drive model
        translate([0,0,MOTOR_LENGTH+4.5/2])difference() {
            union() {
                cube([42,42,4.5],center=true);
                translate([-42/2+9.5/2,0,4.5/2+12/2])cube([9.5,42,12],center=true);
                //bowden tube
                color("white")translate([-42/2,type*(42/2-15),12/2+2])rotate([0,90,0])cylinder(d=BOWDEN_TUBE_DIA,h=25,center=true);
                //filament 1.75mm (2mm channel)
                color("white")translate([-42/2,type*(42/2-15),12/2+2])rotate([0,90,0])cylinder(d=FILAMENT_DIA,h=100,center=true);
                //bowden tube connector
                color("silver")translate([-42/2,type*(42/2-15),12/2+2])rotate([0,90,0])cylinder(d=13,h=15,center=true);
                //spring connector
                color("silver")translate([-42/2,type*(-42/2+10),12/2+2])rotate([0,90,0])cylinder(d=9, h=30,center=true);
            }
            //cylinder(d=MOTOR_CENTER_RING_DIA,h=2*4.5,center=true);
        }
        //filament drive gear
        color("silver")translate([0,0,MOTOR_LENGTH+4.5/2])cylinder(d=FILAMENT_DRIVE_GEAR_DIA+2*FILAMENT_DRIVE_GEAR_SPACING,h=40,center=true);
        //filament guide gear
        color("silver")translate([0,type*(11/2+13/2),MOTOR_LENGTH+4.5/2])cylinder(d=FILAMENT_GUIDE_GEAR+2*FILAMENT_GUIDE_GEAR_SPACING,h=40,center=true);
        //screws M3
        color("silver")translate([-31/2,31/2,MOTOR_LENGTH+4.5/2])translate()cylinder(d=3.5,h=50,center=true);
        color("silver")translate([-31/2,-31/2,MOTOR_LENGTH+4.5/2])translate()cylinder(d=3.5,h=50,center=true);
    }
  
    module assembly() {
        difference() {
            translate([-42/4,0,MOTOR_LENGTH+7])cube([42/2-1,41,24],center=true);
            translate([-42/4+7,type*(-42/4),MOTOR_LENGTH+7])cube([42/4,42/2,30],center=true);
            translate([-42/4+7,type*(+42/4+10),MOTOR_LENGTH+7])cube([42/4,42/2,30],center=true);
        }
    }
    
    difference() {
        assembly();
        #tools();
    }
}

if ($main!=1) {
    FilamentGuide();
}
