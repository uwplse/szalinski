///////////////////////////////////////////////////////////////////////////////////////////
//
// dlb5's Mod to add hole for M3, M4 or any other Screw Grub and to be used as motor pinion in RC cars
//
///////////////////////////////////////////////////////////////////////////////////////////
// Public Domain Modulus Gear OpenSCAD code
// version 1.0
// This code defines a gear based on its modulus rather than pitch in mm,
// Modulus is the ration of tooth count:diameter, effectively the pitch of the gear is 
// modulus * pi 
// ie, a gear of mod=1 has a tooth pitch of 3.1514mm.
//
// The advantage of using modulus rather than pitch to define a gear is that it is very easy to
// prototype - for example, a gear of mod = 1 will have a diamter that matches the tooth count. 
// with mod = 2, radius = tooth count.
// 
// This code is based on the poblic domain Parametric Involute Spur Gear code by Leemon Baird
//found at http://www.thingiverse.com/thing:5505 
//////////////////////////////////////////////////////////////////////////////////////////////
// 
// Since the original file was public domain, this file is public domain as well.  
// Use it for any purpose, including commercial applications.  Attribution would be nice,
// but is not required.  There is no warranty of any kind, including its correctness, 
// usefulness, or safety.
// 
//////////////////////////////////////////////////////////////////////////////////////////////
// An involute spur gear based on Modulus, with reasonable defaults for all the parameters.
// Normally, you should just choose the first 4 parameters, and let the rest be default values.
// Meshing gears must match mod, pressure_angle, and twist. Geras should be separated by the 
// sum of their radii, where gear radius = mod * tooth count.
//////////////////////////////////////////////////////////////////////////////////////////////


// for 1/8 1/10 RC Cars. You should be able to generate with it most of the common compatible pinion gears for your RC Cars. Most important parameter is Modulus. I originally designed this to use Mod1. Second most important one would be the Center Hole Diameter, the same as your motor shaft. Finally in the most important category would be number of teeth. Don't forget to adapt hub diameter after setting the previous 3 params to avoid hiding the teeth with the hub. Now you can create a D-shaped center hole or create another hole for a M3 or M4 grub screw. Also you can use a key to fix the pinion to your 'special' shaft
This_is_a_Motor_Pinion_Gear_Generator = "";
//Select your pitch from the list below
Modulus				= 1     ;//[1:Mod1,0.8:Mod0.8,0.6:Mod0.6,0.8096:32p,0.5397:48p]
//3.3 should fit 3.17mm shafts, while 5.1 should fit 5mm shafts
Center_Hole_Diameter= 3.3	;//[3.3:for 3.17mm motor shaft,5.1:for 5mm motor shaft]
//number of teeth of your pinion gear
Tooth_Count 		= 14	;//[10:1:23]  
//modify gear thickness if you need it
Gear_Thickness 		= 7 	;//[4:0.2:20]

//12 is fine for M1 pinions >13T, use 8 for T10, 9 for T11,and 10 for T12 and T13
Hub_Diameter		= 12	;//[8,9,10,11,12]
//The hub height or thickness
Hub_Extension 		= 7 	;//[0:0.2:30]
// Select your shaft diameter to make the hole D-shaped or No for round hole
Use_D_Shaped_Hole   = 0     ;//[0:No, 0.35:for 3.17mm motor shaft,0.5:for 5mm motor shaft]
//Select if you want to use a M3 or M4 grub screw to fix pinion to the shaft, or if you don't want
Use_Grub_Screw      = 2.85  ;//[2.85:M3,3.85:M4,0:No]
//distance in mm from screw grub hole side to teeth
Grub_Screw_Extra_Height  = 1;//[0.4:0.2:4]
//Gear_Twist		= 0  	;//[0:0.5:360]
//Hidden_Teeth		= 0    	;//[0:1:20]
//Rim_Size 			= 5		;//[1:0.1:10]
//Number_of_Spokes 	= 5		;//[1:1:10]
Tooth_Pressure_Angle= 20	;//[14.5, 20, 28,]
Keyway_Height		= 0		;//[0:0.1:10]
Keyway_width		= 0		;//[0:0.1:8]
//Center_Bore_Shape	= 64	;//[100:round, 6:Hexagon, 4:square]


// Call the modgear module to create the gear using the parameters define above
// If using this as a library, you can delete this, or put a * before modgear to hide it.
modgear (
	mod    			= Modulus,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
	number_of_teeth = Tooth_Count,   //total number of teeth around the entire perimeter
	thickness       = Gear_Thickness,    //thickness of gear in mm
	hole_diameter   = Center_Hole_Diameter,    //diameter of the hole in the center, in mm
	twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
	teeth_to_hide   = 0,    //number of teeth to delete to make this only a fraction of a circle
	pressure_angle  = Tooth_Pressure_Angle,   //Controls how straight or bulged the tooth sides are. In degrees.
	clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
	backlash        = 0.0,  //gap between two meshing teeth, in the direction along the circumference of the pitch circle
	rim				= 3 , 	//thickness of rim supporting the gear teeth
	hub_diameter	= Hub_Diameter,	//diameter of hub
	hub_extension	= Hub_Extension , 	//extension of hub beyond gear thickness
	spoke_num 		= 48 ,	//number of spokes
	keyway			= [Keyway_Height,Keyway_width],
    hole_polygon    = 64,
	grub_diam       = Use_Grub_Screw,
    grub_extra_h    = Grub_Screw_Extra_Height,
    dshaftoffset    = Use_D_Shaped_Hole
    
);




//these 4 functions are used by modgear 
function polar(r,theta)   = r*[sin(theta), cos(theta)];                            //convert polar to cartesian coordinates
function iang(r1,r2)      = sqrt((r2/r1)*(r2/r1) - 1)/3.1415926*180 - acos(r1/r2); //unwind a string this many degrees to go from radius r1 to radius r2
function q7(f,r,b,r2,t,s) = q6(b,s,t,(1-f)*max(b,r)+f*r2);                         //radius a fraction f up the curved side of the tooth 
function q6(b,s,t,d)      = polar(d,s*(iang(b,d)+t));                              //point at radius d on the involute curve



//*****************************************************

module modgear (
	mod    			= 1,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
	number_of_teeth = 15,   //total number of teeth around the entire perimeter
	thickness       = 6,    //thickness of gear in mm
	hole_diameter   = 3.3,    //diameter of the hole in the center, in mm
	twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
	teeth_to_hide   = 0,    //number of teeth to delete to make this only a fraction of a circle
	pressure_angle  = 20,   //Controls how straight or bulged the tooth sides are. In degrees.
	clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
	backlash        = 0.0,  //gap between two meshing teeth, in the direction along the circumference of the pitch circle
	rim				= 5 , 	//thickness of rim supporting the gear teeth
	hub_diameter	= 6,	//diameter of hub
	hub_extension	= 0 , 	//extension of hub beyond gear thickness
	spoke_num 		= 4 ,	//number of spokes
	keyway			= [0,0],
    hole_polygon    = 100,
    grub_diam       = 2.85,
    dshaftoffset    = 2
    
 	
) {
	
    pi = 3.141592653589;
	mm_per_tooth = mod * pi;
	number_of_teeth = floor (abs(number_of_teeth));
	keycut = [ keyway[0] +hole_diameter/2 , keyway[1], 2*(thickness + hub_extension)];
	if (teeth_to_hide > number_of_teeth) {teeth_to_hide = 0;}
	p  = mod * number_of_teeth/ 2; //radius of pitch circle 
	c  = p + mod - clearance ;     //radius of outer circle
	b  = p*cos(pressure_angle);    //radius of base circle
	r  = p-(c-p)-clearance ;       //radius of root circle
	t  = mm_per_tooth/2-backlash/2;                //tooth thickness at pitch circle
	k  = -iang(b, p) - t/2/p/pi*180; {             //angle to where involute meets base circle on each side of tooth
        	//translate ([0,0,thickness+2]) rotate ([0,90,0]) cylinder (h=hub_diameter + 2,r=grub_diam/2,$fn=64);
        
		difference(){	
			
            union() {
				for (i = [0:number_of_teeth - teeth_to_hide-1] )
					rotate([0,0,i*360/number_of_teeth])
						linear_extrude(height = thickness,  convexity = 10, twist = twist)
							polygon(
								points=[
									//[0, -hole_diameter/10],
									polar(r, -181/number_of_teeth),
									polar(r, r<b ? k : -180/number_of_teeth),
									q7(0/5,r,b,c,k, 1),q7(1/5,r,b,c,k, 1),q7(2/5,r,b,c,k, 1),q7(3/5,r,b,c,k, 1),q7(4/5,r,b,c,k, 1),q7(5/5,r,b,c,k, 1),
									q7(5/5,r,b,c,k,-1),q7(4/5,r,b,c,k,-1),q7(3/5,r,b,c,k,-1),q7(2/5,r,b,c,k,-1),q7(1/5,r,b,c,k,-1),q7(0/5,r,b,c,k,-1),
									polar(r, r<b ? -k : 180/number_of_teeth),
									polar(r, 181/number_of_teeth)
								]//,
								//paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]
							);
				difference(){
					cylinder(h=thickness, r=r,  $fn=256);
					translate ([0,0,-2]) cylinder(h=2*thickness+1, r=r-rim,  $fn=256);
				}
				cylinder (h=thickness + hub_extension,r=hub_diameter/2,$fn=256);		// hub
				
				for (i = [0:spoke_num - 1] )		//position the spokes
					rotate([0,0,i*360/spoke_num])
						translate ([-rim/2,0,0])
							cube ([rim,r-2,thickness]);
				
				//translate ([0,0,thickness/2]){
				//	cube ([rim,2*r-2,thickness],center=true);
				//	cube ([2*r-2,rim,thickness],center=true);
				//	}
				
			}
			difference() {
                translate ([0,0,-2])cylinder (h=2*(thickness + hub_extension),r=hole_diameter/2,$fn=hole_polygon);
                translate ([(hole_diameter/2)-(dshaftoffset/2),0,(thickness+hub_extension)/2]) cube ([dshaftoffset,hole_diameter,thickness+hub_extension],center = true);
            }
            translate ([0,0,thickness+(grub_diam/2)+ grub_extra_h]) 
                rotate ([0,90,0]) cylinder (h=hub_diameter + 2,r=grub_diam/2,$fn=64);
            
                
			translate ([hole_diameter/2,0,(thickness + hub_extension-1)]) cube (keycut, center = true);
		}
		
	}
};	
//translate ([(hole_diameter/2)-DshaftOffset,0,0]) 

