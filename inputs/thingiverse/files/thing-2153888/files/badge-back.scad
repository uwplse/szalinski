
// Units: mm

dimension = 38;         // overall width and length of base
height = 2;             // thickness of base
center_diameter = 25;   // Diameter of hole

tab_height = 4;         // Overall height of tabs

tab_top_thickness = 3;  // Overall depth of teeth
tab_thickness = 2;      // Depth of wedge on teeth
tab_wedge_height = 2;   // Height of wedge

tabs = 8;               // How many tabs (must be even number)
tab_space = 4.5;        // Space between each tab
tab_start_angle = 25;   // Determines where the tabs end up.

union() {
    // The base with a circle cut through it
    difference() {
        cube([dimension,dimension,height]);
        translate([dimension/2,dimension/2,-1])
            cylinder(height+2,center_diameter/2,center_diameter/2); 
        
        rounded();
        
    }

    // The teeth
    difference() {
        translate([dimension/2,dimension/2,height])
            cylinder(tab_height, (center_diameter+(tab_top_thickness*2))/2, (center_diameter+(tab_top_thickness*2))/2);
        translate([dimension/2,dimension/2,0])
            cylinder(height+tab_height-tab_wedge_height,center_diameter/2,center_diameter/2); 
        translate([dimension/2,dimension/2,0])
            cylinder(height+tab_height+2,(center_diameter-tab_top_thickness)/2,(center_diameter-tab_top_thickness)/2);
        for (angle =[tab_start_angle:180/(tabs/2):180]) {
            translate([dimension/2,dimension/2,height]) rotate(angle)
                cube([center_diameter+(tab_top_thickness*2),tab_space,(tab_height*2)+(height*2)], true);
        }
    translate([dimension/2,dimension/2,height+tab_height-tab_wedge_height+0.5])
        cylinder(tab_wedge_height,(center_diameter/2)-((tab_top_thickness-tab_thickness)*2),(center_diameter/2) + tab_top_thickness);
    }
}

// Give our base rounded corners
module rounded() {
    translate([0,0,0]) difference() {
        translate([0,0,-1])
            cube([dimension,dimension,height+2]);
                translate([(dimension/4), (dimension/4)])
                    cylinder(height+3, dimension/4, dimension/4);
                translate([(dimension/4), -1])
                    cube([dimension*2,dimension*2,height+3]);
                translate([-1, (dimension/4)])
                    cube([dimension*2,dimension*2,height+3]);
    }
    
    translate([dimension,0,0]) mirror([1,0,0]) difference() {
        translate([0,0,-1])
            cube([dimension,dimension,height+2]);
                translate([(dimension/4), (dimension/4)])
                    cylinder(height+3, dimension/4, dimension/4);
                translate([(dimension/4), -1])
                    cube([dimension*2,dimension*2,height+3]);
                translate([-1, (dimension/4)])
                    cube([dimension*2,dimension*2,height+3]);
    }
    
    translate([dimension,dimension,0]) mirror([1,1,0]) difference() {
        translate([0,0,-1])
            cube([dimension,dimension,height+2]);
                translate([(dimension/4), (dimension/4)])
                    cylinder(height+3, dimension/4, dimension/4);
                translate([(dimension/4), -1])
                    cube([dimension*2,dimension*2,height+3]);
                translate([-1, (dimension/4)])
                    cube([dimension*2,dimension*2,height+3]);
    }
    
    translate([0,dimension,0]) mirror([0,1,0]) difference() {
        translate([0,0,-1])
            cube([dimension,dimension,height+2]);
                translate([(dimension/4), (dimension/4)])
                    cylinder(height+3, dimension/4, dimension/4);
                translate([(dimension/4), -1])
                    cube([dimension*2,dimension*2,height+3]);
                translate([-1, (dimension/4)])
                    cube([dimension*2,dimension*2,height+3]);
    }
    
}    
