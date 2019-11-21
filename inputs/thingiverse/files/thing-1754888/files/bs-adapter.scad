/*
 * Ball and socket adapter for PCB Workstation with Articulated Arms 
 *   (http://www.thingiverse.com/thing:801279)
 *
 * Author: Scott Shumate <scott@shumatech.com>
 *
 * This ball and socket adapter snaps onto the end of a
 * flexible coolant pipe and adapts it for use with all
 * of the accessories available for the PCB Workstation.
 * Flexible coolant pipes hold and wear much better than
 * 3D printed arms and are cheap and readily available at
 * a number of Ebay sellers.
 */

// Diameter of the top ball (mm)
bottom_ball_diameter = 11.7;

// Diameter of the bottom ball (mm)
top_ball_diameter = 10.5;

// Total height of the adapter (mm)
total_height = 19;

// Thickness of the wall around the bottom ball (mm)
wall_thickness = 1.6;

// Diameter of middle hole (mm)
hole_diameter = 4.5;

// Length of the slots in the bottom ball cap (mm)
slot_length = 7.5;

// Number of slots around the bottom ball cap
number_of_slots = 3;

$fa=1;
$fs=0.5;

create();

module create() {
    difference() {
        union() {
            // Bottom ball cap
            ball_cap(bottom_ball_diameter, wall_thickness, slot_length, number_of_slots);
            
            // Neck
            cylinder(d=hole_diameter+2*wall_thickness, h=total_height-top_ball_diameter/2);

            // Top ball
            translate([0, 0, total_height-top_ball_diameter/2])
                sphere(d=top_ball_diameter);
        }
        union() {
            // Hole through middle
            cylinder(d=hole_diameter, h=total_height);
            
            // Bottom ball
            translate([0, 0, bottom_ball_diameter/4])
                sphere(d=bottom_ball_diameter);
        }
    }
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
