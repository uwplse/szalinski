/* [Thickness of holder walls] */
wall_thickness = 2; // [2:10]

// Enter the glove box details. Best to slightly oversize by maybe a mm
/* [Glove box dimensions (oversize for easier fit) */
box_width = 111; // [100:400]
box_depth = 61; // [40:170]
box_height = 220; // [100:400]

/* [Screw hole sizes] */
screw_size = 3; // [2:10]


difference() {
    cube([box_width+(2*wall_thickness), box_depth+(2*wall_thickness), box_height/2]);
    translate([wall_thickness, wall_thickness, wall_thickness])
        union() {
            cube([box_width, box_depth, box_height/2]); // Actual box
            translate([box_width/4, -wall_thickness, box_height*0.1])
                cube([box_width/2, wall_thickness, 2*(box_height/4)]); //Slot for getting gloves
            translate([box_width*0.5, box_depth+wall_thickness, (box_height/3) ])
                rotate(a=[90,0,0])
                    cylinder(wall_thickness,d1=screw_size,d2=screw_size*3,false); //Lower Screw hole
            translate([box_width*0.5, box_depth+wall_thickness, (box_height/6) ])
                rotate(a=[90,0,0])
                    cylinder(wall_thickness,d1=screw_size,d2=screw_size*3,false);  // Upper Screw hole
            translate([box_width*0.1,0,-wall_thickness])
               cube([box_width*0.8,box_depth,wall_thickness]); // Save some filament, don't need the bottom to be whole
            }
       
}
