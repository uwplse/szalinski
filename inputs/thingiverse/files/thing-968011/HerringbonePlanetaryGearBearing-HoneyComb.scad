// Herringbone Planetary gear bearing (customizable)

echo("------------------------ BEGIN ------------------------");

// (Diameter of the outer cylinder)
OuterWheelDiameter  = 65;
// (Ring gear cut out diameter from the outer wheel)
RingGearDiameter   	= 60;
Thickness           = 18; 
// (separation between the gear teeth)
Clearance           = 0.4;
Planets             = 5;
PlanetTeethCount    = 8;
SunToothCountEstimate  = 10;
// (The involute gear teeth pressure angle of obliquity)
PressureAngle       = 45;
// (The # of teeth each gear tooth will cross helically)
TeethToTwistAcross  = 0.9;
// (0=NoFill; The size of the HoneyComb holes )
Infill_HoleSize     = 2;
// (Changes Honeycomb wall thickness)
Infill_Strength		= 33;
// (The outer edge wall thickness of the HoneyComb)
Infill_BorderSize	= 1;
// (Effects # of vertices via involute tooth steps & # of slices per gear extrude)
Precision			= 11;
// (0=NoHole; The HEX hole width in the sun gear)
CenterHEXHoleWidth  = 6.7;
// (Add a Keychain holder on the outside)
Keychain = "no"; // [yes, no]
// The thickness of the KeyChainHole
KeychainThickness = 5;

// PRECALCULATIONS --------------------------------------------------------
InFill_HoleStep = (Infill_HoleSize*3.5) + (((Infill_Strength/100)*(Infill_HoleSize*4)));
MaxTeethDepthRatio = 0.5*1;
PiExact = 1*3.141592653589793238462643383279502884197169399375105820974944592307816406286;
PlanetCount = round(Planets);
PlanetToothCount = round(PlanetTeethCount);
PlanetToothCount_Step1 = round(2/PlanetCount*(SunToothCountEstimate+PlanetToothCount));
PlanetToothCount_Step2 = PlanetToothCount_Step1*PlanetCount%2!=0 ? PlanetToothCount_Step1+1 : PlanetToothCount_Step1;
SunToothCount = PlanetToothCount_Step2*PlanetCount/2-PlanetToothCount;
RingToothCount=SunToothCount+2*PlanetToothCount;
pitchD=0.9*RingGearDiameter/(1+min(PiExact/(2*RingToothCount*tan(PressureAngle)),PiExact*MaxTeethDepthRatio/RingToothCount));
Pitch=pitchD*PiExact/RingToothCount;
helix_angle=atan(2*TeethToTwistAcross*Pitch/Thickness);
phi = $t * 360 / PlanetCount;
PlanetOffset = pitchD/2*(SunToothCount+PlanetToothCount)/RingToothCount;
PlanetRotationMultiplier = SunToothCount/PlanetCount*360/PlanetToothCount-phi*(SunToothCount+PlanetToothCount)/PlanetToothCount-phi;


// USER INFO --------------------------------------------------------------
echo("Planets",Planets);

echo("SunToothCount",SunToothCount);
echo("PlanetToothCount",PlanetTeethCount);
echo("RingToothCount", RingToothCount);

echo("PlanetOffset",PlanetOffset);

echo("RingGearDiameter",RingGearDiameter);
echo("Thickness",Thickness);
echo("Clearance",Clearance);

echo("TeethToTwistAcross",TeethToTwistAcross);
echo("helix_angle=",helix_angle);
echo("PressureAngle",PressureAngle);
echo("Pitch",Pitch);

echo("CenterHEXHoleWidth",CenterHEXHoleWidth);


// PRIMARY BUILD ----------------------------------------------------------
translate([0,0,Thickness/2]){
    // OUTER RING GEAR
	difference(){
        //cylinder(r=OuterWheelDiameter/2,h=Thickness,center=true,$fn=(Precision*10));
		
		union()
			{
				pitch_radius 		= RingToothCount*Pitch/(2*PiExact);
				depth 				= Pitch/(2*tan(PressureAngle));
				outer_radius 		= Clearance<0 ? pitch_radius+depth/2-Clearance : pitch_radius+depth/2;
			
				//RingGearDiameter/2
				cylinder(r=outer_radius+Infill_BorderSize+0.5,h=Thickness,center=true,$fn=(Precision*10));
				Infill_Cylinder(IRadius=OuterWheelDiameter/2,IHeight=Thickness,IPrecision=Precision,
								IHoleSize=Infill_HoleSize, IHoleStep=InFill_HoleStep, IBorderSize=Infill_BorderSize);	
			}
		
		herringbone(RingToothCount,Pitch,PressureAngle,MaxTeethDepthRatio,-Clearance,helix_angle,Thickness+0.2);
	}
    // SUN GEAR
	rotate([0,0,(PlanetToothCount+1)*180/SunToothCount+phi*(SunToothCount+PlanetToothCount)*2/SunToothCount])
	difference(){
		mirror([0,1,0])
			herringbone_adv(SunToothCount,Pitch,PressureAngle,MaxTeethDepthRatio,Clearance,helix_angle,Thickness,
							Infill_HoleSize, Infill_Strength, Infill_BorderSize, CenterHEXHoleWidth);
	}
    // PLANET GEARS
	for(i=[1:PlanetCount])
     rotate([0,0,i*360/PlanetCount+phi])
      translate([PlanetOffset,0,0])
       rotate([0,0,i*PlanetRotationMultiplier])
		herringbone_adv(PlanetToothCount,Pitch,PressureAngle,MaxTeethDepthRatio,Clearance,helix_angle,Thickness,
						Infill_HoleSize, Infill_Strength, Infill_BorderSize, 0);
    
	// KEYCHAIN TORUS
	if( Keychain == "yes")
	{ 
		echo("DRAWING KEYHOLE");
		
		translate([(OuterWheelDiameter/2)+(KeychainThickness*1.5), 0, -(Thickness/2)+(KeychainThickness/2)])
			CreateKeyChainTab(KeychainThickness);
	}
}

module CreateKeyChainTab(KeychainHoleThickness = 5)
{
	difference()
	{
		union()
		{
			// Base
			translate([-(KeychainHoleThickness/2),0, 0])
				cube([KeychainHoleThickness*3,KeychainHoleThickness*2,KeychainHoleThickness], center = true);
			
			// Endcap
			translate([KeychainHoleThickness,0, 0])
			rotate([90,0,0])
				cylinder(d = KeychainHoleThickness, h=(KeychainHoleThickness*2), center = true, $fn=(Precision*10));
			
			// Side1
			translate([-(KeychainHoleThickness/2),KeychainHoleThickness, 0])					
			rotate([0,90,0])
				cylinder(d = KeychainHoleThickness, h=(KeychainHoleThickness*3), center = true, $fn=(Precision*10));
			
			// Side2
			translate([-(KeychainHoleThickness/2),-(KeychainHoleThickness), 0])					
			rotate([0,90,0])
				cylinder(d = KeychainHoleThickness, h=(KeychainHoleThickness*3), center = true, $fn=(Precision*10));
			
			// Corner1
			translate([(KeychainHoleThickness),(KeychainHoleThickness), 0])								
				sphere(d = KeychainHoleThickness, $fn=(Precision*10));
			
			// Corner2
			translate([(KeychainHoleThickness),-(KeychainHoleThickness), 0])								
				sphere(d = KeychainHoleThickness, $fn=(Precision*10));
		}
		
		color("Red")
		translate([0,0, -(KeychainHoleThickness)])
			cylinder(r = KeychainHoleThickness/1.75, h=(KeychainHoleThickness*2), $fn=(Precision*10));
	}
}

module Infill_Cylinder(IRadius=10,IHeight=10,IPrecision=10, IHoleSize=3.5, IHoleStep=10, IBorderSize=3 )
{
	union()
	{
		difference()
		{
			cylinder(r=IRadius,h=IHeight,center=true,$fn=(IPrecision*10));
			
			Infill_Cylinder_Pattern(IC_Radius=IRadius, IC_Height=IHeight+1, IC_Precision=IPrecision, HoleSize=IHoleSize, HoleStep=IHoleStep);
		}
		
		difference()
		{
			// Hole border
			cylinder(r=IRadius,h=IHeight,center=true,$fn=(IPrecision*10));
			// Hole
			cylinder(r=IRadius-IBorderSize,h=IHeight+1,center=true,$fn=(IPrecision*10));
		}
	}
}


module herringbone_adv( number_of_teeth=15, circular_pitch=10, pressure_angle=28, depth_ratio=1, GearClearance=0, helix_angle=0, gear_GearThickness=5,
						Infill_HoleSize, Infill_Strength, Infill_BorderSize, CenterHEXHoleWidth)
{
	union()
		{
			difference()
			{
				// herringbone gear
				herringbone(number_of_teeth,circular_pitch,pressure_angle,depth_ratio,GearClearance,helix_angle,gear_GearThickness);
				
				// center hole (HEX)
				cylinder(r=CenterHEXHoleWidth/sqrt(3),h=gear_GearThickness+1,center=true,$fn=6);
				
				 pitch_radius 	= number_of_teeth*circular_pitch/(2*PiExact);
				 base_radius 	= pitch_radius*cos(pressure_angle);
				 depth 			= circular_pitch/(2*tan(pressure_angle));
				 root_radius1 	= pitch_radius-depth/2-GearClearance/2;
				 root_radius 	= (GearClearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
				 min_radius 	= max (base_radius,root_radius);
				
				// InFill Honeycomb
				Infill_Cylinder_Pattern(IC_Radius=  min_radius-Infill_BorderSize, IC_Height=gear_GearThickness+2, IC_Precision=Precision, 
								HoleSize=Infill_HoleSize, HoleStep=InFill_HoleStep);
			}
		
			// center hole (HEX)
			if(CenterHEXHoleWidth > 0)
			{
				difference()
				{
					// Hole border
					cylinder(r=CenterHEXHoleWidth/sqrt(3)+Infill_BorderSize,h=gear_GearThickness,center=true,$fn=(Precision*10));//6);
					// Hole
					cylinder(r=CenterHEXHoleWidth/sqrt(3),h=gear_GearThickness+1,center=true,$fn=6);
				}
			}
		}
}

module Infill_Cylinder_Pattern( IC_Radius=10, IC_Height=10, IC_Precision=10, HoleSize=3, HoleStep=3 )
{
    if(HoleSize>0)
	{
	
	// https://en.wikipedia.org/wiki/Circle_packing#Packings_in_the_plane
	// For further examination try:  https://en.wikipedia.org/wiki/Hexagonal_lattice
	HoneyCombRatio = PiExact/(2*sqrt(3));	
	
	intersection()
	{
		cylinder(r=IC_Radius, h=IC_Height, center=true, $fn=(IC_Precision*10));

		//HONEYCOMB EXTRUSION PATTERN
		union()
		{
			StartPosition = (IC_Radius+HoleStep);
			XStep = (HoleStep*HoneyCombRatio);
			YStep = (HoleStep*0.5);			
			XOffset = StartPosition - (floor(StartPosition / XStep)*XStep);
			YOffset = StartPosition - (floor(StartPosition / YStep)*YStep);
			
			for(x=[-StartPosition+XOffset:XStep:IC_Radius+HoleStep])
			{
				for(y=[-StartPosition+YOffset:YStep:IC_Radius+HoleStep])
				{
					translate([x,y,0])
						cylinder(r=HoleSize, h=IC_Height+2, center=true, $fn=6);

					translate([x+(HoleStep*(0.5*HoneyCombRatio)),y+(HoleStep*0.75),0])
						cylinder(r=HoleSize, h=IC_Height+2, center=true, $fn=6);
				}
			}
		}
	}
	}
}

// MODULES & FUNCTIONS ----------------------------------------------------
module herringbone( number_of_teeth=15, circular_pitch=10, pressure_angle=28, depth_ratio=1, clearance=0, helix_angle=0, gear_thickness=5)
{
	union()
	{
		gear(number_of_teeth, circular_pitch, pressure_angle, depth_ratio, clearance, helix_angle, gear_thickness/2);
		mirror([0,0,1])
			gear(number_of_teeth, circular_pitch, pressure_angle, depth_ratio, clearance, helix_angle, gear_thickness/2);
	}
}

module gear( number_of_teeth=15, circular_pitch=10, pressure_angle=28, depth_ratio=1, clearance=0, helix_angle=0, gear_thickness=5, flat=false)
{
	pitch_radius = number_of_teeth*circular_pitch/(2*PiExact);
	twist=tan(helix_angle)*gear_thickness/pitch_radius*180/PiExact;

	flat_extrude(h=gear_thickness,twist=twist,flat=flat)
		gear2D( number_of_teeth, circular_pitch, pressure_angle, depth_ratio, clearance);
}

module flat_extrude(h,twist,flat)
{
	if(flat==false)
		linear_extrude(height=h,twist=twist,slices=Precision)
            children(0);
	else
		children(0);
}

module gear2D( number_of_teeth, circular_pitch, pressure_angle, depth_ratio, clearance)
{
	pitch_radius 		= number_of_teeth*circular_pitch/(2*PiExact);
	base_radius 		= pitch_radius*cos(pressure_angle);
	depth 				= circular_pitch/(2*tan(pressure_angle));
	outer_radius 		= clearance<0 ? pitch_radius+depth/2-clearance : pitch_radius+depth/2;
	root_radius1 		= pitch_radius-depth/2-clearance/2;
	root_radius 		= (clearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
	backlash_angle 		= clearance/(pitch_radius*cos(pressure_angle)) * 180 / PiExact;
	half_thick_angle	= 90/number_of_teeth - backlash_angle/2;
	pitch_point 		= involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle 		= atan2 (pitch_point[1], pitch_point[0]);
	min_radius 			= max (base_radius,root_radius);

	intersection()
	{
		rotate(90/number_of_teeth)
			circle($fn=number_of_teeth*3,r=pitch_radius+depth_ratio*circular_pitch/2-clearance/2);
		union()
		{
			rotate(90/number_of_teeth)
				circle($fn=number_of_teeth*2, r=max(root_radius,pitch_radius-depth_ratio*circular_pitch/2-clearance/2));
				
			for (i = [1:number_of_teeth])rotate(i*360/number_of_teeth)
			{
				halftooth( pitch_angle, base_radius, min_radius, outer_radius, half_thick_angle);		
				mirror([0,1])
					halftooth ( pitch_angle, base_radius, min_radius, outer_radius, half_thick_angle);
			}
		}
	}
}


module halftooth( pitch_angle, base_radius, min_radius, outer_radius, half_thick_angle)
{	
	index = [ for (i = [0 : 1 : Precision]) i ];

	start_angle = max(involute_intersect_angle (base_radius, min_radius)-5,0);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);
	angle = index*(stop_angle-start_angle)/index[len(index)-1];
	
	p = concat([[0,0]],[for (a = [ 0 : len(angle) - 1 ]) involute(base_radius,angle[a]+start_angle) ]);

	difference(){
		rotate(-pitch_angle-half_thick_angle)polygon(points=p);
		square(2*outer_radius);
	}
}

// MATH FUNCTIONS -----------------------------------------------------
// Find the angle of the involute about the base radius at the given distance (radius) from it's center.
// source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html
function involute_intersect_angle(base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / PiExact;

// Calculate the involute position for a given base radius and involute angle.
function involute (base_radius, involute_angle) =
[
	base_radius*(cos (involute_angle) + involute_angle*PiExact/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*PiExact/180*cos (involute_angle))
];

echo("------------------------- END -------------------------");
