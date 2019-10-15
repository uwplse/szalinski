//--------------------------------------------
// Sanding Disk Pegboard Organizer
// forked from https://www.thingiverse.com/thing:607640/ by DarkroomDave
// Updated by Nicodemus Paradiso (nicodemus26)
//
// Pick Sizes for each compartment bottom to top
// Rough
//compartments = ["320", "220", "180", "120", "80", "40"];
// Fine
compartments = ["2000", "1500", "1200", "1000", "800", "600"];
// Number of compartments
compartment_count=len(compartments); 
// Disk size in inches (tested 5)
disk_diam=5; // In Inches
// Usable height in each compartment in inches
cavity_height=1;

//--------------------------------------------

mm_per_in=25.4;

// Wall thickness for all walls, backplate, hang tab
wall=1.2;

// total height of each compartment.
compartment_height=cavity_height*mm_per_in+(wall*2);

// How wide the object is. 1/4in of tolerance to make insertion and removal easier.
backplate_width=((disk_diam+.25)*mm_per_in)+(wall*2);

// Hang tab options, peg holes are auto-centered
hang_tab_height=18;
peg_hole_radius=3.3;
peg_hole_distance=2*mm_per_in;

// Radius of the hollow center, bigger saves plastic but less strong.
pullout_radius=1.25*mm_per_in;

// How far to extrude floating text, recommend two print layers.
lable_extrude=.4;

module make_peg_holes(cp_h) {
    holeable_space=backplate_width-(wall*2)-(peg_hole_radius*2);
    holes=round(holeable_space/peg_hole_distance-.5);
    side_gap=(holeable_space-(holes*peg_hole_distance))/2+wall+peg_hole_radius;
    echo(holeable_space);
    echo(holes);
    echo(side_gap);
    
    for ( i = [0 : holes] ) {
        translate([side_gap+i*peg_hole_distance,(cp_h+hang_tab_height)-(peg_hole_radius*2),0])
		cylinder(h = wall+.2, r=peg_hole_radius,$fn=20);
    }
}

module make_back_wall(cp_h) {
	cube([backplate_width,cp_h+hang_tab_height,wall]);
}

module make_compartment(cpn) {
	translate([0,cpn*(compartment_height-wall),0]) {
        difference() {
            cube([backplate_width,compartment_height,disk_diam*mm_per_in]);
            translate([wall,wall,wall]) {
                cube([backplate_width-(wall*2),compartment_height-(wall*2),(disk_diam*mm_per_in)]);
            }
        
    
            translate([(backplate_width)/2,0,disk_diam*mm_per_in]) {
                rotate([270,0,0]) {
                    hull() {
                        cylinder(h = compartment_height+.1, r=pullout_radius,$fn=56);
                        translate([0,backplate_width-pullout_radius*1.5,0])
                        cylinder(h = compartment_height+.1, r=pullout_radius,$fn=56);
                    }
                }
            }
        }
	}
}

module do_label(compartment_index,shift,side) {
    align = (side > 0) ? "right" : "left";
    ts=compartment_height/2;
    //translate([shift,0,disk_diam*mm_per_in-wall])
    //rotate([0,-90*side,0])
    //translate([0,compartment_index*(compartment_height-wall),0])    
    //linear_extrude(height = lable_extrude, center = false, convexity = 0, twist = 0) 
    //translate([0, compartment_height/4]) 
    //text(compartments[compartment_index], font = "Liberation Sans",halign=align,size = ts);
}

// ---------------
// Modules used below
// ---------------

// Backplate and hang tab
difference() {
    hull() {
        make_back_wall(compartment_count*(compartment_height-wall));   
    }
        make_peg_holes(compartment_count*(compartment_height-wall));
}

// Compartments
union() {
    
    for ( i = [0 : compartment_count-1] ) {
        make_compartment(i);
    }
}

// Labels
union() {
    for ( i = [0 : compartment_count-1] ) {
        // Left label
        do_label(i,0,1);
        translate([lable_extrude/2, 0, -lable_extrude/2])
        do_label(i,0,1);
        
        // Right label
        do_label(i,backplate_width,-1);
        translate([-lable_extrude/2, 0, -lable_extrude/2])
        do_label(i,backplate_width,-1);
    }    
}
