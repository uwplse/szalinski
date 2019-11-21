// Make a chess board whatever size you want with whatever size squares.
// You can also create a hollow recess for pieces to peg into.
// This is licensed under CreativeCommons|attribution|share-alike
// To fulfil the "attribution" requirement, please provide a link back to:
//		http://www.thingiverse.com/thing:689588

/* [main] */

// Select what you want to generate (NOTE: there may be different number of each color square, for example a 3x3 board has 5 of one color and 4 of the other)
goal=0; // [0:visualize the whole thing,1:border pieces,2:squares color 1,3:squares color 2]

// Lower values=tighter fit.
dovetail_fit=0.1;

/* [board] */

// Number of squares in the x direction
squares_x=8;

// Number of squares in the y direction
squares_y=8;

// Thickness of the board (in mm)
board_thickness=5;

/* [squares] */

// x,y size of each square (in mm)
square_size=36;

// how far to indent the hollow from the sides (set to 0 to turn off the recess)
hollow_margin=0;

// round over the hollow inset
hollow_radius=2.5;

/* [border] */

// How wide the border should be (in mm) (use 0 to disable border)
border_width=15;

/* [hidden] */

module rounded_recess(corner_dia=5,w=40,inset=2){
	translate([0,0,-inset]) hull(){
		translate([-(w/2-corner_dia/2),-(w/2-corner_dia/2),0]) cylinder(r=corner_dia/2,h=inset);
		translate([ (w/2-corner_dia/2),-(w/2-corner_dia/2),0]) cylinder(r=corner_dia/2,h=inset);
		translate([-(w/2-corner_dia/2), (w/2-corner_dia/2),0]) cylinder(r=corner_dia/2,h=inset);
		translate([ (w/2-corner_dia/2), (w/2-corner_dia/2),0]) cylinder(r=corner_dia/2,h=inset);
	}
}

module dovetail(w1,w2,h,thick){
	hull() rotate([90,0,0]) {
		translate([-w1/2,-thick/2,-h/2]) cube([w1,thick,0.01]);
		translate([-w2/2,-thick/2,h/2]) cube([w2,thick,0.01]);
	}
}

module board_square(){
	w=square_size;
	thick=board_thickness;
	dovetail_h=thick/2;
	dovetail_w1=(w*1/3)+dovetail_h;
	dovetail_w2=(w*1/3);
	fit_margin=dovetail_fit;
	border=hollow_margin;
	border_roundover=hollow_radius*2;
	difference(){
		translate([-w/2,-w/2,0]) cube([w,w,thick]);
		if(border>0){
			translate([0,0,thick]) rounded_recess(border_roundover,w-border*2,thick-1.5);
		}
		rotate([0,0,0]) translate([0,w/2-dovetail_h/2,thick/4]) dovetail(dovetail_w2+fit_margin,dovetail_w1+fit_margin,dovetail_h,thick/2);
		rotate([0,0,-90]) translate([0,w/2-dovetail_h/2,thick/4]) dovetail(dovetail_w2+fit_margin,dovetail_w1+fit_margin,dovetail_h,thick/2);
	}
	rotate([0,0,90]) translate([0,w/2+dovetail_h/2,thick/4]) dovetail(dovetail_w1,dovetail_w2,dovetail_h,thick/2);
	rotate([0,0,180]) translate([0,w/2+dovetail_h/2,thick/4]) dovetail(dovetail_w1,dovetail_w2,dovetail_h,thick/2);
}

module board(){
	x=squares_x;
	y=squares_y;
	gap=1.5;
	thick=board_thickness;
	spacing=square_size+board_thickness/2+gap;
	minor_spacing=border_width+board_thickness/2+gap;
	for(ix=[0:x-1]) for(iy=[0:y-1]) {
		translate([ix*spacing+spacing/2+minor_spacing,iy*spacing+spacing/2+minor_spacing,0]) board_square();
	}
	if(border_width>0){
		border(x,y);
	}
}

module profile(x,y){
	r1=1.5;
	r2=1;
	a=asin((y-r1-r2)/(x-r2));
	h=sqrt(pow((y-r1),2)+pow((x-r2),2));
	union(){
		translate([r2,0,0]) difference(){
			square([x-r2,y-r1]);
			translate([0,r2,0]) rotate([0,0,a]) square([h,y]);
		}
		translate([x-r1,y-r1,0]) circle(r=r1,$fn=24);
		translate([r2,r2,0]) circle(r=r2,$fn=24);
	}
}

// dovetail -1=inside, 0=none, 1=outside
module border_section(dovetail=0,u_dovetail=0){
	w=square_size;
	thick=board_thickness;
	dovetail_h=thick/2;
	dovetail_w1=(w*1/3)+dovetail_h;
	dovetail_w2=(w*1/3);
	fit_margin=dovetail_fit;
	border_size=border_width;
	u_dovetail_h=dovetail_h;
	u_dovetail_w1=(border_size*1/3)+u_dovetail_h;
	u_dovetail_w2=(border_size*1/3);
	u_dovetail_thick=thick/4;
	difference(){
		union() {
			translate([-border_size/2,w/2,0]) rotate([90,0,0]) linear_extrude(w) profile(border_size,thick);
			if(dovetail>0) {
				rotate([0,0,90]) translate([0,-border_size/2-dovetail_h/2,thick/4]) dovetail(dovetail_w2,dovetail_w1,dovetail_h,thick/2);
			}
			if(u_dovetail!=0) translate([0,-w/2-u_dovetail_h/2,u_dovetail_thick/2]) dovetail(u_dovetail_w2,u_dovetail_w1,u_dovetail_h,u_dovetail_thick);
		}
		if(u_dovetail!=0) translate([0,w/2-u_dovetail_h/2,u_dovetail_thick/2]) dovetail(u_dovetail_w2+fit_margin,u_dovetail_w1+fit_margin,u_dovetail_h,u_dovetail_thick);
		if(dovetail<0) rotate([0,0,90]) translate([0,-border_size/2+dovetail_h/2,thick/4]) dovetail(dovetail_w1+fit_margin,dovetail_w2+fit_margin,dovetail_h,thick/2);
	}
}

module corner(){
	thick=board_thickness;
	border_size=border_width;
	dovetail_h=thick/2;
	u_dovetail_h=dovetail_h;
	u_dovetail_w1=(border_size*1/3)+u_dovetail_h;
	u_dovetail_w2=(border_size*1/3);
	u_dovetail_thick=thick/4;
	fit_margin=dovetail_fit;
	difference(){
		union(){
			translate([border_size/2,-border_size/2,0]) difference(){
				translate([-border_size,border_size,0]) rotate([90,0,0]) linear_extrude(border_size) profile(border_size,thick);
				rotate([0,0,-45]) cube([border_size/sin(45),border_size/sin(45),border_width],center=true);
			}
			translate([border_size/2,-border_size/2,0]) intersection(){
				translate([-border_size,0,0]) rotate([0,0,90]) rotate([90,0,0]) linear_extrude(border_size) profile(border_size,thick);
				rotate([0,0,-45]) cube([border_size/sin(45),border_size/sin(45),border_width],center=true);
			}
			translate([border_size/2+u_dovetail_h/2,0,u_dovetail_thick/2]) rotate([0,0,90]) dovetail(u_dovetail_w2,u_dovetail_w1,u_dovetail_h,u_dovetail_thick);
		}
		translate([0,border_size/2-u_dovetail_h/2,u_dovetail_thick/2]) dovetail(u_dovetail_w2+fit_margin,u_dovetail_w1+fit_margin,u_dovetail_h,u_dovetail_thick);
	}
}

module border(x=5,y=5){
	thick=board_thickness;
	gap=1.5;
	spacing=square_size+board_thickness/2+gap;
	minor_spacing=border_width+board_thickness/2+gap;
	y2=spacing*y+minor_spacing*1.5;
	x2=spacing*x+minor_spacing*1.5;
	for(i=[0:y-1]) {
		translate([border_width/2,i*spacing+spacing/2+minor_spacing,0]) border_section(0,1);
		translate([x2,i*spacing+spacing/2+minor_spacing,0]) rotate([0,0,180]) border_section(1,1);
	}
	for(i=[0:x-1]) {
		translate([i*spacing+spacing/2+minor_spacing,border_width/2,0]) rotate([0,0,90]) border_section(0,1);
		translate([i*spacing+spacing/2+minor_spacing,y2,0]) rotate([0,0,-90]) border_section(1,1);
	}

	translate([x2,y2,0]) rotate([0,0,180]) corner();
	translate([x2,border_width/2,0]) rotate([0,0,90]) corner();
	translate([border_width/2,y2,0]) rotate([0,0,-90]) corner();
	translate([border_width/2,border_width/2,0]) rotate([0,0,0]) corner();
}

module border_pieces(){
	gap=1.5;
	spacing=square_size+board_thickness/2+gap;
	minor_spacing=border_width+board_thickness/2+gap;
	for(i=[0:squares_x*2-1]){
		translate([minor_spacing*i,0,0]) border_section();
	}
	for(i=[0:squares_y*2-1]){
		translate([minor_spacing*i,spacing,0]) border_section();
	}
	for(i=[0:3]){
		translate([minor_spacing*i,-minor_spacing/2-spacing/2,0]) corner();
	}
}

module squares_color(which){
	gap=1.5;
	spacing=square_size+board_thickness/2+gap;
	totalsquares=squares_x*squares_y;
	numsquares=which==1?ceil(totalsquares/2.0):floor(totalsquares/2.0);
	x=floor(sqrt(numsquares));
	y=x;
	for(j=[0:y]) for(i=[0:x-1]) if(i+(j*x)<numsquares) {
		translate([i*spacing,j*spacing,0]) board_square();
	}
}

if(goal==0){ // visualize the whole thing
	board();
}else if(goal==1){ // border pieces
	border_pieces();
}else if(goal==2){ // squares color 1
	squares_color(1);
}else if(gaol==3){ // squares color 2
	squares_color(2);
}