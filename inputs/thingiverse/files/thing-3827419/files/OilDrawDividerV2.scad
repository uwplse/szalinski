// Optimised for 0.6mm nozzle

$fa=2;
$fs=0.2;

// Parameters
height_div = 120;
widthA_div = 120;
widthB_div = 82;
thickness_div = 3;

width_rib = 148.5;
depth_rib = 14;
thickness_rib = 2.4;
offset_rib = 5;

thickness_catch = 1.2;

width_rail = 14.3;
fudge = 0.6;

// Construction
difference() {
    union() {
        difference() {
            union() {
                // Divider
                translate([-widthA_div/2,0,0])
                cube([widthA_div, thickness_div, height_div]);
                
                // Divider rib
                translate([widthB_div/2-(depth_rib-thickness_rib),0,0])
                cube([13.2, depth_rib, height_div]);
                
                translate([-(widthB_div/2-(depth_rib-thickness_rib))-13.2,0,0])
                cube([13.2, depth_rib, height_div]);
            }
            
            // Diagonals
            translate([widthB_div/2,-1,0])
            rotate([0,20.8,0])
            cube([20, depth_rib+2, 70]);
            
            translate([-widthB_div/2,-1,0])
            rotate([0,-20.8,0])
            translate([-20,0,0])
            cube([20, depth_rib+2, 70]);
        }
    }
    
    union() {    
        // Side rib cutout
        translate([widthB_div/2-(depth_rib-thickness_div), depth_rib,-1])
        cylinder(h=height_div+2, r=(depth_rib-thickness_div));
    
        translate([-(widthB_div/2-(depth_rib-thickness_div)), depth_rib,-1])
        cylinder(h=height_div+2, r=(depth_rib-thickness_div));      
    }
}

module rail() {
    translate([widthA_div/2,-5, height_div-width_rail-fudge])
    cube([width_rail+fudge, 50, width_rail+fudge]); // including fudge             
}

module clip() {
    difference() {
        union() {
            // Side clip outer
            translate([width_rib/2-thickness_catch,0, height_div+thickness_rib-25])
            cube([thickness_rib+thickness_catch,depth_rib,25]);
            
            // Side clip inner
            translate([widthA_div/2-thickness_catch*2,0, height_div-18.4-1.2])
            cube([thickness_rib+thickness_catch,depth_rib,18.4]);
            
            // Top rib
            translate([0,0,height_div])
            cube([width_rib/2, depth_rib, thickness_rib]);
        }
        
        union() {
            // Top rib cutout
            inset = (widthB_div-depth_rib-9);
       
            translate([-1, thickness_div+offset_rib, height_div-1])
            cube([inset/2+1, depth_rib, thickness_rib*2]);
           
            translate([inset/2, depth_rib+offset_rib+3, 0])
            cylinder(h=height_div+thickness_rib+2, r=depth_rib);
    
            rail();
        }
    } 
    
    // Clip round end
    translate([width_rib/2+thickness_catch/2, 0, height_div+thickness_rib-25])
    rotate([-90,0,0])
    cylinder(h=depth_rib, r=(thickness_rib+thickness_catch)/2);
}

clip();
mirror(v=[1,0,0]) {clip();}
