
// in mm

phone_width = 73;
phone_depth = 10.5;
wall = 1.55; // wall thickness

holder_border_width = 5;

front_length = 5;
front_radius = front_length;

cable_tie_width = 8;
cable_tie_depth = 1.5;
cable_tie_radius = 15;

cut_height = 64; // adjusts also the height

$fn = 50; // details

holder_width = phone_width + 2*wall;
holder_depth = phone_depth + 2*wall;

cut_radius = holder_depth - wall;

holder_height = cut_height + phone_width/2 + cut_radius;

holder_square_height = holder_height/3;
holder_square_depth = holder_depth/2 + 3;
holder_square_z = 1/2* holder_height-5;

translate([0, -front_length + front_radius, -holder_depth])
roundedcube(holder_width, front_length, wall, front_radius);

union(){
    difference(){
        difference(){
            union(){
                difference(){
                    cube([holder_width, holder_depth, holder_height]);
                    
                    union(){
                        translate([wall, wall, wall])
                        cube([phone_width, phone_depth, holder_height]);
                        
                        translate([holder_border_width, -0.01, -0.005])
                        cube([holder_width - 2*holder_border_width, holder_depth-wall+0.01, holder_height + 0.01]);
                    }
                }
                
                // thickness
                hull(){
                    translate([0, holder_depth, 0]){
                        cube([holder_width, 0.01, holder_height]);
                        
                        translate([2*holder_border_width, holder_square_depth, holder_square_z])
                            cube([holder_width - 4*holder_border_width, 0.01, holder_square_height]);
                    }
                }
            }
            // cable ties
            union(){
                translate([holder_width/2, holder_depth + cable_tie_radius - wall - 0.01, holder_square_z])
                    cable_tie_hole();
                translate([holder_width/2, holder_depth + cable_tie_radius - wall - 0.01, holder_square_z+holder_square_height-cable_tie_width])
                    cable_tie_hole();
            
                // cut for buttons                
                translate([-0.01, -0.01, cut_height+cut_radius]){
                    rotate([0, 90, 0])
                    cylinder(r = cut_radius, h=holder_width+0.1);
                    cube([holder_width+0.1, holder_depth-wall, holder_height]);
                }
            }
        }
        // top roundness
        translate([-0.05, 0, cut_height+0.01])
        difference(){   
            cube([holder_width+0.1, 2*holder_depth, holder_height - cut_height]);
            translate([holder_width/2, 2*holder_depth+0.01, 0])
            rotate([90, 0, 0])
            cylinder(r=holder_width/2+0.05, h=2*holder_depth+0.1);
        }
    }
    // bottom for sound
    sound_coube_height = holder_depth;
    difference(){
        translate([0, 0, -sound_coube_height])
        cube([holder_width, holder_depth, sound_coube_height]);
        
        translate([holder_border_width, 0, 0])
        rotate([0, 90, 0])
        cylinder(r=sound_coube_height-wall, h = holder_width - 2*holder_border_width);
    }
}

module cable_tie_hole(){
    difference(){
        translate([-cable_tie_radius, -cable_tie_radius, -0.01])
            cube([2*cable_tie_radius, cable_tie_radius, cable_tie_width]);
        translate([0, 0, -0.1])
            cylinder(h=cable_tie_width + 1, r=cable_tie_radius - cable_tie_depth);
    }
}

module roundedcube(l, w, h, r, center=false){
    hull(){
        translate([r,r,0])cylinder(h=h,r=r, center=center);
        translate([l-r,r,0])cylinder(h=h,r=r, center=center);

        translate([r,w-r,0])cylinder(h=h,r=r, center=center);
        translate([l-r,w-r,0])cylinder(h=h,r=r, center=center);
    }
}