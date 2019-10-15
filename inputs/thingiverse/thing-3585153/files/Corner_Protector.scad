sphere_radius = 30;
mag_dia = 6;
mag_height = 3;

clearance = 1.2;

radius = mag_dia * clearance / 2;
height = mag_height * clearance;
trans = sphere_radius/2*(-1);

difference() {
    sphere(sphere_radius,$fn=200);
    translate ([trans,trans,trans])cube(sphere_radius*2);

    translate ([0,0,trans]) rotate([180,0,0]) cylinder(height,radius,radius);
    translate ([0,trans,0]) rotate([90,0,0]) cylinder(height,radius,radius);
    translate ([trans,0,0]) rotate([0,270,0]) cylinder(height,radius,radius);
}
