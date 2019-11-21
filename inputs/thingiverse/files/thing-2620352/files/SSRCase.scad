//SSR Mount for 2020 Extrusion (or other)
//SSR Configuration
width = 45; //x
length = 58; //y
depth = 26; //z suggest printing this short so clamping force is relatively equal.
bolt_inset = 4;

x_spacing = 3; //spacing in XY dimensions before features
y_spacing = 20; //spacing in XY dimensions before features
z_spacing = 0; //clearance above (bottom is open to clamp)
case_thickness = 5; //case thickness

strain_relief = "cable_tie"; //1 generates strain relief on mains cable.

signal_cable_diameter = 5; //used for strain relief & cutout sizing. @positive Y
output_cable_diameter = 10; //ditto
cable_shield_size = 15; //extra shield space
tie_size = 5; //cable tie size for strain relief.

mount_size = 5; //
clamp_bolt_size = 3; //bolt size for clamps
printer_slop = 0.5; //slop factor for printer only used for bolt holes.

use <BOSL/transforms.scad>;
use <BOSL/shapes.scad>;
use <BOSL/metric_screws.scad>;
$fs = 0.05;

outer_x = case_thickness*2+width+x_spacing;
outer_y = case_thickness*2+length+y_spacing+cable_shield_size*2;
outer_z = case_thickness+depth+z_spacing;//only 1 case thickness in z

module cable_cutout (diameter) {
  hull(){
    translate([0,0,0])rotate([90,0,0])cylinder(r=(diameter+printer_slop)/2,h=2*case_thickness);
    translate([0,0,depth-case_thickness-z_spacing-4])rotate([90,0,0])cylinder(r=(diameter+printer_slop)/2,h=2*case_thickness);
  }
}
module tie_slot (size=tie_size,spacing){
  translate([spacing/2,0,0])rrect([size/2,size,case_thickness*2]);
  translate([-spacing/2,0,0])rrect([size/2,size,case_thickness*2]);
}
difference () {
  rrect([outer_x,outer_y,outer_z]);
  translate([0,0,-0.1]){
    rrect([width+x_spacing,length+y_spacing,depth+z_spacing+0.1]);
    //cable 'shields'
    translate([0,outer_y/2-cable_shield_size/2,0])rrect([width+x_spacing,cable_shield_size+0.1,depth+z_spacing+0.1]);
    translate([0,-outer_y/2+cable_shield_size/2,0])rrect([width+x_spacing,cable_shield_size+0.1,depth+z_spacing+0.1]);
    //cable cutouts.
    translate([0,length/2+y_spacing/2+case_thickness,0])#cable_cutout(diameter=signal_cable_diameter);
    rotate([0,0,180])translate([0,length/2+y_spacing/2+case_thickness,0])cable_cutout(diameter=output_cable_diameter);
    //cable tie slots
    translate([0,length/2+y_spacing/2+cable_shield_size/2,outer_z-case_thickness])tie_slot(spacing=signal_cable_diameter+1);
    rotate([0,0,180])translate([0,length/2+y_spacing/2+cable_shield_size/2,outer_z-case_thickness])tie_slot(spacing=output_cable_diameter+1);
    //mounting bolts.
    translate([0,length/2-bolt_inset,outer_z])screw(screwsize=5,screwlen=outer_z+4,headsize=get_metric_bolt_head_size(5),headlen=3);
    rotate([0,0,180])translate([0,length/2-bolt_inset,outer_z])screw(screwsize=5,screwlen=outer_z+4,headsize=get_metric_bolt_head_size(5),headlen=3);
    //led hole
    translate([-width/2+10,length/2-20,depth])#cylinder(h=case_thickness*2,r=1);
  }
}
