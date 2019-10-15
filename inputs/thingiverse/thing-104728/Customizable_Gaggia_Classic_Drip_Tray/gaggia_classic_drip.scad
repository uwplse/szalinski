include <MCAD/shapes.scad>

// Height of drip tray
height_text_box=51;
// Tray depth
tray_width_text_box=98;
// Tray length
tray_length_text_box=168;
// Tray bottom thickness
bottom_thickness_slider=5; // [0:20]
// Tray insert height
tray_height_slider=5; // [0:10]
// Tray insert lip
tray_lip_slider=6; // [0:20]

height = height_text_box;
tray_width = tray_width_text_box;
tray_length = tray_length_text_box;
bottom_thickness = bottom_thickness_slider;
tray_height = tray_height_slider;
tray_lip = tray_lip_slider;

difference() {
	cube([124, 194, height], center=true);
	translate([0,0,bottom_thickness]) roundedBox(tray_width-tray_lip, tray_length-tray_lip, height, tray_lip);
	translate([0,0,height-tray_height]) cube([tray_width, tray_length, height], center=true);
}