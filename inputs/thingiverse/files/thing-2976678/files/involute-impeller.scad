// Create a blower turbine based on involute curves
//    https://en.wikipedia.org/wiki/Involute
//
// This is licensed under Creative Commons+Attribution+Share Alike
//
// To fulfill the attribution requirement, please link to one or both of:
//   https://theheadlesssourceman.wordpress.com/2018/06/24/custom-blower-turbine
//   https://www.thingiverse.com/thing:2976678

// what part to show
show=0; // [0:assembled,1:printable top,2:printable bottom]

// the total, complete, outside height
total_height=11.3;

// thickness of the top and bottom plate
plate_thickness=0.5;

// diameter of the overall rotor (nothing will go outside this)
outside_dia=126;

// how large the intake hole is in the top
intake_dia=52.25;

// how many vanes there are
num_vanes=6;

// how thick the vanes are (0.5 is pushing our luck!)
vane_thickness=0.5;

// how large the shaft hole in the middle is.
shaft_dia=7.86;

// location where the vanes start (if <0 then use intake_dia)
vane_start_dia=-1;

// direction of the vanes
direction=0; // [0:counter clockwise,1:clockwise]

// gap controlling how tightly the vanes fit 0.2-0.3 is about right (higher number=looser)
vane_fit=0.25;

// resolution 1=low(aka 1x) 2=mid 3=high
resfactor=2;

/* [hidden] */

// make $fn more automatic
function myfn(r)=max(3*r,12)*resfactor;
module cyl(r=undef,h=undef,r1=undef,r2=undef){cylinder(r=r,h=h,r1=r1,r2=r2,$fn=myfn(r!=undef?r:max(r1,r2)));}
module circ(r=undef){circle(r=r,$fn=myfn(r));}
module ball(r=undef){sphere(r=r,$fn=myfn(r));}

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

module involuteOf(r,a=0,degrees=360,clockwise=true,startDegrees=0){
	// sweeps the (convex) children objects along an involute
	inc=5;
	for(t=[startDegrees:inc:degrees-inc]) hull(){
		translate(involutePoint(r,t,a,clockwise)) children();
		translate(involutePoint(r,t+inc,a,clockwise)) children();
	}
}

module involuteLine(r,thick=1,a=0,degrees=360,clockwise=true,startDegrees=0){
	/*
	unlike Archimedes spirals, the levels of consecutive involute lines are parallel
	*/
	involuteOf(r,a,degrees,clockwise,startDegrees) circle(r=thick/2,$fn=6);
}

module involutePlate(r,thick=0.01,a=0,degrees=360,clockwise=true,startDegrees=0){
	inc=5;
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

module vane(start_r,end_r,thickness=1,clockwise=true){
	a=100;
	startDegrees=involuteRadiusToAngle(start_r,a);
	endDegrees=involuteRadiusToAngle(end_r,a)+90;
	//echo(start_r,end_r,startDegrees,endDegrees);
	involuteLine(start_r,thick=thickness,a=a,degrees=endDegrees,clockwise=clockwise,startDegrees=startDegrees);
}

module impeller_fillet(fillet,num_vanes,vane_start_dia,outside_dia,vane_thickness,clockwise=true){
	a=100;
	start_r=vane_start_dia/2;
	end_r=outside_dia/2;
	startDegrees=involuteRadiusToAngle(start_r,a);
	endDegrees=involuteRadiusToAngle(end_r,a)+90;
	for(angle=[0:360/num_vanes:359.99]){
		rotate([0,0,angle]) involuteOf(start_r,a,endDegrees,clockwise,startDegrees) cylinder(r1=fillet+vane_thickness/2,r2=vane_thickness/2,h=fillet,$fn=6);
	}
}

module impellerBottom(outside_dia,intake_dia,total_height=10,num_vanes=6,plate_thickness=1,vane_thickness=0.5,shaft_dia=5,vane_start_dia=-1,fillet=2,clockwise=true){
	vane_start_dia=vane_start_dia>=0?vane_start_dia:intake_dia;
	intersection(){
		union(){
			linear_extrude(total_height) for(angle=[0:360/num_vanes:359.99]){
				rotate([0,0,angle]) vane(vane_start_dia/2,outside_dia/2,vane_thickness,clockwise);
			}
			// impeller_fillet
			translate([0,0,plate_thickness]) impeller_fillet(fillet,num_vanes,vane_start_dia,outside_dia,vane_thickness,clockwise);
			// bottom plate
			linear_extrude(plate_thickness) difference(){
				circ(r=outside_dia/2); 
				circ(r=shaft_dia/2);
			}
		}
		// constrain to this boundary
		cyl(r=outside_dia/2,h=total_height-plate_thickness);
	}
	
}

module impellerTop(outside_dia,intake_dia,total_height=10,num_vanes=6,plate_thickness=1,vane_thickness=0.5,shaft_dia=5,vane_start_dia=-1,fillet=2,clockwise=true,vane_fit=0.2){
	vane_start_dia=vane_start_dia>=0?vane_start_dia:intake_dia;
	intersection(){
		union(){
			// plate
			cyl(r=outside_dia/2,h=plate_thickness);
			// fillet with a place for the vanes
			translate([0,0,plate_thickness]) difference() {
				impeller_fillet(fillet,num_vanes,vane_start_dia,outside_dia,vane_thickness,clockwise==false);
				linear_extrude(total_height) for(angle=[0:360/num_vanes:359.99]){
					rotate([0,0,angle]) vane(vane_start_dia/2,outside_dia/2,vane_thickness+vane_fit*2,clockwise==false);
				}
			}
		}
		// constrain to this boundary
		linear_extrude(total_height) difference(){
			circ(r=outside_dia/2); 
			circ(r=intake_dia/2);
		}
	}
}


clockwise=direction==1;
if(show==0){
	impellerBottom(outside_dia,intake_dia,total_height,num_vanes,plate_thickness,vane_thickness,shaft_dia,vane_start_dia,clockwise);
	translate([0,0,total_height-plate_thickness]) rotate([180,0,0]) impellerTop(outside_dia,intake_dia,total_height,num_vanes,plate_thickness,vane_thickness,shaft_dia,vane_start_dia,clockwise,vane_fit);
}else if(show==1){
	impellerTop(outside_dia,intake_dia,total_height,num_vanes,plate_thickness,vane_thickness,shaft_dia,vane_start_dia,clockwise,vane_fit);
}else if(show==2){
	impellerBottom(outside_dia,intake_dia,total_height,num_vanes,plate_thickness,vane_thickness,shaft_dia,vane_start_dia,clockwise);
}