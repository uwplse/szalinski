// Fun with involute curves, but mostly for the end goal of creating a customizeable 
// scroll compressor.
//
// Licensed under creative commons+attribution+share alike.
//
// To fulfill the attribution requirement, please provide a link back to one or both of:
//     https://theheadlesssourceman.wordpress.com/2018/08/26/involute-scroll-pump/
//     https://www.thingiverse.com/thing:3068796


/* [display settings] */

// see the top lid (NOTE: still missing hole for shaft)
showTopLid=1; // [0=no,1=yes]

// see the rotor
showRotor=1; // [0=no,1=yes]

// see the stator
showStator=1; // [0=no,1=yes]


/* [compressor settings] */

// direction (normally you would change this value based on your motor's rotation direction)
clockwise=1; // [0:counter-clockwise,1:clockwise]

// outside diameter of the compressor
outerDia=100;

// length of the compressor
length=60;

// thickness of the walls
wall_thick=1;

// how many spirals there are
loops=5;


/* [shaft settings] */

// diameter of the input shaft
shaft_d=10;

// length of the input shaft
shaft_len=30;

/* [model settings] */

// gap tolerance between parts
fit=0.2;

// This is a strange value because it's in terms of 1/360, therefore 1=1 vertex per degree, 5=1 vertex for every 5 degrees (lower resolution), etc.
involute_resolution=5;

/* [hidden] */

// generally keep this on with rotor
showShaft=showRotor;

function degrees2radians(a)=a*PI/180.0;
function radians2degrees(a)=a*180.0/PI;

// this comes from wikipedia
/*function involutePoint(r,t,a,cw)=[
	r*(cos(t)+(t-a)*sin(t))/360,
	r*(sin(t)+(cw==true?(t-a):-(t-a))*cos(t))/360
	];*/
// this comes from wolfram (kind of a more reliable source)
function involutePoint(r,t,a,cw)=[
	r*(cos(t)+degrees2radians(t)*sin(t)),
	r*(sin(t)-degrees2radians(t)*cos(t))*(cw==true?1:-1)
	];
function involuteAngleToRadius(angle)=cos(angle)+degrees2radians(angle)*sin(angle);
function involuteRadiusToAngle(radius,a)=radians2degrees(radius/a);

module involuteLine(r,thick=1,a=0,degrees=360,clockwise=true,startDegrees=0){
	/*
	unlike Archimedes spirals, the levels of consecutive involute lines are parallel
	*/
	inc=involute_resolution;
	for(t=[startDegrees:inc:degrees-inc]) hull(){
		translate(involutePoint(r,t,a,clockwise)) circle(r=thick/2,$fn=6);
		translate(involutePoint(r,t+inc,a,clockwise)) circle(r=thick/2,$fn=6);
	}
}

module involutePlate(r,thick=0.01,a=0,degrees=360,clockwise=true,startDegrees=0){
	inc=involute_resolution;
	for(t=[startDegrees:inc:degrees-inc]) hull(){
		translate(involutePoint(r,t,a,clockwise)) circle(r=thick/2,$fn=6);
		translate(involutePoint(r,t+inc,a,clockwise)) circle(r=thick/2,$fn=6);
		circle(r=thick/2,$fn=6);
	}
}

function archimedesRadius(radians,a,b,c=1)=a+b*pow(radians,1/c);

module archimedesLine(a,b,c=1,thick=1,degrees=360,clockwise=true){
	/*
	a = inital offset
	b = spiral increase
	c = a cubic factor.  usually leave at 1.0, but there are related curves you can make by changing this
	
	NOTE: archimedes junk is just for playing around.  It is not actually being used for this model.
	*/
	inc=15;
	for(angle=[0:inc:degrees-inc]) hull(){
		rotate([0,0,angle]) translate([archimedesRadius(angle/(2*PI),a,b,c),0,0]) circle(r=thick/2,$fn=6);
		rotate([0,0,angle+inc]) translate([archimedesRadius((angle+inc)/(2*PI),a,b,c),0,0]) circle(r=thick/2,$fn=6);
	}
}

module archimedesPlate(a,b,c=1,degrees=360,clockwise=true){
	/*
	draw a flat plane representing an Archimedes curve
	
	a = initial offset
	b = spiral increase
	c = a cubic factor.  usually leave at 1.0, but there are related curves you can make by changing this
	*/
	thick=0.1;
	inc=15;
	for(angle=[0:inc:degrees-inc]) hull(){
		rotate([0,0,angle]) translate([archimedesRadius(angle/(2*PI),a,b,c),0,0]) circle(r=thick/2,$fn=6);
		rotate([0,0,angle+inc]) translate([archimedesRadius((angle+inc)/(2*PI),a,b,c),0,0]) circle(r=thick/2,$fn=6);
		//circle(r=thick/2,$fn=6); // for some baffling reason, this line crashes
	}
}

module scrollCompressor(outerDia=100,length=60,wall_thick=1,loops=5,shaft_d=10,shaft_len=30,fit=0.2,clockwise=true){
	// https://en.wikipedia.org/wiki/Scroll_compressor
	dp=5;
	r=dp/2;
	a=0;
	angle=involuteRadiusToAngle(outerDia/2,r);
	ani=-1*$t*360;
	movementR=dp*PI/2-wall_thick-fit/2;
	wobble=[-movementR*cos(ani)-r,-movementR*sin(ani)];
	plate_angle=angle-180-movementR; // plate has to end shorter than the base
	// bottom (stator)
	if(showStator!=0) difference(){
		color([1,0,0,0.5]) translate([-r,0,0]) {
			linear_extrude(length-wall_thick) difference(){
				involuteLine(r,wall_thick,a,angle,clockwise);
				circle(r=movementR);
			}
			linear_extrude(wall_thick) difference(){
				involutePlate(r,wall_thick,a,angle,clockwise);
				circle(r=movementR);
			}
		}
		// cut off a section for the top plate
		translate([0,0,length-wall_thick*2-fit]) rotate([0,0,180]) {
			linear_extrude(length) involutePlate(r,wall_thick,a,plate_angle,clockwise);
		}
	}
	// top plate (rotor)
	if(showRotor!=0) color([0,0,1,0.5]) translate([wobble[0],wobble[1],length-wall_thick-fit/2]) mirror([0,0,1]) rotate([0,0,180]) {
		cylinder(r=shaft_d/2,h=shaft_len+wall_thick);
		linear_extrude(length-fit-wall_thick) involuteLine(r,wall_thick,a,plate_angle,clockwise,0);
		linear_extrude(wall_thick) involutePlate(r,wall_thick,a,plate_angle,clockwise);
	}
	// shaft
	if(showShaft!=0) color([0,0,1,0.5]) translate([-r,0,length]) cylinder(r=shaft_d/2,h=shaft_len+wall_thick);
	// lid
	if(showTopLid!=0) color([1,0,0,0.5]) translate([-r,0,length-wall_thick]) {
		linear_extrude(wall_thick) involutePlate(r,wall_thick,a,angle,clockwise);
	}
}

scrollCompressor(outerDia,length,wall_thick,loops,shaft_d,shaft_len,fit,clockwise!=0);