use <MCAD/involute_gears.scad>

// preview[view:west, tilt:top]

//Rotation of the servo in degrees
Rot = 0;	//[0:180] 
//Display Assembled or printable
assembly = 0;//[0:Assembled,1:Printable - Gears,2:Printable - Bottom Plate,3:Printable - Top Plate,4:Printable - Arms,5:Printable - Grippers,6:Printable - Servo Rotation Mount]
//Number of gear stages
Gear_Stages = 1; //[0:Direct,1:Single Reduced,2:Double Reduced]
//Display Sizing Target
show_target = 1;//[1:Show,0:Hide]
//Size of the target object
target_side = 50; //[5:200]

//Move Target Object
target_translation = 110; //[0:200]
//Show Top Plate
hide_coverplate = 1; //[0:Show,1:Hide]

//Length of arms
arm_length = 45;//[5:70]	
//Width of arms		
arm_width = 8;//[5:15]
//Thickness of arms (and gears)	
arm_thickness = 5;//[2:8]

grip_angle = 15*2;
//Offset between gear arms and free arms
freeArmStay_Offset = 32;//[10:50]
// length of gripper hand
hand_length = 30;//[10:70]
//Gripper thickness
GripPlate_height = 15;//[10:50]
Gear_thickness = arm_thickness;
//Number of teeth on the small gears
Gear_Teeth = 10;

Gear_Pitch = 400;
//Space between gears (smaller is tighter)
Gear_Play = 0.2;

Small_Gear_rad = (Gear_Teeth * Gear_Pitch / 180)/2;
Large_Gear_rad = (Gear_Teeth*2 * Gear_Pitch / 180)/2;
//Size of joining holes (PLA filliment can be used)
Screw_Size = 3;
//Fudge factor for joining holes
Screw_play = 0.1;
//Cover plate thickness
plate_thickness = 3;//[1:5]


// Calculated
Screw_Hole = Screw_Size + Screw_play;
Small_Gear_Pos = (Small_Gear_rad+Gear_Play/2);
Arm_Gear_Pos = (Small_Gear_rad*2)*Gear_Stages+Large_Gear_rad+(Gear_Play*(Gear_Stages*2));
grip_offset = arm_length + Arm_Gear_Pos;

$fn=2*20;



gear_pos_small_l1 = [0,(Small_Gear_rad+Gear_Play/2),Gear_thickness];
gear_pos_small_r1 = [0,-(Small_Gear_rad+Gear_Play/2),0];
gear_pos_small_l2 = [0,(Small_Gear_rad+Gear_Play/2)*3,0];
gear_pos_small_r2 = [0,-(Small_Gear_rad+Gear_Play/2)*3,0];
gear_pos_large_r = [0,-Arm_Gear_Pos,0];
gear_pos_large_l = [0,Arm_Gear_Pos,0];

freeArmStay_pos_r = [(freeArmStay_Offset*cos(30)),-grip_offset+((freeArmStay_Offset*sin(30)))+arm_length,0];
freeArmStay_pos_l = [(freeArmStay_Offset*cos(30)),grip_offset-((freeArmStay_Offset*sin(30)))-arm_length,0];

Grip_pos_l = [(arm_length*sin(Rot/2)),grip_offset-(arm_length*(1-cos(Rot/2))),-arm_thickness-0.3];
Grip_pos_r = [(arm_length*sin(Rot/2)),-grip_offset+(arm_length*(1-cos(Rot/2))),-arm_thickness-0.3];

GripPlate_pos_l = [(arm_length*sin(Rot/2))+(freeArmStay_Offset*cos(grip_angle))+(hand_length),grip_offset-(arm_length*(1-cos(Rot/2)))+(freeArmStay_Offset*(-sin(grip_angle))),0];
GripPlate_pos_r = [(arm_length*sin(Rot/2))+(freeArmStay_Offset*cos(grip_angle))+(hand_length),-grip_offset+(arm_length*(1-cos(Rot/2)))+(freeArmStay_Offset*(sin(grip_angle))),0];

if(assembly == 0){
claw_assembled();
}
else{
print_plate();
}
module claw_assembled() {
	
	
	if(show_target){translate([target_translation,0,0])cube([target_side,target_side,target_side],true);}

	if (Gear_Stages >= 1){
	translate(gear_pos_small_l1)rotate([0,180,Rot+(90*Gear_Stages+90)])ServoGear();
	translate(gear_pos_small_r1)rotate([0,0,-Rot+(90*Gear_Stages+90)])GearSmallL();
		if (Gear_Stages >= 2){
			translate(gear_pos_small_l2)rotate([0,0,-Rot+(90)])GearSmallL();
			translate(gear_pos_small_r2)rotate([0,0,-Rot])GearSmallL();
		}
	}
	translate(gear_pos_large_l)rotate([0,0,-Rot/2])GearArmL(arm_length);
	translate(gear_pos_large_r)rotate([0,0,Rot/2])GearArmR(arm_length);
	translate(freeArmStay_pos_r)rotate([0,0,Rot/2])FreeArmStayR(arm_length);
	translate(freeArmStay_pos_l)rotate([0,0,-Rot/2])FreeArmStayL(arm_length);
	translate(Grip_pos_l)rotate([0,0,-grip_angle])GripL();
	translate(Grip_pos_r)rotate([0,0,grip_angle])GripR();
	translate(GripPlate_pos_l)rotate([0,0,-90])grip_plate();
	translate(GripPlate_pos_r)rotate([0,0,90])grip_plate();
	
	if(hide_coverplate == 0){translate([0,0,Gear_thickness+2])cover_plate();}
	translate([0,0,-2])Servo_plate();
	if(Gear_Stages >= 1){
		translate([-Small_Gear_rad*1.5 - 16,0,2])rotate([0,90,0])claw_rotate_plate();
	}
	else{
		translate([-Large_Gear_rad*1.5 - 16,0,2])rotate([0,90,0])claw_rotate_plate();
	}
}

module print_plate() {

	if(assembly == 6){claw_rotate_plate();}
	if(assembly == 5){rotate([0,90,0])grip_plate();}
	if(assembly == 5){
		if(GripPlate_height<((hand_length*0.7)*2)){
			translate([GripPlate_height*1.5,0,0])rotate([0,90,0])grip_plate();
		}
		else{
			translate([0,((hand_length*0.7)*3),0])rotate([0,90,0])grip_plate();
		}
		
	}

	if(assembly == 2){rotate([0,180,])Servo_plate();}
	if(assembly == 3){cover_plate();}
	if(assembly == 1){
		if (Gear_Stages >= 2){translate([0,-Small_Gear_rad*3.6,0])GearSmallL();	}
		if (Gear_Stages >= 2){translate([0,Small_Gear_rad*3.6,0])rotate([0,0,90])GearSmallL();}
		if (Gear_Stages >= 1){translate([0,Small_Gear_rad*1.2,0])GearSmallL();}
		if (Gear_Stages >= 1){translate([0,-Small_Gear_rad*1.2,0])ServoGear();}
		translate([Small_Gear_rad*1.2 + Large_Gear_rad*1.2,0,0])rotate([0,0,180])GearArmR(arm_length);
		translate([-Small_Gear_rad*1.2 - Large_Gear_rad*1.2,0,0])GearArmL(arm_length);
	}
	if(assembly == 4){
		translate([0,-arm_width*0.7,0])rotate([0,0,90])FreeArmStayL(arm_length);
		translate([0,arm_width*0.7,0])rotate([0,0,-90])FreeArmStayR(arm_length);
		translate([0,arm_width*2,0])rotate([0,0,180])GripR();
		translate([0,-arm_width*2,0])rotate([0,0,180])GripL();
	}
	//translate([4.5,2,-2.4])rotate([0,180,-60])med_servo_holder();
}


module claw_rotate_plate() {
			
	difference(){
		union() {
			cylinder(r=12.5,h=4);
			translate([0,0,8])cube([7,20,12],true);
		}
		union() {
			translate([0,0,8])cube([8,6,20],true);
			translate([-9,0,-1])cylinder(r=1.5,h=30);
			translate([9,0,-1])cylinder(r=1.5,h=30);
			translate([-15,5,11])rotate([0,90,0])cylinder(r=1.5,h=30);
			translate([-15,-5,11])rotate([0,90,0])cylinder(r=1.5,h=30);
		}
	}
}

module grip_plate() {
	
	difference(){
		union() {
			translate([8,0,0])cube([4,(hand_length*0.7)*2,GripPlate_height],true);
			beam(8);	
		}
		translate([14,0,0])cube([8,20,20],true);
	}

}

module med_servo_holder() {
	union() {
	translate([-14,0,-1.4])cube([3,18,2],true);
	difference(){	
			union() {	
				cube([45,18,11],true);
				translate([19,0,7])difference(){
					cube([7,18,5],true);
					translate([-1.7,0,-0.5])cube([5,14,3.1],true);
				}
			}
		union(){
			translate([8,0,-6])cylinder(r=4.5,h=12);
			translate([4,0,-6])cylinder(r=3.4,h=12);
			translate([0,-6.5,5])cube([38,1,3],true);
			translate([0,6.5,5])cube([38,1,3],true);
			translate([0,0,3])cube([31,14,11],true);
			translate([-17.5,0,-6])cylinder(r=1.7,h=12);
			translate([17.5,0,-6])cylinder(r=1.7,h=12);
			translate([0,0,-4.4])cube([46,19,4],true);
		}
	}
}
}

module Servo_plate() {
	difference(){
		union() {
			empty_plate();
			if (Gear_Stages >= 1){
				translate([-Small_Gear_rad*1.5,0,0])difference(){
					cube([20,20,plate_thickness],true);
					union() {
						translate([-5,5,-4])cylinder(r=Screw_Hole/2,h=15);
						translate([-5,-5,-4])cylinder(r=Screw_Hole/2,h=15);
					}
				}
			}
			else {
				translate([-Large_Gear_rad*1.5,0,0])difference(){
					cube([20,20,plate_thickness],true);
					union() {
						translate([-5,5,-4])cylinder(r=Screw_Hole/2,h=15);
						translate([-5,-5,-4])cylinder(r=Screw_Hole/2,h=15);
					}
				}
			}
			translate([4.5,2,-3.9])rotate([0,180,-60])med_servo_holder();		
		}
		union() {
			plate_holes();
			translate(gear_pos_small_r1+[0,0,-5-plate_thickness/2])rotate([0,0,-60])cube([6,6,10],true);
		}
	}
}

module cover_plate() {
	difference(){
		union() {
			empty_plate();
			if (Gear_Stages >= 1){
				translate([-Small_Gear_rad*1.5,0,0])difference(){
					cube([20,20,plate_thickness],true);
					union() {
						translate([-5,5,-4])cylinder(r=Screw_Hole/2,h=15);
						translate([-5,-5,-4])cylinder(r=Screw_Hole/2,h=15);
					}
				}
			}
			else {
				translate([-Large_Gear_rad*1.5,0,0])difference(){
					cube([20,20,plate_thickness],true);
					union() {
						translate([-5,5,-4])cylinder(r=Screw_Hole/2,h=15);
						translate([-5,-5,-4])cylinder(r=Screw_Hole/2,h=15);
					}
				}
			}
		}
		plate_holes();
	}
}

module plate_holes() {
	union() {
			if (Gear_Stages >= 1){
				translate(gear_pos_small_l1+[0,0,-10])cylinder(r=6,h=9);
				translate(gear_pos_small_r1+[0,0,-10])cylinder(r=Screw_Hole/2,h=15);
				if (Gear_Stages >= 2){
					translate(gear_pos_small_l2+[0,0,-10])cylinder(r=Screw_Hole/2,h=15);
					translate(gear_pos_small_r2+[0,0,-10])cylinder(r=Screw_Hole/2,h=15);
				}
			}
			translate(gear_pos_large_r+[0,0,-10])cylinder(r=Screw_Hole/2,h=15);
			translate(gear_pos_large_l+[0,0,-10])cylinder(r=Screw_Hole/2,h=15);
			translate(freeArmStay_pos_r + [0,0,-10])cylinder(r=Screw_Hole/2,h=15);
			translate(freeArmStay_pos_l + [0,0,-10])cylinder(r=Screw_Hole/2,h=15);
		}
}


module empty_plate() {

	if (Gear_Stages >= 1){
		translate([0,0,-plate_thickness/2])polyhedron(
		points = [
			gear_pos_large_r + [-0,-5,0],	
			gear_pos_large_l + [-0,5,0],
			gear_pos_large_r + [-Small_Gear_rad*1.5,-0,0],	
			gear_pos_large_l + [-Small_Gear_rad*1.5,0,0],
			freeArmStay_pos_r + [5,-5,0],
			freeArmStay_pos_l + [5,5,0],
			gear_pos_large_r + [-0,-5,plate_thickness],
			gear_pos_large_l + [-0,5,plate_thickness],
			gear_pos_large_r + [-Small_Gear_rad*1.5,0,plate_thickness],	
			gear_pos_large_l + [-Small_Gear_rad*1.5,0,plate_thickness],
			freeArmStay_pos_r + [5,-5,plate_thickness],
			freeArmStay_pos_l + [5,5,plate_thickness]
		],
		triangles = [
			[4,5,1,3,2,0],
			[10,6,8,9,7,11],
			[3,9,8,2],
			[0,2,8,6],
			[7,9,3,1],
			[11,7,1,5],
			[4,0,6,10],
			[5,4,10,11]
		]
		);
	}
	else {
		translate([0,0,-plate_thickness/2])polyhedron(
		points = [
			gear_pos_large_r + [-0,-Large_Gear_rad*0.5,0],	
			gear_pos_large_l + [-0,Large_Gear_rad*0.5,0],
			gear_pos_large_r + [-Large_Gear_rad*1.5,-0,0],	
			gear_pos_large_l + [-Large_Gear_rad*1.5,0,0],
			freeArmStay_pos_r + [5,-5,0],
			freeArmStay_pos_l + [5,5,0],
			gear_pos_large_r + [-0,-Large_Gear_rad*0.5,plate_thickness],
			gear_pos_large_l + [-0,Large_Gear_rad*0.5,plate_thickness],
			gear_pos_large_r + [-Large_Gear_rad*1.5,0,plate_thickness],	
			gear_pos_large_l + [-Large_Gear_rad*1.5,0,plate_thickness],
			freeArmStay_pos_r + [5,-5,plate_thickness],
			freeArmStay_pos_l + [5,5,plate_thickness]
		],
		triangles = [
			[4,5,1,3,2,0],
			[10,6,8,9,7,11],
			[3,9,8,2],
			[0,2,8,6],
			[7,9,3,1],
			[11,7,1,5],
			[4,0,6,10],
			[5,4,10,11]
		]
		);
	}
}

module Servo_Mount_Holes() {
	union() {
		translate([0,0,0])cylinder(r=6,h=9);
		translate([0,0,0])cylinder(r=3,h=11);
		translate([26.5,0,-4.3])cylinder(r=1.55,h=10);
		translate([26.5,0,6],$fn=6)cylinder(r=3,h=3);
	}
}

module beam(l=20) {
	translate([0,-arm_width/2,0])difference(){
			union() {
				cube([l,arm_width,arm_thickness]);
				translate([l,arm_width/2,0])cylinder(r=arm_width/2,h=arm_thickness);
				translate([0,arm_width/2,0])cylinder(r=arm_width/2,h=arm_thickness);
			}
			union() {
				translate([l,arm_width/2,-1])cylinder(r=Screw_Hole/2,h=arm_thickness+2);
				translate([0,arm_width/2,-1])cylinder(r=Screw_Hole/2,h=arm_thickness+2);
			}
		}
}

module GripR() {
	beam(freeArmStay_Offset);
	translate([freeArmStay_Offset,0,0])rotate([0,0,-grip_angle])beam(hand_length);
}

module GripL() {
	beam(freeArmStay_Offset);
	translate([freeArmStay_Offset,0,0])rotate([0,0,grip_angle])beam(hand_length);
}

module FreeArmStayR(l=38) {
	rotate([0,0,-90])beam(l);
}

module FreeArmStayL(l=38) {
	rotate([0,0,90])beam(l);
}


module GearSmallL() {
	rotate([0,0,90])gear (number_of_teeth=Gear_Teeth,
					circular_pitch=Gear_Pitch,
					gear_thickness = Gear_thickness,
					rim_thickness = Gear_thickness,
					hub_thickness = Gear_thickness,
					hub_diameter = 0,
					bore_diameter = Screw_Hole,
					circles=0);
}

module GearArmR(l=38) {
	rotate([0,0,-90])difference(){
		union() {
			rotate([0,0,45])gear (number_of_teeth=2*Gear_Teeth,
								circular_pitch=Gear_Pitch,
								gear_thickness = Gear_thickness,
								rim_thickness = Gear_thickness,
								hub_thickness = Gear_thickness,
								hub_diameter = 0,
								bore_diameter = Screw_Hole,
								circles=0);
			
			beam(l);
		}
	}
}

module GearArmL(l=38) {
	rotate([0,0,90])difference(){
		union() {
			gear (number_of_teeth=2*Gear_Teeth,
								circular_pitch=Gear_Pitch,
								gear_thickness = Gear_thickness,
								rim_thickness = Gear_thickness,
								hub_thickness = Gear_thickness,
								hub_diameter = 0,
								bore_diameter = Screw_Hole,
								circles=0);
			
			beam(l);
		}
		if (Gear_Stages == 0){
			translate([0,0,1.5])cylinder(r=2.9,h=Gear_thickness);
		}
	}
}

module ServoGear() {

difference(){
	gear (number_of_teeth=Gear_Teeth,
					circular_pitch=Gear_Pitch,
					gear_thickness = 0,
					rim_thickness = Gear_thickness,
					hub_thickness = Gear_thickness+4,
					hub_diameter = 9,
					bore_diameter = Screw_Hole,
					circles=0);
	
	translate([0,0,1.5])cylinder(r=3.1,h=Gear_thickness+4);
}

}