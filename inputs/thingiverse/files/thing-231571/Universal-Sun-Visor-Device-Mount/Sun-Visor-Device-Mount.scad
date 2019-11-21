// Device Width
device_width = 85; // [1:200]
// Device Thickness
device_thickness = 13; // [1:50]
// Visor Thickness
visor_thickness = 20; // [1:50]
// Visor Height
visor_height = 150; // [1:300]
// Thickness
thickness = 5; // [1:10]

// device holder
translate([thickness, thickness+device_thickness+visor_thickness+thickness, 0])
	cube([thickness, thickness, thickness]);
translate([0, thickness+visor_thickness+thickness, 0])
	cube([thickness, device_thickness, thickness]);
translate([thickness, visor_thickness+thickness, 0])
	cube([device_width, thickness, thickness]);
translate([thickness+device_width, thickness+visor_thickness+thickness, 0])
	cube([thickness, device_thickness, thickness]);
translate([device_width, thickness+device_thickness+visor_thickness+thickness, 0])
	cube([thickness, thickness, thickness]);

// visor clip
translate([thickness, visor_thickness+thickness, 0])
	cube([visor_height, thickness, thickness]);
translate([thickness+visor_height, thickness, 0])
	cube([thickness, visor_thickness, thickness]);
translate([thickness+(visor_height/2), 0, 0])
	cube([visor_height/2, thickness, thickness]);

linear_extrude(thickness) {	
	polygon(points=[
		[0,         thickness+visor_thickness+thickness], 
		[thickness, thickness+visor_thickness+thickness], 
		[thickness, thickness+visor_thickness]], paths=[[0, 1, 2]]);
	polygon(points=[
		[0,         thickness+visor_thickness+thickness+device_thickness], 
		[thickness, thickness+visor_thickness+thickness+device_thickness+thickness], 
		[thickness, thickness+visor_thickness+thickness+device_thickness]], paths=[[0, 1, 2]]);
	polygon(points=[
		[thickness+visor_height,           0], 
		[thickness+visor_height,           thickness], 
		[thickness+visor_height+thickness, thickness]], paths=[[0, 1, 2]]);
	polygon(points=[
		[thickness+visor_height,           thickness+visor_thickness], 
		[thickness+visor_height,           thickness+visor_thickness+thickness], 
		[thickness+visor_height+thickness, thickness+visor_thickness]], paths=[[0, 1, 2]]);
	polygon(points=[
		[thickness+device_width,           thickness+visor_thickness], 
		[thickness+device_width,           thickness+visor_thickness+thickness], 
		[thickness+device_width+thickness, thickness+visor_thickness+thickness]], paths=[[0, 1, 2]]);
	polygon(points=[
		[thickness+device_width,           thickness+visor_thickness+thickness+device_thickness], 
		[thickness+device_width,           thickness+visor_thickness+thickness+device_thickness+thickness], 
		[thickness+device_width+thickness, thickness+visor_thickness+thickness+device_thickness]], paths=[[0, 1, 2]]);
}