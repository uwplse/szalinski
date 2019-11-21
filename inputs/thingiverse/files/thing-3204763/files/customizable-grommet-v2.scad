// Customizable cable grommet
// by Frederic RIBLE F1OAT / 2018/11/09

// (in mm)
cable_diameter = 7.5;

// (in mm)
hole_diameter = 9.8;

// (in mm)
hole_depth = 9.5;

// (in mm)
shoulder_diameter = 14;

// (in mm)
shoulder_thickness = 2;

// (in mm)
cone_thickness = 1;

// (in degree)
cone_angle = 20;

// (in mm)
flex_thickness = 1;
    
// Following variables are not parameters
epsilon = 0.1+0;
$fn=64.0;

cable_radius = cable_diameter/2;
hole_radius = hole_diameter/2;
shoulder_radius = shoulder_diameter/2;
cone_radius = hole_radius+cone_thickness;
cone_length = cone_thickness/tan(cone_angle);

total_length = shoulder_thickness+hole_depth+cone_thickness+cone_length;
   
profile = [[0, 0],
           [0, total_length], 
           [hole_radius, total_length],
           [hole_radius+cone_thickness, shoulder_thickness+hole_depth+cone_thickness],
           [hole_radius, shoulder_thickness+hole_depth],
           [hole_radius, shoulder_thickness],
           [shoulder_radius, shoulder_thickness],
           [shoulder_radius, 0],
           [0, 0]
          ];
          
module base() {
    rotate_extrude()
        polygon(points=profile, convexity = 10);
}

module cut() {
    nb_gaps = 6;
    gap = (cone_radius-hole_radius)*6.28/nb_gaps * 1.1;
    gap_length = cone_length + 5*cone_thickness;
    
    union() {
        for (c=[0:nb_gaps-1]) 
            rotate([0, 0, 360/nb_gaps*c])
                translate([-gap/2, 0, total_length - gap_length+epsilon])
                    cube([gap, hole_radius+cone_thickness+epsilon, gap_length]);
        r2 = 2;
        r1 = hole_radius - flex_thickness - r2;

        if (r1 > r2) {
            translate([0, 0, total_length - gap_length+r2/2])
                torus(r1, r2);
        }
        
        translate([0, 0, -epsilon])
            cylinder(h=total_length+2*epsilon, r=cable_radius);
    }
}

module torus(r1, r2) {
    rotate_extrude(convexity = 10)
        translate([r1, 0, 0])
            circle(r = r2);
}
difference() {
    base();
    cut();
}

