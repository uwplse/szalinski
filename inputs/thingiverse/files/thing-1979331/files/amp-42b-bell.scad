pi = 3.14159265359;//TODO

// the radius of the small end of your bell connector
bell_connector_small_radius = 7.958;
// the radius of the large end of your trombone connector
bell_connector_large_radius = 8.706;
//the length of the bell connector, in mm */
bell_connector_length = 31.5;
//the bore size, 0.547 inch = 13.9mm 
bore_size=13.7;

//the width of your phone
phone_width=67;
//the thickness of your phone
phone_thickness=6.9;
//the margin at the side of the model. You should not need to change it.
margin=5;

$fn=200;
rotate([-45-90,0,0])
difference() {
    union() {
        difference() {
            cube([phone_width+margin*2, 40, 35]);
            rotate([10,0,0])
            iphone_shape();
            translate([0,80+60,40])
            rotate([45+90,0,0])
            cube(100);
        }
        
        translate([20, 0, bell_connector_large_radius+4])
        bell_connector();
    }
    translate([20,18,12.7])
    rotate([90,0,0])
    cylinder(r=bore_size/2, h=40);
    
    translate([9.5,12,5])
    rotate([10,0,0])
    cube([20,10,3]);
    
    translate([0,25,0])
    cube(200);
}

module bell_connector() {
    rotate([90,0,0]) {
        union() {
            difference() {
                cylinder(r1=bell_connector_large_radius, r2=bell_connector_small_radius, h= bell_connector_length);
                cylinder(r=bore_size/2, h=bell_connector_length);
            }

        }
    }
}

module iphone_shape() {
    translate([margin, 15, 5])
    cube([phone_width+0.2, phone_thickness+0.2, 138.1]);
}