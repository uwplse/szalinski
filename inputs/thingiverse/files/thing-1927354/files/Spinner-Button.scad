/*=========================================
Program Name :	Spinner Button
Base Language:	English
Created by   :	Esmarra
Creation Date:  30/11/2016
Rework date entries:
Program Objectives:
Observations:
	Module imported form: EDC Tri-Spinner [28/09/2016]
Special Thanks:
=========================================*/

/* [Bearing] */
// #### 608 Bearing Settings #### 
bearing_dia=22+printer_threshold*2 ;
bearing_inner_dia= 8 ;
bearing_thickness=7.2 ;

/* [Button] */
// #### Button Settings #### 
button_grip_h=1 ;
button_spacer= 0.5 ;
button_dia = 20 ; 
// 20.42 default

// ===== #### =====
/* [Hidden] */
arm_fn=90 ; // <-- Decrease fn for faster rendering
$fn=arm_fn;

module button();

//=======  MAIN  =======
button();

//======= Modules =======

module button(){
	rotate([0,180,0])
	difference(){
		union(){
			translate([0,0,bearing_thickness/2])cylinder(h=button_grip_h,d=button_dia); //
			echo(bearing_dia-2);
			cylinder(h=bearing_thickness/2,d=bearing_inner_dia);
			translate([0,0,(bearing_thickness/2)-button_spacer])cylinder(h=button_spacer,d=bearing_inner_dia+3);
		}
		if(magnet=="true")translate([0,0,-.01])cylinder(d=magnet_dia,h=magnet_h);
		//translate([0,0,bearing_thickness/2+button_grip_h])scale([1,1,.10])sphere(bearing_inner_dia+1.5);
	}
}