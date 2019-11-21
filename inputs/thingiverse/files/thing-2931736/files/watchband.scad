//the total number of regular links in the bracelet
num_links = 8; // [2:20]

//the space added between moving parts to account for print tolerance
print_tolerance = 0.3; // [0:0.05:1.0]

//the width of the links (should be your lug width)
link_width = 19; // [16:0.5:28]

//the height of the links
link_height = 5;

//the length of each individual link
link_length = 12;

bar_offset = 1;
lug_pin_radius = (1.8 + print_tolerance) / 2;
$fn = 64;

/*
#-#-#  <-- sideA end
#####  <-- base shape
 # #   <-- sideB end
*/

// base shape of the link
module link_base() {
    union() {
        // base shape
        cube([link_width, link_length, link_height]);
        
        // sideA rounded end
        translate([0, 0, link_height/2]) rotate([0, 90, 0]) 
            cylinder(h = link_width, r=link_height/2, center = false);
        
        // sideB rounded end
        translate([0, link_length,link_height/2]) rotate([0, 90, 0]) 
            cylinder(h = link_width, r=link_height/2, center = false);
    }
}

module link_sideA() {
    // spacing of slots
    spacing = link_width / 5;
    
    for(i = [0 : 1]) {
        difference() {
            // sleeve
            translate([spacing + (2 * (i * spacing)) - print_tolerance, 0, link_height / 2]) rotate([0, 90, 0]) 
                cylinder(h = spacing + (print_tolerance * 2), r = link_height / 2 + print_tolerance, center = false);
            
            // bar
            translate([spacing + (2 * (i * spacing)) - print_tolerance, 0, 2.5]) rotate([0, 90, 0]) 
                cylinder(h = spacing + (print_tolerance * 2), r = (link_height / 2) - bar_offset - print_tolerance, center = false);
        }
    }
    
}

module link_sideB() {
    // spacing of slots
    spacing = link_width / 5;
    
    // sideB end bore
    translate([0, link_length,link_height/2]) rotate([0, 90, 0]) 
        cylinder(h = link_width, r=link_height/2 - bar_offset, center = false);
        
    // sideB end slots
    for(i = [0 : 2]) {
        translate([2 * (i * spacing), link_length, link_height / 2]) rotate([0, 90, 0]) 
            cylinder(h = spacing, r = link_height / 2 + print_tolerance, center = false);
    }
}

module link () {
    difference() {
        link_base();
        link_sideA();
        link_sideB();
    }
}

module lug_link() {
    difference() {
        link_base();
        link_sideB();
        
        // bore for lug pin
        translate([0, 0, link_height/2]) rotate([0, 90, 0]) 
            cylinder(h = link_width, r = lug_pin_radius, center = false);
    }
}

button_offset = 0.15;
module sideA_clasp() {
    difference() {
        union() {
            link_base();
            cube([link_width, link_length * 1.5, link_height]);
        }
        link_sideA();
        translate([0, link_length / 2 - print_tolerance, link_height/2]) cube([link_width, link_length + print_tolerance, link_height / 2]);
        
        // button hole
        translate([link_width / 2, link_length, 0]) cylinder(h = link_height/4, r1 = link_length/3 - button_offset, r2 = link_length/3, center = false);
        translate([link_width / 2, link_length, link_height/4]) cylinder(h = link_height/4, r1 = link_length/3, r2 = link_length/3 - button_offset, center = false);
    }
}

module sideB_clasp() {
    union() {
        difference() {
            union() {
                link_base();
                cube([link_width, link_length * 1.5, link_height]);
            }
            link_sideA();
            translate([0, link_length / 2 - print_tolerance, link_height/2]) cube([link_width, link_length + print_tolerance, link_height / 2]);
        }   
        
        // button
        difference() {
            union() {
                translate([link_width / 2, link_length, link_height / 2]) cylinder(h = link_height/4, r1 = link_length/3 - button_offset, r2 = link_length/3, center = false);
                translate([link_width / 2, link_length, 3* link_height / 4]) cylinder(h = link_height/4, r1 = link_length/3, r2 = link_length/3 - button_offset, center = false);
            }
            // slot
            translate([link_width / 2, link_length, link_height * (3/4)])  cube([2, link_length, link_height / 2], center = true);
        }
    }
}


//link();

// build the bracelet

// sideA side
translate([0, 0, 0]) {
    lug_link();
    sideA_links = ceil(num_links / 2);
    for(i = [1 : sideA_links]) {
        translate([0, i * link_length, 0]) link();
    }
    translate([0, (sideA_links + 1) * link_length, 0]) sideA_clasp();
}

// sideB side
translate([link_width + 10, 0, 0]) {
    lug_link();
    sideB_links = floor(num_links / 2);
    for(i = [1 : sideB_links]) {
        translate([0, i * link_length, 0]) link();
    }
    translate([0, (sideB_links + 1) * link_length, 0]) sideB_clasp();
}

