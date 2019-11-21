/*
    Custom Cable Clip
    based on the design Cable clip by edwinm1:
    https://www.thingiverse.com/thing:2861539


*/
thickness = 0.8; // [0.5:0.1:1.5]
cable_width = 3.5; // [1.0:0.1:4.0]
cable_height = 8.3; // [1.0:0.1:12]
base_width = 12.7; // [4:0.1:20]
base_length = 12.7; // [4:0.1:20]
opening = 0.8; // [0.1:0.1:2.0]
clearance = 0.3; // [0:0.1:0.6]

/* [Hidden] */

inner_width=cable_width+2*clearance;
inner_height=cable_height+2*clearance;
inner_radius=inner_width/2;
inner_rect_height=inner_height-2*inner_radius;

outer_width=inner_width+2*thickness;
outer_radius=inner_radius+thickness;



linear_extrude(height = base_length, center = false, convexity = 10)
    difference() {
        union() {
            // base
            translate([-(outer_width-thickness)/2,0])
            square([thickness,base_width],center=true);
            // outer rect
            square([outer_width,inner_rect_height],center=true);
            // top outer circle
            translate([0,inner_rect_height/2])
            circle(r=outer_radius,$fn=360,center=true);
            // bottom outer circle
            translate([0,-inner_rect_height/2])
            circle(r=outer_radius,$fn=360,center=true);
        }
        // hole
        union() {
            square([inner_width,inner_rect_height],center=true);
            translate([0,inner_rect_height/2])
            circle(r=inner_radius,$fn=360,center=true);
            translate([0,-inner_rect_height/2])
            circle(r=inner_radius,$fn=360,center=true);
            translate([-(inner_width/2-opening/2),-inner_rect_height])
            square([opening,inner_rect_height],center=true);
        }
    }