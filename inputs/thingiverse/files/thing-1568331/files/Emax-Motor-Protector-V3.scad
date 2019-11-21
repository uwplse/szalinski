/*
Customisable Motor Protection for Quadcopter

    - by Harlo
    - 16/05/2016
    
    **Standard variables are based on an Emax Nighthawk 250**
*/

//MOTOR PROTECTOR VARIABLES

//Fixing Screws Diameter
screw_dia = 3.3; //[0:0.25:8]
//Fixing Screw Head Diameter
screw_head_dia = 6; //[0:0.25:20]
//Screw Fixing Thickness
screw_fixing_thickness = 2; //[0:0.25:20]
//Distance Between Screw Centers
screw_seperation = 19; //[0:0.25:50]
//Screw Slide Distance
screw_slide = 6; //[0:0.25:10]
//Rotate the fixings (degrees)
screw_rotation = 0; //[0:1:90]
//Motor Shaft Diameter (upper)
shaft_dia = 7; //[0:0.25:15]
//Motor Shaft Diameter (lower)
shaft_dia_2 = 4; //[0.1:0.1:15]
//Motor Shaft Height
shaft_height = 35; //[0:0.25:100]
//Arm Diameter (of mount)
arm_dia = 30; //[5:0.25:80]
//Arm Width
arm_width = 25.25; //[3:0.25:80]
//General Smoothness 
resolution = 80; //[20:1:180]
//Outside Diameter
protector_dia = 35; //[20:0.25:120]
//Outer Shape/Smoothness
protector_res = 12; //[8:1:180]
//Protector Height (Total Z)
protector_height = 2.5; //[1:0.1:60]
//Protector Lower Thickness
protector_bottom_thickness = 2.5; //[0.5:0.1:10]
//Rotate (for viewing while editing)
turn = -90; //[-90:5:90]
//Flip (for printing the other way up)
flip = 180; //[0:15:180]


//LEG VARIABLES

//Base Diameter
base_dia = 10; //[0:0.25:80]
//Leg Length -- set to 0 for no length
base_length = 65; //[0:0.25:100]
//Smoothness of the foot
base_resolution = 50; //[6:1:200]
//Scale/Flatness of the foot
base_z_scale = 0.25; //[0.1:0.1:2]


//Internal Variables
arm_length = arm_dia*3;
screw_height = 20 * 20;
arm_thickness = 20 * 1;


//Render
rotate([flip,0,turn]){
    protector_with_cuts();
}


//Modules

module protector_with_cuts(){
    difference(){
        hull(){
            protector();
            foot();
        }
        cut_arm();
        cut_base();
        cut_screws();
        cut_shaft(); 
        cut_screw_heads();
    }
}

//LEG/BASE MODULES



module foot(){
    
    base_height_int = base_dia * base_z_scale; //actual height
    
    translate([0,0,-(base_length - base_height_int/2)]){
        scale([1,1,base_z_scale]){
            sphere(d = base_dia, $fn = base_resolution, center = true);
        }
    }
}


//PROTECTOR MODULES
module protector(){
    translate([0,0,protector_height/2 - protector_bottom_thickness]){
        cylinder(h = protector_height, d = protector_dia, center = true, $fn = protector_res);
    }
}


//CUTTING Modules
module cut_shaft(){
    translate([0,0,-shaft_height/2]){
        cylinder(h = shaft_height, d2 = shaft_dia, d1 = shaft_dia_2, center = true, $fn = resolution);
    }
}

module cut_screws(){
    rotate([0,0,screw_rotation]){
        screw_placed();
        rotate([0,0,90]){
            screw_placed();
        }
    }
}

module cut_screw_heads(){
    rotate([0,0,screw_rotation]){
        screw_head_placed();
        rotate([0,0,90]){
            screw_head_placed();
        }
    }
}

module screw_head_placed(){
    translate([screw_seperation/2,0,-(screw_height/2 +screw_fixing_thickness)]){
        screw_head_slide();
    }
    
    translate([-screw_seperation/2,0,-(screw_height/2 +screw_fixing_thickness)]){
        screw_head_slide();
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

module screw_head_slide(){
    hull(){
        translate([screw_slide/2,0,0]){
            screw(screw_height, screw_head_dia);
        }
        translate([-screw_slide/2,0,0]){
            screw(screw_height, screw_head_dia);
        }
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