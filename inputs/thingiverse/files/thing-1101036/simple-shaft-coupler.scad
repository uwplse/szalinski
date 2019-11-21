$fn=64*1;

E= 0.05*1;

// Height of the coupler (mm)
coupler_height = 30;

// Outer diameter of the coupler (mm)
coupler_dia = 20;

// Diameter of the first shaft being coupled (mm)
shaft1_dia = 5;

// Diameter of the second shaft being coupled (mm)
shaft2_dia = 8;

// Diameter of holes for set screws (mm). No threading is printed, so just set this to ~95% of the diameter of the screw being used, and it will bite into the plastic and tap as you go. 3.75mm worked well for #8 screws for me.
set_screw_dia = 3.75;

// lower is smaller for best printing
lower_shaft_dia = min(shaft1_dia,shaft2_dia);
upper_shaft_dia = max(shaft1_dia,shaft2_dia);


difference() {
    cylinder(d=coupler_dia,h=coupler_height);
    
    // lower bore
    translate([0,0,-E]) cylinder(d=lower_shaft_dia,h=coupler_height+2*E);
    
    // upper bore
    translate([0,0,coupler_height/2]) cylinder(d=upper_shaft_dia,h=coupler_height/2+E);
    
    for (z = [coupler_height*1/4, coupler_height*3/4]) translate([0,0,z]) {
        for (r = [0:90:360-1]) rotate([90,0,r]) {
            cylinder(d=set_screw_dia,h=coupler_dia/2+E);
        }
    }
}