//Text configuration. Leave  blank to not have any text.
start_text = "START";
//Font selection. Uses the included google fonts.
start_font = "Libre Baskerville";
//Text size. Scale this with your model.
text_size = 4;
//Is the left side an open door instead of a wall?
left_door = 1; // [0:false, 1:true]
//Is the right side an open door instead of a wall?
right_door = 1; // [0:false, 1:true]
//Is the top an open door instead of a wall?
top_door = 1; // [0:false, 1:true]
//Is the bottom an open door instead of a wall?
bottom_door = 1; // [0:false, 1:true]
//Are there stairs in the center of the tile?
stairs = 1; // [0:false, 1:true]
//Sometimes the stairs get a little big on small tiles. Change this to false if you want less stairs. If you're seeing the wrong number of stairs, try increasing your wall thickness- they're linked.
there_are_four_steps = 1; // [0:false, 1:true]
//The base size of the tile, in millimeters.
size = 30;
//Total size of the blocks used for the walls. If you want walls, keep this higher than thickness.
wall = 2.5;
//The thickness of the tile. Since the tile partially covers walls and stairs, make sure to resize them to match.
thickness = 2;

module base() {
    translate([-(size/2),-(size/2),0]) {
        cube([size,size,thickness]);
    }
}

module walls() {
    difference() {
        union() {
            translate([-(size/2),-(size/2),0]) {
                cube([size,wall,wall]);
            }
            translate([-(size/2),(size/2)-wall,0]) {
                cube([size,wall,wall]);
            }
            translate([-(size/2),-(size/2),0]) {
                cube([wall,size,wall]);
            }
            translate([(size/2)-wall,-(size/2),0]) {
                cube([wall,size,wall]);
            }
        }
        if (bottom_door) {
            translate([-size/6,-size/2-1,2]) {
                cube([(size/3),(size/3),wall]);
            }
        }
        if (top_door) {
            translate([-size/6,size/6+1,2]) {
                cube([(size/3),(size/3),wall]);
            }
        }
        if (left_door) {
            translate([-size/2,-size/6,2]) {
                cube([(size/3),(size/3),wall]);
            }
        }
        if (right_door) {
            translate([size/6,-size/6,2]) {
                cube([(size/3),(size/3),wall]);
            }
        }
    }
    
}

module stairs() {
    translate([-wall,-wall,(wall * 2/5)]) {
        cube([wall*2,wall,(wall * 2/5)]);
    }
    translate([-wall,0,(wall * 2/5)]) {
        cube([wall*2,wall,(wall * 4/5)]);
    }
    translate([-wall,wall,(wall * 2/5)]) {
        cube([wall*2,wall,(wall * 6/5)]);
    }
    if (there_are_four_steps) {
        translate([-wall,2*wall,(wall * 2/5)]) {
            cube([wall*2,wall,(wall * 8/5)]);
        }
    }
}

module start() {
    translate ([0,-size/4,thickness-1]) {
        linear_extrude(height=1) {
            text(start_text, font=start_font, size=text_size, halign="center");
        }
    }    
}

module main() {
    difference() {
        union() {
            walls();
            base();
            if (stairs) {
                stairs();
            }
        }
        start();
    }
}

main();