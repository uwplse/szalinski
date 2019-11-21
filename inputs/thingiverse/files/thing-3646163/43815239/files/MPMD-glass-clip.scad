//Author: Nathaniel Stenzel
//May 21, 2019
//Use this to hold down a glass bed for a Monoprice Mini Delta Printer

$fn=180;
glass_thickness= 3.1;   // thickness of glass in mm
bed_radius = 57.5;   // radius of bed in mm
glass_radius = 63.5; // radius of glass in mm

radius = max(bed_radius,glass_radius);
overhang_thickness = 2;   // thickness of overhanging lip that holds glass
overhang_width = 5;     // how far lip extends over the glass.

above_plate= glass_thickness+overhang_thickness;

plate = 2;      // Existing plate is 2mm thick
below_plate=1;  // Max thickness below plate 
                // (2mm space, but need 1mm travel for bed leveling)

height = above_plate + plate + below_plate;

intersection(){
union(){
     //the glass gripper on top
    difference(){
translate([0,0,height-overhang_thickness])cylinder(r1=glass_radius-overhang_width/2,r2=glass_radius+3, h=overhang_thickness);
translate([0,0,below_plate+plate])cylinder(r=glass_radius-overhang_width,h=glass_thickness+overhang_thickness+1); //subtract from bottom of glass to inner rim at the top
}
//the area at glass surface and below
difference(){
cylinder(r=radius+3,h=height);
translate([0,0,below_plate])cylinder(r=bed_radius,h=plate+0.001);
translate([0,0,below_plate+plate])cylinder(r=glass_radius,h=glass_thickness+overhang_thickness+1); //subtract from bottom of glass to inner rim at the top
translate([0,0,-0.1])cylinder(r=bed_radius-3,h=below_plate+0.2);
translate([0,0,below_plate/2-0.1])rotate([0,0,78])cube([5,bed_radius*2,below_plate+0.3],center=true); //slot 1
translate([0,0,below_plate/2-0.1])rotate([0,0,102])cube([5,bed_radius*2,below_plate+0.3],center=true); //slot 2
}
    } //end of combined top and bottom
//the disc that those two parts must intersect with to make our part
translate([radius,0,-0.1])cylinder(r=radius/2,h=height+0.1);
}
