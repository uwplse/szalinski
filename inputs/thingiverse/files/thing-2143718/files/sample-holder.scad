// spool holder diameter (mm)
inner_diameter = 60;

// filament hooks diameter (this is the diameter of your filament) (mm)
hook_diameter = 100;

// the size of the whole holder
outside_diameter = 160;

// depth of the holder
spindle_depth = 25;

// how thick all the 'flat' parts should be
wall_thickness = 3;

// how many arms on your holder? (3+)
num_arms = 3;

arm_width = 20;

module Hub() {

    difference() {   
        cylinder(h=spindle_depth, r=inner_diameter/2);
        cylinder(h=spindle_depth, r=inner_diameter/2 - wall_thickness);
        

            for(a= [0:3]) {
            rotate(a=45*a, v=[0,0,1]) translate([-inner_diameter*0.6,0,spindle_depth/2]) rotate(a=90, v=[0,1,0]) cylinder(h=inner_diameter*1.2, r= (spindle_depth - 2*wall_thickness)/2);
        }
        
    }
    

}

module Arm() {
    
    translate([-arm_width/2,0,0]) cube([arm_width,(outside_diameter)/2 , wall_thickness]);
    translate([0,outside_diameter/2,0]) cylinder(r=arm_width/2, h=wall_thickness);
    
    difference() {
        translate([0,hook_diameter/2,0]) cylinder(r=4, h=spindle_depth);
        translate([0,hook_diameter/2,0]) cylinder(r=2, h=spindle_depth,$fn=50);
    }
    
}

module Hook() {
    
    translate([0,hook_diameter/2,0]) cylinder(r=1.9, h=spindle_depth*0.7,$fn=50);
    
    hull () {        
        translate([0,hook_diameter/2,0]) cylinder(r=arm_width/2, h=wall_thickness);
        translate([0,outside_diameter/2,0]) cylinder(r=arm_width/2, h=wall_thickness);
    }
}


difference() {
    
    union() {
        Hub();

        for (a = [1:num_arms]) {
            angle = a * (360/num_arms);
            rotate(a=angle, v=[0,0,1]) Arm();
            rotate(a=angle, v=[0,0,1]) translate([0,(outside_diameter)/2,0]) Hook();

        } 
    }
// punch a hole back through the middle
cylinder(h=spindle_depth, r=inner_diameter/2 - wall_thickness);
}


