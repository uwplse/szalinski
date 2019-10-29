//=============================================================================
// nespresso-honeycomb.scad
//
// a parametric honeycomb-shaped holder for nespresso pods
//=============================================================================
// Written in 2018 by Patrick Barrett
//
// To the extent possible under law, the author(s) have dedicated all copyright
// and related and neighboring rights to this work to the public domain
// worldwide. This work is distributed without any warranty.
//
// See <http://creativecommons.org/publicdomain/zero/1.0/> for full dedication.
//=============================================================================

// dimensions
x = 3; // cell count, vertical, odd numbers only
y = 7; // cell count, horizontal, odd numbers only

shape = "hexagon"; // [hexagon|rectangle], overall shape

di = 38; // mm, main pod well indiameter
pod_well = 1.5; // mm, main pod well depth

blg_well = 0.5; // mm, buldge well depth
blg_dia = 30.5; // mm, buldge well depth

mag_well = 1.5; // mm, magnet well depth
mag_dia = 4.2; // mm, magnet diameter
mag_on_back = true; // magnet on back face (true) or front face (false)

lip_length = 2; // mm, top edge holder lip extension from edge
lip_depth = 0.5; // mm, top edge holder lip thickness
lip_angle_offset = 1; // mm, top edge holder lip angle offset

cell_wall = 3; // mm, cell side wall size
mag_wall = 0.6; // mm, magnet backing wall minimum size

// customizable variables end here

abit = 0.001; //use for making overlap to get single manifold stl
alot = 150;

$fn = 50;

Di = di * (2/sqrt(3)); // mm, circumdiameter of inner side of honeycomb

do = di + (2*cell_wall); // mm, inradius of outter side of honeycomb
Do = do * (2/sqrt(3)); // mm, circumdiameter of outter side of honeycomb

dm = (di+do)/2; // mm, inradius of median of honeycomb
Dm = (Di+Do)/2; // mm, circumdiameter of median of honeycomb

total_body_depth = mag_wall + mag_well + blg_well
                 + pod_well + lip_depth + lip_angle_offset;
max_back_depth = mag_wall + mag_well + blg_well;

x_min = -floor(x/2);
x_max = floor(x/2);
y_min = -floor(y/2);
y_max = floor(y/2);

// each pod cell
module cell() {
    union() {
        difference() {
            cylinder(d = Do, h = total_body_depth, $fn = 6);
            
            // main hex cut
            translate([0,0,max_back_depth])
            cylinder(d = Di, h = alot, $fn = 6);
            
            // buldge cut
            translate([0,0,max_back_depth-blg_well])
            cylinder(d = blg_dia, h = alot);
            
            // magnet cut
            if (mag_on_back) {
                for(i=[0:5]){
                    translate([sin(360*i/6)*Dm/4,
                               cos(360*i/6)*Dm/4,
                               -alot+mag_well])
                    cylinder(d = mag_dia, h = alot);
                }
            } else {
                for(i=[0:5]){
                    translate([sin(360*i/6)*Dm/4,
                               cos(360*i/6)*Dm/4,
                               mag_wall])
                    cylinder(d = mag_dia, h = alot);
                }
            }
        }
        
        // add lip
        hull() {
            difference() {
                translate([0,0,total_body_depth - lip_depth])
                cylinder(d = Do, h = lip_depth, $fn = 6);
                translate([0,-alot/2 + di/2 - lip_length,0])
                cube([alot, alot, alot], center = true);
            }
            
            translate([0,
                       dm/2,
                       (lip_depth + lip_angle_offset)/2
                       + (total_body_depth - lip_depth - lip_angle_offset)])
            cube([dm/2, abit, lip_depth+lip_angle_offset], center=true);
        }
    }
}

// main body
union() {
    for(i = [x_min:x_max]){
        for(j=[ for (jj=[y_min:y_max]) jj+(0.5 * abs(i%2))]){
            // ^^^ adds 0.5 to odd cols ^^^
            hide = (shape != "hexagon")
            ? j == y_max && i%2 != 0
            : abs(j) > -0.5*(abs(i)) + (y_max - 0.5 * min(0, y_max-x_max))
              || abs(j) > y_max;
            
            if (!hide) {
                x = i * (dm * sqrt(3)/2);
                y = j * dm;
                translate([x,y,0])
                cell();
            }
        }
    }
}