// printed 50 3 56 60 3
// printed 36 3 80 66 4

// Size of the hole in the middle of the spool
Core_Diameter = 36; // [10:60]
 
// Position of the spool core relative to the holder
Core_Offset = 3; // [0:20]

// Depth of the spool core
Core_Depth = 80; // [10:100]

// How much of the core to print
Percentage = 66; // [10:100]

module dont_customize(){}

wall = 4;

notch_y = 50;
notch_z = 10;
notch_x = 8;

tab_z = 50-15;
tab_x = wall;

hang_z = 47;
hang_x = wall;

drop_z=42;

p1 = 50;
p2 = 50;

hang_d = Core_Diameter + 10;

translate([-notch_x,0,0]) cube([notch_x,notch_y,notch_z]);
translate([-notch_x-tab_x,0,0]) cube([tab_x,notch_y,tab_z]);
translate([0,0,-hang_z+notch_z]) cube([hang_x,notch_y,hang_z]);

translate([wall,notch_y/2,-drop_z]) rotate([0,90,0]) {
    intersection()
    {
        union()
        {
            cylinder(d=Core_Diameter,h=Core_Offset+Core_Depth+hang_x);
            translate([0,0,0]) cylinder(d=hang_d,h=Core_Offset);
            translate([0,0,Core_Offset+Core_Depth]) cylinder(d=hang_d,h=wall);
         }
        translate([-105,-Core_Diameter/100*Percentage/2,0]) cube([100,Core_Diameter/100*Percentage,200]);
    }
}

