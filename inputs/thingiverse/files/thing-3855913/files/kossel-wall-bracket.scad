// the distance the machine should be fixed away from the apex of the wall corner
distance_from_wall=50; // [30:100]

// the width of the vertical extrusion, kossel uses 2020 (20mm) extrusion
extrusion_width=20; // [20:10:40]

// the shank diameter of the bolts used to fix the brace to the extrusion
extrusion_bolt_diameter=4;  // [3:0.5:7]


// the corner clearance, useful for wallpapered or older walls that don't have a sharp corner
wall_fillet_radius=8;  // [4:1:10]

// the shank diameter of the screws used to fix the brace to the wall
wall_bolt_diameter=4; // [3:1:6]

// the head diameter of the screws used to fix the brace to the wall
wall_bolt_clearance_diameter=8;  // [6:1:10]

/** {Hidden] **/
wall_thickness=3;
adjusted_distance_from_wall=distance_from_wall < extrusion_width+20 ? extrusion_width+20 : distance_from_wall;
u2020=extrusion_width+wall_thickness*2;
width=sqrt(pow(u2020,2)*0.5);
$fn=25;

use <fillet.scad>

difference(){
    union(){
        // the length of a square to create
        // a diagonal of a certain width
        difference(){
            union(){
                cube(size=[u2020,u2020,u2020]);
                
                translate([u2020*0.5, u2020*0.5, 0]){
                    rotate([0,0,45]){
                        cube([width,width,u2020]);
                    }
                }
            }
            
            // 2020 extrusion
            translate([wall_thickness,-1,-extrusion_width]){
                cube(size=[extrusion_width, extrusion_width+1, extrusion_width*3]);
            }

        }
        
    
        // shaft
        translate([wall_thickness+extrusion_width*0.125, extrusion_width]){
            cube([extrusion_width*0.75, adjusted_distance_from_wall-(u2020*0.5), u2020]);
        }

        // wall diamond
        translate([u2020*0.5, extrusion_width+adjusted_distance_from_wall-u2020]){
            rotate([0,0,45]){
                difference(){
                    cube([width,width,u2020]);
                    translate([.1, .1, .1]){
                        difference(){
                            intersection(){
                                translate([0,0,-1]){
                                    cube([width,width,u2020+2]);
                                }
                                translate([width, width,-1]){
                                    cylinder(h=u2020+2, r=wall_fillet_radius);
                                }
                            }
                            
                            translate([width-wall_fillet_radius, width-wall_fillet_radius, -1]){
                                cylinder(h=u2020+2, r=wall_fillet_radius);
                            }
                        }
                    }
                }
            }
        }
    }

    // screw holes
    translate([-1, extrusion_width*0.5, u2020*0.5]){
        rotate([0,90,0]){
            cylinder(h=u2020+2, d=extrusion_bolt_diameter);
        }
    }

    translate([(u2020*0.5), extrusion_width+adjusted_distance_from_wall, u2020*0.5]){
        rotate([0,0,225]){
            translate([(width*0.55), wall_thickness-1, 0]){
                rotate([-90,0,0]){
                    cylinder(h=wall_bolt_clearance_diameter*0.5, d=wall_bolt_clearance_diameter, d1=wall_bolt_diameter);
                    translate([0,0, wall_bolt_clearance_diameter*0.5]){
                        cylinder(h=u2020, d=wall_bolt_clearance_diameter);
                    }
                    translate([0,0, -wall_thickness-1]){
                        cylinder(h=u2020, d=wall_bolt_diameter);
                    }
                }
            }
        }
    }

    translate([u2020, extrusion_width+adjusted_distance_from_wall-(u2020*0.5), u2020*0.5]){
        rotate([0,0,135]){
            translate([(width*0.45), wall_thickness-1, 0]){
                rotate([-90,0,0]){
                    cylinder(h=wall_bolt_clearance_diameter*0.5, d=wall_bolt_clearance_diameter, d1=wall_bolt_diameter);
                    translate([0,0, wall_bolt_clearance_diameter*0.5]){
                        cylinder(h=u2020, d=wall_bolt_clearance_diameter);
                    }
                    translate([0,0, -wall_thickness-1]){
                        cylinder(h=u2020, d=wall_bolt_diameter);
                    }
                }
            }
        }
    }
}