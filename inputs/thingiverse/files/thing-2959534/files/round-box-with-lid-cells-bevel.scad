itemsShown="both"; // [both,box,lid]
boxLength=80;
boxWidth=100;
boxHeight=30;
cornerRadius=5;
wallThickness=2;
bottomThickness=2;
lidThickness=2;
lidClearance=0.2;
lidEdgeThickness=0.5;
columns = 3; //[1:10]
rows = 2; //[1:10]
// Notch in the lid
withNotch=true;//[true:false]
innerBevel = 5;//[0:.25:10]

/* [Global] */
if (itemsShown=="box") showBox();
if (itemsShown=="lid") showLid();
if (itemsShown=="both"){showBox();showLid();}


module showLid(){
	translate ([0, -2*wallThickness, 0]) 
	roundBoxLid(l=boxLength-wallThickness,
				w=boxWidth-2*wallThickness-lidClearance,
				h=lidThickness,
				et=lidEdgeThickness,
				r=cornerRadius-wallThickness,
				notch=withNotch);
}

module showBox(){
	round_box(l=boxLength,
			  w=boxWidth,
			  h=boxHeight,
			  bt=bottomThickness,
			  wt=wallThickness,
			  lt=lidThickness,
			  r=cornerRadius,
              rs=rows,
              cs=columns);
}

module round_box(l=40,w=30,h=30,bt=2,wt=2,lt=2,r=5,rs=1,cs=1){
	difference() { 
		round_cube(l=l,w=w,h=h-lt,r=r);
		translate ([wt, wt, bt]) 
		round_cube(l=l-wt*2,w=w-wt*2,h=h,r=r-wt);
	}
    
    // add cells
    for (i = [2:1:rs]) {
        translate([(l/rs)*(i-1)-(wt/2),wt,wt])
        cube([wt, w - wt*2, h-wt*2]);
    }
    for (i = [2:1:cs]) {
        translate([wt, (w/cs)*(i-1)-(wt/2), wt])
        cube([l - wt*2, wt, h-wt*2]);
    }
    
    // add inner bevels
    for (row = [0:rs-1], column = [0:cs-1]) {
		ht = wt / 2;
		roundBoxBevel(
			x1=wt + row * (l / rs),
			y1=ht + column * (w / cs),
			x2=(row +1) * (l / rs) - wt,
			y2=(column+1) * (w / cs) - ht,
			radius=innerBevel,
			wt=wt
		);
    }
    
	//use two box rims. one to make a slope to support the lid
	roundBoxRim();
	translate ([0, 0, -wt]) roundBoxRim();
}


module roundBoxRim(l=boxLength,
				   w=boxWidth,
				   h=boxHeight,
				   et=lidEdgeThickness,
				   r=cornerRadius,
				   wt=wallThickness,
				   lt=lidThickness){
	difference() { 
		translate ([0, 0, h-lt]) 
		round_cube(l=l,w=w,h=lt,r=r);
		translate ([wt+lt,wt+lt-et*2,h-lt-0.1]) 
		round_cube(l=l*2,w=w-2*(wt+lt)+4*et,h=lt+0.2,r=r-wt+lt);

		//subtract out a lid to make the ledge
		translate ([wt, w-wt, h-lt-0.1])
		roundBoxLid(l=l*2,w=w-2*wt,h=lt+0.1,wt=wt,t=lt,et=0.5,r=r-wt,notch=false);
	}
}

module roundBoxLid(l=40,w=30,h=3,wt=2,t=2,et=0.5,r=5,notch=true){
	translate ([l, 0, 0]) 
	rotate (a = [0, 0, 180]) 
	difference(){
		round_cube(l=l,w=w,h=h,t=t,r=r);

		translate ([-1, 0, et]) rotate (a = [45, 0, 0])  cube (size = [l+2, h*2, h*2]); 
		translate ([-1, w, et]) rotate (a = [45, 0, 0])  cube (size = [l+2, h*2, h*2]); 
		translate ([l, -1, et]) rotate (a = [45, 0, 90]) cube (size = [w+2, h*2, h*2]); 
		if (notch==true){
			translate([2,w/2,h+0.001]) thumbNotch(10/2,72,t);
		}
	}
}

module thumbNotch(
	thumbR=12/2,
	angle=72,
	notchHeight=2){

	size=10*thumbR;

	rotate([0,0,90])
	difference(){
		translate([0,
					(thumbR*sin(angle)-notchHeight)/tan(angle),
					 thumbR*sin(angle)-notchHeight])
		rotate([angle,0,0])
		cylinder(r=thumbR,h=size,$fn=30);

		translate([-size,-size,0])
		cube(size*2);
	}
}

module round_cube(l=40,w=30,h=20,r=5,$fn=30){
	hull(){ 
		translate ([r, r, 0]) cylinder (h = h, r=r);
		translate ([r, w-r, 0]) cylinder (h = h, r=r);
		translate ([l-r,w-r, 0]) cylinder (h = h, r=r);
		translate ([l-r, r, 0]) cylinder (h = h, r=r);
	}
}

module roundBoxBevel(x1,y1,x2,y2,radius,wt) {
//%   color("red", .25) translate([x1, y1, 0]) cube([x2-x1, y2-y1, 50]);
    if (radius > 0) {
        translate([x1, y1, wt]) rotate([0, 0, 90]) rotate([90, 0, 0]) bevel(x2-x1, radius);
        translate([x1, y2, wt]) rotate([90, 0, 0]) rotate([0, 0, 0]) bevel(y2-y1, radius);
        translate([x2, y2, wt]) rotate([0, 0, 270]) rotate([90, 0, 0]) bevel(x2-x1, radius);
        translate([x2, y2, wt]) rotate([0, 0, 90]) rotate([0, 270, 0]) bevel(y2-y1, radius);
    }
}

module bevel(length,radius) {
    difference() {
        cube([radius, radius, length]);
        translate([radius, radius, -1])
        cylinder(length + 2, radius, radius, false);
    }
}
    



