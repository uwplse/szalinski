TIRE_SIZE = 50; // Distance between outer and inner tire circumference + wiggle room
INNER_WIDTH = 27; // Width of tire in mm + wiggle room
HEIGHT = 50; // Height of whole assembly
SIDE_THICKNESS = 10; // How thick the side walls are
BACK_THICKNESS = 7; // How thick the back wall is
SCREW_SPACING = 8; // mm from top/bot edge
SCREW_RADIUS = 1.8; // mm
ROD_RADIUS = 5; // size of hole
ROD_SPACING = 5; // distance between rod hole and edge
ROD_OVERFLOW = 10; // how much longer the rod is than the gap between sides
CORNER_THICKNESS = 5; // thickness of corner supports

$fn=50;
DEPTH = TIRE_SIZE + ROD_RADIUS * 2 + ROD_SPACING + BACK_THICKNESS;
difference(){
    union(){
        // Back support
        difference(){            
            cube([INNER_WIDTH+SIDE_THICKNESS*2, HEIGHT ,BACK_THICKNESS]);
            
            translate([SIDE_THICKNESS + INNER_WIDTH/2, SCREW_SPACING, 0])
            union(){
                cylinder(BACK_THICKNESS, SCREW_RADIUS, SCREW_RADIUS); 
                translate([0, HEIGHT - SCREW_SPACING*2, 0])
                cylinder(BACK_THICKNESS, SCREW_RADIUS, SCREW_RADIUS);
            }
        }
        
        // Sides
        translate([0,SIDE_THICKNESS/2,SIDE_THICKNESS/2])
        union(){
            minkowski(){
                cube([SIDE_THICKNESS/2, HEIGHT - SIDE_THICKNESS, DEPTH - SIDE_THICKNESS]);
                rotate([0,90,0])
                cylinder(r=SIDE_THICKNESS/2,SIDE_THICKNESS/2);
            }  
            translate([INNER_WIDTH + SIDE_THICKNESS, 0, 0])
            minkowski(){
                cube([SIDE_THICKNESS/2, HEIGHT - SIDE_THICKNESS, DEPTH - SIDE_THICKNESS]);
                rotate([0,90,0])
                cylinder(r=SIDE_THICKNESS/2,SIDE_THICKNESS/2);
            }
        }
    }
        
    union(){
        // Hole for bar
        translate([0, HEIGHT/2, DEPTH - ROD_RADIUS - ROD_SPACING])
        rotate([0,90,0])
        cylinder(INNER_WIDTH + SIDE_THICKNESS * 2, 5, 5);    
        // Notch along top edge for bar
        translate([0, 0, BACK_THICKNESS + CORNER_THICKNESS + ROD_RADIUS])
        rotate([0,90,0])
        cylinder(INNER_WIDTH + SIDE_THICKNESS * 2, 5, 5);       
    }
    
}

// Triangular corner supports
module triangular_prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],
               [0,0,0],[w,0,0],
               [0,l,h],
               [0,l,0],[w,l,0]
       ], faces=[
               [0,2,1],
               [3,4,5],
               [0,1,4,3],
               [1,2,5,4],
               [0,3,5,2],
       ]);
}

translate([SIDE_THICKNESS, 0, BACK_THICKNESS])
triangular_prism(HEIGHT, CORNER_THICKNESS, CORNER_THICKNESS);


translate([SIDE_THICKNESS+INNER_WIDTH, 0, BACK_THICKNESS])
rotate([0,270,0])
triangular_prism(HEIGHT, CORNER_THICKNESS, CORNER_THICKNESS);

// Rod
translate([SIDE_THICKNESS * 2 + INNER_WIDTH + ROD_RADIUS + 3, 0, ROD_RADIUS - 0.5])
rotate([0,90,90])
cylinder(INNER_WIDTH + SIDE_THICKNESS * 2 + ROD_OVERFLOW, ROD_RADIUS - 0.5, ROD_RADIUS - 0.5);
