// Quick T-Slot Clamp 
// Design by Marius Gheorghescu (@mgx3d), July 2017


// Chose the extrusion type
extrusion_type = "80/20 20-2020"; // [1515:Misumi 15mm (1515),2020:Misumi 20mm (2020),80/20 1010:80/20 1" (1010),80/20 20-2020:80/20 20mm (20-2020), OpenBeam:OpenBeam 15mm,MicroRax: MicroRax 10mm]

// length of the clamp on the extrusion (longer => better grip)
clamp_len = 30; // [10:100]

// length of the jaw in milimeters
jaw_len = 100; // [10:500]

// jaw guiding grooves depth (set to 0 for no grooves)
groove_depth = 2.25; // [0:0.1:5]

// Add a nub to the lever to limit rotation?
lever_nub = 1; // [0,1]

// Pad grooves as a ratio of jaw (total clamp length is jaw + jaw*pad)
pad_ratio = 0.5; // [0.0:0.1:1.0]


/* [Hidden] */

wall_thickness = groove_depth+2;


extrusion_size = 
    (extrusion_type == "1515")?15:
    (extrusion_type == "2020")?20:
    (extrusion_type == "80/20 1010")?25.4:
    (extrusion_type == "80/20 20-2020")?20:
    (extrusion_type == "OpenBeam")?15:
    (extrusion_type == "MicroRax")?10:
    10;

extrusion_groove_min =     
    (extrusion_type == "1515")?3.55:
    (extrusion_type == "2020")?6.15:
    (extrusion_type == "80/20 1010")?6.5:
    (extrusion_type == "80/20 20-2020")?5.15:
    (extrusion_type == "OpenBeam")?3.25:
    (extrusion_type == "MicroRax")?4.90:
    3.3;

extrusion_groove_max = 
    (extrusion_type == "1515")?5.5:
    (extrusion_type == "2020")?11.75:
    (extrusion_type == "80/20 1010")?14.5:
    (extrusion_type == "80/20 20-2020")?11.75:
    (extrusion_type == "OpenBeam")?5.75:
    (extrusion_type == "MicroRax")?6.0:
    5.5;


extrusion_groove_lip =
    (extrusion_type == "1515")?1.15:
    (extrusion_type == "2020")?2.3:
    (extrusion_type == "80/20 1010")?2.4:
    (extrusion_type == "80/20 20-2020")?1.55:
    (extrusion_type == "OpenBeam")?1.45:
    (extrusion_type == "MicroRax")?1.0:
    1.0;

extrusion_groove_depth = 
    (extrusion_type == "1515")?4.2:
    (extrusion_type == "2020")?6.1:
    (extrusion_type == "80/20 1010")?7.2:
    (extrusion_type == "80/20 20-2020")?6.0:
    (extrusion_type == "OpenBeam")?4.2:
    (extrusion_type == "MicroRax")?3.1:
    4.0;


epsilon = 0.01;

cam_dia = min(extrusion_size*0.8, clamp_len/2);
cam_z_offset = cam_dia/2 ;
cam_lock_offset = 1;

// slide-in clearance between parts 
clearance = 0.25;


$fn=100;

pad_len = epsilon + jaw_len*pad_ratio;


module round_rect_ex(x1, y1, x2, y2, z, r1, r2)
{
    brim = z/10;

    hull() {
        translate([-x1/2 + r1, y1/2 - r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([x1/2 - r1, y1/2 - r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([-x1/2 + r1, -y1/2 + r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);
        translate([x1/2 - r1, -y1/2 + r1, z/2-brim/2])
            cylinder(r=r1, h=brim,center=true);

        translate([-x2/2 + r2, y2/2 - r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([x2/2 - r2, y2/2 - r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([-x2/2 + r2, -y2/2 + r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);
        translate([x2/2 - r2, -y2/2 + r2, -z/2+brim/2])
            cylinder(r=r2, h=brim,center=true);

    }
}

// groove slider with 0-reference on the face of the extrusion
module groove_clamp(len, depth)
{
    radius = 0.3;
    
    difference() {
        union() {
            hull() {
                
                translate([-extrusion_groove_max/2 + radius, -radius - extrusion_groove_lip, 0])
                    cylinder(r=radius, h=len, center=true);

                translate([extrusion_groove_max/2 - radius, -radius - extrusion_groove_lip, 0])
                    cylinder(r=radius, h=len, center=true);

                translate([0, - min(extrusion_size/2, extrusion_groove_max*cos(45)) + radius - extrusion_groove_lip, 0])
                    cylinder(r=radius, h=len, center=true);
            }
            
            // extension
            hull() {
                translate([0, -extrusion_groove_lip/2 - epsilon, 0])
                    cube([extrusion_groove_min, extrusion_groove_lip, len], center=true);
                
                translate([0, depth, 0])
                    cube([extrusion_groove_min, extrusion_groove_lip, cam_dia], center=true);
                
                translate([0, depth, 0])
                    cube([extrusion_groove_min, extrusion_groove_lip, len], center=true);

            }
        }
        
        // clear bottom of the groove
        translate([0, -extrusion_groove_depth - extrusion_groove_max/2, 0])
            cube([extrusion_groove_max, extrusion_groove_max, len + epsilon], center=true);
        
    }        
}

module logo()
{
    rotate([-90,0,90]) {
    intersection() {
        union() {
            difference() {
                round_rect_ex(3, 10, 3, 10, 2, 1, 1);
                round_rect_ex(2, 9, 2, 9, 3, 1, 1);
            }

            translate([2.5, 0, 0]) 
                difference() {
                    round_rect_ex(3, 10, 3, 10, 2, 1, 1);
                    round_rect_ex(2, 9, 2, 9, 3, 1, 1);
                }
        }

        translate([0, -3.5, 0]) 
            cube([20,4,10], center=true);
    }

    translate([1.25, -2.5, 0]) 
        difference() {
            round_rect_ex(8, 7, 8, 7, 2, 1, 1);
            round_rect_ex(7, 6, 7, 6, 3, 1, 1);

            translate([3,0,0])
                cube([4,2.5,3], center=true);
        }


    translate([2.0, -1.0, 0]) 
        cube([8, 0.5, 2], center=true);

    translate([0,-2,0])
        cylinder(r=0.25, h=2, center=true, $fn=12);

    translate([2.5,-2,0])
        cylinder(r=0.25, h=2, center=true, $fn=12);
    }

}


module arm() {
    
    cam_shaft_clearance = 0.5;
        
    translate([0,0,-clamp_len/2])
    difference() {
        
        hull() {
            // extrusion shell
            translate([extrusion_size/4,0,0])
               cube([extrusion_size/2, extrusion_size, clamp_len], center=true);
            
            // pad
            translate([jaw_len - pad_len/2, 0, clamp_len/2 - wall_thickness/2])        
               cube([pad_len, extrusion_size, wall_thickness], center=true);
            
        }    

        // save material / add strength
        translate([jaw_len/2 - epsilon + extrusion_size, extrusion_size/5, -wall_thickness])
            cube([jaw_len , extrusion_size/5, clamp_len], center=true);

        translate([jaw_len/2 - epsilon + extrusion_size, -extrusion_size/5, -wall_thickness])
            cube([jaw_len, extrusion_size/5, clamp_len], center=true);
        
        // longitudinal groove
        translate([jaw_len - pad_len/2, 0 ,clamp_len/2])
        rotate([0,90,0])
        rotate([0,0,45])
            cube([groove_depth, groove_depth, pad_len], center=true);
    
        // cross-grooves
        translate([jaw_len - pad_len/2, 0, clamp_len/2 - wall_thickness/2])
        for(i=[0:max(extrusion_size/4, groove_depth*2):pad_len]) {
            translate([i-pad_len/2,0,wall_thickness/2])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([groove_depth, groove_depth, extrusion_size + jaw_len], center=true);
        }
    }
}


module cam_lever()
{
    lever_len = clamp_len+extrusion_size/4;
    
    difference() {
        union() {    
            
            // cam shaft
            translate([0, 0, extrusion_size/2])
                cylinder(r=cam_dia/2, h=extrusion_size, center=true);    
            
            // handle
            translate([0, 0, -cam_dia/4 + epsilon])
            {
                // handle
                translate([0, 0, cam_dia/8])
                hull() {
                    cylinder(r=cam_dia/2, h=cam_dia/4, center=true);
                    
                    translate([0, lever_len, 0])
                        cylinder(r=cam_dia/4, h=cam_dia/4, center=true);
                }
                
                if (lever_nub) {
                    // nub to prevent flipping around
                    translate([0, lever_len, cam_dia/4 + cam_dia/8 - epsilon])
                        cylinder(r=cam_dia/4, h=cam_dia/4, center=true);
                }
                
                // bevel
                translate([0, 0, -cam_dia/8 +epsilon])
                hull() {
                    cylinder(r1=cam_dia/4, r2=cam_dia/2, h=cam_dia/4, center=true);
                    translate([0, lever_len, 0])
                        cylinder(r1=cam_dia/8, r2=cam_dia/4, h=cam_dia/4, center=true);
                }
                
            }
         }
         
         
         // offset groove
         translate([0, cam_lock_offset, extrusion_size/2 - extrusion_groove_min/2])
         difference() {
         
           
            translate([0, 0, extrusion_groove_min/2 + cam_dia/2 + clearance])
                cylinder(r=cam_dia, h=extrusion_groove_min + cam_dia + 2*clearance, center=true);
         
            cylinder(r=cam_dia/2 - cam_lock_offset, h=extrusion_size, center=true);         
            translate([0,0,cam_dia/2 + extrusion_groove_min - epsilon])
                cylinder(r1=cam_dia/2 - cam_lock_offset, r2=cam_dia*1.5, h=cam_dia, center=true);
            
         }
    }
}

module jaw()
{
    depth = extrusion_size/2 - extrusion_groove_lip/2;
    height = clamp_len;
    
    difference() {
        union() {
            groove_clamp(height, depth);

            // cam rider
            translate([0, cam_z_offset + cam_lock_offset*0, 0])
            rotate([90,0,90])
                cylinder(r=cam_dia/2 + cam_lock_offset, h=extrusion_groove_min, center=true);

                        
            difference() {
                translate([0,clearance, -clamp_len/2])
                rotate([0,180,-90]) arm();

                // cam shaft clearance
                translate([0, cam_z_offset + cam_lock_offset*0, 0])
                rotate([90,0,90])
                    hull() {
                        cylinder(r=cam_dia/2 + clearance, h=60, center=true);
                        
                        translate([-cam_lock_offset,0,0])
                            cylinder(r=cam_dia/2 + clearance, h=60, center=true);
                        
                        translate([-cam_lock_offset - cam_dia, cam_dia/2,0])
                            cylinder(r=cam_dia/2 + clearance, h=60, center=true);
                    }
            }
        }
        
        translate([0, cam_z_offset - cam_lock_offset*1.5, 0])
        rotate([90,0,90])
            hull() {
                cylinder(r=cam_dia/2 + clearance, h=60, center=true);                
            }
            
        //translate([extrusion_size/2 + 0.25, cam_z_offset + cam_dia, -2 - ((jaw_len < 40)?cam_dia/2:0)])
        translate([-1, extrusion_groove_lip + 0.5, clamp_len/2 + 0.5])
        rotate([0,-90,-90])
        scale((extrusion_size*1.5 - 8)/extrusion_size)
            logo();

    }
    

}

module clamp()
{
    depth = cam_dia;
    height = clamp_len;
    cam_shaft_clearance = 0.25;

    //translate([0,0,-clamp_len/2])
    
    difference() {
        union() { 
            hull() {
                // extrusion shell
                translate([extrusion_size/4,0,0])
                   cube([extrusion_size/2, extrusion_size, clamp_len], center=true);
                
                // pad
                translate([extrusion_size/2 + jaw_len, 0, -clamp_len/2 + wall_thickness/2])        
                   cube([pad_len, 0*2*wall_thickness + extrusion_size, wall_thickness], center=true);
                
                translate([cam_z_offset, 0,  0])        
                rotate([0,90,90])
                    cylinder(r=cam_dia/2 + clearance + wall_thickness, h=extrusion_size, center=true);
                
            } 
        }
        
        // locking plate clearance
        translate([jaw_len/2- epsilon,0, wall_thickness])
            cube([jaw_len, extrusion_groove_min, clamp_len+epsilon], center=true);
        

        // clear material
        translate([jaw_len/2 + pad_len/2 - epsilon + extrusion_size/2, 0, wall_thickness])
            cube([jaw_len + pad_len, extrusion_size/2, clamp_len], center=true);
                
        // longitudinal groove
        translate([(extrusion_size + jaw_len)/2 + extrusion_size,0, -clamp_len/2])
        rotate([0,90,0])
        rotate([0,0,45])
            cube([groove_depth, groove_depth, extrusion_size + jaw_len + pad_len], center=true);
    
        // cross-grooves
        translate([0*wall_thickness + extrusion_size/2 + jaw_len, 0, -clamp_len/2 - wall_thickness/2])
        for(i=[extrusion_size/4:extrusion_size/4:pad_len]) {
            translate([pad_len/2 - i,0,wall_thickness/2])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([groove_depth, groove_depth, extrusion_size + jaw_len], center=true);
        }
                        
        // cam shaft clearance
        translate([cam_z_offset, 0,  0])        
        rotate([0,90,90])
            cylinder(r=cam_dia/2 + clearance, h=60, center=true);        
    } 
}


module locking_plate()
{
    difference() {
        
        union() {
            groove_clamp(clamp_len, cam_z_offset + cam_dia/2 + wall_thickness);
            
            harden_len = cam_z_offset + cam_dia/2 - extrusion_size/2 + wall_thickness + extrusion_groove_lip;
            
            translate([0, extrusion_size/2 + harden_len/2, 0])
                cube([extrusion_size/2, harden_len, clamp_len], center=true);
        }
                

        // cam shaft clearance
        translate([0, cam_z_offset - extrusion_groove_lip, -wall_thickness])
        rotate([0,90,0])
            cylinder(r=cam_dia/2 + clearance, h=extrusion_size, center=true);
    }
    
}




// show assembled?
if (0) {
    
    color([0.2,0.2,0.2,1.0]) jaw();
    color("red") translate([ -extrusion_size/2, cam_z_offset, 0]) rotate([90,0,90]) 
        cam_lever();
    
    %translate([0, -extrusion_size/2, 0]) cube([extrusion_size, extrusion_size, 5*clamp_len], center=true);

} else {

    jaw();
    translate([extrusion_size, 0, -clamp_len/2 +cam_dia/2]) cam_lever();

}



