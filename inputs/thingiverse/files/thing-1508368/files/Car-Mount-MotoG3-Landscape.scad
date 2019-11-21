phone_width = 143;
phone_length = 73;
phone_height = 15;
radius_phone = 10;

/* [Hidden] */
height = 4;
radius = 5;

$fn=50;

//#phone();

difference() {
    union() {
        difference() {
            base_plate();
        }
        lower_connector();
        mirror([1,0,0]) lower_connector();
        // No upper connector
        //upper_connector();
        middle_part();
        lower_part();
        // No upper part
        //upper_part();
    }
    translate([0,0,height-2]) scale([0.8,0.8,1]) base_plate(); 
    mount_grid();
}

module phone() {    
    color("blue", 0.2) hull() {
        translate([phone_width/2-radius_phone, phone_length/2-radius_phone, height]) cylinder(r=radius_phone,h=phone_height);
        translate([phone_width/2-radius_phone, -phone_length/2+radius_phone, height]) cylinder(r=radius_phone,h=phone_height);
        translate([-phone_width/2+radius_phone, phone_length/2-radius_phone, height]) cylinder(r=radius_phone,h=phone_height);
        translate([-phone_width/2+radius_phone, -phone_length/2+radius_phone, height]) cylinder(r=radius_phone,h=phone_height);
    }
}

module base_plate() {
    hull() {
        translate([15, 30, 0]) cylinder(r=radius,h=height);
        translate([15, -30, 0]) cylinder(r=radius,h=height);
        translate([-15, 30, 0]) cylinder(r=radius,h=height);
        translate([-15, -30, 0]) cylinder(r=radius,h=height);
    }
}

module upper_connector() {
    hull() {
        translate([0, 20, height/2]) cube([4*radius, 4*radius, height], center = true);
        translate([0, phone_length/2, height/2]) cube([2*radius, 2*radius, height], center = true);
    }
}

module upper_part() {
    translate([0, phone_length/2+radius, 1]) rotate([0,90,0]) {
        hull() {
            cylinder(r=1,h=2*radius, center=true);
            translate([-phone_height+2, 0, 0]) cylinder(r=0.5,h=2*radius, center=true);
        }        
        translate([-phone_height-4, 0, 0]) difference() {
            cylinder(r=6, h=2*radius, center=true);
            cylinder(r=5, h=2*radius, center=true);
            translate([-10,0.5,-10]) cube([20, 10, 20]);
            translate([-15,-12,-10]) rotate([0,0,45]) cube([20, 10, 20]);
        }
        #translate([-phone_height-12,-5.5,-radius]) rotate([0,0,45])  cube([radius, 1, 2*radius]);
    }
}

module lower_connector() {
    hull() {
        translate([10, 18, 0]) cylinder(r=2*radius,h=height);
        translate([phone_width/2-5, -phone_length/2+4, 0]) cylinder(r=radius,h=height);
    }
    // No rotation of lower part
    //translate([phone_width/2-10, -phone_length/2+4, 0]) cylinder(r=radius,h=7);
}

module lower_part() {
    // No rotation of lower part
    rotate([/*-5*/0,0,0]) difference() {
        hull() {
            translate([0, -phone_length/2+18, (phone_height + 2+height)/2]) cube([phone_width + 4, 2, phone_height + 2+height], center=true);
            translate([-phone_width/2+radius+3, -phone_length/2+radius_phone - 2, 0]) cylinder(r=radius_phone,h=phone_height + 2+height);
            translate([phone_width/2-radius-3, -phone_length/2+radius_phone - 2, 0]) cylinder(r=radius_phone,h=phone_height + 2+height);
        }
        phone();
        // cut out for display
        //translate([0,10,20]) cube([phone_width, phone_length, phone_height], center=true);
        // cut out for microphone
        translate([0,2,20]) cube([phone_width-10, phone_length, phone_height], center=true);
        // cut out for charger
        //translate([0,-12,16]) cube([15, phone_length, phone_height], center=true);
    }
}

module middle_part() {
    translate([0,17,height/2]) {
        cube([phone_width+4, 10, height], center = true);
        translate([-phone_width/2-2,-35,-height/2]) cube([2, 54, phone_height + 2+height]);
        translate([phone_width/2,-35,-height/2]) cube([2, 54, phone_height + 2+height]);

        translate([-phone_width/2+1,18,-height/2]) cylinder(r=3, h=phone_height+2+height, $fn=20);
        translate([+phone_width/2-1,18,-height/2]) cylinder(r=3, h=phone_height+2+height, $fn=20);
    }
}

module mount_grid() {
    translate([-10.5, -20, 0]) mount_grid_module();
    translate([10.5, -20, 0]) mirror([180,0,0]) mount_grid_module();
    translate([-10.5, 10, 0]) mount_grid_module();
    translate([10.5, 10, 0]) mirror([180,0,0]) mount_grid_module();
}

module mount_grid_module() {    
    translate([-1.5, 0, -10]) cube([6, 7, 20]);
    translate([-1.5, 7, -10]) cube([3, 7, 20]);
    translate([1.5, 10, -10]) cylinder(r=1,h=20);
}