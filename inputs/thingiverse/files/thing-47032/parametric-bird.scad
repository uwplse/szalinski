//------------------------------------------------------------
//	for the birds
//   (parametric bird pendant)
//
//   Bird Shaper : http://chaaawa.com/forthebirds/
//
//	http://thingiverse.com/Benjamin
//	http://www.thingiverse.com/thing:47032
//------------------------------------------------------------

// preview[view:south, tilt:top]

// paste here the "Bird Shaper" output. Get back to the object's page, by clicking "for the birds", if you don't know what I mean.
shape = "040,020,030,008,005,013,000,015,005,030,050,025-,067,010,003-,010-";

ring_orientation = 2;	//	[1:horizontal, 2:vertical, 3:none]
ring_outer_diameter = 6;
ring_thickness = 3;
legs_number = 2;// [0, 1, 2, 3]
legs_diameter = 2;
legs_spacings = 2;
toes_length = 4;//[0:30]
toes_angle = 80;//[0:180]
beak_separation_ratio = 67; // [0:100]
body_thickness = 4;//[3:10]
eye_diameter = 2.5;
rounding = 2;
layer_height = 0.25;

//---------------------------------------------------------------------------------------------------------
u = str("0123456789", ""); // str() to hide u, d and c in Customizer
d = str("0123456789", "");
c = str("0123456789", "");
csv = search(",",shape, 20)[0];

body_circle_diameter = strToNumber(str(shape[0], shape[1], shape[2], shape[3]));
body_height = 		posToNum(0);
body_orientation = 	posToNum(1);
beak_length = 		posToNum(2);
beak_height = 		posToNum(3);
beak_angular_position=posToNum(4); 
beak_orientation = 	posToNum(5);
tail_length = 		posToNum(6);
tail_feather_number = posToNum(7);
tail_feather_width = 	posToNum(8)/10;
tail_opening_angle = 	posToNum(9);
tail_orientation = 	posToNum(10);
eye_pos = 			posToNum(11);
legs_length = 		posToNum(12);
legs_offsetX = 		posToNum(13);
legs_offsetY = 		posToNum(14);

//---------------------------------------------------------------------------------------------------------
ring_inner_diameter = body_thickness > 3 ? ring_outer_diameter - 4 : 1;
body_circle_distance =  body_circle_diameter - body_height;
rc = body_circle_diameter/2;
A_offsetY = -body_circle_distance/2;
B_offsetY = body_circle_distance/2;
precision = 32*1;
intcircY = body_circle_distance/2 ;
intangle = asin(intcircY / rc);
intcircX = rc * cos(intangle);
body_sphere = intcircX;
beak_thickness = body_thickness*0.67;
beakX = rc * cos(intangle + beak_angular_position);
beakY = B_offsetY  - rc *  sin(intangle + beak_angular_position);
tgX =  A_offsetY * sin(-body_orientation);
tgY = A_offsetY * cos(-body_orientation);
ry1 = tgY - sqrt(rc*rc - tgX*tgX);
ry2 = tgY + sqrt(rc*rc - tgX*tgX);
rY = max(ry1, ry2);
nbo = (1 + sqrt(5))/2;
wing_thickness = body_thickness/3;
//---------------------------------------------------------------------------------------------------------
union() {
		//--------------------- body ----------------------------
		rotate([0, 0, body_orientation])
		body_profile(body_thickness);
	
		//--------------------- wing ----------------------------
		rotate([0, 0, body_orientation])
		translate([0, 0, body_thickness])
		wing(wing_thickness);

		//--------------------- ring ----------------------------
		intersection() {
			ring();
			translate([0, rY + ring_inner_diameter/2, ring_outer_diameter])
			cube([2*ring_outer_diameter, 2*ring_outer_diameter, 2*ring_outer_diameter], center=true);
		}

		//--------------------- legs ----------------------------

		union() {
			if (legs_number == 1) {
				translate([legs_offsetX, legs_offsetY - legs_length/2, legs_diameter/2])
				cube([legs_diameter, legs_length, legs_diameter], center=true);
			
				translate([legs_offsetX, legs_offsetY - legs_length, legs_diameter/2])
				{
					rotate([0, 0,-toes_angle / 2])toes();
					rotate([0, 0,+toes_angle / 2])toes();
					translate([0, toes_length*(1-cos(toes_angle/2))-(legs_diameter/2)*sin(toes_angle/2),0]) toes();
				}
			}
			if (legs_number == 2) {
		
				translate([legs_offsetX - legs_diameter/2 - legs_spacings/2, legs_offsetY - legs_length/2, legs_diameter/2])
				cube([legs_diameter, legs_length, legs_diameter], center=true);
				
				translate([legs_offsetX +  legs_diameter/2 + legs_spacings/2, legs_offsetY - legs_length/2, legs_diameter/2])
				cube([legs_diameter, legs_length, legs_diameter], center=true);
			
				translate([legs_offsetX - legs_diameter/2 - legs_spacings/2, legs_offsetY - legs_length, legs_diameter/2])
				{
					rotate([0, 0,-toes_angle / 2])toes();
					rotate([0, 0,+toes_angle / 2])toes();
					translate([0, toes_length*(1-cos(toes_angle/2))-(legs_diameter/2)*sin(toes_angle/2),0]) toes();
				}
	
				translate([legs_offsetX +  legs_diameter/2 + legs_spacings/2, legs_offsetY - legs_length, legs_diameter/2])
				{
					rotate([0, 0,-toes_angle / 2])toes();
					rotate([0, 0,+toes_angle / 2])toes();
					translate([0,  toes_length*(1-cos(toes_angle/2))-(legs_diameter/2)*sin(toes_angle/2), 0]) toes();
				}
			}

			if (legs_number == 3) {
				translate([legs_offsetX, legs_offsetY - legs_length/2, legs_diameter/2])
				cube([legs_diameter, legs_length, legs_diameter], center=true);
			
				translate([legs_offsetX, legs_offsetY - legs_length, legs_diameter/2])
				{
					rotate([0, 0,-toes_angle / 2])toes();
					rotate([0, 0,+toes_angle / 2])toes();
					translate([0, toes_length*(1-cos(toes_angle/2))-(legs_diameter/2)*sin(toes_angle/2),0]) toes();
				}
				
		
				translate([legs_offsetX - legs_diameter/2 - legs_spacings/2, legs_offsetY - legs_length/2, legs_diameter/2])
				cube([legs_diameter, legs_length, legs_diameter], center=true);
				
				translate([legs_offsetX +  legs_diameter/2 + legs_spacings/2, legs_offsetY - legs_length/2, legs_diameter/2])
				cube([legs_diameter, legs_length, legs_diameter], center=true);
			
				translate([legs_offsetX - legs_diameter/2 - legs_spacings/2, legs_offsetY - legs_length, legs_diameter/2])
				{
					rotate([0, 0,-toes_angle / 2])toes();
					rotate([0, 0,+toes_angle / 2])toes();
					translate([0, toes_length*(1-cos(toes_angle/2))-(legs_diameter/2)*sin(toes_angle/2),0]) toes();
				}
	
				translate([legs_offsetX +  legs_diameter/2 + legs_spacings/2, legs_offsetY - legs_length, legs_diameter/2])
				{
					rotate([0, 0,-toes_angle / 2])toes();
					rotate([0, 0,+toes_angle / 2])toes();
					translate([0,  toes_length*(1-cos(toes_angle/2))-(legs_diameter/2)*sin(toes_angle/2), 0]) toes();
				}
			}
		}

		

		//--------------------- tail ----------------------------
		rotate([0, 0, body_orientation])
		translate([-intcircX + 2, 0.5 , 0])
		rotate([0, 0, tail_orientation - tail_opening_angle/2])
		for ( i = [1 : tail_feather_number] )
		{
		    rotate([0, 0,  i * tail_opening_angle / tail_feather_number])
		    feather(body_thickness - rounding - ((i-1)*(body_thickness-rounding)/tail_feather_number));	
		}

		//--------------------- beak ----------------------------
		rotate([0, 0, body_orientation])
		translate([beakX, beakY , 0])
		rotate([0, 0, beak_orientation - intangle - beak_angular_position])
		rotate([90, 0, -90])
		hull() {
			
			linear_extrude(height=0.1, center=true) {
				polygon(points=[[0, 0], [-beak_height*beak_separation_ratio/100, 0], [0, beak_thickness]]);
				polygon(points=[[0, 0], [beak_height*(100-beak_separation_ratio)/100, 0], [0, beak_thickness]]);
			}		
	
			translate([0, 0, -beak_length])
			scale([0.01, 0.01, 0.01])
			linear_extrude(height=0.1, center=true) {
				polygon(points=[[0, 0], [-beak_height*beak_separation_ratio/100, 0], [0, beak_thickness]]);
				polygon(points=[[0, 0], [beak_height*(100-beak_separation_ratio)/100, 0], [0, beak_thickness]]);
			}

		}

		rotate([0, 0, body_orientation])
		hull() {
			translate([beakX, beakY , 0])
			rotate([0, 0, beak_orientation - intangle - beak_angular_position])
			rotate([90, 0, -90])
			linear_extrude(height=0.1, center=true) {
				polygon(points=[[0, 0], [-beak_height*beak_separation_ratio/100, 0], [0, beak_thickness]]);
				polygon(points=[[0, 0], [beak_height*(100-beak_separation_ratio)/100, 0], [0, beak_thickness]]);
			}
			
			translate([0, 0 , 1])
			rotate([90, 0, -90])
			scale([0.3, 0.3, 0.3])
			linear_extrude(height=0.1, center=true) {
				polygon(points=[[0, 0], [-beak_height*beak_separation_ratio/100, 0], [0, beak_thickness]]);
				polygon(points=[[0, 0], [beak_height*(100-beak_separation_ratio)/100, 0], [0, beak_thickness]]);
			}
	
		}
		
		//--------------------- eye ----------------------------

	rotate([0, 0, body_orientation])
	translate([eye_pos*intcircX/100, 0, body_thickness - eye_diameter/6])
	sphere(r=eye_diameter/2, $fn=precision);

} 
//---------------------------------------------------------------------------------------------------------
module wing(pT) {
hull() {
	translate([-intcircX +rounding+ (intcircX)/(nbo), 0, 0])
	color("orange")
	linear_extrude(height=0.1, center=false, convexity=10)
	scale(1/nbo)
	intersection() {
		translate([0 , A_offsetY, 0])
		circle (r=body_circle_diameter/2 - rounding, $fn=precision*2, center=true);
		translate([0, B_offsetY, 0])
		circle (r=body_circle_diameter/2 - rounding, $fn=precision*2, center=true);
	}
	
	translate([-intcircX +rounding+ (intcircX)/(nbo), 0, 1])
	color("orange")
	rotate([-10, 0, 0])
	linear_extrude(height=0.1, center=false, convexity=10)
	scale(1/nbo)
	intersection() {
		translate([0 , A_offsetY, 0])
		circle (r=body_circle_diameter/2 - rounding, $fn=precision*2, center=true);
		translate([0, B_offsetY, 0])
		circle (r=body_circle_diameter/2 - rounding, $fn=precision*2, center=true);
	}
}
}
//---------------------------------------------------------------------------------------------------------
module body_profile(pH) {
	for (x = [0:layer_height:rounding]) {
		assign (y = sqrt((2*rounding*x - x*x))) {
			linear_extrude(height=pH - rounding + y, center=false, convexity=10)
			intersection() {
				translate([0 , A_offsetY, 0])
				circle (r=body_circle_diameter/2 - x, $fn=precision*2, center=true);
				translate([0, B_offsetY, 0])
				circle (r=body_circle_diameter/2 - x, $fn=precision*2, center=true);
			}		
		}
	}
}
//---------------------------------------------------------------------------------------------------------
module ring() {
	if (ring_orientation == 1) {
		translate([0, rY + ring_inner_diameter/2 , ring_outer_diameter/2 - (ring_outer_diameter-ring_inner_diameter)/6])
		difference() {
			rotate([0, 90, 0])
			cylinder(r=ring_outer_diameter/2, h=ring_thickness, $fn=precision, center=true);
			rotate([0, 90, 0])
			cylinder(r=ring_inner_diameter/2, h=ring_thickness*2, $fn=precision, center=true);
		} 
	} 
	if (ring_orientation == 2)  {
		translate([0, rY + ring_inner_diameter/2 , ring_thickness/2])
		difference() {
			cylinder(r=ring_outer_diameter/2, h=ring_thickness, $fn=precision, center=true);
			cylinder(r=ring_inner_diameter/2, h=ring_thickness*2, $fn=precision, center=true);
		} 
	}
	if (ring_orientation == 3) {
		translate([0, 0, -10])
		cylinder(r=ring_outer_diameter/2, h=ring_thickness, $fn=precision, center=true);
	}
}

//---------------------------------------------------------------------------------------------------------
module feather(pH) {
		linear_extrude(height=pH) {
		scale([tail_length/48, tail_feather_width/18])
		polygon([[0,-4],[-28,-9],[-40,-9],[-48,-5],[-50,0],[-48,6],[-40,9],[-28,9],[0,4]]);
		}
}
//---------------------------------------------------------------------------------------------------------
module wing_feather(pL=20, pW=10, pH=2) {
	linear_extrude(height=pH) {
	scale([pL/57, pW/26])
	polygon([[0,0],[0,1],[-1,2],[-4,4],[-11,7],[-20,10],[-32,12],[-39,12],[-45,11],[-52,8],[-56,4],[-57,0],[-56,-4],[-52,-8],[-45,-11],[-39,-12],[-32,-12],[-20,-10],[-11,-7],[-4,-4],[-1,-2],[0,-1]]);
	}
}
//---------------------------------------------------------------------------------------------------------
module toes() {
		translate([0, -toes_length/2, 0])
		cube([legs_diameter*0.8, toes_length, legs_diameter], center=true);
}

//---------------------------------------------------------------------------------------------------------
function posToNum(index)  = strToNumber(str(shape[csv[index]+1], shape[csv[index]+2], shape[csv[index]+3], shape[csv[index]+4]));
function strToNumber(str) = (search(str[2],u)[0]+10*search(str[1],d)[0]+100*search(str[0],c)[0])*(str[3]=="-"?-1:1);
//---------------------------------------------------------------------------------------------------------



