/*
 * Oscilloscope probe holder for PCB Workstation with Articulated Arms 
 *   (http://www.thingiverse.com/thing:801279)
 *
 * Author: Scott Shumate <scott@shumatech.com>
 */

// Diameter of the top gripper (mm)
top_gripper_diameter = 8.5;

// Height of the top gripper (mm)
top_gripper_height = 4;

// Diameter of the bottom gripper (mm)
bottom_gripper_diameter = 6.7;

// Height of the bottom gripper (mm)
bottom_gripper_height = 2;

// Gap between the two grippers (mm)
gripper_gap = 7;

// Offset of the grippers from the shaft (mm)
gripper_offset = 13;

// Angle of the gripper opening (degrees)
gripper_angle = 30;

// Thickness of the gripper walls (mm)
gripper_wall_thickness = 2;

// Diameter of the gripper shaft
gripper_shaft_diameter = 8.5;

// Diameter of the ball (mm)
ball_diameter = 10.5;

// Thickness of the wall around the ball (mm)
ball_wall_thickness = 1.6;

// Length of the slots in the ball cap (mm)
slot_length = 6.5;

// Number of slots around the ball cap
number_of_slots = 3;

$fa=1;
$fs=0.5;

create();

module create() {
    total_gripper_height=bottom_gripper_height+gripper_gap+top_gripper_height;
    
    // Ball cap
    translate([0, 0, total_gripper_height+0.75*ball_diameter])
        rotate([180, 0, 0])
            ball_cap(ball_diameter, ball_wall_thickness, slot_length, number_of_slots);
    
    // Griper Shaft
    cylinder(d=gripper_shaft_diameter, h=total_gripper_height);
    
    //Bottom Gripper
    translate([gripper_offset, 0, 0])
        difference() {
            union() {
                cylinder(d=bottom_gripper_diameter+2*gripper_wall_thickness, h=bottom_gripper_height);
                translate([-gripper_offset, -gripper_shaft_diameter/2, 0])
                    cube([gripper_offset, gripper_shaft_diameter, bottom_gripper_height]);
            }
            union() {
                translate([0, 0, -bottom_gripper_height/2]) {
                    cylinder(d=bottom_gripper_diameter, h=2*bottom_gripper_height);
                    translate([-bottom_gripper_diameter/2,0,0])
                        triangle(2*bottom_gripper_diameter, 2*bottom_gripper_height, gripper_angle);
                }
            }
        }        

    //Top Gripper
    translate([gripper_offset, 0, bottom_gripper_height+gripper_gap])
        difference() {
            union() {
                cylinder(d=top_gripper_diameter+2*gripper_wall_thickness, h=top_gripper_height);
                translate([-gripper_offset, -gripper_shaft_diameter/2, 0])
                    cube([gripper_offset, gripper_shaft_diameter, top_gripper_height]);
            }
            union() {
                translate([0, 0, -top_gripper_height/2]) {
                    cylinder(d=top_gripper_diameter, h=2*top_gripper_height);
                    translate([-top_gripper_diameter/2,0,0])
                        triangle(2*top_gripper_diameter, 2*top_gripper_height, gripper_angle);
                }
            }
        }
    
}

module triangle(diameter, height, angle)
{
    cd = diameter * cos(angle);
    sd = diameter * sin(angle);
    
    linear_extrude(height=height)
        polygon([[0,0],[cd,sd],[cd,-sd],[0,0]]);
}

module ball_cap(ball_diameter, wall_thickness, slot_length, number_of_slots)
{
    difference() {
        // Cap body
        translate([0, 0, ball_diameter/4])
            sphere(d=ball_diameter+2*wall_thickness);

        union() {
            // Bottom ball
            translate([0, 0, ball_diameter/4])
                sphere(d=ball_diameter);
            
            // Bottom bevel
            translate([0, 0, -1.7])
                cylinder(r1=(ball_diameter+wall_thickness)/2+1, r2=0, h=(ball_diameter+wall_thickness)/2+1);
            
            // Bottom trim
            translate([0, 0, -ball_diameter/2])
                cylinder(d=2*wall_thickness+ball_diameter, h=ball_diameter/2);

            // Slots
            for (i = [1:number_of_slots])
                ball_slot(slot_length, ball_diameter, i*360/number_of_slots);
        }
    }
}

module ball_slot(slot_length, slot_height, angle)
{
    rotate([-90, 0, angle]) {
        translate([0, -slot_length, 0])
            ball_teardrop(1.25*slot_length, slot_height);
    }
}

module ball_teardrop(length,height)
{
    r1=0.15*length;
    x1=0;
    y1=r1;

    r2=0.45*length;
    x2=0.5*length;
    y2=length-r2;

    t12 = tangent(x1, y1, r1, x2, y2, r2, -1, -1);
    t23 = tangent(x2, y2, r2, -x2, y2, r2, 1, -1);
    t31 = tangent(-x2, y2, r2, x1, y1, r1, -1, 1);

    linear_extrude(height=height) {
        difference() {
            union() {
                translate([x1,y1]) circle(r=r1);
                polygon([t12[0], t12[1], t23[0], t23[1], t31[0], t31[1]]);
            }
            union() {
                translate([x2,y2]) circle(r=r2);
                translate([-x2,y2]) circle(r=r2);
            }
        }
    }
}

// Calculate the tangent points between two circles
function tangent (x1, y1, r1, x2, y2, r2, s1, s2) = 
    let ( 
    d = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)),
    vx = (x2 - x1) / d,
    vy = (y2 - y1) / d,
    
    c = (r1 - s1 * r2) / d,
    h = sqrt(1.0 - c*c),

    nx = vx * c - s2 * h * vy,
    ny = vy * c + s2 * h * vx,

    xt1 = x1 + r1 * nx,
    yt1 = y1 + r1 * ny,
    xt2 = x2 + s1 * r2 * nx,
    yt2 = y2 + s1 * r2 * ny
    ) 
    [[xt1,yt1],[xt2,yt2]]; 
