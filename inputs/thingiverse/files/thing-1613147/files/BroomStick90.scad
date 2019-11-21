// Broom Handle Screw End Cap
// Modification of Broom Handle Screw End Plug by Ed Nisley KE4ZNU March 2013
//PI
PI = 3.14159265358979;
//Print Wall Thickness
WThick=2.5;
//Broom Handle Diameter
PostOD = 24;
//Length of Hole for Broom Handle
PostLength = 25.0;
//Thread small diameter
PitchDia = 15.5;
//Length of Screw
ScrewLength = 20.0;
//Thread Outer Diameter
ThreadFormOD = 2.5;
//Thread Pitch
ThreadPitch = 5.0;
//Rotation of thread relateve to leg (if mop head has to be in a particulate rotation)
ThreadRotation=0;
//Top ID marking (to identify thread rotations if printing multiple options at once)
ThreadID="1";
$fn=8*4;

module Cyl_Thread(pitch,length,pitchdia,cyl_radius,resolution=32) {

Cyl_Adjust = 1.25;                      // force overlap

    Turns = length/pitch;
    Slices = Turns*resolution;
    RotIncr = 1/resolution;
    PitchRad = pitchdia/2;
    ZIncr = length/Slices;
    helixangle = atan(pitch/(PI*pitchdia));
    cyl_len = Cyl_Adjust*(PI*pitchdia)/resolution;

    union() {
        for (i = [0:Slices-1]) {
            translate([PitchRad*cos(360*i/resolution),PitchRad*sin(360*i/resolution),i*ZIncr])
                rotate([90+helixangle,0,360*i/resolution])
                    cylinder(r=cyl_radius,h=cyl_len,center=true,$fn=12);
        }
    }
}

difference(){
    union() {
		//Thread post
        translate([0,0,-PostOD-WThick*2])cylinder(r=PitchDia/2,h=ScrewLength+PostOD+WThick*2);
		//Thread on post
        rotate([0,0,ThreadRotation])translate([0,0,0])
                Cyl_Thread(ThreadPitch,(ScrewLength - ThreadFormOD/2),PitchDia,ThreadFormOD/2);
		//Block and round sections of broom stick head
        translate([-PostOD/2-WThick,0,-PostOD-WThick*2])cube([PostOD+WThick*2,PostLength+WThick,PostOD/2+WThick]);
        translate([0,0,-PostOD/2-WThick])rotate([-90,0,0])cylinder(d=PostOD+WThick*2,h=PostLength+WThick);
    }
    union(){
		//Broom Stick Cut Out
        translate([0,WThick,-PostOD/2-WThick])rotate([-90,0,0])cylinder(d=PostOD,h=PostLength+WThick);
		//Chanfers for Bottom Block
        translate([PostOD/2+WThick,PostLength/2,-PostOD-WThick*2])
            rotate([0,45,0])
                cube([WThick*2,PostLength+WThick*4,WThick*2],center=true);
        translate([-PostOD/2-WThick,PostLength/2,-PostOD-WThick*2])
            rotate([0,45,0])
                cube([WThick*2,PostLength+WThick*4,WThick*2],center=true);
        translate([-PostOD/2-WThick,0,-PostLength/2])
            rotate([0,0,45])
                cube([WThick*2,WThick*2,PostLength*2],center=true);
        translate([PostOD/2+WThick,0,-PostLength/2])
            rotate([0,0,45])
                cube([WThick*2,WThick*2,PostLength*2],center=true);
		translate([-PitchDia,0,-PostOD-WThick*2])rotate([120,0,0])cube([PitchDia*2,PitchDia*2,PitchDia*2]);
		//Marking for top of screw
        translate([0,0,ScrewLength])
			linear_extrude(height=2,center=true){
				text(text=ThreadID,valign="center",halign="center",font="Arial Black",size=6.5);
			}
    }
}