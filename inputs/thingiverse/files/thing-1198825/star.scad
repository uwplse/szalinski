points = 6;
num = 7;

outerR1 = 20;
innerR1 = 13;
clearance = 0.75;

thick = 4;
height = 6;
pin_clearance = 0.25;
corner_fudge = 0.8;
bevel = 0.7;
do_loop=true;

innerRd = thick+clearance*1;
outerRd = innerRd*(outerR1/innerR1);
rotation = 360/points;
isEven = (points%2) ? false:true;

star_assembly();
*difference() { 
	star_assembly();
	translate([-200,-200,0]) cube(400);
}
//star(points,outerR1,innerR1,thick,height,0.5,false);
//star(points,outerR1-outerRd,innerR1-innerRd,thick,height,0.5,false);
//star_ring(points, outerR1, innerR1, innerHole=false, outerPin=true, innerPin=true);

module star_assembly() {
	union() {
		for (i = [0:num-1]) {
			outerPin = (i==0) ? false:true;
			innerPin = (i==num-1) ? false:true;
			limit_test = (outerR1-outerRd*i<=thick/2 || innerR1-innerRd*i<=thick/2) ? false:true;
			//echo(i,outerPin,innerPin);
			if(limit_test==true) rotate(-rotation*i)
				star_ring(points=points,
					outerR=outerR1-outerRd*i,
					innerR=innerR1-innerRd*i,
					innerHole=false,
					outerPin=outerPin,
					innerPin=innerPin);
		}
		if(do_loop==true) {
			twist = (isEven==true) ? rotation : 0;
			rotate(twist)
				translate([outerR1+thick,0,0])
					difference() {
						hull() {
							cylinder(d=thick*2,h=height-bevel*2,center=true);
							cylinder(d=thick*2-bevel*2,h=height,center=true);
						}
						cylinder(d=thick,h=height+1,center=true);
					}
		}
	}
}

module star_ring(points, outerR, innerR, innerHole, outerPin, innerPin) {
    pin = (height>thick) ? thick/2 : height/2-clearance;
	trans = (isEven==false) ? outerR : innerR;
	//echo("A",outerPin,innerPin);
	difference() {
		union() {
			star(points,outerR,innerR,thick,height,bevel,innerHole);
			if (outerPin==true) rotate(-rotation/2) difference() {
				trans_choice = (isEven==false) ? -trans-clearance/2-thick*(outerR1/innerR1-1): -(trans+thick/2+clearance);
				hull() {
					translate([innerR+thick/2+clearance,0,0])
						rotate([0,90,0])
							cylinder(r1=pin, r2=0, h=pin, $fn=12);
					translate([trans_choice,0,0])
						rotate([0,90,180])
							cylinder(r1=pin, r2=0, h=pin, $fn=12);
				}
				translate([innerR/2-trans/2,0,0])
					cube([innerR+trans,pin*3,pin*3],center=true);
			}
		}
		if (innerPin==true) {
			trans_choice = (isEven==false) ? -trans+thick+clearance: -trans+thick/2;
			rotate(-3*rotation/2) hull() {
				translate([innerR-thick/2,0,0])
					rotate([0,90,0])
						cylinder(r1=pin+pin_clearance, r2=0, h=pin+pin_clearance, $fn=12);
				translate([trans_choice,0,0])
					rotate([0,90,180])
						cylinder(r1=pin+pin_clearance, r2=0, h=pin+pin_clearance, $fn=12);
			}
		}
	}
}

module star(points, outer, inner, thick, height, bevel=1, solid=true) {
	//echo(outer,inner);
	po = [outer,0];
	pi = [inner * cos(180/points),inner * sin(180/points)]; 
	//echo(po,pi);
	d=thick;
	h=height;
	for(i = [0:points-1])
		rotate(360/points*i) {
			union() {
				mir([0,1,0]) hull() {
					translate(po) {
						cylinder(d=d-bevel*2, h=h, center=true);
						cylinder(d=d, h=h-bevel*2, center=true);
					}
					translate(pi) rotate(180/points) {
						cylinder(d=d-bevel*2, h=h, center=true);
						cylinder(d=d, h=h-bevel*2, center=true);
					}
					if(solid==true)
						cylinder(d=d, h=h, center=true);
				}
				if(isEven==false) translate([outer-thick+corner_fudge,0,0])
					hull() {
						cube([d,d*1.2,h-bevel*2],center=true);
						cube([d-bevel*2,d*1.2,h],center=true);
					}
			}
		}
}

module mir(plane=[1,0,0]) {
	children();
	mirror(plane)
		children();
}