shell_thickness = 1.5;
height = 62;
diameter = 6.5;
thread_pitch = 2;
clearance = 0.4;
grips = 12;
grip_d = 3;
label = "6 4u";

use <threads.scad>;

$fn = 40;
module bottle(){
  difference(){
	union(){
	  translate([0,0,-shell_thickness])cylinder(d = diameter+2*shell_thickness, h = height*0.7 + shell_thickness);
	  translate([0,0,-shell_thickness])cylinder(d = diameter+6*shell_thickness, h = height/2+shell_thickness);
	  translate([0,0,height/2])metric_thread(diameter=diameter+4*shell_thickness, pitch=thread_pitch, length=height*0.1);
	}
	cylinder(d = diameter, h = height);
	for(a = [0:360/grips:360]){
	  rotate([0,0,a])translate([(diameter+6*shell_thickness + grip_d/2)/2,0,-shell_thickness])cylinder(d = grip_d, h = height/4);
	}
  }
}
module cap(){
  difference(){
	union(){
	  
	  cylinder(d = diameter+6*shell_thickness, h = height/2+shell_thickness);
	}
	cylinder(d = diameter, h = height/2);
	translate([0,0,height*0.1])cylinder(d = diameter+2*shell_thickness + clearance, h = height*0.2);
	metric_thread(diameter=diameter+4*shell_thickness+clearance, pitch=thread_pitch, length=height*0.1);
	for(a = [0:360/grips:360]){
	  rotate([0,0,a])translate([(diameter+6*shell_thickness + grip_d/2)/2,0,height/4+shell_thickness])cylinder(d = grip_d, h = height/4);
	}
	  translate([0,0,height/2+shell_thickness/2])linear_extrude(height = shell_thickness/2)text(text = label, font = "Liberation Sans Bold:style=Bold", size = 5, valign = "center",halign = "center");
  }
}
bottle();
translate([20,0,height/2])cap();
