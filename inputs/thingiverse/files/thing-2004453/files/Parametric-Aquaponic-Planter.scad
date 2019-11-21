/*
    Ian McLinden, 2016
    Parametric Aquaponic Planter - Aquaponic planter to turn cylindrical vases into aquaponic systems
*/

/* ---- CONFIGURABLES ---- */

// Inside Diameter of vase [mm]
inside_diameter = 80;

// Wall & Base Thickness [mm]
wall_thickness = 2.5;

// Height of lower portion [mm]
lower_height = 20;

// Height of upper portion [mm]
upper_height = 30;

// Include a feeding hole in the front
include_feed_hole = "true"; // [true:True,false:False]

// Feed hole diameter [mm]
feed_hole_diameter = 25;

// Include a lift tube & Air hose channel
include_lift_tube = "true"; // [true:True,false:False]

// Diameter of Lift Tube [mm]
lift_tube_diameter = 13.25;

echo(version=version());
echo("\n----\nIan McLinden, 2016\nParametric Vase Planter - Aquaponic planter to turn cylindrical vases into aquaponic systems\n----");
make();

/* ---- FUNCTIONS ---- */
module make() {
    hfh = (include_feed_hole =="true");
    hlt = (include_lift_tube =="true");
    
    vasePlanter(inside_diameter, wall_thickness, lower_height, upper_height, hfh, feed_hole_diameter, hlt, lift_tube_diameter);
}

module vasePlanter(id, wt, lh, uh, has_f, fd, has_lt, ltd) {
    rad = (id)/2;
    color("grey")
    union() {
        difference() {
            // Cut Hole for accesories
            shell(rad, wt, lh, uh);
            accesories_mask(rad, wt, lh, uh, has_f, fd, has_lt, ltd);
        }
        // Fill them back in
        accesories(rad, wt, lh, uh, has_f, fd, has_lt, ltd);
    }
}

module shell(rad, wt, lh, uh) {
    union() {
        linear_extrude(height=wt,slices=1) {
            for(r=[0:45:360]) {
                rotate([0,0,r]) {
                    translate([wt,-(wt/2),0]) 
                    square(size=[rad-wt*2,wt],center=false);
                }
            }
        }
        rotate_extrude($fn=75) {
            // Base
            for (r=[wt:wt*3:rad-(wt*4)]) {
                translate([r,0,0])
                square(size=[wt*2,wt], center=false);
            }
            translate([rad-(wt*4),0,0])
            square(size=[wt*3.5,wt], center=false);
            
            // Submerged Wall 
            translate([rad-wt,(wt/2),0])
            square(size=[wt,lh+wt],center=false);
            translate([rad-(wt/2),(wt/2),0])
            circle(d=wt, $fn=20);
            
            // Fillet
            translate([rad-wt,lh+wt*1.5,0])
            polygon(points=[[0,0],[wt,0],[wt,wt]], paths=[[0,1,2]],convexity=10);
            
            // Upper Wall
            translate([rad,lh,0])
            square(size=[wt,uh-(wt/2)],center=false);
            translate([rad+(wt/2),lh+uh-(wt/2),0])
            circle(d=wt, $fn=20);
        }
    }
}

module accesories_mask(rad, wt, lh, uh, has_f, fd, has_lt, ltd) {
    union() {
        if (has_f) feed_hole_mask(rad, wt, lh, fd);
        if (has_lt) {
            lift_tube_mask(rad, wt, lh, ltd);
            air_hose_mask(rad, wt, lh);
        }
    }
}

module accesories(rad, wt, lh, uh, has_f, fd, has_lt, ltd) {
    if (has_f || has_lt) {
        intersection() {
            solid_mask(rad, wt, lh, uh);
            union() {
                if (has_f) feed_hole(rad, wt, lh, fd);
                if (has_lt) {
                    lift_tube(rad, wt, lh, ltd);
                    air_hose(rad, wt, lh);
                }
            }
        }
    }
}

module feed_hole_mask(rad, wt, lh, fd) {
    union() {
        translate([rad,0,-1])
        cylinder(h=lh+1, r1=(fd/2)+wt, r2=(fd/2)+wt, $fn=35);
        rotate([0,90,0])
        translate([-lh,0,rad])
        sphere(d=fd+(wt*2), $fn=35);
    }
}

module feed_hole(rad, wt, lh, fd) {
    difference() {
        union() {
            translate([rad,0,0])
            cylinder(h=lh, r1=(fd/2)+wt, r2=(fd/2)+wt, $fn=35);
            rotate([0,90,0])
            translate([-lh,0,rad])
            sphere(r=(fd/2)+wt, $fn=35);
        }
        union() {
            translate([rad,0,-1])
            cylinder(h=lh+1, r1=(fd/2), r2=(fd/2), $fn=35);
            rotate([0,90,0])
            translate([-lh,0,rad])
            sphere(r=(fd/2), $fn=35);
        }
    }
}

module lift_tube_mask(rad, wt, lh, ltd) {
    translate([-(rad-wt-ltd/2),0,-1])
    cylinder(h=lh+ltd+1, r1=ltd/2, r2=ltd/2, $fn=30);
}

module lift_tube(rad, wt, lh, ltd) {
    translate([-(rad-wt-ltd/2),0,-1])
    difference() {
        difference() {
            cylinder(h=lh+2.5*wt+1, r1=(ltd/2)+wt, r2=(ltd/2)+wt, $fn=30);
            cylinder(h=lh+2.5*wt+2, r1=ltd/2, r2=ltd/2, $fn=30);
        }
        translate([-(ltd/2)-wt,0,lh+ltd-wt])
        rotate([0,20,0])
        cube(size=[3*(ltd+wt),2*(ltd+wt),ltd+wt],center=true);
    }
}

module air_hose_mask(rad, wt, lh) {
    union() {
        rotate([0,0,20])
        translate([-(rad-1.25),0,-1])
        cylinder(h=lh+6+1, r1=3, r2=3, $fn=15,center=false);
        rotate([0,0,20])
        translate([-(rad-1.25),0,lh+6])
        sphere(r=3, $fn=15);
        rotate([0,0,20])
        translate([-rad-wt+1.25,0,lh+6])
        rotate([0,90,0])
        linear_extrude(height=2*wt, slices=1, center=true) {
            hull() {
                circle(r=3,center=true, $fn=15);
                translate([6,0,0])
                circle(r=3,center=true, $fn=15);
            }
        }
    }
}

module air_hose(rad, wt, lh) {
    difference() {
        union() {
            rotate([0,0,20])
            translate([-(rad-1.25),0,0])
            cylinder(h=lh+6, r1=3+wt, r2=3+wt, $fn=15,center=false);
            rotate([0,0,20])
            translate([-(rad-1.25),0,lh+6])
            sphere(r=3+wt, $fn=15);
        }
        air_hose_mask(rad, wt, lh);
    }
}


module solid_mask(rad, wt, lh, uh) {
    rotate_extrude($fn=75) {
        // Base
        square(size=[rad-(wt/2),wt], center=false);

        // Submerged Wall 
        translate([0,(wt/2),0])
        square(size=[rad,lh+wt],center=false);
        translate([rad-(wt/2),(wt/2),0])
        circle(d=wt, $fn=20);

        // Upper Wall
        translate([0,lh,0])
        square(size=[rad+wt,uh],center=false);
    }
}

