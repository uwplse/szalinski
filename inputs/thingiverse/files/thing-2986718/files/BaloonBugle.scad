//Customizable variables
// Thicness of the outer walls
THICNESS = 2; //[1:5]
// Radius of the outter part
OUT_RADIUS = 20; //[10:50]
// Radius of the smal iner hole, must be smaller than (out_radius - 2*thichness)
IN_RADIUS = 10; //[5:45]
// Length of the tube/body, except from the front part/noozle
TUBE_LENGTH = 60;//[10:100]
// Lenght of the noozle, it will automatically geerate the radius of the front part
NOZZLE_LENGTH = 40;//[10:100]
// Quality
$fn = 50; //[20:Draft,50:Normal,100:Fine]

//Automatic variables - can be set manually if needed
NOZZLE_EXTERN_RADIUS = 2*NOZZLE_LENGTH/sqrt(3);
THIN_THICNESS = THICNESS/2;
HOLE_LENGTH = TUBE_LENGTH/2;
HOLE_RADIUS = OUT_RADIUS/5;

module Nozzle (){
    intersection(){
        cylinder(r = OUT_RADIUS+NOZZLE_EXTERN_RADIUS, h = NOZZLE_LENGTH);
        difference(){
            rotate_extrude(convexity = 10)
            translate([OUT_RADIUS-THICNESS+NOZZLE_EXTERN_RADIUS, 0, 0])
            circle(r = NOZZLE_EXTERN_RADIUS);
            
            rotate_extrude(convexity = 10)
            translate([OUT_RADIUS+NOZZLE_EXTERN_RADIUS, 0, 0])
            circle(r = NOZZLE_EXTERN_RADIUS);        
        }
    }
}

module Tube (){
    difference(){
        cylinder(r = OUT_RADIUS, h = TUBE_LENGTH);
        cylinder(r = OUT_RADIUS-THICNESS, h = TUBE_LENGTH);
        translate([0,0,HOLE_LENGTH])rotate([90,0,0])
        cylinder(r = HOLE_RADIUS, h = OUT_RADIUS);
    }
}

module Inner (){
    difference(){
        cylinder(r = IN_RADIUS+THIN_THICNESS, h = HOLE_LENGTH+HOLE_RADIUS + 2.5);
        cylinder(r = IN_RADIUS, h = HOLE_LENGTH+HOLE_RADIUS*2 + 2);  
    }
    translate ([0,0,IN_RADIUS-OUT_RADIUS]) difference(){
        cylinder(r = OUT_RADIUS-THICNESS, h = OUT_RADIUS-IN_RADIUS);
        cylinder(r1 = OUT_RADIUS-THICNESS, r2 = IN_RADIUS, h = OUT_RADIUS-IN_RADIUS);
    }
}

Tube();
translate([0,0,HOLE_LENGTH-HOLE_RADIUS - 1])Inner();
rotate([180,0,0])Nozzle();