
base_length = 7;
base_diameter = 6;
shaft_length = 15;
hole_length = 6.5;
hole_diameter = 2.2; // 2.2mm hole appears to be good tight fit for motor shaft (maybe slightly too tight?)

shaft_xy_rescale = 1.0; // multiplicative factor to rescale the official technic dimensions

difference() {
    union() {
        translate([0,0,base_length]) scale([shaft_xy_rescale,shaft_xy_rescale,1]) technic_x(shaft_length);  
                                                                // technic cross head
        cylinder(base_length,d=base_diameter,true,$fn=50);      // base cylinder
    }
    cylinder(hole_length,d=hole_diameter,true,$fn=50);          
}

module technic_x (length=20) {
    intersection() {
        cylinder(length,d=4.74,true,$fn=50);
    
        translate([0,0,(length/2)]) {
            cube([5,1.58,length], true);
            cube([1.58,5,length], true);
        }
    }
}