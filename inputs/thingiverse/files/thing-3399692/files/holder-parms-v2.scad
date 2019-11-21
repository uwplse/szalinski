// preview[view:south west, tilt:top diagonal]

//number of x dimension holes
num_x_holes=5; 
//number of x dimension holes
num_y_holes=5; 
// size of holes on X axis (mm)
hole_x_size=15; 
// size of holes on Y axis (mm)
hole_y_size=15; 
// height of the upper and lower grid (mm)
grid_height=6; 
// thickness of the grid webs (mm)
web_thickness=1.5; // [1:0.5:3]
//Height of the risers (mm) between upper and lower
riser_height=75; //[10:200]
// number of vertical risers 
num_risers=2; // [0:1:6]
// hollow risers (boolean)
hollow_risers=1; // [0:NOT Hollow, 1:Hollow]

// hollow supports
show_base=1; // [0:NO base, 1:Include Base]
// hollow supports
show_top=1; // [0:NO top, 1:Include Top]


//bevel size (bevel on outer edges)
bevel_sz=.5; // [0:0.5:2]
//tolerance (increase if parts too tight, decrease if parts too loose)
tolerance=.1;  

/* [Hidden] */

//derived values
x_len=web_thickness + num_x_holes*(hole_x_size+web_thickness);
y_len=web_thickness + num_y_holes*(hole_y_size+web_thickness);
z_len=web_thickness;

show_part();

module show_part() {
    if ( show_base >0) {
        base();
    }
    if (show_top > 0 ) {
        translate([show_base * (x_len+10), 0,0])
            upper();
    }
    translate([(show_base + show_top)*(x_len+10), 0,0])
        riser();
}

module base() {
    difference() {
        union() {
            //base
            cube([x_len, y_len, z_len]);
            
            for(i=[0:num_x_holes]) {
                translate([i*(hole_x_size+web_thickness),0,z_len])
                    cube([web_thickness, 
                        y_len,
                        grid_height]);
            }
            for(i=[0:num_y_holes]) {
                translate([0,i*(hole_y_size+web_thickness),z_len])
                    cube([x_len, 
                        web_thickness, 
                        grid_height]);
            }
        }
        
        //bevel corners
        for (i=[0:1]) {
            for (j=[0:1]) {
                translate([i*x_len,j*y_len,0]) 
                    rotate([0,0,i*90+ j*90]) {
                        bevel(bevel_sz, length=grid_height+z_len);
                }
            }
        }
        for (i=[0:1]) {
            translate([0,i*y_len,0]) 
                rotate([90,-90*i,90]) {
                    bevel(bevel_sz, length=x_len);
            }
        }
        for (j=[0:1]) {
            translate([j*x_len,0,0]) 
                rotate([-90,-90-90*j,0]) {
                    bevel(bevel_sz, length=x_len);
            }
        }
        
        
    }
}


L2_height=riser_height+z_len+grid_height;
//upper grid
module upper() {
    
    difference() {
        union() {
            for(i=[0:num_x_holes]) {
                translate([i*(hole_x_size+web_thickness),0,0])
                    cube([web_thickness, 
                        y_len,
                        grid_height]);
            }
            for(i=[0:num_y_holes]) {
                translate([0,i*(hole_y_size+web_thickness),0])
                    cube([x_len, 
                        web_thickness, 
                        grid_height]);
            }
        }
        
        //bevel corners
        for (i=[0:1]) {
            for (j=[0:1]) {
                translate([i*x_len,j*y_len,0]) 
                    rotate([0,0,i*90+ j*90]) {
                        bevel(bevel_sz, length=grid_height);
                }
            }
        }
        for (i=[0:1]) {
            translate([0,i*y_len,grid_height]) 
                rotate([90,90+90*i,90]) {
                    bevel(bevel_sz, length=x_len);
            }
        }
        for (j=[0:1]) {
            translate([j*x_len,0,grid_height]) 
                rotate([-90,90*j,0]) {
                    bevel(bevel_sz, length=x_len);
            }
        }
    }
    
}
//risers
module riser() {
    for(i=[0:num_risers-1]) {
        translate([0,i*(hole_y_size + 2*web_thickness +10),0])
            difference() {
                union() {
                    translate([web_thickness+tolerance,
                            web_thickness+tolerance,0])
                        // inner
                        cube([hole_x_size - 2*tolerance, 
                            hole_y_size - 2*tolerance,
                            2*grid_height +riser_height]);
                    translate([0, 0,grid_height])
                        cube([hole_x_size+2*web_thickness, 
                            hole_y_size+2*web_thickness,
                            riser_height]);
                }
                            
                if (hollow_risers ==1) {
                    translate([2*web_thickness,2*web_thickness,0])
                        cube([hole_x_size- 2*web_thickness, 
                            hole_y_size - 2*web_thickness,
                            2*grid_height +riser_height]);
                }
                //bevel outer
                for (i=[0:1]) {
                    for (j=[0:1]) {
                        translate([i*(hole_x_size+2*web_thickness),
                                j*(hole_y_size+2*web_thickness),
                                grid_height]) 
                            rotate([0,0, 90*i -90*j  + (180*i*j)]) {
                                bevel(bevel_sz, length=riser_height);
                        }
                    }
                }
                //bevel inner
                for (i=[0:1]) {
                    for (j=[0:1]) {
                        translate([web_thickness+tolerance + i*(hole_x_size-2*tolerance),
                                web_thickness+tolerance +j*(hole_y_size-2*tolerance),
                                0])
                            rotate([0,0, 90*i -90*j  + (180*i*j)]) {
                                bevel(bevel_sz, length=grid_height);
                        }
                        translate([web_thickness+tolerance + i*(hole_x_size-2*tolerance),
                                web_thickness+tolerance +j*(hole_y_size-2*tolerance),
                                grid_height + riser_height])
                            rotate([0,0, 90*i -90*j  + (180*i*j)]) {
                                bevel(bevel_sz, length=grid_height);
                        }
                    }
                }
               
            }
    }
}

module bevel(size=1, length=0) {
    
    if (length>0) {
        linear_extrude(height=length, center=false)
            polygon([[0,0], [size,0], [0,size]]);
    } else {
        polygon([[0,0], [size,0], [0,size]]);
    }
    
}
    