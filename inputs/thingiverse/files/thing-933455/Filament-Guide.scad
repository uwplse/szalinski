// Measures
thick = 4; // Thickness
t_w = 20; // Width
t_h = 60; // Height
u_arm_l = 20; // Upper arm lenght
d_arm_l = 40; // Lower arm lenght
ua_l = u_arm_l+thick;
da_l = d_arm_l+thick;
d_arm_sep = 20; // How far do you want lower tab be from the upper tab
chamfer_size = thick/2;


// Parts definitions
m_part = [t_w,thick,t_h]; // Define the main part
u_arm = [t_w,ua_l,thick]; // Define the upper arm
d_arm = [t_w,da_l,thick]; // Define the lower arm


// Positioning the parts on assembly
m_part_loc = [0,0,0];
ua_loc = t_h-thick;
u_arm_loc = [0,0,ua_loc];
da_loc = (t_h-(thick*2))-d_arm_sep;
d_arm_loc = [0,0,da_loc];


// Parts building
module main_plate()
    {
        translate(m_part_loc) cube(m_part);
        translate(u_arm_loc) cube(u_arm);
        translate(d_arm_loc) cube(d_arm);
    }
    
module main_hole_drilled()
    {
        difference()
            {
                main_plate();
                filament_hole();
            }
    }
    
module main_hole_rounded()
    {
        union()
            {
                main_hole_drilled();
                translate([t_w/2,2.5,t_w/2]) scale(.25
) rotate([90,90,0])round_hole();
            }
    }
    
// Assembly position
*main_hole_drilled();
assembly();

// Drilling hole for the filament
hole_loc = [t_w/2,12,t_w/2];
r_hole_loc_1 = [t_w/2,0,t_w/2];
r_hole_loc_2 = [t_w/2,4,t_w/2];
fil_dia = 1.75; // Diameter of filament
module filament_hole()
    {
        translate(hole_loc) rotate([90,0,0]) cylinder(h = 20, r = fil_dia, $fn = 100);
    }

module round_hole()
    {
rotate_extrude(convexity = .5, $fn = 100)
translate([10,10,10])
circle(r = 3, $fn = 100);
    }

// Rounding corners
module chamfer_template()
    {
        difference()
            {
                translate([-2,-1,0])cube([t_w+4,chamfer_size+1,chamfer_size+1]);
                translate([-4,chamfer_size,0]) rotate([0,90,0]) cylinder(h = t_w+8,r = chamfer_size, $fn = 100);
            }
    }
    
module assembly()
    {
        difference()
            {
                main_hole_drilled();
                // Upper arm chamfers
                translate([0,0,ua_loc+chamfer_size]) chamfer_template();
                translate([0,u_arm_l+chamfer_size,ua_loc+(chamfer_size*2)]) rotate([-90,0,0]) chamfer_template();
                *translate([0,u_arm_l+(chamfer_size*2),ua_loc+chamfer_size]) rotate([180,0,0]) chamfer_template();
                // Lower arm chamfers
                *translate([0,d_arm_l+chamfer_size,da_loc+(chamfer_size*2)]) rotate([-90,0,0]) chamfer_template();
                translate([0,d_arm_l+(chamfer_size*2),da_loc+chamfer_size]) rotate([180,0,0]) chamfer_template();
                // Base chamfers
                translate([0,chamfer_size,0]) rotate([90,0,0]) chamfer_template();
                translate([0,thick,chamfer_size]) rotate([180,0,0]) chamfer_template();
            }
        union()
            {
                translate([0,u_arm_l+(thick/2),ua_loc]) rotate([0,90,0]) cylinder(h = t_w, r = chamfer_size, $fn = 100);
                                translate([0,d_arm_l+(thick/2),da_loc+thick]) rotate([0,90,0]) cylinder(h = t_w, r = chamfer_size, $fn = 100);
            }
    }