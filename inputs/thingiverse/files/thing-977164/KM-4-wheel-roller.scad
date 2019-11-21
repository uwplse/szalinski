/* [Global] */
// Diameter of wheel that will run across the aluminum extrusion. Values should be 19mm or higher.  Use 19.05mm for 3/4" wheels, and 22.23mm for 7/8" wheels. (mm)
wheel_diameter = 19.05;
// Radius of screw for wheels (mm)
wheel_screw_r = 2.1;
// Radius of screwhead for wheels (mm)
wheel_screw_head_r = 4.2;
// Additional clearance on screw holes required by your printer (mm)
extruder_adj = 0.2;
// Vertical length of the carriage (default 54mm, but can be increased)
carriage_height = 54; // [54:100]
// Thickness of the carriage (values other than 12mm not tested)
carriage_depth = 12; // [12:12]
// Gap between the carriage and extrusion.
carriage_gap = 0;
// Round the corners of the wheel mount by this amount (mm)
round_corners_r = 3;

/* [Hidden] */
// Work-in-progress parameters
// Width of aluminum. Only partially implemented. 
extrusion_width = 15;
// Width of wheel
wheel_width = 6.35;
// Offset built into wheel (i.e. nut width in the case of Prime Line products);
wheel_offset = 3.3;
// Prime Line wheels (with the hex nut at the end) or generic?
prime_line = "true"; // [true:Prime Line, false:Generic]


// These should not generally be adjusted
carriage_width = 10.5 + wheel_diameter + extrusion_width;
m3_screw_r = 1.5;
m3_nut_r = 5.5/2;

wheel_nut_size = (7/16) * 25.4 + extruder_adj;
wheel_nut_h = sqrt(3) * wheel_nut_size/2;
m3_nut_r1 = m3_nut_r + extruder_adj*2;
m3_nut_h1 = sqrt(3) * m3_nut_r1 / 2;
joint_length = carriage_height/2 - 5 - 6;
adjuster_step = 12;

$fa = 10;
$fs = extruder_adj*2;

difference() {
    union() {
        translate([round_corners_r, round_corners_r, 0]) minkowski()
        {
            cube(size=[carriage_width-round_corners_r*2, carriage_height-round_corners_r*2, carriage_depth-1]);
            cylinder(r=round_corners_r, h=1);
        }
        
        // Mounting cutout for wheels
        for (x = [-1, 1], y = [-1, 1]) {
            translate([carriage_width/2 + x*(carriage_width/2-1-wheel_nut_h/2),carriage_height/2 + y*(carriage_height/2-3.5-wheel_nut_size/2),0])
                if (prime_line == "true") {
                    rotate([0, 0, 90+90*y])
                        wheelHolder();
                } else {
                    
                }
        }
    }
    
    // Mounting holes for...
    for (x = [-1, 1], y = [-1, 1]) {
        // wheels
        #translate([carriage_width/2 + x*(carriage_width/2-1-wheel_nut_h/2),carriage_height/2 + y*(carriage_height/2-3.5-wheel_nut_size/2),-1]) {
            cylinder(r=wheel_screw_r+extruder_adj, h=20);
            cylinder(r1=(wheel_screw_head_r-wheel_screw_r)/3*4+wheel_screw_r+extruder_adj, r2=wheel_screw_r+extruder_adj, h=4);
        }
        // traxxas_carriage
        translate([carriage_width/2 + x*10, carriage_height/2 + y*7.5, -1])
            #union() {
                cylinder(r=m3_screw_r, h=20);
                translate([0,0,carriage_depth - 6+1]) cylinder(r1=m3_nut_r, r2=m3_nut_r+extruder_adj*2, h=7, $fn=6);
            }
    }
    
    // Tension adjuster
    for (y = [-1, 1]) {
        translate([carriage_width+1, carriage_height/2+y*(carriage_height/2-3.5), carriage_depth/2])
        rotate([0, -90, 0])
            union() {
                // Screw hole
                cylinder(r1=(m3_screw_r+extruder_adj)*1.1, r2=m3_screw_r, h=35);
                //#cylinder(r=(m3_screw_r+extruder_adj)*1.1, h=13);
                cylinder(r=3.1, h=6);
                
                // nut trap
                rotate(90-90*y, 0, 0) translate([-m3_nut_h1, 0, 20]) 
                    cube([(m3_nut_h1)*2, 4, 3.5]);
                translate([0, 0, 20]) rotate([0,0,90]) cylinder(r=(m3_nut_r1), h=3.5, $fn=6);
                
                // joint
                translate([0, 0.5*y, 13.5]) cube([carriage_depth+1, 6.1, 3], center=true);
                rotate([90, 0, 180+y*90]) translate([2.5,9.5,0]) linear_extrude(height = 20, center=true, convexity=5)
                for (a = [0:adjuster_step:180-adjuster_step]) {
                    polygon([
                        [(a)/180*joint_length,3*(1-a/180)+cos(a)*2.5], 
                        [(a)/180*joint_length,0+cos(a)*2.5], 
                        [(a+adjuster_step)/180*joint_length,0+cos(a+adjuster_step)*2.5], 
                        [(a+adjuster_step)/180*joint_length,3*(1-(a+adjuster_step)/180)+cos(a+adjuster_step)*2.5]]);
                }
            }
    }
}

module wheelHolder() {
    translate([-wheel_nut_h/2,-wheel_nut_size/2,0])
    difference() {
        translate([wheel_nut_h/2, wheel_nut_size/2, 12]) union() {
            rotate([0,0,90]) cylinder(r=wheel_nut_size/2, h=4, $fn=6);
            translate([-wheel_nut_h/2, -wheel_nut_size/2-2, 0]) cube([wheel_nut_h, wheel_nut_size/2+2, 4]);
        }
        translate([wheel_nut_h/2, wheel_nut_size/2, 14])
            rotate([0,0,90]) cylinder(r=wheel_nut_size/2*1.01, h=4, $fn=6);
    }
}