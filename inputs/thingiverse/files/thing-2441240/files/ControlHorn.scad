// preview[view:south west, tilt:top diagonal]

$fs = 0.01;


///// USER PARAMETERS /////



// Which one would you like to see?
part = "both"; // [horn:Horn Only, base:Bottom Base Only, both:Horn and Bottom Base]



/* [Horn] */

horn_height = 25; //measured from top of base vertically to top of horn
horn_width = 25;
horn_thickness = 1.5;
// this is the part under the triangular part that joins to the base
horn_elevate_tab_height = 3;
// rounding on front top and back of horn
horn_corner_radius = 3;



/* [Pushrod Holes] */

holes_count = 5;
holes_diameter = 1.5;
holes_radius = holes_diameter/2;
// space between top of horn and top hole
holes_top_offset = 1.5;
// space between bottom of horn and bottom hole
holes_bottom_offset = 1.5;
// space between back of horn and holes
holes_back_offset = 2;



/* [Base] */
base_attached = "yes"; //[yes,no]
base_thickness = 1.5;
base_hole_diameter = 2;
// offset from sides of base to place screw holes
base_hole_offset = 1;
base_hole_radius = base_hole_diameter/2;
base_width = 10;
base_length = 15;
base_corner_radius = 1;
// creates a fillet between the base and the horn
base_fillet_on = "yes"; //[yes,no]
base_fillet_radius = 1;
// for detached base only - offset from side of base to start/end slot for perpendicular horn
base_tab_offset = 2;
// for detached base only - extra space to cut in slot to give tolerance 
base_tab_extra_space = 0.01;



/* [Bottom Base] */
// This is where the screws will be drilled into
bottom_base_hole_diameter = 1;
bottom_base_hole_radius = bottom_base_hole_diameter/2;



holes_spacing = (horn_height - holes_top_offset - holes_bottom_offset - horn_elevate_tab_height - 2*holes_radius) / (holes_count-1);



//////////////////////////////
//////     MODULES       /////
//////////////////////////////


module horn(){
    translate([0,0,-horn_thickness/2])
    hull(){
        intersection(){
            translate([0,horn_elevate_tab_height,0])
                cube([horn_width,horn_height ,horn_thickness]);
            translate([horn_corner_radius,horn_elevate_tab_height,0])
                cylinder(r=horn_corner_radius, h=horn_thickness);
        }
        translate([horn_width-horn_corner_radius,horn_corner_radius+horn_elevate_tab_height,0])
            cylinder(r=horn_corner_radius, h=horn_thickness);
        translate([horn_width-horn_corner_radius,horn_height-horn_corner_radius,0])
            cylinder(r=horn_corner_radius, h=horn_thickness);
    }
}



module horn_holes(){
    for(i=[0:1:holes_count-1]){
        x = horn_width-holes_radius-holes_back_offset;
        y = horn_height-holes_radius-holes_top_offset - holes_spacing*i;
        echo(y);
        translate([x,y,-horn_thickness/2-1])
            cylinder(r=holes_radius, h=horn_thickness+2);
    }
}


module elevate_tab(){
    difference(){
        translate([0,-horn_thickness/2,-base_thickness])
            cube([base_length,horn_thickness,horn_elevate_tab_height+base_thickness]);
        if(base_attached=="no"){
            translate([-1,-horn_thickness/2-1,-base_thickness-1])
                cube([base_tab_offset+1,horn_thickness+2,base_thickness+1]);
            translate([base_length-base_tab_offset,-horn_thickness/2-1,-base_thickness-1])
                cube([base_tab_offset+1,horn_thickness+2,base_thickness+1]);
        }
    }
    
}


module screw_base(cut_through_ok=true){
    //translate([0,-base_width/2,-base_thickness])
    //cube([base_length,base_width,base_thickness]);
    difference(){
        translate([base_corner_radius,-base_width/2,-base_thickness])
            hull(){
                translate([0,0,0])
                    cylinder(r=base_corner_radius, h=base_thickness);
                translate([0,base_width,0])
                    cylinder(r=base_corner_radius, h=base_thickness);
                translate([base_length-2*base_corner_radius,0,0])
                    cylinder(r=base_corner_radius, h=base_thickness);
                translate([base_length-2*base_corner_radius,base_width,0])
                    cylinder(r=base_corner_radius, h=base_thickness);
            }
        if(base_attached=="no" && cut_through_ok){
            translate([ base_tab_offset+base_tab_extra_space-base_tab_extra_space*2,
                        -horn_thickness/2-base_tab_extra_space,
                        -base_thickness-1 ])
                cube([  base_length-base_tab_offset*2+base_tab_extra_space*2,
                        horn_thickness+base_tab_extra_space*2,
                        base_thickness+2 ]);
        }
    }
}


module base_holes(hole_radius=base_hole_radius){
    translate([ base_hole_radius+base_hole_offset,
                -base_width/2+base_hole_offset-base_hole_radius+base_hole_radius,
                -base_thickness-1 ])
        cylinder(r=hole_radius, h=base_thickness+2);
    
    translate([ base_hole_radius+base_hole_offset,
                base_width/2-base_hole_offset+base_hole_radius-base_hole_radius,
                -base_thickness-1 ])
        cylinder(r=hole_radius, h=base_thickness+2);
    
    translate([ base_length-base_hole_radius-base_hole_offset,
                -base_width/2+base_hole_offset-base_hole_radius+base_hole_radius,
                -base_thickness-1 ])
        cylinder(r=hole_radius, h=base_thickness+2);
    
    translate([ base_length-base_hole_radius-base_hole_offset, 
                base_width/2-base_hole_offset+base_hole_radius-base_hole_radius, 
                -base_thickness-1 ])
        cylinder(r=hole_radius, h=base_thickness+2);
}


module base_fillet(){
    difference(){
        translate([0,horn_thickness/2,0])
            cube([base_length,base_fillet_radius,base_fillet_radius]);
        translate([-1,horn_thickness/2+base_fillet_radius,base_fillet_radius])
        rotate([0,90,0])
            cylinder(r=base_fillet_radius, h=base_length+2);
    }
    difference(){
        translate([0,-horn_thickness/2-base_fillet_radius,0])
            cube([base_length,base_fillet_radius,base_fillet_radius]);
        translate([-1,-horn_thickness/2-base_fillet_radius,base_fillet_radius])
        rotate([0,90,0])
            cylinder(r=base_fillet_radius, h=base_length+2);
    }
    

}


module bottom_screw_base(){
    translate([  horn_width+5,
                -base_thickness/2,
                base_width/2+base_corner_radius ])
    rotate([90,0,0])
    difference(){
        screw_base(false);
        base_holes(bottom_base_hole_radius);
    }
}

module separate_screw_base(){
    translate([ horn_width+5,
                -base_thickness/2,
                base_width/2+base_corner_radius+base_width+5 ])
    rotate([90,0,0])
    difference(){
        screw_base();
        base_holes();
    }
}




//////////////////////////////
//////    BUILD MODEL    /////
//////////////////////////////

if(part=="horn" || part=="both"){
    rotate([90,0,0])
        difference(){
            // Create horn arm
            //translate([horn_corner_radius,horn_corner_radius,-horn_thickness/2])
            horn();
            horn_holes();
        }
    elevate_tab();
        if(base_attached=="yes"){
            difference(){
                screw_base();
                base_holes();
            }
            if(base_fillet_on=="yes"){
                base_fillet();
            }
        }
        if(base_attached=="no"){
            separate_screw_base();
        }
}


if(part=="base" || part=="both"){
    bottom_screw_base();
}
