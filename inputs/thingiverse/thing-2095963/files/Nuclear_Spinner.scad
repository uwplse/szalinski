/*=========================================
Program Name :	EDC Nuclear Spinner
Base Language:	English
Created by   :	Esmarra
Creation Date:  08/02/2017
Rework date entries:
Program Objectives:
Observations:
	You Will Need Chamfer library installed:
		http://www.thingiverse.com/thing:1305888
		https://github.com/SebiTimeWaster/Chamfers-for-OpenSCAD/releases
		
Special Thanks:
	@SebiTimeWaster for is lib
=========================================*/

include <Chamfers-for-OpenSCAD/Chamfer.scad>;

// preview[view:south, tilt:top]

// Set Detail (Rendering:40 Printing:120)
arm_fn = 40 ;  // [40,120]

// Which one would you like to see?
part = "cal_bearing"; // [cal_bearing:Bearing Calibration,final:Main Body]


/* [Spinner] */
// How long do you want the arm to be?
arm_distance= 39 ; // [38:50]
//Default 39

// How manny arms?
number_of_arms = 3 ; //[2:5]
// Tri-Spinner -> 3

// Set Cut Angle
tab_extra_angle = 5 ;
// Default 5

// Center Radius Grip Ring
center_r = 7 ;
// Default 7

// Outter Bearing Distance to Wall
bearing_distance_to_wall= 2 ;
//Default 2

// To Use Chanfer Donwload Nuclear_Spinner.scad and open on PC
chanfer = "true" ; // [ture,false]

// Set Chamfer Unit
chamfer_unit=1.5 ;


/* [Printer] */
// If your Calibration doesn't fit increase this. Else descreasing untill you get a tight fit.
printer_threshold= 0.15 ;
// My Printer 0.21


/* [Bearing] */
// #### 608 Bearing Settings #### 
bearing_dia=22+printer_threshold*2 ;
bearing_inner_dia= 8 ;
bearing_thickness=7.2 ;
// ===== #### =====










/* [Hidden] */
angle=360/number_of_arms;
tab_angle = 360/number_of_arms - 60 -tab_extra_angle ;
main_angle_z=angle/2 ; // Set Zero angle
arm_length=arm_distance-bearing_distance_to_wall-bearing_dia/2 ; // Work Arround arm distance
extra_cut=100 ; // IF THE CUT BUGGS INCREASE THIS
$fn=arm_fn;
/* ====== */

//=======  MAIN  =======

//cal_bearing();
//final();
print_part();



//======= Modules =======
module bearing(){
	cylinder(d=bearing_dia,h=bearing_thickness+2,center=true,$fn=arm_fn); // Bearing
}

module cal_bearing(){
	difference(){
		cylinder(d=bearing_dia+2,bearing_thickness,center=true,$fn=arm_fn); // Shell
		cylinder(d=bearing_dia,bearing_thickness+2,center=true,$fn=arm_fn); // Bearing
	}
}

module bearing_holes(){
	bearing(); // Center Bearing Hole
	for (i = [1:number_of_arms]){
		rotate([0,0,angle*i])translate([arm_length,0,0])bearing(); // Arm Bearing Hole
	}
}

module cut_tab(){
    hull(){
        rotate([0,0,main_angle_z-tab_angle/2])translate([(arm_distance+extra_cut)/2,0,0]) cube([arm_distance+extra_cut,0.1,bearing_thickness+1],center=true);
        rotate([0,0,main_angle_z+tab_angle/2 ])translate([(arm_distance+extra_cut)/2,0,0])cube([arm_distance+extra_cut,0.1,bearing_thickness+1],center=true);
    }
}

module final(){
	difference(){
		union(){
			if(chanfer=="true")translate([0,0,-bearing_thickness/2])chamferCylinder(bearing_thickness, arm_distance,arm_distance,chamfer_unit);
			else cylinder(r=arm_distance,h=bearing_thickness,center=true,$fn=arm_fn); //Main Body
		}
		union(){
			bearing_holes();
			for (i = [1:number_of_arms]){
				rotate([0,0,angle*i])cut_tab();
			}
		}
	}
	
	difference(){
		if(chanfer=="true")translate([0,0,-bearing_thickness/2])chamferCylinder(bearing_thickness, (bearing_dia+center_r)/2,(bearing_dia+center_r)/2,chamfer_unit);
		else cylinder(d=bearing_dia+center_r,h=bearing_thickness,center=true,$fn=arm_fn);
		bearing_holes();
	}
	
}

module print_part() {
	if (part == "cal_bearing") cal_bearing();
	else final();
}


