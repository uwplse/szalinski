// Planetary peristaltic pump (customizable)
// by Drmn4ea (drmn4ea at google's mail)
//
// Released under the Creative Commons - Attribution - Share Alike license (http://creativecommons.org/licenses/by-sa/3.0/)
//
// Adapted from Emmett Lalish's Planetary Gear Bearing at http://www.thingiverse.com/thing:53451

// Modded By Stonedge: Add 2 Mount Bracket model, Quickfix for outer diameter,custom central hole
// motor bracket for 2 motor

// --------  Printer-related settings ------------

// Clearance to generate between non-connected parts. If the gears print 'stuck together' or are difficult to separate, try increasing this value. If there is excessive play between them, try lowering it. (default: 0.15mm)
tol=0.15;

// Allowed overhang for overhang removal; between 0 and 0.999 (0 = none, 0.5 = 45 degrees, 1 = infinite)
allowed_overhang = 0.75;


// --------  Details of the tubing used in the pump, in mm ------------

// Outer diameter of your tubing in mm
tubing_od = 10;

// Wall thickness of your tubing
tubing_wall_thickness = 1;
// Amount the tubing should be compressed by the rollers, as a proportion of total thickness (0 = no squish, 1.0 = complete squish)
tubing_squish_ratio = 0.25;

// --------- Mount bracket Setting ---------
Mount_Enabled=1;
// Mount Style: 1=Compact (mount hole distance =(3/4)*OD) 2=Standard (mount hole distance=1.5*OD)
Mount_Style=1;
// Mounting Hole Diameter in mm
Mount_hole_dia=3;

// -------- Center Hole Parameter -------------

// Arduino TT Motor Yellow: CH_Dia=5.37 CH_Num_of_Flat=2 CH_Flat_Dia=3.67
// Normal screwdriver hex : CH_Dia=0 CH_Num_of_Flat=6 CH_Flat_Dia=5.5

// Diameter of the motor shaft (Not Used for #ofFlat = 3-8)
CenterHole_dia = 5.37; 

// Number of Flat on the motor shaft
CenterHole_Num_of_Flat = 2;//[0,1,2,3,4,5,6,8]

// Diameter taken on the flat part of the motor shaft (Face 2 Face(for pair num of Flat) or Face 2 Edge) (for #ofFlat 1-8)
CenterHole_Flat_dia = 3.67;

// -------- Motor Mount Parameter ----------

//Generate MotorMount
MotorMount=1;
//Type 1 is for TT yellow Motor, 2 is for 28BYJ-48
MotorMount_Type=1;

// --------  Part geometry settings ------------

// Approximate outer diameter of ring in mm
OD=60;

// Thickness i.e. height in mm
T=25;

// Number of planet gears
number_of_planets=3;

// Number of teeth on planet gears
number_of_teeth_on_planets=7;

// Number of teeth on sun gear (approximate)
approximate_number_of_teeth_on_sun=9;

// pressure angle
P=45;//[30:60]

// number of teeth to twist across
nTwist=1;

// width of hexagonal hole
//w=5.5;

DR=0.5*1;// maximum depth ratio of teeth


// ----------------End of customizable values -----------------

//Needed to move those computation here for Outer Diameter Fix ** Stonedge
// compute some parameters related to the tubing
tubing_squished_width = tubing_od * (PI/2);
tubing_depth_clearance = 2*(tubing_wall_thickness*(1-tubing_squish_ratio));

///Quick Fix to keep external Diameter to user Choice ** Stonedge
D = OD - (tubing_depth_clearance*2);


m=round(number_of_planets);
np=round(number_of_teeth_on_planets);
ns1=approximate_number_of_teeth_on_sun;
k1=round(2/m*(ns1+np));
k= k1*m%2!=0 ? k1+1 : k1;
ns=k*m/2-np;
echo(ns);
nr=ns+2*np;
pitchD=0.9*D/(1+min(PI/(2*nr*tan(P)),PI*DR/nr));
pitch=pitchD*PI/nr;
echo(pitch);
helix_angle=atan(2*nTwist*pitch/T);
echo(helix_angle);

phi=$t*360/m;

// temporary variables for computing the outer radius of the outer ring gear teeth
// used to make the clearance for the peristaltic squeezer feature on the planets
outerring_pitch_radius = nr*pitch/(2*PI);
outerring_depth=pitch/(2*tan(P));
outerring_outer_radius = tol<0 ? outerring_pitch_radius+outerring_depth/2-tol : outerring_pitch_radius+outerring_depth/2;

// temporary variables for computing the outer radius of the planet gear teeth
// used to make the peristaltic squeezer feature on the planets
planet_pitch_radius = np*pitch/(2*PI);
planet_depth=pitch/(2*tan(P));
planet_outer_radius = tol<0 ? planet_pitch_radius+planet_depth/2-tol : planet_pitch_radius+planet_depth/2;

// temporary variables for computing the inside & outside radius of the sun gear teeth
// used to make clearance for planet squeezers
sun_pitch_radius = ns*pitch/(2*PI);
sun_base_radius = sun_pitch_radius*cos(P);
echo(sun_base_radius);
sun_depth=pitch/(2*tan(P));
sun_outer_radius = tol<0 ? sun_pitch_radius+sun_depth/2-tol : sun_pitch_radius+sun_depth/2;
sun_root_radius1 = sun_pitch_radius-sun_depth/2-tol/2;
sun_root_radius = (tol<0 && sun_root_radius1<sun_base_radius) ? sun_base_radius : sun_root_radius1;
sun_min_radius = max (sun_base_radius,sun_root_radius);

// debug raw gear shape for generating overhang removal
//translate([0,0,5])
//{
//	//halftooth (pitch_angle=5,base_radius=1, min_radius=0.1,	outer_radius=5,	half_thick_angle=3);
//	gear2D(number_of_teeth=number_of_teeth_on_planets, circular_pitch=pitch, pressure_angle=P, depth_ratio=DR, clearance=tol);
//}

// Mount Calculation
OR_OuterRad = OD/2;
OR_InnerRad = (outerring_outer_radius+tubing_depth_clearance);

// 28BYJ-48 MotorMount Gap
28BYJ48_Gap=5;

if(MotorMount==1){
	//TT motor Mount
	if(MotorMount_Type==1){
		translate([-OR_OuterRad,-(OR_OuterRad+(5)),(OR_OuterRad-OR_InnerRad)]){
		rotate([90,0,90]){
		difference(){
		union(){
		// Basic L shape of the motor mount
		linear_extrude (height=(OR_OuterRad-7)){
		polygon(points=[[-(T+20),0],[-(T+20),-(OR_OuterRad-OR_InnerRad)],
				[(OR_OuterRad-OR_InnerRad),-(OR_OuterRad-OR_InnerRad)],
				[(OR_OuterRad-OR_InnerRad),(OR_OuterRad+(OR_OuterRad-OR_InnerRad)+11.25 +1.25)],
				[0,(OR_OuterRad+(OR_OuterRad-OR_InnerRad)+11.25 +1.25)],
				[0,(OR_OuterRad-OR_InnerRad)], [-(OR_OuterRad-OR_InnerRad),0]]);
		}
		//Ajust width of the motor mount based to fit pump mount
		if(Mount_Style==1){
			linear_extrude (height=OD){
			polygon(points=[[-(T+20),0],[-(T+20),-(OR_OuterRad-OR_InnerRad)],
					[-20,-(OR_OuterRad-OR_InnerRad)],[-20,0]]);
			}}
		else if(Mount_Style==2){
			translate([0,0,-(OR_OuterRad/2)]){
			linear_extrude (height=OD + OR_OuterRad){
			polygon(points=[[-(T+20),0],[-(T+20),-(OR_OuterRad-OR_InnerRad)],
					[-20,-(OR_OuterRad-OR_InnerRad)],[-20,0]]);
			}}
		}
		// Triangle to Made it Pretty ;) and Strong
		linear_extrude (height=(OR_OuterRad-OR_InnerRad)){
		polygon(points=[[0,0],[-(20),0],
				[0,(OR_OuterRad+(OR_OuterRad-OR_InnerRad)-11.75)]]);
		}
		rotate([90,0,0])
				{
				linear_extrude (height=(OR_OuterRad-OR_InnerRad)){
					polygon(points=[[(OR_OuterRad-OR_InnerRad),(OR_OuterRad)],
					[(OR_OuterRad-OR_InnerRad),0],[-(20),0],
					[-20,(OD)]]);
					}
				}
		translate([0,0,OR_OuterRad-(7+(OR_OuterRad-OR_InnerRad))]){
				linear_extrude (height=(OR_OuterRad-OR_InnerRad)){
					polygon(points=[[0,0],[-(20),0],
					[0,(OR_OuterRad+(OR_OuterRad-OR_InnerRad)-11.75)]]);
				}
		}
		
		}
		//Mount Hole for joining to Pump Mount
		translate([-((T/2)+20),0,OR_OuterRad]){
		rotate([90,90,0])
				{
					if(Mount_Style==1){
					translate([(OR_OuterRad-(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-(OR_OuterRad-(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
				} else if(Mount_Style==2){
					translate([(OR_OuterRad+(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-(OR_OuterRad+(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
				}
				}
		}

		//Mount Hole for Motor
		translate([0,OR_OuterRad+(OR_OuterRad-OR_InnerRad),OR_OuterRad-20]){
		rotate([90,0,90])
				{
					translate([9,0,0]) cylinder(r=1.5,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-9,0,0]) cylinder(r=1.5,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([0,9.5,0]) cylinder(r=2.1,h=(2.5*OR_OuterRad),center=true,$fn=100);
				}
		}

		// Fix Width of Motor Mount for > 60mm Pump
		if(OR_OuterRad > 25)
		linear_extrude (height=(OR_OuterRad-25)){
		polygon(points=[[(OR_OuterRad-OR_InnerRad),(OR_OuterRad+(OR_OuterRad-OR_InnerRad)+11.25 +1.25)],
				[0,(OR_OuterRad+(OR_OuterRad-OR_InnerRad)+11.25 +1.25)],
				[0,(OR_OuterRad+(OR_OuterRad-OR_InnerRad)-11.75)], [(OR_OuterRad-OR_InnerRad),(OR_OuterRad+(OR_OuterRad-OR_InnerRad)-11.75)]]);
		}
		
		}
		}
		}
	}
	//28BYJ-48 motor Mount
	if(MotorMount_Type==2){
		translate([OR_OuterRad,-(OR_OuterRad+(5)),(OR_OuterRad-OR_InnerRad)]){
		rotate([90,90,-90]){
		difference(){
		union(){
		// Basic L shape of the motor mount
		translate([0,0,(OR_OuterRad-22.5)]){
		linear_extrude (height=(45)){
		polygon(points=[[-(T+28BYJ48_Gap),0],[-(T+28BYJ48_Gap),-(OR_OuterRad-OR_InnerRad)],
				[(OR_OuterRad-OR_InnerRad),-(OR_OuterRad-OR_InnerRad)],
				[(OR_OuterRad-OR_InnerRad),(OR_OuterRad+(OR_OuterRad-OR_InnerRad)+10)],
				[0,(OR_OuterRad+(OR_OuterRad-OR_InnerRad)+10)],
				[0,(OR_OuterRad-OR_InnerRad)], [-(OR_OuterRad-OR_InnerRad),0]]);
		}}
		//Ajust width of the motor mount based to fit pump mount
		if(Mount_Style==1){
			linear_extrude (height=OD){
			polygon(points=[[-(T+28BYJ48_Gap),0],[-(T+28BYJ48_Gap),-(OR_OuterRad-OR_InnerRad)],
					[(OR_OuterRad-OR_InnerRad),-(OR_OuterRad-OR_InnerRad)],[(OR_OuterRad-OR_InnerRad),0]]);
			}}
		else if(Mount_Style==2){
			translate([0,0,-(OR_OuterRad/2)]){
			linear_extrude (height=OD + OR_OuterRad){
			polygon(points=[[-(T+28BYJ48_Gap),0],[-(T+28BYJ48_Gap),-(OR_OuterRad-OR_InnerRad)],
					[(OR_OuterRad-OR_InnerRad),-(OR_OuterRad-OR_InnerRad)],[(OR_OuterRad-OR_InnerRad),0]]);
			}}
		}
		}
		//Mount Hole for joining to Pump Mount
		translate([-((T/2)+28BYJ48_Gap),0,OR_OuterRad]){
		rotate([90,90,0])
				{
					if(Mount_Style==1){
					translate([(OR_OuterRad-(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-(OR_OuterRad-(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
				} else if(Mount_Style==2){
					translate([(OR_OuterRad+(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-(OR_OuterRad+(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
				}
				}
		}

		//Mount Hole for Motor
		translate([0,(OR_OuterRad+(OR_OuterRad-OR_InnerRad))-8,OR_OuterRad]){
		rotate([90,0,90])
				{
					translate([0,17.5,0]) cylinder(r=2.1,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([0,-17.5,0]) cylinder(r=2.1,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([0,0,0]) cylinder(r=14.5,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-14,0,0]) cube(size = [9,18,(2.5*OR_OuterRad)], center = true);;
				}
		}
		
		}
		}
		}
	}
}

union()
{
	if (Mount_Enabled!=0)
	{
		//Compact Mount: Contain small bridge for side openning not an issue
		//  with small pump but must check it is you do big one ** Stonedge
		if (Mount_Style==1)
		{
		difference()
		{
			linear_extrude (height=T)
			{
      		polygon(points=[[-(OR_OuterRad),0],[-(OR_InnerRad),0],
				[-(OR_InnerRad),-(OR_InnerRad)],[(OR_InnerRad),-(OR_InnerRad)],
				[(OR_InnerRad),0],[(OR_OuterRad),0], [(OR_OuterRad),-(OR_OuterRad)],
				[-(OR_OuterRad),-(OR_OuterRad)]]);
			}
			translate([0,0,T/2])
			{
				rotate([90,0,90])
				{
					hull()
					{
						translate([-(T/6),0,0]) cylinder(r=T/6,h=(2.5*OR_OuterRad),center=true);
						translate([-(OR_InnerRad-(T/6)),0,0]) cylinder(r=T/6,h=(2.5*OR_OuterRad),center=true);
					}
				}
				rotate([90,0,0])
				{
					translate([(OR_OuterRad-(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-(OR_OuterRad-(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
				}
			}
	
		}
		}
		// Standard Mount: Bracket goes out of the OuterDiameter by 1/4 of the OD on
		// each side, not bridge so better choice for big pump
		if (Mount_Style==2)
		{
		difference()
		{
			linear_extrude (height=T)
			{
      		polygon(points=[[-(OR_OuterRad),0],[-(OR_InnerRad),0],
				[-(OR_InnerRad),-(OR_InnerRad)],[(OR_InnerRad),-(OR_InnerRad)],
				[(OR_InnerRad),0],[(OR_OuterRad),0], [(OR_OuterRad),-(OR_InnerRad)],
				[(OR_OuterRad + OR_OuterRad/2),-(OR_InnerRad)],
				[(OR_OuterRad + OR_OuterRad/2),-(OR_OuterRad)],
				[-(OR_OuterRad + OR_OuterRad/2),-(OR_OuterRad)],
				[-(OR_OuterRad + OR_OuterRad/2),-(OR_InnerRad)],
				[-(OR_OuterRad),-(OR_InnerRad)]]);
			}
			translate([0,0,T/2])
			{
				rotate([90,0,0])
				{
					translate([(OR_OuterRad+(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
					translate([-(OR_OuterRad+(OR_OuterRad/4)),0,0]) cylinder(r=Mount_hole_dia/2,h=(2.5*OR_OuterRad),center=true,$fn=100);
				}
			}
	
		}
		}
	}

	translate([0,0,T/2])
	{
	
   // outer ring
	difference()
	{
		// HACK: Add tubing depth clearance value to the total OD, otherwise the outer part may be too thin. FIXME: This is a quick n dirty way and makes the actual OD not match what the user entered...
		cylinder(r=D/2 + tubing_depth_clearance,h=T,center=true,$fn=100);
		exitholes(outerring_outer_radius-tubing_od/4,tubing_od, len=100);
		union()
		{
			// HACK: On my printer, it seems to need extra clearance for the outside gear, trying double...
			herringbone(nr,pitch,P,DR,-2*tol,helix_angle,T+0.2);
			cylinder(r=outerring_outer_radius+tubing_depth_clearance,h=tubing_squished_width,center=true,$fn=100);
			// overhang removal for top teeth of outer ring: create a frustum starting at the top surface of the "roller" cylinder 
			// (which will actually be cut out of the outer ring) and shrinking inward at the allowed overhang angle until it reaches the
			// gear root diameter.
			translate([0, 0, tubing_squished_width/2])
			{
				cylinder(r1=outerring_outer_radius+tubing_depth_clearance, r2=outerring_depth,h=abs(outerring_outer_radius+tubing_depth_clearance - outerring_depth)/tan(allowed_overhang*90),center=false,$fn=100);
			}
		}
	}
}
}
translate([0,0,T/2])
{

	// sun gear
	rotate([0,0,(np+1)*180/ns+phi*(ns+np)*2/ns])
	
	difference()
	{

		// the gear with band cut out of the middle
		difference()
		{
			mirror([0,1,0])
				herringbone(ns,pitch,P,DR,tol,helix_angle,T);
				// center hole
				// Here Math for Calculating Smallest Circle around multiface shaft
				// for a triangle face to edge mesure = 2*((3*(mesure in mm) / 2)/sqrt(3));
				// for a square face 2 face mesure = sqrt(2)*(mesure in mm);
				// for hexa(6) face 2 face mesure = (((mesure in mm)/sqrt(3))*2); 
				// for octo(8) face 2 face mesure = 0.5*(sqrt(2+sqrt(2)))*(mesure in mm);

				linear_extrude (height=T+1,center=true){
				
		 			// Round Shaft
					if (CenterHole_Num_of_Flat == 0){
							circle(d=CenterHole_dia,center=true,$fn=30);
					} else// Single flat Shaft
					if (CenterHole_Num_of_Flat == 1){
						intersection() {
        			circle(d=CenterHole_dia,center=true,$fn=30);
						translate([0,-((CenterHole_dia-CenterHole_Flat_dia)/2)]) square([CenterHole_dia,CenterHole_Flat_dia],center=true);
						}
					} else
					// Double Flat Shaft
					if (CenterHole_Num_of_Flat == 2){
						intersection() {
        					circle(d=CenterHole_dia,center=true,$fn=30);
							square([CenterHole_dia,CenterHole_Flat_dia],center=true);
						}
					} else
					// triangle
					if (CenterHole_Num_of_Flat == 3){
						circle(d=2*((3*(CenterHole_Flat_dia) / 2)/sqrt(3)),center=true,$fn=CenterHole_Num_of_Flat);
					} else
					// Square
					if (CenterHole_Num_of_Flat == 4){
						circle(d=sqrt(2)*(CenterHole_Flat_dia),center=true,$fn=CenterHole_Num_of_Flat);
					} else
					// Pentagon
					if (CenterHole_Num_of_Flat == 5){
						circle(d=2*(CenterHole_Flat_dia/(1+cos(PI/5))),center=true,$fn=CenterHole_Num_of_Flat);
					} else
					// Hexagon
					if (CenterHole_Num_of_Flat == 6){
						circle(d=(((CenterHole_Flat_dia)/sqrt(3))*2),center=true,$fn=CenterHole_Num_of_Flat);
					} else
					//Heptagon
					if (CenterHole_Num_of_Flat == 7){
						circle(d=2*(CenterHole_Flat_dia/(1+cos(PI/7))),center=true,$fn=CenterHole_Num_of_Flat);
					} else
					// Octogon
					if (CenterHole_Num_of_Flat == 8){
						circle(d=0.5*(sqrt(2+sqrt(2)))*(CenterHole_Flat_dia),center=true,$fn=CenterHole_Num_of_Flat);
					} else
						{
						circle(d=CenterHole_dia,center=true,$fn=CenterHole_Num_of_Flat);
					}
						
// for multi face is the dia of de smalless circle that cold go around the shaft ( edge to edge mesure for shaft with pair number of face(4+)) 
        	
    			}

				// gap for planet squeezer surface
				difference()
				{
					cylinder(r=sun_outer_radius,h=tubing_squished_width,center=true,$fn=100);
					cylinder(r=sun_min_radius-tol,h=tubing_squished_width,center=true,$fn=100);
				}
		}

		// on the top part, cut an angle on the underside of the gear teeth to keep the overhang to a feasible amount
		translate([0, 0, tubing_squished_width/2])
		{
			difference()
			{
				// in height, numeric constant sets the amount of allowed overhang after trim.
				//h=abs((sun_min_radius-tol)-sun_outer_radius)*(1-allowed_overhang)
				// h=tan(allowed_overhang*90)
				cylinder(r=sun_outer_radius,h=abs((sun_min_radius-tol)-sun_outer_radius)/tan(allowed_overhang*90),center=false,$fn=100);
				cylinder(r1=sun_min_radius-tol, r2=sun_outer_radius,h=abs((sun_min_radius-tol)-sun_outer_radius)/tan(allowed_overhang*90),center=false,$fn=100);
			}
		}
	
	}



	// planet gears

	for(i=[1:m])
	{

		rotate([0,0,i*360/m+phi])
		{
		
			translate([pitchD/2*(ns+np)/nr,0,0])
			{
				rotate([0,0,i*ns/m*360/np-phi*(ns+np)/np-phi])
				{
					union()
					{
						herringbone(np,pitch,P,DR,tol,helix_angle,T);
						// Add a roller cylinder in the center of the planet gears.
						// But also constrain overhangs to a sane level, so this is kind of a mess...
						intersection()
						{
							// the cylinder itself
							cylinder(r=planet_outer_radius,h=tubing_squished_width-tol,center=true,$fn=100);

							// Now deal with overhang on the underside of the planets' roller cylinders.
							// create the outline of a gear where the herringbone meets the cylinder;
							// make its angle match the twist at this point.
							// Then difference this flat gear from a slightly larger cylinder, extrude it with an
							// outward-growing angle, and cut the result from the cylinder.
							planet_overhangfix(np, pitch, P, DR, tol, helix_angle, T, tubing_squished_width, allowed_overhang);

						}

					}

				}
			}
		}
	}
	
}


module planet_overhangfix(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	depth_ratio=1,
	clearance=0,
	helix_angle=0,
	gear_thickness=5,
	tubing_squished_width,
	allowed_overhang)
{

	height_from_bottom =  (gear_thickness/2) - (tubing_squished_width/2);
	pitch_radius = number_of_teeth*circular_pitch/(2*PI);
	twist=tan(helix_angle)*height_from_bottom/pitch_radius*180/PI; // the total rotation angle at that point - should match that of the gear itself



	translate([0,0, -tubing_squished_width/2]) // relative to center height, where this is used
	{
		// FIXME: This calculation is most likely wrong...
		//rotate([0, 0, helix_angle * ((tubing_squished_width-(2*tol))/2)])
		rotate([0, 0, twist])
		{
			// want to extrude to a height proportional to the distance between the root of the gear teeth
			// and the outer edge of the cylinder
			linear_extrude(height=tubing_squished_width-clearance,twist=0,slices=6, scale=1+(1/(1-allowed_overhang)))
			{
				gear2D(number_of_teeth=number_of_teeth, circular_pitch=circular_pitch, pressure_angle=pressure_angle, depth_ratio=depth_ratio, clearance=clearance);
			}
		}
	}
}

module exitholes(distance_apart, hole_diameter)
{
	translate([distance_apart, len/2, 0])
	{
		rotate([90, 0, 0])
		{
			cylinder(r=hole_diameter/2,h=len,center=true,$fn=100);
		}
	}
	
	mirror([1,0,0])
	{
		translate([distance_apart, len/2, 0])
		{
			rotate([90, 0, 0])
			{
				cylinder(r=hole_diameter/2,h=len,center=true,$fn=100);
			}
		}
	}
}

module rack(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	helix_angle=0,
	clearance=0,
	gear_thickness=5,
	flat=false){
addendum=circular_pitch/(4*tan(pressure_angle));

flat_extrude(h=gear_thickness,flat=flat)translate([0,-clearance*cos(pressure_angle)/2])
	union(){
		translate([0,-0.5-addendum])square([number_of_teeth*circular_pitch,1],center=true);
		for(i=[1:number_of_teeth])
			translate([circular_pitch*(i-number_of_teeth/2-0.5),0])
			polygon(points=[[-circular_pitch/2,-addendum],[circular_pitch/2,-addendum],[0,addendum]]);
	}
}

//module monogram(h=1)
//linear_extrude(height=h,center=true)
//translate(-[3,2.5])union(){
//	difference(){
//		square([4,5]);
//		translate([1,1])square([2,3]);
//	}
//	square([6,1]);
//	translate([0,2])square([2,1]);
//}

module herringbone(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	depth_ratio=1,
	clearance=0,
	helix_angle=0,
	gear_thickness=5){
union(){
	//translate([0,0,10])
	gear(number_of_teeth,
		circular_pitch,
		pressure_angle,
		depth_ratio,
		clearance,
		helix_angle,
		gear_thickness/2);
	mirror([0,0,1])
		gear(number_of_teeth,
			circular_pitch,
			pressure_angle,
			depth_ratio,
			clearance,
			helix_angle,
			gear_thickness/2);
}}

module gear (
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	depth_ratio=1,
	clearance=0,
	helix_angle=0,
	gear_thickness=5,
	flat=false){
pitch_radius = number_of_teeth*circular_pitch/(2*PI);
twist=tan(helix_angle)*gear_thickness/pitch_radius*180/PI;

flat_extrude(h=gear_thickness,twist=twist,flat=flat)
	gear2D (
		number_of_teeth,
		circular_pitch,
		pressure_angle,
		depth_ratio,
		clearance);
}

module flat_extrude(h,twist,flat){
	if(flat==false)
		linear_extrude(height=h,twist=twist,slices=twist/6, scale=1)children(0);
	else
		children(0);
}

module gear2D (
	number_of_teeth,
	circular_pitch,
	pressure_angle,
	depth_ratio,
	clearance){
pitch_radius = number_of_teeth*circular_pitch/(2*PI);
base_radius = pitch_radius*cos(pressure_angle);
depth=circular_pitch/(2*tan(pressure_angle));
outer_radius = clearance<0 ? pitch_radius+depth/2-clearance : pitch_radius+depth/2;
root_radius1 = pitch_radius-depth/2-clearance/2;
root_radius = (clearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
backlash_angle = clearance/(pitch_radius*cos(pressure_angle)) * 180 / PI;
half_thick_angle = 90/number_of_teeth - backlash_angle/2;
pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
min_radius = max (base_radius,root_radius);

intersection(){
	rotate(90/number_of_teeth)
		circle($fn=number_of_teeth*3,r=pitch_radius+depth_ratio*circular_pitch/2-clearance/2);
	union(){
		rotate(90/number_of_teeth)
			circle($fn=number_of_teeth*2,r=max(root_radius,pitch_radius-depth_ratio*circular_pitch/2-clearance/2));
		for (i = [1:number_of_teeth])rotate(i*360/number_of_teeth){
			halftooth (
				pitch_angle,
				base_radius,
				min_radius,
				outer_radius,
				half_thick_angle);		
			mirror([0,1])halftooth (
				pitch_angle,
				base_radius,
				min_radius,
				outer_radius,
				half_thick_angle);
		}
	}
}}

module halftooth (
	pitch_angle,
	base_radius,
	min_radius,
	outer_radius,
	half_thick_angle){
index=[0,1,2,3,4,5];
start_angle = max(involute_intersect_angle (base_radius, min_radius)-5,0);
stop_angle = involute_intersect_angle (base_radius, outer_radius);
angle=index*(stop_angle-start_angle)/index[len(index)-1];
p=[[0,0],
	involute(base_radius,angle[0]+start_angle),
	involute(base_radius,angle[1]+start_angle),
	involute(base_radius,angle[2]+start_angle),
	involute(base_radius,angle[3]+start_angle),
	involute(base_radius,angle[4]+start_angle),
	involute(base_radius,angle[5]+start_angle)];

difference(){
	rotate(-pitch_angle-half_thick_angle)polygon(points=p);
	square(2*outer_radius);
}}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / PI;

// Calculate the involute position for a given base radius and involute angle.

function involute (base_radius, involute_angle) =
[
	base_radius*(cos (involute_angle) + involute_angle*PI/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*PI/180*cos (involute_angle))
];