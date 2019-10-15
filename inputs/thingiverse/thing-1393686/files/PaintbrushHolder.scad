// Brush holder
//
// ===================================================
// This is a remix of the Cubistand Pen Brush Holder Stand
// by sdmc
//
// ===================================================


// preview[view:south, tilt:top]

/* [Parameters] */

// Which part would you like to see?
part = "fullset"; // [base:Base only,top:Top only,rod:Connecting rod,cap: Connecting rod cap, fullset:Full set of parts]

// Paintbrush hole width.
hole_w = 10; 

// Paintbrush hole length.
hole_d = 10;

// Wall thickness. 
wall_thickness = 2; 

// Holder base and top height
holder_h = 8; 

//Rod height (excludes the part that goes into the base and top)
rod_h = 50; 

// Number of holes width
holes_count_w = 5;

// Number of holes depth
holes_count_d = 6;

// Rounding. This is the rounding at the corners of the base and top.
rounding = 6; 

// Bottom Thickness. 
bottom_h = 3; //[1,2,3,4,5]

// Rod play. This shrinks the ends of the rod by a smidge so they can be inserted into the printed base and top.
rod_play = 0.05; // [0,0.05, 0.1, 0.2]

// Cap height. Zero means no cap.
cap_h = 6; 

/*[Hidden]*/
full_width = holes_count_w * (hole_w + wall_thickness) + wall_thickness;
full_depth = holes_count_d * (hole_d + wall_thickness) + wall_thickness;
$fn = 64;


inner_rounding = rounding - wall_thickness;
if ( inner_rounding < 0 ) {
    inner_rounding = 0;
}

print_part();

module print_part() {
    if (part=="base") {
        part_base();
    }
    else if (part == "top") {
        part_main();
    }
    else if (part == "cap") {
        part_cap();
    }
    else if (part == "rod") {
        part_rod();
    }
    else if (part=="fullset") {
        part_fullset();
    }
}

module part_fullset() {
    part_base();
    part_main();   
    part_rod();
    part_cap();
}

module part_cap() {
    if ( cap_h > 0 ) {
         translate([0,0,rod_h+30]) {
            difference() {
                onecorner_rounded_rectangle(hole_w+2*wall_thickness, hole_d+2*wall_thickness, cap_h, rounding);
                translate([wall_thickness,wall_thickness,-1]) 
                onecorner_rounded_rectangle(hole_w, hole_d, cap_h - wall_thickness+2, inner_rounding);
            }
        }
    }
}

module part_rod() {
    union() {
        translate([0,0,holder_h]) 
            onecorner_rounded_rectangle(hole_w+2*wall_thickness, hole_d+2*wall_thickness, rod_h, rounding);
        
        o = sign(cap_h) * (cap_h - wall_thickness);
        
        translate([wall_thickness+rod_play,wall_thickness+rod_play,rod_play]) 
            onecorner_rounded_rectangle(hole_w-rod_play*2, 
                    hole_d-rod_play*2, 
                    rod_h+(2*holder_h)-rod_play*2 + o, 
                    inner_rounding);
    }
}

module part_base() {
    union() {
        holed_rectangle();
        translate([0,0,-bottom_h]) {
            rounded_rectangle(bottom_h);
        }
    }
}

module part_main() {
    translate([0,0,rod_h+holder_h]) {
        holed_rectangle();
    }
}

module holed_rectangle() {
    difference() {
        rounded_rectangle(holder_h);
        for( x=[0:holes_count_w-1]) {
             for( y =[0:holes_count_d-1] ) {
                translate(
                    [wall_thickness+ (hole_w + wall_thickness) * x ,
                     wall_thickness+ (hole_d + wall_thickness) * y,
                     -1]) {
                         if ( (x == 0 && y == 0)) {
                             onecorner_rounded_rectangle( hole_w, hole_d, holder_h+2, inner_rounding);
                         } 
                         else if ( x==0 && y == (holes_count_d -1)) {
                             rotated_rounded_hole(180, true);
                         }                         
                         else if ( x== (holes_count_w -1) && y == (holes_count_d -1)) {
                             rotated_rounded_hole(180, false);
                         }                         
                         else if ( x==(holes_count_w -1) && y == 0) {
                             rotated_rounded_hole(0, true);
                         }                         
                         else                          
                         {
                             onecorner_rounded_rectangle( hole_w, hole_d, holder_h+2,0);
                         }
                }
             }
        }
    }
}

module rotated_rounded_hole(deg, which_corner) {
     translate([hole_w/2, hole_d/2,0]) {
         rotate([0,0,deg]) {
             translate([-hole_w/2, -hole_d/2,0]) {
                 if ( !which_corner) 
                     onecorner_rounded_rectangle( hole_w, hole_d, holder_h+2, inner_rounding, 0);                 
                 else 
                     onecorner_rounded_rectangle( hole_w, hole_d, holder_h+2, 0, inner_rounding);
             }
         }                             
    }
}

module onecorner_rounded_rectangle(w, d, h, r, r1) {    
    difference() {
        cube([w, d, h], false);
        if ( r > 0 ) {
            round_corner(r,h);
        }
        if ( r1 > 0 ) {
            other_round_corner(r1, w, h);
        }
    }
}

module round_corner(r, h) {
    p=1;      
    difference () {
        translate([-p,-p,-p]) { 
            cube( [r+p,r+p,h+p*2] , false);
        }
        translate([r, r, 0]) {
            cylinder(h,r,r);
        }
    }
}

module other_round_corner(r,w,h) {
    p=1;      
    difference () {
        translate([w-r,-p,-p]) { 
            cube( [r+p,r+p,h+p*2] , false);
        }
        translate([w-r, r, 0]) {
            cylinder(h,r,r);
        }
    }
}

module rounded_rectangle(h) {
    union() {
        translate([0,rounding,0]) {
            cube([full_width,full_depth - (rounding * 2),h], false);
        }
        translate([rounding,0,0]) {
            cube([full_width - (rounding * 2), full_depth ,h], false);
        }
        translate([rounding,rounding,0]) {
            cylinder(h, rounding, rounding);
        }
        translate([full_width - rounding,rounding,0]) {
            cylinder(h, rounding, rounding);
        }
        translate([full_width - rounding,full_depth - rounding,0]) {
            cylinder(h, rounding, rounding);
        }
        translate([rounding,full_depth - rounding,0]) {
            cylinder(h, rounding, rounding);
        }
    }
}
