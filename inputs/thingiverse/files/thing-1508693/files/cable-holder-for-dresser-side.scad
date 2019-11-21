$fn=32*1;

// Number of spots for cables
num_slots = 2; // [1:20]

// Gap for each cable (mm)
slot_width = 6;

// Thickness of walls separating cables (mm)
wall_thickness = 2;

// How far out the walls stick out from the base (mm)
wall_depth = 10;

// Height of the assembly (mm)
height = 10;

// Thickness of the back plate (mm)
back_thickness = 2;

// Diameter of the mounting holes in the back plate (mm). A value of 3mm is appropriate for #4 wood screws.
back_hole_dia = 3;

// Diameter of the holes in the walls for ziptie, bolt+nut, etc. (mm)
slot_hole_dia = 3;

// Radius of the rounding of the walls (mm)
wall_corner_radius=3;

// Countersink the holes for wood screws to sit flush?
back_wood_screws = 1; // [1:Yes, 0:No]

// For wood screws, how many times bigger is the head than the shaft?
wood_screw_head_ratio = 2;

difference() {
    translate([0,0,-back_thickness]) hull() {
        x0 = -wall_thickness/2-slot_width/2;
        x1 = num_slots*(slot_width+wall_thickness)+wall_thickness/2+slot_width/2;
        translate([x0,0]) cylinder(d=height, h=back_thickness);
        translate([x1,0]) cylinder(d=height, h=back_thickness);
    }
    for (s = [-1:num_slots-1+1]) {
        x = (slot_width+wall_thickness)*s+wall_thickness/2+slot_width/2;
        if (back_wood_screws) {
            translate([x,0,-back_thickness/2]) cylinder(d1=back_hole_dia, d2=back_hole_dia*wood_screw_head_ratio ,h=back_thickness+0.1,center=true);
        } else {
            translate([x,0,0]) cylinder(d=back_hole_dia ,h=20,center=true);
        }
            
    }
}

for (s = [0:num_slots]) {
    x = (slot_width+wall_thickness)*s;
    translate([x,0,0]) difference() {
        hull() {
            translate([-wall_thickness/2,-height/2]) cube([wall_thickness,height,0.1]);
            y = height/2-wall_corner_radius;
            z = wall_depth-wall_corner_radius;
            for (m = [0,1]) mirror([0,m]) 
                translate([0,y,z]) rotate([0,90]) cylinder(r=wall_corner_radius,h=wall_thickness,center=true);
        }
        translate([0,0,wall_depth-slot_hole_dia]) rotate([0,-90]) cylinder(d=slot_hole_dia,h=20,center=true);
    }
}


