
// millimeters
chip_diameter = 40;

// millimeters
chip_thickness = 3.3;

// number of chips
stack_height = 12;

wall_thickness = 0.75;

slot_opening = 8;

leg_length = 10;

/* [Hidden] */

slop = 0.2;

difference() {
    cylinder(h=((stack_height * chip_thickness) + wall_thickness + leg_length), d=(chip_diameter + (2 * wall_thickness) + slop));
    
    translate([0,0,wall_thickness + leg_length])
    cylinder(h=(stack_height * chip_thickness), d=chip_diameter + slop);
    
    cylinder(h=(wall_thickness + leg_length), d=(chip_diameter - (8 * wall_thickness)));
        
    translate([-(chip_diameter + (2 * wall_thickness) + slop)/2, 0, (chip_thickness * stack_height)/2 + leg_length])
    rotate([0,90,0])
    hull() {
        translate([(chip_thickness * stack_height)/4, 0, 0])
        cylinder(h=(chip_diameter + (2 * wall_thickness) + slop), d=slot_opening);
        
        translate([-(chip_thickness * stack_height)/4, 0, 0])
        cylinder(h=(chip_diameter + (2 * wall_thickness) + slop), d=slot_opening);
    };
    
    translate([0, -(chip_diameter + (2 * wall_thickness) + slop)/2, (chip_thickness * stack_height)/2 + leg_length])
    rotate([0,90,90])
    hull() {
        translate([(chip_thickness * stack_height)/4, 0, 0])
        cylinder(h=(chip_diameter + (2 * wall_thickness) + slop), d=slot_opening);
        
        translate([-(chip_thickness * stack_height)/4, 0, 0])
        cylinder(h=(chip_diameter + (2 * wall_thickness) + slop), d=slot_opening);
    };
    
    translate([-(chip_diameter + (2 * wall_thickness) + slop)/2,0,0])
    rotate([0,90,0])
    cylinder(h=(chip_diameter + (2 * wall_thickness) + slop), d=(chip_diameter/2));
    
    translate([0,-(chip_diameter + (2 * wall_thickness) + slop)/2,0])
    rotate([0,90,90])
    cylinder(h=(chip_diameter + (2 * wall_thickness) + slop), d=(chip_diameter/2));
};