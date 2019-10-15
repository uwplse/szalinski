bed_max_x = 150;
bed_max_y = 150;
plate_size = 50;
height = .1;
triangle_factor = 1.25;

module four_corners() {
    translate([bed_max_x-plate_size,0,0]){
        cube([plate_size,plate_size,height]);
    }
    translate([bed_max_x-plate_size,bed_max_y-plate_size,0]){
        cube([plate_size,plate_size,height]);
    }

    translate([0,bed_max_y-plate_size,0]){
        cube([plate_size,plate_size,height]);
    }

    cube([plate_size,plate_size,height]);
}

module edge_triangles() {
    translate([bed_max_x/2,bed_max_y/2,0]) {
        
        translate([0,plate_size*triangle_factor,0]){
            rotate([0,0,30]) {
                cylinder(r=plate_size/2, h=height, $fn=3);
            }
        }
        
        translate([plate_size*triangle_factor,0,0]){
            rotate([0,0,60]) {
                cylinder(r=plate_size/2, h=height, $fn=3);
            }
        }

        translate([0,(plate_size*triangle_factor)*-1,0]){
            rotate([0,0,90]) {
                cylinder(r=plate_size/2, h=height, $fn=3);
            }
        }

        translate([(plate_size*triangle_factor)*-1,0,0]){
            rotate([0,0,0]) {
                cylinder(r=plate_size/2, h=height, $fn=3);
            }
        }

    }
    
}


module center_point() {
    translate([bed_max_x/2,bed_max_y/2,0]) {
        cylinder(r=plate_size/2, h=height, center=true);
    }
}
    
four_corners();
center_point();
edge_triangles();

