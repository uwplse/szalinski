/* [Global] */
style = 2; // [1:PCB Holder, 2:PCB Standoff]
//length of the PCB or holes distance
pcb_X = 85;
//width of the PCB or holes distance (width cannot be greater than length)
pcb_Y = 54;
base_width = 8;
base_height = 2;

/* [Holder] */
//distance between PCB and base
pcb_clearance = 2;
//pcb groove height
pcb_thickness = 1.8;

/* [Standoff] */
//select the shape of the 4 edges
stand_shape = 1; // [1:Round, 2:Square, 3:Hex]
//select the mounting style
stand_style = 1; //[1:Male, 2:Female]
//height of 4 edges
stand_extend = 10;
//diameter of hole PCB hole
hole_diameter = 3;
//height of hole(female) or mount cylinders(male)
hole_height = 12;

/* [Hidden] */
cyl_top = 2;
debug = 0;
$fn = 100;

//caclulations
pcb_center_X = pcb_X/2;
pcb_center_Y = pcb_Y/2;
arc_R = (pow(pcb_center_X,2) + pow(pcb_center_Y,2)) / (2*pcb_center_Y) + base_width/2;
arc_center_x = pcb_center_X;
arc_center_y = - (arc_R - pcb_center_Y) + base_width/2;
poly_edge_dist = (pcb_center_X * pcb_center_Y) / (arc_R-base_width/2 - pcb_center_Y);
cyl_D = base_width ;
cyl_height = base_height + pcb_clearance + pcb_thickness + cyl_top;
stands_height = stand_extend + base_height;
cube_w = sqrt(pow(base_width,2)/2);


if (style == 1){
	base();
}
else{
	if (stand_style == 1){ //male stand
		union(){
			base();
			translate([0,0,stands_height]) cylinder (d=hole_diameter, h=hole_height);
			translate([pcb_X,0,stands_height]) cylinder (d=hole_diameter, h=hole_height);
			translate([pcb_X,pcb_Y,stands_height]) cylinder (d=hole_diameter, h=hole_height);
			translate([0,pcb_Y,stands_height]) cylinder (d=hole_diameter, h=hole_height);
		}
	}
	else{ //female stand
		difference(){
			base();
			translate([0,0,stands_height-hole_height]) cylinder (d=hole_diameter, h=hole_height);
			translate([pcb_X,0,stands_height-hole_height]) cylinder (d=hole_diameter, h=hole_height);
			translate([pcb_X,pcb_Y,stands_height-hole_height]) cylinder (d=hole_diameter, h=hole_height);
			translate([0,pcb_Y,stands_height-hole_height]) cylinder (d=hole_diameter, h=hole_height);
		}
	}
}

module base(){
	if (!(pcb_X < pcb_Y)){
		intersection(){
			union(){
				arc();
				translate([0, 2*arc_R-base_width, 0]) arc();
			}
			if (pcb_X!=pcb_Y){
				linear_extrude(height = base_height) polygon([[0,0],[arc_center_x,arc_center_y],[pcb_X,0],[pcb_X+poly_edge_dist,pcb_center_Y],[arc_center_x,arc_R+pcb_center_Y-base_width/2],[0,pcb_Y],[-poly_edge_dist,pcb_center_Y]]);
			}
			else{
				translate([-base_width/2, 0, 0]) cube([pcb_X+base_width,pcb_Y,base_height]);
			}
		}
	}
	if (style == 1){ //pcb holder
		difference(){
			holders();
			translate([0,0,base_height+pcb_clearance]) cube([pcb_X, pcb_Y, pcb_thickness]);
			translate([0,0,base_height+pcb_clearance]) linear_extrude(height = pcb_thickness+cyl_top+1) polygon([[0,cyl_D/2],[cyl_D/2,cyl_D/2],[cyl_D/2,0]]);
			translate([pcb_X,0,base_height+pcb_clearance]) rotate([0,0, 90]) linear_extrude(height = pcb_thickness+cyl_top+1) polygon([[0,cyl_D/2],[cyl_D/2,cyl_D/2],[cyl_D/2,0]]);
			translate([pcb_X,pcb_Y,base_height+pcb_clearance]) rotate([0,0, 180]) linear_extrude(height = pcb_thickness+cyl_top+1) polygon([[0,cyl_D/2],[cyl_D/2,cyl_D/2],[cyl_D/2,0]]);
			translate([0,pcb_Y,base_height+pcb_clearance]) rotate([0,0, 270]) linear_extrude(height = pcb_thickness+cyl_top+1) polygon([[0,cyl_D/2],[cyl_D/2,cyl_D/2],[cyl_D/2,0]]);
		}
	}
	else{ //pcb stand
		stands();
	}
}

module arc () {
	difference(){
		translate([arc_center_x, arc_center_y, 0]) cylinder (r=arc_R, h=base_height);
		translate([arc_center_x, arc_center_y, -1]) cylinder (r=arc_R - base_width, h=base_height+2);
	}
}

module holders(){
	union(){
			cylinder (d=cyl_D, h=cyl_height);
			translate([0, pcb_Y, 0]) cylinder (d=cyl_D, h=cyl_height);
			translate([pcb_X, pcb_Y, 0]) cylinder (d=cyl_D, h=cyl_height);
			translate([pcb_X, 0, 0]) cylinder (d=cyl_D, h=cyl_height);
		}
}

module stands(){
	if (stand_shape == 1){ //round tops
		cylinder (d=cyl_D, h=stands_height);
		translate([0, pcb_Y, 0]) cylinder (d=cyl_D, h=stands_height);
		translate([pcb_X, pcb_Y, 0]) cylinder (d=cyl_D, h=stands_height);
		translate([pcb_X, 0, 0]) cylinder (d=cyl_D, h=stands_height);
	}
	else if (stand_shape == 2){ //square tops
		translate([0, 0, stand_extend/2+base_height/2]) rotate([0,0,45+atan(arc_center_y/arc_center_x)]) cube([cube_w,cube_w,stands_height], true);
		translate([0, pcb_Y, stand_extend/2+base_height/2]) rotate([0,0,45+atan(arc_center_x/arc_center_y)]) cube([cube_w,cube_w,stands_height], true);
		translate([pcb_X, pcb_Y, stand_extend/2+base_height/2]) rotate([0,0,45+atan(arc_center_y/arc_center_x)]) cube([cube_w,cube_w,stands_height], true);
		translate([pcb_X, 0, stand_extend/2+base_height/2]) rotate([0,0,45+atan(arc_center_x/arc_center_y)]) cube([cube_w,cube_w,stands_height], true);
	}
	else{ //hex tops
		rotate([0,0,atan(arc_center_y/arc_center_x)]) cylinder (d=cyl_D, h=stands_height, $fn = 6);
		translate([0, pcb_Y, 0]) rotate([0,0,90+atan(arc_center_x/arc_center_y)]) cylinder (d=cyl_D, h=stands_height, $fn = 6);
		translate([pcb_X, pcb_Y, 0]) rotate([0,0,atan(arc_center_y/arc_center_x)]) cylinder (d=cyl_D, h=stands_height, $fn = 6);
		translate([pcb_X, 0, 0]) rotate([0,0,90+atan(arc_center_x/arc_center_y)]) cylinder (d=cyl_D, h=stands_height, $fn = 6);
	}
}

if (debug){
	#translate([arc_center_x, arc_center_y, 0]) cylinder (d=5, h=10);
	#translate([arc_center_x, arc_R+pcb_center_Y-base_width/2, 0]) cylinder (d=5, h=10);
}
