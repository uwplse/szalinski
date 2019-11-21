// Parametric Settings 
use_cutout=true;      // 1 = Cut out uneccesaary base material, 0 - use full rectangle base
resolution = 90;
width = 25;        // Distance between mounting holes, center to center along long side  
depth = 28;        // Distance between mounting holes, center to center along short side 
pillar_height = 24;       // Pillar Height
pillar_hole_diameter = 2;        // Pillar Hole Diameter
pillar_diameter=4;        // Pillar Diameter
mount_hole_diameter = 4; // Base Mounting Hole Diameter
base_thickness=4;
spine_width=10;  // Width of the base spine when use_cutout is set to true. 


// Math
$fn=resolution;
hole_r = (pillar_hole_diameter/2);   
pillar_r = (pillar_diameter/2);
mount_hole_r  = (mount_hole_diameter/2);
cut_depth=(depth/2)-(spine_width/2);



// Renders //
base();
translate([0,0,0]) pillar();
translate([width,0,0]) pillar();
translate([0,depth,0]) pillar();
translate([width,depth,0]) pillar();


// Modules //
module pillar(){
    difference(){
        // start with outside shape5
        cylinder(h=pillar_height,r=pillar_r);
        // take away inside shape
        cylinder(h=(pillar_height+1),r=hole_r);  
    }
}

module base(){
    difference(){
        translate([(-1*pillar_r),0,0]) linear_extrude(base_thickness) square([width+(2*pillar_r),depth]);
        if(width<=30) {
            translate([5,depth/2,-0.1]) cylinder(r=mount_hole_r,h=base_thickness+1);
            translate([width-5,depth/2,-0.1]) cylinder(r=mount_hole_r,h=(base_thickness+1));
        }
        else {
            translate([10,depth/2,-0.1]) cylinder(r=mount_hole_r,h=base_thickness+1);
            translate([width-10,depth/2,-0.1]) cylinder(r=mount_hole_r,h=(base_thickness+1));        
        }
        if(width>=50) {translate([(width/2),depth/2,-0.1]) cylinder(r=mount_hole_r,h=(base_thickness+1));}
        if(use_cutout==true) {
            translate([pillar_r,-0.1,-0.5]) linear_extrude(height=(base_thickness+1)) square([width-(2*pillar_r),cut_depth]);
            translate([pillar_r,(depth+0.1)-cut_depth,-0.5]) linear_extrude(height=(base_thickness+1)) square([width-(2*pillar_r),cut_depth]);
        }
    }
}