module tube (length, diameter, x, y, z){
 translate([x,y,z]){
    cylinder(length, r=diameter/2);
 }    
}

module box (xlength, ylength, zlength, x, y, z){
    dx = xlength/2;
    dy = ylength/2;
    dz = zlength/2;
    translate([x-dx,y-dy,z]){
        cube ([xlength,ylength,zlength]);
    }
}

$fn=50; // rurve

final = true;
cross_test = true;
axil_test = true;

radius = 9;
axil=8;
motor=6;

axis_wcross = 5.34; //width of cross
axis_wbeam = 2.34; // with of a small crossbeam that builds the cross

motor_width = 5.48;
motor_length = 3.48;

test_hight = 2;

module cross (wcross,wbeam,x,y,z) {
    box (wcross,wbeam,z,x,y);
    box (wbeam,wcross,z,x,y);
}


if (!final) {
    
    // CREATE THE AXIS CONNECTOR
    if (axil_test){
        difference(){
            tube(test_hight, radius, 0, 0, 0);
            cross(axis_wcross,axis_wbeam,0,0,axil);
        }
    }

    // CREATE MOTOR CONNECTOR
    if (cross_test) {

        translate([radius + 1,0,-axil]){
            difference(){
                tube(test_hight, radius, 0, 0, axil);
                box (motor_width,motor_length,motor,0,0,axil);
            }
        }
    }    
}    

if (final) { 
    // CREATE THE AXIS CONNECTOR
    difference(){
        tube(axil, radius, 0, 0, 0);
        cross(axis_wcross,axis_wbeam,0,0,axil);
    }

    // CREATE MOTOR CONNECTOR
    difference(){
        tube(motor, radius, 0, 0, axil);
        box (motor_width,motor_length,motor,0,0,axil);
    }
}