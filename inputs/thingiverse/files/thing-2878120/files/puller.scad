/******************************************************************************\
|***                                                                        ***|
|**                       Customizable Pinion Puller                         **|
|**                                              by Svenny                   **|
|**                                                                          **|
|**               https://www.thingiverse.com/thing:2878120                  **|
|***                                                                        ***|
\******************************************************************************/

/* [Puller Body] */
// axis hole diameter
hole_d = 2;
// width and depth of the inner space
space_x = 20;
// height of the inner space
space_z = 45;
// bottom side thickness
grip_t = 1.8;
// sides thickness
side_t = 2.5;
// size of the nut measured across the angles of hexagon (default is fitting M4)
nut_d = 8;
// hole for bolt (it should go through freely)
bolt_d = 4.2;

/* [Joint] */
// pushing part diameter
pusher_d = 4.7;
// pushing part shape (6 = hexagon, 30 = circle)
pusher_fn = 6;
// height of the joint
joint_h = 17;
// minimal wall thickness of the joint
joint_minimal_t = 1.5;
joint_d = max(bolt_d, pusher_d) + 2*joint_minimal_t;

$fn = 50;

module puller_body() {
    translate([0, 0, space_x+side_t])
    mirror([0, 0, 1])
    difference() {
        cube([space_x+2*side_t, space_z+grip_t+10, space_x+side_t]);
        translate([side_t, grip_t, -0.01])
        cube([space_x, space_z, space_x]);
        
        hull() {
            translate([space_x/2+side_t, 0, space_x/2])
            rotate([90,0,0])
            cylinder(d=hole_d, h=3*grip_t, center=true);
            
            translate([space_x/2+side_t, 0, -space_x/2])
            rotate([90,0,0])
            cylinder(d=hole_d, h=3*grip_t, center=true);        
        }
        
        translate([space_x/2+side_t, space_z, space_x/2])
        rotate([-90,0,0])
        cylinder(d=bolt_d, h=3*grip_t+15);
        
        translate([space_x/2+side_t, space_z, space_x/2])
        rotate([-90,90,0])
        cylinder(d=nut_d, h=grip_t+4, $fn=6);
    }
}

module central_joint() {
    translate([0, 0, joint_h/2])
    difference() {
        cylinder(d=joint_d, h=joint_h, center=true);
        
        mirror([0, 0, 1])
        cylinder(d=bolt_d, h=joint_h);
        
        translate([0, 0, 1])
        cylinder(d=pusher_d, h=joint_h, $fn=pusher_fn);
    }
}

puller_body();

translate([-joint_d, 0, 0])
central_joint();