// Kyle Johnson (with Laurie Gellatly)
// Holder for multiple rings of pencils and a carrying handle

/* [Fancy Pencil Holder] */

// How many pencils on the outer ring
number_of_pencils_on_outer_ring = 36;   // [24:64]
// Starting slope angle of the outer ring of pencils
pencil_slope_angle = 30;	// [20:40]	
// Number of pencil rings
rings = 2; // [1:5]
// Include a carrying handle?
include_handle = "yes"; // [yes: Yes, no: No]
// Show what the pencils will look like (for debug only, do not generate with this turned on)
show_pencils = "no"; // [yes: Show Pencils (DEBUG ONLY), no: Hide Pencils]

/* [Hidden] */
pencil_dia = 8.1;   // point to point
pencil_rad = pencil_dia/2;
slope_in = 5-pencil_slope_angle;
inner_angle_mod = 0.15;

base_rad = pencil_dia + (number_of_pencils_on_outer_ring * (3+pencil_dia))/6.282;
holder_height = 1.5+2*pencil_dia;
top_inner_radius = base_rad - pencil_dia - (pencil_dia + (pencil_dia*(rings-1)))  - ((rings-1)*pencil_rad) + (rings-1);
bottom_inner_radius = base_rad - (pencil_dia + (pencil_dia*(rings-1))) - ((rings-1)*pencil_rad) - (rings-1);

full_pencil = 160;

module pencil (length, has_point) {
    union() {
        cylinder(r=pencil_rad, h=length, $fn = 24);
        if(has_point){
            translate([0,0,length-0.1]) cylinder(r1=pencil_rad, r2=0, h=15, $fn = 24);
        }    
    }
}

module pencil_rings (pencil_length, has_point) {
    for(row = [0:(rings-1)]){ 
            n_pencils = round(((base_rad - (pencil_dia-(row))) * 6.282)/(3.0+pencil_dia) - (pencil_dia*row));
            echo("Row",row+1," Pencils:", n_pencils);
            for(ang=[0:360/n_pencils:360]){
                rotate([0,0,ang]) translate ([base_rad - (pencil_rad+(pencil_dia*row)+(pencil_rad*row)), 0, 4.5]) rotate([pencil_slope_angle-(pencil_slope_angle*inner_angle_mod*row),(5-pencil_slope_angle)+(pencil_slope_angle*inner_angle_mod*row),0]) pencil(pencil_length, has_point);
            }
    }   
}

module handle() {
    union(){
        difference() {
            union() {
                translate([-bottom_inner_radius, -(pencil_rad/2), 0]) cube(size = [2*bottom_inner_radius, pencil_rad, holder_height]);
                translate([-(pencil_rad/2),-bottom_inner_radius, 0]) cube(size = [pencil_rad, 2*bottom_inner_radius, holder_height]);
            }
            translate([0,0,-.1]) difference() {
                cylinder(r1=base_rad+4, r2 = base_rad - 3, h=holder_height+.2 ,$fn = 2*number_of_pencils_on_outer_ring);
                translate([0,0,-.1]) cylinder(r2 = top_inner_radius+.1, r1 = bottom_inner_radius+.1, h=holder_height+.4,$fn = 2*number_of_pencils_on_outer_ring);
            }
        }
        cylinder(r1=pencil_dia, r2 = pencil_rad, h = full_pencil/2, $fn = number_of_pencils_on_outer_ring);
        translate([0,0,full_pencil/2-.1]) union() {
            cylinder(r2=pencil_dia+pencil_rad, r1 = pencil_rad, h = 30, $fn = number_of_pencils_on_outer_ring);
        }
    }
}

union(){    
    difference(){
        // Outside Cylinder
        cylinder(r1=base_rad+4, r2 = base_rad - 3, h=holder_height ,$fn = 2*number_of_pencils_on_outer_ring);
        translate([0,0,-.1]) cylinder(r2 = top_inner_radius, r1 = bottom_inner_radius, h=holder_height+.2,$fn = 2*number_of_pencils_on_outer_ring);
        pencil_rings(4*pencil_dia, false);
    }
    if(include_handle == "yes"){
        handle();
    }
}
if(show_pencils == "yes"){
    pencil_rings(full_pencil, true);
}


