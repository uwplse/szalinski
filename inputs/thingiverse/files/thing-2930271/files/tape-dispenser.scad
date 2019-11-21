// Tape dispenser
// Made by Lucian Brandus
// teeth by Marcel Mommsen (and some stuff translated to english - incomplete)
// Detents by Jonas Schiller

tape_width = 51; // width rola
height = 20; // dispenser height
length = 30; // dispenser length
diametre_curvature = 50; // grip diameter
gap = 10; // gap
detent_radius=4;
add_teeth = "no"; // [yes,no]
enable_teeth = add_teeth == "yes";

/* [Hidden] */
width = tape_width + 1.9*2;

$fn=100;

tooth_size=1;
tooth_distance_factor=1.5;

corp();
if (enable_teeth) {
    teeth();
}
detent();
mirror([0,1,0]) detent();

// Module

module corp() {
    union()
    {
        intersection()
        {  
            // cilindru curbura aripi
            rotate([90, 0, 0])
            translate([0, -diametre_curvature/2, 0])
            cylinder(h = tape_width*2, d = diametre_curvature, center = true, $fn=100);
            // corp
            difference(){
                // corp dispenser
                translate([0, 0, -height/2])
                cube(size = [length,width,height], center = true);
                // cutout roll    
                translate([0, 0, 2-height/2])
                cube(size = [length+1,tape_width,height], center = true);
                // gap tape
                cube(size = [gap,tape_width,height*3], center = true); 
                // cutout finger
                translate([-length/2-10, 0, 0])    
                cylinder(h = tape_width*2, d = 26, center = true);
                // second cutout finger (remove this one for teeth)
//                if (!enable_teeth) {
//                    translate([length/2+10, 0, 0])    
//                    cylinder(h = tape_width*2, d = 26, center = true);
//                }
            }
        }    
    }
}

module teeth() {
    union()
    {
        for(a = [-tape_width/2:tooth_size*tooth_distance_factor:tape_width/2]) {
            translate([length/2-tooth_size, a, -height-tooth_size])    
            cylinder(h=tooth_size,r1=0,r2=tooth_size,$fn=4);
        }

    }
}

module detent() {
    difference(){ 
        translate([0,width/2,-detent_radius])
        sphere(r=detent_radius);
        translate([0,width/2+detent_radius,-detent_radius])
        cube(2.2*detent_radius, center=true);
    }
}
