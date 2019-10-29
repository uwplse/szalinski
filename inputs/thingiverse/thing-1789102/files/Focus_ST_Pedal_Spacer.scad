//This will increase the thickness of the part, in mm.
Part_Thickness = 12;

//This will change the raidus of the bolt holes, in mm.
Thread_Radius = 3.5;

rotate([180, 0, 0])union(){difference(){union(){difference(){union(){cube([162, 45, Part_Thickness]);
translate([105, -0, 0])cube([28.5, 51, Part_Thickness]);
translate([130, 31.5, 0])rotate([0,0, -10])cube([29, 20, Part_Thickness]);
translate([80, 25, 0])rotate([0,0, 12])cube([30, 20, Part_Thickness]);}


union(){translate([8, 8, -0.5])cylinder(r=Thread_Radius, h=20, $fn=50);
translate([133.5, 42.5, -0.5])cylinder(r=Thread_Radius, h=20, $fn=50);

translate([23, 23.5, -0.1])cylinder(r=5, h=3, $fn=50);
translate([113, 23.5, -0.1])cylinder(r=5, h=3, $fn=50);
translate([163, 40, -1])rotate([0, 0, 58])cube([5, 16, 20]);}}}

}}

