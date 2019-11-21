

//variable description
/* [Box] */
part = "Both"; // [Box:Box Only,Lid:Lid Only,Both:Box and Lid]
//Total height of the box when closed
height=100;
diameter=25.5;
//wall, bottom and top thickness
wall_thickness=3;

/* [Locking] */
//The size of the locking part (does not count for total height)
locking_height=5;
//This the difference in the path's width for impeding the box to be easily open.
path_relief=0.3;

/* [Calibration] */
//The bigger, the round the box will be
$fn=64;
//This is the absolute error for fitting parts in your printer
error=0.1;





print_part();
// preview[view:south, tilt:top diagonal]

module print_part() {
	if (part == "Box") {
		box();
	} else if (part == "Lid") {
		lid();
	} else if (part == "Both") {
		both();
	} else {
		both();
	}
}

module box(){
    difference(){
        //body of cylinder
        union(){
            cylinder(h = (height-locking_height)/2, r = diameter/2);
            cylinder(h = (height+locking_height)/2, r = (diameter-wall_thickness)/2-error);
        }
        translate([0,0,wall_thickness])cylinder(h = height/2+locking_height, r = diameter/2-wall_thickness);
        //first path and holes
        translate([0,diameter/2-wall_thickness/2,(height-locking_height+wall_thickness*0.8)/2+error]){
            sphere(r = wall_thickness/2*0.8+error);
            cylinder(h=locking_height,r = (wall_thickness*0.8+error-path_relief)/2);
        }
        translate([0,-diameter/2+wall_thickness/2,(height-locking_height+wall_thickness)/2+error]){
            sphere(r = wall_thickness/2*0.8+error);
            cylinder(h=locking_height,r = (wall_thickness*0.8+error-path_relief)/2);
        }
        
        //lateral paths
        translate([0,0,(height-locking_height+wall_thickness*0.8)/2+error]){
        rotate_extrude(angle = 90, convexity = 2) translate([diameter/2-wall_thickness/2,0,0])
        circle(r = wall_thickness/2*0.8+error-path_relief);
        rotate_extrude(angle = 90, convexity = 2) translate([-diameter/2+wall_thickness/2,0,0])
        circle(r = wall_thickness/2*0.8+error-path_relief);
        }
        
        //final holes
        translate([diameter/2-wall_thickness/2,0,(height-locking_height+wall_thickness*0.8)/2+error]){
            sphere(r = wall_thickness/2*0.8+error);
        }
        translate([-diameter/2+wall_thickness/2,0,(height-locking_height+wall_thickness)/2+error]){
            sphere(r = wall_thickness/2*0.8+error);
        }
        
    }

}

module lid(){
    //body of cylinder
    difference(){
        cylinder(h = (height-locking_height)/2, r = diameter/2);
        translate([0,0,wall_thickness])cylinder(h = height/2+locking_height, r = diameter/2-wall_thickness);
    }
    difference(){
        cylinder(h = (height+locking_height)/2, r = diameter/2);
        translate([0,0,wall_thickness]) cylinder(h = height/2+locking_height, r = (diameter-wall_thickness)/2+error);
    }
    //lumps to fit in box
    translate([0,diameter/2-wall_thickness/2,(height+locking_height-wall_thickness)/2-0.5])sphere(r = wall_thickness/2*0.8);
    translate([0,-diameter/2+wall_thickness/2,(height+locking_height-wall_thickness)/2-0.5])sphere(r = wall_thickness/2*0.8);
}

module both(){
    box();
    translate([diameter+wall_thickness,0,0])lid();
}