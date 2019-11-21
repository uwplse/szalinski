// recessed-spot-insert.scad
// Author: JoeGu  
// last update: April 2019
// V1.1

// (number of segments for full circle)
resolution = 80; // [30:1:180]

// (mm)
support_seat_diameter = 84; // [50:0.1:100]

// (mm)
support_seat_thickness = 1.0; // [0.2:0.1:2]

// (percent of "Support Seat Thickness")
support_seat_rounding = 80; // [0:1:100]

// (mm, keep it lower or equal as "Support Seat Diameter")
outer_insert_diameter = 80.2; // [50:0.1:100]

// (mm, keep it lower as "Outer Insert Diameter")
inner_insert_diameter = 68.0; // [50:0.1:100]

// (mm)
insert_hight = 7.5; // [0.6:0.1:20]

// (percent of "Insert Thickness (Outer Diameter - Inner Diameter")
insert_rounding = 25; // [0:1:100]


if (outer_insert_diameter>support_seat_diameter)  
    {outer_insert_diameter=support_seat_diameter;}
if (inner_insert_diameter>=outer_insert_diameter)  
    {inner_insert_diameter=inner_insert_diameter-0.1;}
    
s_s_r = support_seat_thickness*support_seat_rounding/100;
    
i_r = (outer_insert_diameter - inner_insert_diameter)/2*insert_rounding/100;

$fn=resolution; 
frf=0.2; // fragment remove factor

    
// generate insert
difference()
    { union()
        { cylinder(h=support_seat_thickness, r=support_seat_diameter/2, center=false);      cylinder(h=support_seat_thickness+insert_hight, r=outer_insert_diameter/2, center=false);
        }
        
        translate([0,0,-0.5]) cylinder(h=support_seat_thickness+insert_hight+1, r=inner_insert_diameter/2, center=false);
    difference()
    { translate([0,0,-frf]) rotate_extrude() translate([support_seat_diameter/2-s_s_r+frf,0,0]) square(s_s_r,s_s_r);
      translate([0,0,s_s_r]) rotate_extrude() translate([support_seat_diameter/2-s_s_r,0,0]) circle(r=s_s_r);
    }
    difference()
    { translate([0,0,-frf]) rotate_extrude() translate([inner_insert_diameter/2-frf,0,0]) square(s_s_r+frf,s_s_r+frf);
      translate([0,0,s_s_r]) rotate_extrude() translate([inner_insert_diameter/2+s_s_r,0,0]) circle(r=s_s_r);
    }
    difference()
    { translate([0,0,insert_hight+support_seat_thickness-i_r+frf]) rotate_extrude() translate([inner_insert_diameter/2-frf,0,0]) square(i_r+frf,i_r+frf);
      translate([0,0,insert_hight+support_seat_thickness-i_r]) rotate_extrude() translate([inner_insert_diameter/2+i_r,0,0]) circle(r=i_r);
    }
    difference()
    { translate([0,0,insert_hight+support_seat_thickness-i_r+frf]) rotate_extrude() translate([outer_insert_diameter/2-i_r,0,0]) square(i_r+frf,i_r+frf);
      translate([0,0,insert_hight+support_seat_thickness-i_r]) rotate_extrude() translate([outer_insert_diameter/2-i_r,0,0]) circle(r=i_r);
    }
    }
