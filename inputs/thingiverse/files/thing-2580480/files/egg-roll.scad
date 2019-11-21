
egg_width = 200;
egg_height = 60;
stick = 15;
stick_width = 8;

hole_dia = 22;
hole_margin = 5;
hole_angle = 3;

mount_thickness = 7;
mount_height = 110;
mounting_hole_dia = 3;
mounting_hole_spacing = 27;
mounting_hole_top_spacing = 10;

show_egg = true;
show_mount = true;

$fn=50;

if (show_egg) {
difference(){
    intersection(){
        union(){
            intersection(){
                scale([(egg_width + 15) / egg_height,1,1]) rotate([0,90,0]) sphere(d=egg_height, $fn=40);
               cube(egg_width, center = true); 
            }
            rotate([0,90,0]) cylinder(h = egg_width + 2*stick, d = stick_width, center = true);
            
     
        }
        sphere(d=egg_width + 2*stick);
    }
    //translate([-(egg_width /2 + stick), 0, -(egg_width /2 + stick)]) cube(egg_width + 2 * stick);
    //scale([(egg_width-2*wall) / (egg_height - wall) ,1,1]) rotate([0,90,0]) sphere(d=egg_height-wall); 
}
}
if (show_mount) {
base_move = 25 + (egg_width /2 + stick);
mount_width = hole_dia + hole_margin;


difference(){
    
hull(){
    //stick hole
    translate([base_move + (hole_dia + hole_margin) / 2, 0, (hole_dia + hole_margin) / 2]) rotate([-90,0,0]) cylinder(h = mount_thickness , d = hole_dia + hole_margin, center = false);
    //Base block
    translate([base_move, 0, hole_dia + 2*hole_margin]) cube([mount_width, mount_thickness, mount_height- hole_dia - 2-hole_margin]);
}    
    //stick hole
    translate([base_move + (hole_dia + hole_margin) / 2, -2, (hole_dia + hole_margin) / 2]) rotate([-90 - hole_angle,0,0]) cylinder(h = mount_thickness + 40, d = hole_dia, center = false);
    
    //mounting holes
    translate([base_move + (hole_dia + hole_margin) / 2, -1, mount_height - mounting_hole_top_spacing ]) rotate([-90,0,0]) cylinder(h = mount_thickness+2, d = mounting_hole_dia, center = false);
    
    translate([base_move + (hole_dia + hole_margin) / 2, -1, mount_height - mounting_hole_top_spacing - mounting_hole_spacing]) rotate([-90,0,0]) cylinder(h = mount_thickness+2, d = mounting_hole_dia, center = false);
}
}

