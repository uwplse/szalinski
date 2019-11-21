/*
    Folding or metal ruler marking gauge - Mk 3
    (Streichmass mit Meterstab oder Metallmass)

    Author: MrFuzzy_F, 
    License: CC BY-NC
*/

$fa=1*1;
$fs=0.25*1;


// width of folding ruler
ruler_width = 17; // .. [17:FoldingRuler, 13.5:SmallMetalRuler, 30.6:MidMetalRuler, 32.6:BroadMetalRuler]

// ruler thickness
ruler_thickness = 3.7; // .. [3.7:FoldingRulerSegment, 6.7:FoldingRulerFull, 0.9:SmallMetalRuler, 1.7:MidMetalRuler, 1.2:BroadMetalRuler]

// length of base
base_length = 35;

// lever length standing out over base
lever_length_over_base = 15;

// guide height
guide_height = 11;

// fence length over base (single side)
fence_length = 20;

// fence height 
fence_height = 11;

// print-in-place distance
print_adjust = 0.4;

// cutout adjustment. If inner cutout or drill holes are printed too small. 
cutout_adjust = 0.4;



housing_base_height = 15 + 0.0;
clamp_radius = 10 + 0.0;
clamp_holder_diameter = clamp_radius + 6;
protector_thickness = 2 + 0.0;
housing_inner_width = 6 + 0.0;
clamp_width = housing_inner_width - print_adjust*2;
protector_width = clamp_radius;
protector_depth = protector_thickness+2*print_adjust + 1;
axle_diameter = 6 + 0.0;
clamp_mid_pos = 18 + 0.0;
ambos_inner_size = clamp_radius - 1;
ambos_outer_size = clamp_radius + 4;

tunnel_elevation = ruler_thickness < 2 ? 2 : 0;


// thickness of base plate and walls
wall_thickness = 5 + 0.0;



main();



// TEST
//base();
//lever();
//lever_housing();
//lever_with_housing();
//ruler_protector();
//front();


module main() {

    base();
    lever_with_housing();
    front();
}   


module base() {

    ya = ambos_inner_size + 2*print_adjust + cutout_adjust;   
    yb = ambos_outer_size + 2*print_adjust + cutout_adjust;
    
    difference() {
        union() {
            translate([0,0,-wall_thickness])
                cube([ruler_width + 2*wall_thickness, base_length, wall_thickness]);
            
            // right wall
            cube([wall_thickness, base_length, guide_height]);
            
            
            // left wall
            translate([ruler_width+wall_thickness,0,0]) {
                difference() {

                    cube([wall_thickness, base_length, guide_height]);
                    
                    // cut-out in side wall for lever 
                    translate([0, clamp_mid_pos-ya/2, 0]) 
                        cube([wall_thickness, ya, housing_inner_width]);   
                    translate([0, clamp_mid_pos-yb/2, 0]) 
                        cube([wall_thickness/2, yb, housing_inner_width]);

                }
            }

                    
            lever_with_housing();
        }
        
        
    }
    
    // ambos
    translate([ruler_width+wall_thickness,0,0]) {
        translate([0,clamp_mid_pos-ambos_inner_size/2,print_adjust]) 
            cube([wall_thickness+2,ambos_inner_size, housing_inner_width-2*print_adjust]);   
        translate([0,clamp_mid_pos-ambos_outer_size/2,print_adjust]) { 
            trapezoid(2,ambos_outer_size, ambos_inner_size, housing_inner_width-2*print_adjust);   
            translate([wall_thickness+2, 0, 0]) 
                cube([2,ambos_outer_size, housing_inner_width-2*print_adjust]);   
        }
    }
    
    // ruler tunnel at back end
    translate([wall_thickness, base_length-wall_thickness, ruler_thickness+cutout_adjust+tunnel_elevation])
        cube([ruler_width, wall_thickness, guide_height-ruler_thickness-cutout_adjust-tunnel_elevation]);
    
    // tunnel elevation for flat metallic rulers
    if (tunnel_elevation > 0) {
        difference() {
            translate([wall_thickness, -wall_thickness, 0])
                cube([ruler_width, base_length+wall_thickness, tunnel_elevation]);
            
            cut_size = ambos_outer_size+2*(cutout_adjust+print_adjust);
            translate([ruler_width+wall_thickness-3, clamp_mid_pos-cut_size/2, 0]) { 
                cube([3, cut_size, tunnel_elevation]);
            }
        }
    }
}


module lever_with_housing() {

    housing_width = 2*wall_thickness+housing_inner_width;

    translate([wall_thickness+ruler_width, clamp_mid_pos-clamp_holder_diameter/2, -wall_thickness])
    rotate([90,0,90]) {
        translate([clamp_holder_diameter/2, housing_inner_width/2+wall_thickness, housing_base_height])
            lever();
                
        lever_housing();
    }
}



module lever_housing() {
    
    lever_bearing();
    translate([0, wall_thickness+housing_inner_width, 0]) 
        lever_bearing();   
}


module lever_bearing() {
    difference() {
        union() { 
            // round holder around axle
            translate([clamp_holder_diameter/2,wall_thickness,housing_base_height])
                rotate([90,0,0]) 
                    cylinder(wall_thickness, d=clamp_holder_diameter);

            // base below axle holder
            cube([clamp_holder_diameter, wall_thickness, housing_base_height]);

        }
        // cut-out for axle
        translate([clamp_holder_diameter/2,wall_thickness+1,housing_base_height])
            rotate([90,0,0]) 
                cylinder(wall_thickness+2, d=axle_diameter+cutout_adjust+print_adjust);
    }
    
}


module lever() {
 
    r = housing_base_height - wall_thickness - 4 - print_adjust; 
    //echo("r:", r);
    factor = (housing_base_height - wall_thickness - 2) / r;
    w_handle = housing_inner_width-print_adjust*2;
    l1 = (ruler_width + 2*wall_thickness)/2+lever_length_over_base-clamp_radius;
    
    
    rotate([90,-90,0]) {
        // elliptical clamp 
        scale([1,factor,1])
            cylinder(clamp_width, r=r, center=true);
        
        // axle of clamp 
        cylinder(clamp_width + 2*wall_thickness, d=axle_diameter, center=true);    
         
        // lever handle
        translate([l1/2, 0, 0])
            cube([l1, clamp_radius, w_handle], center=true);
        
        // rounding end of lever
        translate([l1, 0, 0]) 
            cylinder(w_handle, r=clamp_radius/2, center=true);
    }
}




module front() {
 
    w = ruler_width + 2*wall_thickness;
    translate([0,-wall_thickness,0])
    difference() {
        translate([-fence_length, 0, -wall_thickness])
            cube([w+2*fence_length, wall_thickness, fence_height+wall_thickness]);
        translate([wall_thickness-cutout_adjust/2, 0, tunnel_elevation])
            cube([ruler_width+cutout_adjust, wall_thickness, ruler_thickness+cutout_adjust]);
    }
    
}



module trapezoid(x, y1, y2, z) {
    //echo("y1:", y1);
    //echo("y2:", y2);
    d = (y1-y2)/2;
    linear_extrude(z)
        polygon(points=[[2,0], [2,y1], [0,d+y2], [0,d]], paths=[[0,1,2,3,0]]);
    
}
