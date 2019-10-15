/*
Customisable Motor Protection for Quadcopter

    - by Harlo
    - 16/05/2016
    
    **Standard variables are based on an Emax Nighthawk 250**
*/


//Fixing Screws Diameter
screw_dia = 3.5; //[0:0.25:8]
//Distance Between Screw Centers
screw_seperation = 17; //[0:0.25:50]
//Screw Slide Distance
screw_slide = 3; //[0:0.25:10]
//Rotate the fixings (degrees)
screw_rotation = 0; //[0:1:90]
//Motor Shaft Diameter (add tolerance)
shaft_dia = 9; //[0:0.25:15]
//Arm Diameter (of mount)
arm_dia = 30; //[5:0.25:80]
//Arm Width
arm_width = 25.25; //[3:0.25:80]
//General Smoothness 
resolution = 80; //[20:1:180]
//Outside Diameter
protector_dia = 35; //[20:0.25:120]
//Outer Shape/Smoothness
protector_res = 8; //[8:1:180]
//Protector Height (Total Z)
protector_height = 10; //[1:0.1:60]
//Protector Lower Thickness
protector_bottom_thickness = 2; //[0.5:0.1:10]
//Rotate (for viewing while editing)
turn = -90; //[0:15:360]

//Internal Variables
arm_length = arm_dia*3;
screw_height = 20 * 1;
arm_thickness = 20 * 1;
shaft_height = 20 * 1;

//Render
rotate([0,0,turn]){
    protector_with_cuts();
}

//Modules

module protector_with_cuts(){
    difference(){
        protector();
        cut_arm();
        cut_base();
        cut_screws();
        cut_shaft();        
    }
}

module protector(){
    translate([0,0,protector_height/2 - protector_bottom_thickness]){
        cylinder(h = protector_height, d = protector_dia, center = true, $fn = protector_res);
    }
}


//CUTTING Modules
module cut_shaft(){
    cylinder(h = shaft_height, d = shaft_dia, center = true, $fn = resolution);
}

module cut_screws(){
    rotate([0,0,screw_rotation]){
        screw_placed();
        rotate([0,0,90]){
            screw_placed();
        }
    }
}

module screw_placed(){
    translate([screw_seperation/2,0,0]){
        screw_slide();
    }
    
    translate([-screw_seperation/2,0,0]){
        screw_slide();
    }
}

module screw_slide(){
    hull(){
        translate([screw_slide/2,0,0]){
            screw(screw_height, screw_dia);
        }
        translate([-screw_slide/2,0,0]){
            screw(screw_height, screw_dia);
        }
    }
}

module screw(height, diameter){
    cylinder(h = height, d = diameter, $fn = resolution, center = true);
}

module cut_base(){
    translate([0,0,arm_thickness/2]){
        cylinder(h = arm_thickness, d = arm_dia, $fn = resolution, center = true);
    }
}

module cut_arm(){
    translate([arm_length/2,0,arm_thickness/2]){
        cube([arm_length, arm_width, arm_thickness], center = true);
    }
}