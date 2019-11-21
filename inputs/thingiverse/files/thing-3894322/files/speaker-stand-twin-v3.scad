// Everything in millimeters

model = "calibration"; // ["bottom", "top", "leg", "calibration"]

// printer line width
line_width = 0.575;
// printer line height
layer_height = 0.287;

// to fit connection between leg and top/bottom
tolerance = 0.08; 

// height of first layers of bottom and top
layer1 = round(0.5 / layer_height) * layer_height;

// hole depth on top and bottom platform
hole_depth = round(15/layer_height) * layer_height;

// ### bottom

bottom_x = 208;
bottom_y = 175;
bottom_h = hole_depth + layer1;
bottom_edge_radius = 50;
// Level of detail, if set to very low the area gets edgy


// ### top

top_x = 168;
top_y = 145;
top_edge_radius = 50;
top_h = round(6/layer_height)*layer_height + layer1;

// ### leg

leg_radius = 12.9;
leg_wall = round(1.1/line_width) * line_width + 0.01; // wall thickness of the leg cylinder
leg_bottom_h = 5 + hole_depth;
leg_height = 150;
leg_holder_height = 50;

// holder/leg distance
leg_distance = 80;

holder_outside_radius = leg_radius;
holder_inside_radius = leg_radius - leg_wall - tolerance;


leg_radius_holder_outside = leg_radius - leg_wall - tolerance;
leg_radius_holder_inside = leg_radius - 2*leg_wall - tolerance;

// Level of detail, if set to very low, it gets edgy
$fn=150;

// leg
if(model == "leg"){
    translate([0, -2*leg_radius - 5, 0])
    union(){
        double_wall_height = 5;
        // inner holder (smaller radius)    
        translate([0, 0, leg_height])
        difference(){
            cylinder(r=leg_radius_holder_outside, h=leg_holder_height);
            translate([0, 0,-0.1])
            cylinder(r=leg_radius_holder_inside, h=leg_holder_height+0.2);
        }

        // bigger outside    
        difference(){
            cylinder(r=leg_radius, h=leg_height);
            translate([0, 0, -0.01])
            cylinder(r=leg_radius - leg_wall, h=leg_height+0.02);
        }
        
        // double wall
        translate([0, 0, leg_height-double_wall_height])
        difference(){
            cylinder(r=leg_radius, h=double_wall_height);
            translate([0, 0,-0.1])
            cylinder(r=leg_radius_holder_inside, h=double_wall_height+0.2);
        }

        // inner champfer for easy printing
        translate([0, 0, leg_height-double_wall_height])
        rotate([180, 0, 0])
        champfer_triangle_inside(outer_radius=leg_radius_holder_outside + tolerance, inner_radius=leg_radius_holder_inside, height=leg_wall*2);
     }
}

// bottom
if(model == "bottom"){
  difference(){
    union(){
        // left
        hull(){
            roundedcube(bottom_x, bottom_y, layer1, bottom_edge_radius);
            translate([bottom_x/2 - leg_distance/2, bottom_y/2, -0.01]){            
                cylinder(r=leg_radius+tolerance, h=bottom_h);
            }
        }
        // right
        hull(){
            roundedcube(bottom_x, bottom_y, layer1, bottom_edge_radius);
            translate([bottom_x/2 + leg_distance/2, bottom_y/2, -0.01]){            
                cylinder(r=leg_radius+tolerance, h=bottom_h);
            }
        }
        
        translate([bottom_x/2 - leg_distance/2, bottom_y/2, layer1-0.01])       
        cylinder(r=leg_radius, h=leg_holder_height + hole_depth/2);
        
        
        translate([bottom_x/2 + leg_distance/2, bottom_y/2, layer1-0.01])        
        cylinder(r=leg_radius, h=leg_holder_height + hole_depth/2);
        
    }
    
    union(){
        translate([bottom_x/2 - leg_distance/2, bottom_y/2, layer1-0.01])
        cylinder(r=leg_radius - leg_wall, h=leg_holder_height + hole_depth/2 +0.02);

        translate([bottom_x/2 + leg_distance/2, bottom_y/2, layer1-0.01])
        cylinder(r=leg_radius - leg_wall, h=leg_holder_height + hole_depth/2 +0.02);
            
        // round cuts
        translate([bottom_x/2, 0, -0.01])
        cylinder(r=leg_radius*5, h = 20);
        
        translate([bottom_x/2, bottom_y, -0.01])
        cylinder(r=leg_radius*5, h = 20);   
       
       translate([0, bottom_y/2, -0.01])
        cylinder(r=leg_radius*3, h = 20); 
        
       translate([bottom_x, bottom_y/2, -0.01])
        cylinder(r=leg_radius*3, h = 20); 
    }  
}
}

if(model == "top"){
    difference(){
        translate([-top_x, 0, 0])
        {
            // base
            hull(){
                roundedcube(top_x, top_y, layer1, top_edge_radius);
                translate([top_x/2 - leg_distance/2, top_y/2, 0])
                cylinder(r=hole_depth + holder_outside_radius, h = top_h);
            }
            hull(){
                roundedcube(top_x, top_y, layer1, top_edge_radius);
                translate([top_x/2 + leg_distance/2, top_y/2, 0])
                cylinder(r=hole_depth + holder_outside_radius, h = top_h);
            }
            
            // leg 1
        union(){
            translate([top_x/2 - leg_distance/2, top_y/2, top_h - 0.01]){
                champher_sphere(holder_outside_radius , hole_depth);
                difference(){
                    cylinder(h=hole_depth, r=holder_outside_radius);   
                    cylinder(h=hole_depth+1, r= holder_inside_radius);
                }
                difference(){
                    cylinder(r=leg_radius_holder_outside, h=leg_holder_height+hole_depth);
                    translate([0, 0,-0.1])
                    cylinder(r=leg_radius_holder_inside, h=leg_holder_height+hole_depth+0.2);
                }
            }

            // leg 2
            translate([top_x/2 + leg_distance/2, top_y/2, top_h - 0.01]){
                champher_sphere(holder_outside_radius, hole_depth);
                difference(){
                    cylinder(h=hole_depth, r=holder_outside_radius);   
                    cylinder(h=hole_depth+1, r= holder_inside_radius);
                }
                difference(){
                    cylinder(r=leg_radius_holder_outside, h=leg_holder_height+hole_depth);
                    translate([0, 0,-0.1])
                    cylinder(r=leg_radius_holder_inside, h=leg_holder_height+hole_depth+0.2);
                }

            }
            }
        }
        // round cuts
        union(){
            translate([-top_x/2, 0, -0.01])
            cylinder(r=holder_outside_radius*4, h = 20);
            
            translate([-top_x/2, top_y, -0.01])
            cylinder(r=holder_outside_radius*4, h = 20);   
           
           translate([0, top_y/2, -0.01])
            cylinder(r=holder_outside_radius*2, h = 20); 
            
           translate([-top_x, top_y/2, -0.01])
            cylinder(r=holder_outside_radius*2, h = 20); 
        }
    }
}

if(model == "calibration"){
    union(){
        // inside
        calib_height=30;
        translate([bottom_x/2 + leg_radius, 0, 0])
        difference(){
            cylinder(r=leg_radius_holder_outside, h=calib_height);
            translate([0, 0,-0.1])
            cylinder(r=leg_radius_holder_inside, h=calib_height+0.2);
        }
        //outside
        
        translate([bottom_x/2 - leg_radius, 0, 0])
        difference(){
            cylinder(r=leg_radius, h=calib_height);
            translate([0, 0,-0.1])
            cylinder(r=leg_radius - leg_wall, h=calib_height+0.2);
        }
    }
}

module champher_sphere(r, h){    
    difference(){        
        cylinder(r = r + h, h = h);
        union(){
            translate([0, 0, -0.01])
            cylinder(r = r, h=h+0.1);
            translate([0, 0, h])
            rotate_extrude()
            translate([r+h, 0, 0])
            circle(r=h);
        }
    }
}

module champher_sphere_inside(r, h){    
    difference(){        
        cylinder(r = r + h, h = h);
        union(){
            translate([0, 0, -0.01])
            cylinder(r = r, h=h+0.1);
            translate([0, 0, h])
            rotate_extrude()
            translate([r, 0, 0])
            circle(r=h);
        }
    }
}
//champfer_triangle_inside();
module champfer_triangle_inside(outer_radius=10, inner_radius=4, height=19){
    rotate_extrude()
    translate([inner_radius, -inner_radius, 0])
    polygon([[0, inner_radius], [outer_radius-inner_radius,inner_radius], [outer_radius-inner_radius, height+inner_radius]]);
}

module roundedcube(l, w, h, r, center=false){
    hull(){
        translate([r,r,0])cylinder(h=h,r=r, center=center);
        translate([l-r,r,0])cylinder(h=h,r=r, center=center);

        translate([r,w-r,0])cylinder(h=h,r=r, center=center);
        translate([l-r,w-r,0])cylinder(h=h,r=r, center=center);
    }
}
