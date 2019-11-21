//use <tyler.scad>;

/**
 * Linkos: by Tyler Bletsch (Tyler.Bletsch@gmail.com)
 */
 
// preview[view:south west, tilt:top diagonal]

$fn=16*1;

E=0.05*1;
inch = 25.4*1;

/* [Global] */

// Type of link to show: LINK mates to another link, PLATE_HORIZONTAL and PLATE_VERTICAL are used to mount to whatever object you're messing with. 
part = "LINK"; // [LINK, PLATE_HORIZONTAL, PLATE_VERTICAL]

/* [General] */

// Length of the link, excluding the mounting stuff at the ends (mm)
link_len = 40;

// Diameter of the hole used in linkages (mm). I like to use 1/4-20 bolts, so I set this to 0.25" with a 10% margin, or about 7mm.
link_hole_dia = 7; 
/// (0.25*inch*1.10)

// Thickness of the link (mm). For a nice look, make this bolt_length-nut_thickness. For example, you can use 3/4" bolts with 1/4"-thick nuts by setting this to 1/2" (12.7mm). This variable is forced to be at least 50% greater than link_hole_dia for strength.
thickness_ = 12.7;
thickness = max(link_hole_dia*1.5,thickness_);

// Extra margin on the side of the link to allow for clean swiveling (mm).
tab_extra = 2;

// How much to loosen the fit of the links (%).
layer_tolerance_percent = 5; // [0:25]

layer = thickness/3 * (1 - layer_tolerance_percent/100);

/* [Horizontal plate] */

// Diameter for mounting holes on the horizontal plate (mm). 4.4mm works for #8 screws.
hplate_hole_dia = 4.4;

// Number of holes in the X direction
hplate_num_holes_x = 2; // [1:4]

// Number of holes in the Y direction
hplate_num_holes_y = 2; // [1:4]

// Thickness of the horizontal plate (mm)
hplate_thickness = 2;

// Rounding radius of the plate corners (mm)
hplate_corner_radius = 2;

// Optional: you can boost the plate width irrespective of the holes here (mm)
hplate_extra_width = 0; 

// Optional: you can boost the plate height irrespective of the holes here (mm)
hplate_extra_height = 0;

hplate_width = 3*hplate_hole_dia*hplate_num_holes_x + hplate_extra_width;
hplate_height= 3*hplate_hole_dia*hplate_num_holes_y + hplate_extra_height;


/* [Vertical plate] */

// Diameter for mounting holes on the vertical plate (mm). 4.4mm works for #8 screws.
vplate_hole_dia = 4.4;

// Number of holes in the Y direction
vplate_num_holes_y = 1; // [1:4]

// Number of holes in the Z direction
vplate_num_holes_z = 3; // [1:4]

// Thickness of the plate (mm)
vplate_thickness = 3;

// Optional: you can boost the plate width irrespective of the holes here (mm)
vplate_extra_width = 0;

// Optional: you can boost the plate height irrespective of the holes here (mm)
vplate_extra_height = 0;

vplate_width =(3*vplate_num_holes_y)*vplate_hole_dia+vplate_extra_width;
vplate_height=(3*vplate_num_holes_z)*vplate_hole_dia+vplate_extra_height;

// hull each child in a row, one after another -- makes a "snake" of the given forms
module hull_chain() {
    for (i = [1:$children-1]) {
        hull() children([i-1:i]);
    }
}

left_center_x  = 0*0;
left_tab_start_x = left_center_x+thickness/2+tab_extra;
right_center_x = thickness/2+tab_extra+link_len+tab_extra+thickness/2;
right_tab_start_x = right_center_x-thickness/2-tab_extra;

difference() {
    if (part=="LINK") {
        hull_chain() {
            translate([left_center_x,0,thickness/2]) rotate([90]) cylinder(d=thickness, h=thickness, center=true);
            translate([left_tab_start_x,0]) cube2([E,thickness,thickness],aligns="RCL");
            translate([right_tab_start_x,0]) cube2([E,thickness,layer],aligns="RCL");
            translate([right_center_x,0]) cylinder(d=thickness, h=layer, center=false);
        }
    } else if (part=="PLATE_HORIZONTAL") {
        hull_chain() {
            translate([left_center_x,0,thickness/2]) rotate([90]) cylinder(d=thickness, h=thickness, center=true);
            translate([left_tab_start_x,0]) cube2([E,thickness,thickness],aligns="RCL");
            translate([right_tab_start_x,0]) cube2([E,hplate_height,hplate_thickness],aligns="RCL");
            translate([right_tab_start_x,0]) cube2([hplate_width,hplate_height,hplate_thickness],xy_radius=hplate_corner_radius, aligns="LCL");
        }
    } else if (part=="PLATE_VERTICAL") {
        hull_chain() {
            translate([left_center_x,0,thickness/2]) rotate([90]) cylinder(d=thickness, h=thickness, center=true);
            translate([left_tab_start_x,0]) cube2([E,thickness,thickness],aligns="RCL");
            translate([right_tab_start_x,0]) cube2([E,vplate_width,thickness],aligns="RCL");
        }
        translate([right_tab_start_x,0]) cube2([vplate_thickness,vplate_width,thickness+vplate_height],aligns="LCL");
    }

    // left hole
    translate([0,0,thickness/2]) rotate([90]) cylinder(d=link_hole_dia,h=thickness+E,center=true); 
    
    // left cutout (to make two tabs)
    translate([0,0,-E]) cube2([2*(thickness/2+tab_extra),thickness-2*layer,thickness+2*E],aligns="CCL");

    // right hole
    if (part=="LINK") {
        translate([right_center_x,0]) cylinder(d=link_hole_dia, h=thickness+E, center=true);
    } else if (part=="PLATE_HORIZONTAL") {
        if (hplate_hole_dia && hplate_num_holes_x && hplate_num_holes_y) {
            translate([right_tab_start_x,0,-E]) {
                for (i = [0:hplate_num_holes_x-1]) for (j = [0:hplate_num_holes_y-1]) {
                    x = hplate_hole_dia*(1.5+3*i);
                    y = hplate_hole_dia*(1.5+3*(j-hplate_num_holes_y/2));
                    translate([x,y,0]) cylinder(d=hplate_hole_dia,h=hplate_thickness+2*E);
                }
            }
        }
    } else if (part=="PLATE_VERTICAL") {
        if (vplate_hole_dia && vplate_num_holes_y && vplate_num_holes_z) {
            translate([right_tab_start_x-E,0]) {
                for (i = [0:vplate_num_holes_y-1]) for (j = [0:vplate_num_holes_z-1]) {
                    echo(i,j);
                    y = vplate_hole_dia*(1.5+3*(i-vplate_num_holes_y/2));
                    z = vplate_hole_dia*(1.5+3*j) + thickness;
                    translate([0,y,z]) rotate([0,90]) cylinder(d=vplate_hole_dia,h=vplate_width+2*E);
                }
            }
        }
    }
    
}


module cube2(size,aligns="LLL",radius=0,xy_radius=0) {
    real_size = len(size) ? size : [size,size,size];
    tr = [
        aligns[0]=="C" ? 0 : aligns[0]=="R" ? (-real_size[0]/2) : (+real_size[0]/2),
        aligns[1]=="C" ? 0 : aligns[1]=="R" ? (-real_size[1]/2) : (+real_size[1]/2),
        aligns[2]=="C" ? 0 : aligns[2]=="R" ? (-real_size[2]/2) : (+real_size[2]/2)
    ];
    translate(tr) {
        if (xy_radius>0) {
            inner_size = [for (v=real_size) v-min(xy_radius*2,v)];
            linear_extrude(real_size[2], center=true) offset(r=xy_radius) square([inner_size[0],inner_size[1]], center=true);
        } else if (radius>0) {
            if (radius*2 >= max(real_size)) {
                resize(real_size) sphere(1);
            } else {
                inner_size = [for (v=real_size) v-min(radius*2,v)];
                minkowski() {
                    cube(inner_size,center=true);
                    sphere(r=radius);
                }
            }
        } else {
            cube(real_size,center=true);
        }
    } 
}

