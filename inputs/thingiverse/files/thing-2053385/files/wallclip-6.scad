// Rod wall holder by Timoi for Thingiverse Jan 21st 2017

tol = 0.6*1;
$fn = 60*1;

// Setting for screw
screw_hat_thickness = 2;  // [1:4]
screw_hat_width = 6; // [3:10]
screw_hole_size = 3;  // [2:10]
screw_length = 40*1;
nbr_of_screws = 1; // [1:6]

// Settings for rod
rod_diameter = 24; // [14:60]

// For multiple holders  printing
number_of_wall_clips = 1; // [1,2,4,6,8,10,12,14,16,18,20]
gridX = rod_diameter*2.5*1;
gridY = rod_diameter*2.0*1;

// Calculated values
rod_arc_thickness=screw_hat_thickness*2;
rod_clip_width =  nbr_of_screws*screw_hat_width*2+rod_arc_thickness*2;

// creating module to create one holder
module  rodWallClip() {

    // creating screw mounts
    for(step = [ 0 : 1 : nbr_of_screws-1]) {
        translate ([screw_hat_width*(2*step-(2*nbr_of_screws-1)/2+0.5),0,0]) 
        screwblock(screw_hat_thickness, screw_hat_width,screw_hole_size);
    }
    
    // Creating arc holding rod
    difference() {
        // Rod clip
        union () {
         
            // leaving arc top over above given angles
            aa = -35;
            xr = cos(aa)*(rod_diameter+rod_arc_thickness)/2;
            zr = sin(aa)*(rod_diameter+rod_arc_thickness)/2;
            
            translate ([-rod_clip_width/2,0,-(rod_diameter+0*rod_arc_thickness)/2]) {  
                
                difference() {
                    // Rod arch
                    difference() {
                        rotate([0,90,0]) cylinder(rod_clip_width, d=rod_diameter+rod_arc_thickness*2);
                        translate([-tol,0,0]) { rotate([0,90,0]) cylinder(rod_clip_width*2*tol, d=rod_diameter);}
                    }
                  
                    // removing top part of rod Arch
                    translate([-tol,-2*xr,zr-rod_diameter]) cube([rod_clip_width+2*tol, 4*xr,rod_diameter ],false);
                    translate([-tol,-xr,zr-rod_diameter+rod_arc_thickness/2]) cube([rod_clip_width+2*tol, 2*xr,rod_diameter ],false);
                                
                    // removing material from arc edges
                    for(astep = [ -50 : 2 : 10]) {    
                        barOnAngle(astep, (rod_diameter+rod_arc_thickness)/2, rod_arc_thickness/2, rod_clip_width+2*tol);
                    }
                
                    for(bstep = [ 170: 1 : 230]) {    
                        barOnAngle(bstep, (rod_diameter+rod_arc_thickness)/2, rod_arc_thickness/2, rod_clip_width+2*tol);
                    }              
            }
                
                // Adding bump bars to top arch ends (size adaptive)
                slimit = rod_diameter/screw_hat_thickness;       
                //dbars = 1.2;
                if ( slimit <= 12 ) {dbars = 1.3;
                    translate([0,xr,zr]) {rotate([0,90,0])  cylinder(rod_clip_width,d=rod_arc_thickness*dbars);}
                    translate([0,-xr,zr]) {rotate([0,90,0]) cylinder(rod_clip_width,d=rod_arc_thickness*dbars);}
                }  else {
                          translate([0,xr,zr]) {rotate([0,90,0])  cylinder(rod_clip_width,d=rod_arc_thickness*1.8);}
                    translate([0,-xr,zr]) {rotate([0,90,0]) cylinder(rod_clip_width,d=rod_arc_thickness*1.8);}
                    }
            
                }
            }
        
        // Removing parts
        union() {
            // arc removal from screws top
            removal_height = rod_diameter/2+rod_arc_thickness+tol; 
            translate([0,0,removal_height/2]+rod_arc_thickness) { 
                cube([rod_clip_width-2*rod_arc_thickness, 2*screw_hat_width, removal_height], true);
                }
            }
        
    }
    
    // --- modules --- 
    module screw(hatThicknes, screw_hat_witdh,screw_hole_size, screw_length  ){
            
        // Screw which size is made larger by tol
        cylinder(hatThicknes,d1=screw_hat_witdh+tol*2,d2=screw_hat_witdh+1*tol);
        translate([0,0,-2*tol]) cylinder(2*tol,d1=screw_hat_witdh+tol*2,d2=screw_hat_witdh+2*tol);
        cylinder(screw_length,d=screw_hole_size+tol);
      }
    
    module screwblock(hatThickess, screw_hat_witdh,screw_hole_size) {
        
    difference() {
        // Lower vertical part on screw side
        translate([0,0,(hatThickess*2+1*tol)/2]) {       
            cube([screw_hat_witdh*2,screw_hat_witdh*2,hatThickess*2+1*tol], true);
            }  
    
        // Screw made larger by tol and placed correctly
        screw(screw_hat_thickness,screw_hat_width,screw_hole_size, screw_length);
         
        }
        }
        
}

module barOnAngle(angleDeg, placeAtRadius, barDia, barLen) {
        aa = -angleDeg;
        xr = cos(aa)*(placeAtRadius);
        zr = sin(aa)*(placeAtRadius);
        translate([0,xr,zr]) {rotate([0,90,0]) {      
                translate([0,0,-tol])
                cylinder(barLen,d=barDia);
                }
            }
}


// Array of clips
module column_of_fasteners()  { 
    for (a =[1:number_of_wall_clips/2]) { 
        translate([0,-(a-1)*gridY,0]) { rotate([0,90,0]) rodWallClip();}
    } 
}

if (number_of_wall_clips>1) { 
    column_of_fasteners();
    mirror([1,0,0]) { translate([gridX,0,0]) { column_of_fasteners();}}
} else {
    rotate([0,90,0]) rodWallClip();

}