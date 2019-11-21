

/* [Temples (Arms)] */
//Height of the temple
Temple_Height = 14.2;		//[8:0.1:20]
//Width of the temple
Temple_Width = 4.5;		//[2:0.1:10]
//Amount of taper
Temple_Taper = 1.4;	//[0:0.1:3]
//If curving, enable this after you have set all of the other options because Thingiverse displays the model very small.
Curved_Temple = "No"; //[Yes,No]
//Amount of curve
Temple_Curve = 35;	//[0:100]


/* [Hinge] */
//Hinge height
Hinge_Height = 5.6;	//[2:0.1:16]
//Hinge screw hole radius
Screw_Radius = 1.0;			//[0.1:0.1:2]
//Hinge temple offset spacer
Hinge_Spacer = 5;			//[1:0.1:10]
//Gap tolerance
Tolerance = 0.5; 			//[0:0.1:1]

/* [Ear Bend] */
//Temple length to ear curve
Temple_Length1 = 77;  //[50:100]
//Ear Bend Radius
Ear_Radius = 22;		//[10:40]
//Ear Bend Radius
Ear_Radius2 = 14;		//[5:40]
// Temple end length
Temple_Length2 = 29;	//[10:40]
//Ear bend angle
Temple_Angle = 30;	//[10:45]

/* [Hidden] */

$fn = 100; 

temple_h1 = Temple_Height+.5; // Arm height adjustment
temple_h2 = Temple_Height-9;	// Ear bend height adjustment
temple_h3 = Temple_Height-7.7;	// Arm end height adjustment



eps = 1e-3;


translate([0, 0, -200])
rotate(90, [1,0,0])
intersection() {
	rotate(Temple_Taper, [0,1,0])
	temple();
	temple();
}

$t = 50;




module temple() {

	if (Curved_Temple == "Yes") {
		translate([0, 20, 0]) 
		rotate(-90, [0,0,1])
		parabolic_bend([400, 500, Temple_Width*1.5], (Temple_Curve * .0001))
		translate([20, 0, 0]) 
		rotate(90, [0,0,1])
			linear_extrude(height=Temple_Width) _temple();
	}else{
		linear_extrude(height=Temple_Width) _temple();
	}

		translate([-(Hinge_Spacer+1)/2, 0, (Temple_Width+2)/2])
			difference() {
                                union() {
												// hinge body
                                    translate([(Temple_Width)/2,0,-1])
												//cube([Hinge_Spacer+1-(Temple_Width+2)/2, Hinge_Height-0.5, Temple_Width+2], center=true);
                                    cube([Hinge_Spacer, Hinge_Height-Tolerance, Temple_Width], center=true);
                                    // curved hinge edge
												translate([-((Temple_Width)/4)+1, 0, -1]) rotate([90,0,0])
                                    cylinder(r=(Temple_Width)/2, h=Hinge_Height-Tolerance, center=true, $fn=30);
                                }
				// screw hole
				translate([0, 0, -1])
				rotate([90, 0, 0]) cylinder(r=Screw_Radius, h=Hinge_Height+0.5, center=true, $fn=30); 
			}
}


module _temple() {
	hull() {
		// main body
		square([eps, temple_h1], center=true); 
		translate([Temple_Length1+eps, 0]) square([eps,temple_h2], center=true);
		
	}
	// ear curve
	translate([Temple_Length1, 0]) for (i=[0:Ear_Radius2-1]) hull() {
		translate([sin(Temple_Angle*i/(Ear_Radius2-1))*Ear_Radius, -(1-cos(Temple_Angle*i/(Ear_Radius2-1)))*Ear_Radius]) 
			rotate(-Temple_Angle*i/(Ear_Radius2-1)) 
				square([eps, temple_h2], center=true);
		
		translate([sin(Temple_Angle*(i+1)/(Ear_Radius2-1))*Ear_Radius, -(1-cos(Temple_Angle*(i+1)/(Ear_Radius2-1)))*Ear_Radius]) 
			rotate(-Temple_Angle*(i+1)/(Ear_Radius2-1)) 
				square([eps, temple_h2], center=true);
	}
	//tail piece
	translate([Temple_Length1+sin(Temple_Angle)*Ear_Radius, -(1-cos(Temple_Angle))*Ear_Radius])
		rotate(-Temple_Angle) hull() {
			square([eps, temple_h2], center=true);
			translate([Temple_Length2, 0]) square([eps,temple_h3], center=true);
 		translate([Temple_Length2, 0]) circle(temple_h3/2);
		}
}



// Bend flat object on parabole
// dimensions: vector with dimensions of the object that should be bent
// steepness:  coeficient 'a' of the function 'y = a * x^2'
// nsteps:     number of parts the object will be split into before being bent 
module parabolic_bend(dimensions, steepness, nsteps = $fn) {
	function curr_z(step, ysw) = steepness * pow(step * ysw, 2);
	function flat_width(step, ysw) = 
		ysw * sqrt(pow(2 * steepness * step * ysw, 2) + 1);
	function acc_y(step, ysw) =
		step == 0 ? ysw / 2 : acc_y(step - 1, ysw) + flat_width(step, ysw);

	assign(max_y = dimensions.y / sqrt(1 + steepness))
	assign(ysw = nsteps == 0 ? tan($fa) / (2 * steepness) : max_y / nsteps)
	assign(steps = nsteps == 0 ? max_y / ysw : nsteps)
	{
		intersection() {
			children(0);
			cube([dimensions.x, ysw/2, dimensions.z]);
		}      		

		for (step = [1:ceil(steps)]) {
			assign(curr_flat = flat_width(step, ysw))
			assign(acc_flat = acc_y(step - 1, ysw))
			assign(angle = atan(2 * steepness * step * ysw))
			{
				translate([0, step * ysw, curr_z(step, ysw)])
   				rotate(angle, [1, 0, 0])
						translate([0, -acc_flat - curr_flat/2, 0])
							intersection() {
								children(0);
								translate([0, acc_flat, 0])
									cube([dimensions.x, curr_flat, dimensions.z]);
							}
			}
		}
	}
}


