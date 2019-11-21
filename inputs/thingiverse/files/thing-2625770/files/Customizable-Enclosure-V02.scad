// Original design https://www.thingiverse.com/thing:155001 by ffleurey
// 
// This remix comes with the following enhancements:
// - rails for PCB
// - rectangular and round holes
//
// Remix by Frederic RIBLE F1OAT / 2017/11/04

enclosure_inner_length = 60.25+0.5;
enclosure_inner_width = 40;
enclosure_inner_depth = 97+0.5;

enclosure_thickness = 2;

cover_thickness = 3;

pcb_position = 10;
pcb_thickness = 1.65+0.4;
rail_thickness = 2;

top_drills = [ [52, 8.7, 3.5], [52, 15.3, 3.5] ];
top_rects = [ [17.7, 9, 13, 5.5, 2], [17.7+19.14, 9, 13, 5.5, 2] ];

bottom_drills = [  ];
bottom_rects = [ [24.2, 6.95, 32, 13.6, 2], [49.4, 7.39, 13.2, 11.75, 2] ];

build_plate_space = 20;

part = "build"; // [enclosure:Enclosure, cover:Cover, both:Enclosure and Cover, build:Build Plate]

print_part();

module print_part() {
	if (part == "enclosure") {
		box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
	} else if (part == "cover") {
		lid2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2+0.10,cover_thickness);
	} else if (part == "build") {
        offset = -enclosure_inner_width-enclosure_thickness-build_plate_space;
		translate([0, -offset/2, 0])
            box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
		translate([0, offset/2, -enclosure_inner_depth-enclosure_thickness])
            lid2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2+0.10,cover_thickness);
	} else {
		both();
	}
}

module both() {

    box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
    lid2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2+0.10,cover_thickness);

}

module screws(in_x, in_y, in_z, shell) {

	sx = in_x/2 - 4;
	sy = in_y/2 - 4;
	sh = shell + in_z - 12;
	nh = shell + in_z - 4;

    translate([0,0,0]) {
        translate([sx , sy, sh]) cylinder(r=1.5, h = 16, $fn=32);
        translate([sx , -sy, sh ]) cylinder(r=1.5, h = 16, $fn=32);
        translate([-sx , sy, sh ]) cylinder(r=1.5, h = 16, $fn=32);
        translate([-sx , -sy, sh ]) cylinder(r=1.5, h = 16, $fn=32);


        translate([-sx , -sy, nh ]) rotate([0,0,-45]) 
            translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
        translate([sx , -sy, nh ]) rotate([0,0,45]) 
            translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
        translate([sx , sy, nh ]) rotate([0,0,90+45]) 
            translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
        translate([-sx , sy, nh ]) rotate([0,0,-90-45]) 
            translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
    }
}

module bottom(in_x, in_y, in_z, shell) {

	hull() {
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
	}
}

module sides(in_x, in_y, in_z, shell) {
    translate([0,0,shell])
    difference() {

        hull() {
            translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
            translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
            translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
            translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
        }

        hull() {
            translate([-in_x/2+shell, -in_y/2+shell, -0.5]) cylinder(r=shell,h=in_z+1, $fn=32);
            translate([+in_x/2-shell, -in_y/2+shell, -0.5]) cylinder(r=shell,h=in_z+1, $fn=32);
            translate([+in_x/2-shell, in_y/2-shell, -0.5]) cylinder(r=shell,h=in_z+1, $fn=32);
            translate([-in_x/2+shell, in_y/2-shell, -0.5]) cylinder(r=shell,h=in_z+1, $fn=32);
        }
    }

    intersection() {
        translate([-in_x/2, -in_y/2, shell]) cube([in_x, in_y, in_z+2]);

        union() {
            translate([-in_x/2 , -in_y/2,shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
            translate([-in_x/2 , -in_y/2,shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);

            translate([in_x/2 , -in_y/2, shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
            translate([in_x/2 , -in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);

            translate([in_x/2 , in_y/2,  shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
            translate([in_x/2 , in_y/2,  shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);

            translate([-in_x/2 , in_y/2, shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
            translate([-in_x/2 , in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);
        }

    }
}

module lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness) {

	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);

	translate([0,0,shell+in_z])

    difference() {

        hull() {
            translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
            translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
            translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
            translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
        }

        
        translate([0, 0, -1]) linear_extrude(height = top_thickness + 2) polygon(points = [
            [cxm+5, cym],
            [cxm, cym+5],
            [cxm, cyp-5],
            [cxm+5, cyp],
            [cxp-5, cyp],
            [cxp, cyp-5],
            [cxp, cym+5],
            [cxp-5, cym]]);
    }
}

module lid2(in_x, in_y, in_z, shell, top_lip, top_thickness) {

	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);	

    difference() {
        translate([0, 0, in_z+shell]) linear_extrude(height = top_thickness ) polygon(points = [
            [cxm+5, cym],
            [cxm, cym+5],
            [cxm, cyp-5],
            [cxm+5, cyp],
            [cxp-5, cyp],
            [cxp, cyp-5],
            [cxp, cym+5],
            [cxp-5, cym]]);
            

            screws(in_x, in_y, in_z, shell);
            translate([0, 0, in_z+shell-1]) holes(in_x, in_y, top_drills, top_rects);
        
    }
}

module box2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
	difference() {
        bottom(in_x, in_y, in_z, shell);
        holes(in_x, in_y, bottom_drills, bottom_rects);
    }
	difference() {
		sides(in_x, in_y, in_z, shell);
		screws(in_x, in_y, in_z, shell);
	}
	lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness);
    rail(in_x, in_y, in_z, shell);
    mirror([1,0,0]) rail(in_x, in_y, in_z, shell);
}

module rail(in_x, in_y, in_z, shell) {
    translate([-in_x/2, -in_y/2+pcb_position-rail_thickness, shell]) cube([rail_thickness, rail_thickness, in_z]);
    translate([-in_x/2, -in_y/2+pcb_position+pcb_thickness, shell]) cube([rail_thickness, rail_thickness, in_z]);
}

module CylinderHole(Cx, Cy, Cdia) {
    translate([Cx,Cy,-1]) cylinder(d=Cdia,10, $fn=50);
}

module SquareHole(Sx, Sy, Sw, Sh, Filet) {
    minkowski(){
        translate([Sx+Filet/2-Sw/2,Sy+Filet/2-Sh/2,-1]) cube([Sw-Filet,Sh-Filet,10]);
        cylinder(d=Filet,h=10, $fn=100);
    }
}

module holes(in_x, in_y, drills, rects) {
    translate([-in_x/2, -in_y/2+pcb_position]) {
        for (d=drills) CylinderHole(d[0], d[1], d[2]);
        for (r=rects) SquareHole(r[0], r[1], r[2], r[3], r[4], r[5]);
    }
}
