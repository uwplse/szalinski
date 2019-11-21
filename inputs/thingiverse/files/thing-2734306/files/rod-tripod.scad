// Rod Tripod
// Design by Marius Gheorghescu, December 2017

// diameter of the rod or diagonal (!) or the square rod
rod_dia = 20.0;

// length of a leg 
size = 80;

// thickness of the legs (recommended: minimum 6x extrusion width)
wall_thickness = 2.46;

// has round pads at the end of legs (0:off, 0.1-0.2: breakable, 1.0: full)
leg_pads = 0.9;

// set to 1 to re-inforce the legs 
extra_strong = 0.0;

// ratio of height to leg length (0.5 recommended)
height_ratio = 0.5;

// set to closed bottom
closed_bottom = 1;

// set to 1 if square rod
square_rod = 0;

/* [Hidden] */

height = size * height_ratio;
epsilon = 0.001;

module leg(leg_pads)
{
    $fn = 50;
    
    union() {
        hull() {
            translate([0,0, height/2])
                cylinder(r=min(wall_thickness,rod_dia/2), h=height, center=true);
            
            translate([size,0,wall_thickness/2])
                cylinder(r=wall_thickness/2, h=wall_thickness, center=true);
        }

        hull() {
            translate([size - rod_dia/2 + wall_thickness,0,wall_thickness/2*leg_pads])
                cylinder(r=min(size/4, rod_dia), h=wall_thickness*leg_pads, center=true);        
        
            if (extra_strong) {
                translate([0,0, height - wall_thickness/2 - epsilon])
                    cylinder(r=(rod_dia + 2*wall_thickness)/2, h=wall_thickness, center=true);
                
                translate([0,0, wall_thickness/2])
                    cylinder(r=wall_thickness/2, h=wall_thickness, center=true);
            }
        }
        
    }

}

difference() {

    $fn=square_rod?4:30;

    // legs 
    union() {

        // center rod support
        translate([0,0, height/2])
            rotate([0,0,45])
            cylinder(r=(rod_dia/2 + wall_thickness), h=height, center=true);
        
        leg(leg_pads);
        
        rotate([0,0,120])
            leg(leg_pads);
        
        rotate([0,0,-120])
            leg(leg_pads);
    }
    
    // rod 
    translate([0,0, height/2 + closed_bottom*wall_thickness])
        rotate([0,0,45])
        cylinder(r=rod_dia/2, h=height + epsilon, center=true);
    
}


//%translate([0,0,100/2])cube([8,8,100], center=true);
