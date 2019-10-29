// Check source holder detector cap

$fn = 50;
cap_height = 35;
inner_diameter = 100;
face_thickness= 3;
standoff_width = 3;
standoff_depth = 3;
sidewall_thickness=1.4;
source_diameter = 25.6;
source_mount_depth = 2.4;
through_hole_diameter = 16;
breather_holes_true = 1;
breather_diameter = 2;
/* [Hidden] */

difference(){
cylinder(h = cap_height, d = inner_diameter+2*sidewall_thickness);
    translate([0,0,face_thickness])
    cylinder(h= cap_height-face_thickness+0.01, d = inner_diameter-standoff_width*2);
    translate([0,0,face_thickness+standoff_depth])
    cylinder(h= cap_height-face_thickness+0.01, d = inner_diameter);
    translate([0,0,face_thickness-source_mount_depth])
    cylinder(h= source_mount_depth+0.01, d = source_diameter);
    translate([0,0,-0.01])
    cylinder(h= cap_height, d = through_hole_diameter);
    if(breather_holes_true == 1)
    {
        translate([-inner_diameter/2-2*sidewall_thickness,0,face_thickness+standoff_depth/2])
        rotate([0,90,0])   
        cylinder(h = 2*inner_diameter+3*sidewall_thickness/2, d = breather_diameter);

        translate([0,-inner_diameter/2-2*sidewall_thickness,face_thickness+standoff_depth/2])
        rotate([-90,0,0])   
        cylinder(h = 2*inner_diameter+3*sidewall_thickness/2, d = breather_diameter);
    }
}