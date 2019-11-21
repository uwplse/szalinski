//use <write\\write.scad>
include <write/Write.scad>
//Sphere Charm Customizer
//preview[view:west,tilt:top diagonal]


/* [Charm Body] */
//Sphere diameter in mm
sphere_diameter = 12; //[8:0.1:20]
//Hole diameter
Hole_diameter = 6; //[0:0.1:12]
//Include ridge around the hole?
Hole_ridge = "T"; //["T": Yes,"F": No]


/* [Text] */
Text = "22-10-92";
//Font = "Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
Text_Spacing = 1; //[0.5:0.1:5] 
Text_Height = 4; //[2:0.1:5] 
Text_Depth = 1; //[0.5:0.1:1.5] 
Recessed = "F"; //["T": Yes,"F": No]
Rotate_text = 0; // [0:90]
Rotation = Rotate_text * -1;

/* [Hidden] */
//Amount shaved from top and bottom
flatten = 1; //[0.5:0.1:5]

r=sphere_diameter/2;  //outer radius
down=-(r-flatten);
top=r-flatten;
cylinder=Hole_diameter/2;    //cylinder radius

//Ridge thickness
Ridge_Thickness = .75; //[0:0.1:1]
//Ridge diameter
//Ridge_Diameter = 3.4;
Ridge_Diameter = cylinder + .4;

smoothness=100;
$fn=smoothness;
//Smoothness
//smoothness = 100; //[5:100]
///////////////////////program///////////

union(){  //build the bowl, then add the base
	difference(){ //make a sphere, then cut things away
		intersection() {
			union(){
				sphere (r);
				if (Hole_ridge == "T") {
					rotate_extrude(convexity = 100)
					translate([Ridge_Diameter, r - (flatten + Ridge_Thickness), 0]) circle(r = Ridge_Thickness, $fn = 100);
					rotate_extrude(convexity = 100)
					translate([Ridge_Diameter, -1 * (r - (flatten + Ridge_Thickness)), 0]) circle(r = Ridge_Thickness, $fn = 100);
				}
			}
			cube([r*2, r*2, r*2-(flatten*2)],center=true); //cut off the top and bottom
		}
		cylinder (h=r*2 ,r=cylinder, center=true);
		if (Recessed == "T") {
			writesphere(Text,[0,0,0],r,font=Font,space=Text_Spacing,rotate=Rotation,h=Text_Height,t=Text_Depth);
		}
	}



	if (Recessed == "F") {
			writesphere(Text,[0,0,0],r,font=Font,space=Text_Spacing,rotate=Rotation,h=Text_Height,t=Text_Depth);
		}
}




