lower_height = 51.5; // mm, height of bottom part
lower_radius=30/2; // mm, outer radius of bottom part
upper_height = 15.5; // mm, height of top part
upper_radius=27/2; // mm, outer radius of top part
overlap = 9; // mm
slotwidth = 4; // mm
lower_wallwidth = 1.3; // mm
upper_wallwidth = 1.3; // mm

difference() {
union() {
    // These are the two cylinders
    translate ([0,0,0]) cylinder(r=lower_radius,h=lower_height, $fn=60);
    translate ([0,0,lower_height]) cylinder(r=upper_radius,h=upper_height, $fn=60);
}
// Below are the parts to cut out
union() {
    // Inside the bottom cylinder (up to the overlap)
    translate ([0,0,-1]) cylinder(r=lower_radius-lower_wallwidth,h=lower_height+1-overlap,$fn=60);
    // Inside the top cylinder
    translate ([0,0,lower_height-1]) cylinder(r=upper_radius-upper_wallwidth,h=upper_height+2,
    $fn=60);
    // The overlap (a truncated cone)
    translate ([0,0,lower_height-overlap]) cylinder(r1=lower_radius-lower_wallwidth,r2=upper_radius-upper_wallwidth,h=overlap, $fn=60);
    // the slot starts at the bottom of the "overlap"
    translate([lower_radius-upper_wallwidth*3,-slotwidth/2,lower_height-overlap]) cube([upper_wallwidth*3,slotwidth,upper_height+overlap+1]);
    }
}


 