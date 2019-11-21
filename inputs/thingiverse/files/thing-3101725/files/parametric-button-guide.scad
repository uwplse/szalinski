/*Parametric Button Guide Bezel Trim, by ggroloff 9.15.2018

Use this to generate a friction fit button guide trim.
Example values for my Anet A8. Mine is one with the newer dimensions.
*/

//Sets thickness of the bezel
bezel_thickness = 1;

//Sets diameter of the bezel
bezel_diameter = 10;

//Sets diameter of the housing hole/mount (this should be snug)
housing_diameter = 7.8;

//Sets the depth of the mount
mount_depth = 4;

//Sets the mount offset from center (0 for center)
mount_offset = 0;

//Sets the diameter of the button guide at the mount side of the model (this should be loose)
button_base_diameter = 7;

//Sets the diameter of the button guide at the bezel side of the model (this should be loose)
button_top_diameter = 6.25;

//Sets the outer diameter of the bevel recess
bevel_diameter = 8;

//Sets how deep the bevel recess is
bevel_depth=.75;

/*[Hidden]*/
//Code starts here


module guide_shape(){
translate ([mount_offset, 0, 0]) cylinder (d= housing_diameter,h= mount_depth, $fn=128);
translate ([0,0,mount_depth]) cylinder(d=bezel_diameter, h=bezel_thickness, $fn=128);
}

rotate ([0,180,0])
difference() {
    guide_shape();
    translate ([0,0, -.005])cylinder (r1= button_base_diameter/2, r2=button_top_diameter/2, h=mount_depth+bezel_thickness+.01, $fn=128);
    translate ([0,0,mount_depth + bezel_thickness - bevel_depth-.005]) cylinder (r1=button_top_diameter/2, r2=bevel_diameter/2, h=bevel_depth+.01, $fn=128);
}
