// Object parameters

/* [Battery and torch sizes] */
battery_diameter = 19; // [10:40]
torch_diameter = 33.5; // [10:100]

/* [Thickness of base and total height of base] */
base_thickness = 2; // [1:10]
base_height = 30; // [15:50]
back_thickness = 3; // [2:10]

/* [Screw hole sizes] */
screw_size = 5; // [2:10]

/* [Tape details] */
allow_tape = true; // [true, false]
tape_width = 20; // [10:50]
tape_thickness = 1; // [1:5]

total_width = battery_diameter + torch_diameter + 15;

inset_points = [
            [0,0,0],
            [(total_width + 1),0,0],
            [(total_width + 1),tape_thickness,0],
            [0,tape_thickness,0],
            [0,0,tape_width],
            [(total_width + 1),0,tape_width],
            [(total_width + 1),tape_thickness,tape_width+2],
            [0,tape_thickness,tape_width+2]];
            
inset_faces = [
            [0,1,2,3],  // bottom
            [4,5,1,0],  // front
            [7,6,5,4],  // top
            [5,6,2,1],  // right
            [6,7,3,2],  // back
            [7,4,0,3]]; // left




union() {
    translate([0,-back_thickness,0])
    difference() {
        cube([total_width,back_thickness,(base_height*3)]);
        translate([total_width*0.25, -0.001, (base_height*2.5) ])
            rotate(a=[-90,0,0]) 
                cylinder(back_thickness+1,d1=screw_size,d2=screw_size*3,false);
        translate([total_width*0.75, -0.001, (base_height*2.5) ])
            rotate(a=[-90,0,0]) 
                cylinder(back_thickness+1,d1=screw_size,d2=screw_size*3,false);
        if (allow_tape) {
            translate([-0.001,back_thickness-(tape_thickness-0.001),base_height+base_thickness])
                polyhedron( inset_points, inset_faces );
        }
    }
    difference() {
        cube([(total_width),(torch_diameter + base_thickness),(base_height+base_thickness)]);
        translate([(total_width)-((torch_diameter/2)+base_thickness), (torch_diameter + base_thickness)/2, base_thickness + (base_height/2) + 0.1 ])
            cylinder(base_height,(torch_diameter/2),(torch_diameter/2),true);
        if (torch_diameter/battery_diameter > 2.25) {
             translate([(battery_diameter/2)+base_thickness, (torch_diameter + base_thickness)/4, base_thickness + (base_height/2) + 0.1 ]) 
                cylinder(base_height,(battery_diameter/2),(battery_diameter/2),true);  
             translate([(battery_diameter/2)+base_thickness, 3*(torch_diameter + base_thickness)/4, base_thickness + (base_height/2) + 0.1 ]) 
                cylinder(base_height,(battery_diameter/2),(battery_diameter/2),true);         
        } else {
            translate([(battery_diameter/2)+base_thickness, (torch_diameter + base_thickness)/2, base_thickness + (base_height/2) + 0.1 ]) 
                cylinder(base_height,(battery_diameter/2),(battery_diameter/2),true);
        }

    }
}