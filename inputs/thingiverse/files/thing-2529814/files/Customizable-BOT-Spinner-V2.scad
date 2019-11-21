/*
 * Customizable BOT Spinner
 * Randy Batt <rbatthwms@gmail.com>
 * Thingiverse.com user: B-O-T
 *
 * This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
 *
 *
 * 
 *
 * Changelog:
 *
 * 2016-12-23, batt - original design
 * 2017-01-24, batt - testing with Thingiverse Customizer
 * 2017-02-05, batt - Version 1 made public
 *
 * 2017-02-08, batt - lowered quality of Previews to speed up response on Thingiverse
 * 2017-03-14, batt - Reduced shoulder diameter on grips to prevent drag on smaller bearings
 *                  - Included comment on using Arc Cutout in Customizer
 *                  - Moved Grip screw recess from Male grip to Female grip for better threading of Male grip
 *                  - Fixed spacing when printing Well Lids
 *                  - Fixed Well Lid size issue.  They now snap in place very well. ****
 * 2017-03-28, batt - Reduced Chamfer on grip shaft for better fit.
 * 2017-04-12, batt - Fixed speeling mistakes.  :)
 * 2017-04-18, batt - Version 2 made public
 *
 *
 *TODO
 *
 *
 *CENTER BEARINGS
 * 625 - 16mm Out, 5mm In, 5mm High -
 * 608 - 22mm Out, 8mm In, 7mm High - Common Skateboard Bearing
 * 624 - 13mm Out, 4mm In, 5mm High -
 * 623 - 10mm Out, 3mm In, 4mm High
 * 605 - 14mm Out, 5mm In, 5mm High
 * 688 - 16mm Out, 8mm In, 5mm High
 * 606 - 17mm Out, 6mm In, 6mm High
 *
 *OUTER HOLEs (Ball Bearings, Hex Nuts, Coins etc)
 * Add .2mm-.3mm for loose fit 
 * Quarters		    24.5mm
 * BB's			    4.36mm use 4.6mm for better fit
 * 3/4" Ball		19.05mm
 * 5/8" Ball		15.875mm
 * 1/2" Ball		12.7mm
 * 7/16" Ball	    11.1mm
 * 3/8" Ball		9.53mm
 * 1/4" Ball		6.35mm
 *
 *
 *
 */

//preview[view:south, tilt:top]  

//Resolution
adj = .05*1; 	//Extra height for Differencing	


//User Vars
/* [DESIGN] */
//Previews are low quality and optionally show bearings for viewing the fit and appearance.  Change to 3D Print Quality when downloading STL.
Display_Mode = 1; // [1:Preview,2:3D Print Quality]
//Select the part to modify. Well Caps are only used when the "Well" Hole Type is chosen.
Part = "Spinner"; // [Spinner:Spinner,Grips:Finger Grips,Inserts:Color Inserts,WellLids:Well Lids,NodeTest:Node Size Test]]

//Set the resolution up for print quality
res = (Display_Mode == 2) ? 50 : 20;  	//Sets $fn quality where needed.  Default=30.  

$fa = (Display_Mode == 2) ? 4 : 8;  	//Sets $fa for most cases.  Default=5.  Total Fragments = 360/$fa.

$fs = (Display_Mode == 2) ? .75 : 3;  	//Sets $fs for most cases.  Default=.5-1.  Min size of Fragments in mm.




/* [SPINNER GEOMETRY] */
//How many spinner Nodes? (5)
Node_Count = 9; //[2:80]
//Radius to the Node centers(typically 20mm-40mm). (29)
Node_Radius = 40;
//Outer edge profile (Round)
Edge_Profile = 6; //[0:Round,4:Square,6:Hexagon,8:Octagon,10:Decagon,12:Dodecagon]
//Ratio of the Node Width to the Notch Width.  Too small could leave the outer holes with thin walls. (.9)
Node_To_Notch_Ratio = 1.3; //[0:.1:3]
//The higher the number the deeper the notch.  Too large might create a deformed spinner. (72)
Notch_Depth = 72; //[1:.1:108]  
//Leave at 0 unless you want to override to create unique pods. Note: You will not not see an effect until you exceed the calculated node diameter. (0)
Alt_Node_Diameter = 1.5;
//Leave at the default 1.5mm unless you need to surround the center bearing will a larger or smaller solid ring. (2)
Center_Bearing_Support_Ring_Width = 2; //2

/* [INTERIOR APPEARANCE] */
//Spice up the design by creating a cutout pattern!  NOTE: Arc may timeout when using Customizer.  (Square)
Cutout_Shape = 1;	//[0:None,1:Triangle,2:Arc,3:Circle,4:Square,5:Diamond,6:Trapezoid]
//Distance to cutout centers. 0=Auto. (0)
Cutout_Radius = 0;
//Don't go too large or you will produce a weak design. For Triangles this is the sides. For circles this is the diameter. (5)
Cutout_Height = 6;
//Width of the cutout. (Triangle=Base, Arc=Span in DEGREES, Square=Width in mm, Trapezoid=Top width in mm) (5)
Cutout_Width = 5;
//Orientation of each individual Cutout. (0)
Cutout_Orientation_Degrees = 0;//[-180:1:180]
//Rotation around center.  (0)
Cutout_Rotation_Degrees = 0;//[-180:1:180]
//Increase or decrease the cutouts per node. Make sure you set the Separation Degrees below. (Normal)
Cutout_Multiplier = 0;//[-1:Half,0:Normal,1:Dual]
//For Dual Cutouts enter the degrees to separate by. (60)
Dual_Cutout_Separation_Degrees = 60;//[-180:1:180]


/* [HIDDEN] */
//For Outer_Hole_Type=WELL: Floor Height.  (Inner_Compartment_Height = Spinner_Height - Well_Floor_Height - Well_Lid_Height) (1)
Well_Floor = 1;  
//For Outer_Hole_Type=WELL.  Lid Height. (1.4)
Well_Lid_Height = 1.4;
//For Outer_Hole_Type=WELL.  Add or subtract from Well LID Radius to get best fit. (0)
Well_Lid_Adjustment = 0;  
//For Outer_Hole_Type=WELL.  Print entire set of Well Lids instead of just one Lid? (Yes)
Well_Lid_Set = "No"; // [Yes:Yes,No:No]

/* [HIDDEN] */
//If bearing is inset below the spinner surface enter that inset + 1mm here.  Otherwise use 1mm.(1)
Bearing_Grip_Shoulder_Thickness = 5;//[.5:.1:10]
//Hole diameter if using a screw. Use 2.8-3.0 for a 3mm screw. (2.9)
Bearing_Grip_Center_Hole = 2.9;//[0:.1:5]
//Finger pad thickness. (2)
Bearing_Grip_Thickness = 2;//[.5:.1:5]
//Make sure it hides the center bearing. 0=Auto (Center Bearing Outer Diameter + 4)
Bearing_Grip_Diameter = 0; 

/* [HIDDEN] */
//Height of the spinner.  Generally enter the height of the center bearing that you are using. The defaults are for the common 608 skate bearing. (7)		
Height = 7;  //7mm default or 5mm
//Use the exact bearing size for a tight "press fit". Add .1 or .2 for "loose fit". (22.1) 
Center_Bearing_Outer_Diameter = 22.1;  //22mm default or 16mm
//Only needed if the Bearing Grips are being printed. (8)
Center_Bearing_Inner_Bore_Diameter = 8;  //8mm default or 5mm
//Ball Bearings will have a small retainer to capture the ball bearing yet allow it to spin. (2)
Outer_Hole_Type = 3;  //[0:None,1:Smooth Bore,2:Ball Bearing Retainer,3:Hex (diam is flats),4:Well (with caps)]
//The exact diameter of the holes needed. If the Test Node print is too tight to let the ball bearing snap in then increase this number. Add .2 for easily rotatable ball bearings.  If using a hex nut the diameter is taken from the flats. (12.9)
Outer_Hole_Diameter = 12.9;  //12.7 is 1/2",  19.05 is 3/4",  15.875 is 5/8" bearing,  11.1 is 7/16" bearing, 6.35 in 1/4"

/* [HIDDEN] */
//
//Create Inserts from a contrasting color!  Enter the percent of fullsize. Scale down for printing accent color inserts that fit properly. (90)
Color_Insert_Scaling = 90;//[80:100]
//Height for ring connecting the color inserts. 0=None. Use .1 or .2 for a breakaway ring.  If using a tiny insert, this will help it print better.   (.1)
Color_Insert_Surface_Ring_Height = .1;
//Protrusion extra height for color inserts. 0=None. Looks better with a small protrusion. (.4)
Color_Insert_Extra_Height = .4;

{//Config

//Only for the "Well" Hole Type lids. How many to print?
How_Many_Items = (Well_Lid_Set == "No") ? Node_Count: 1;
	
X_Retainer = .4;  //  .4 default Bearing only
X_Gap = .15;  //  .15 default Bearing only (must be 1mm or less)
	
	

Well_Lip_Height = Well_Lid_Height;  //For outer hole=well.  Lid/Lip Height.
Well_Lip_Width = 1;  //For outer hole=well.  Lip width(added to dia.)
Well_Lip_Bevel = .2;  //For outer hole=well.  Lid/Lip bevel for capture.

	
cornerwidth = 1.154701 * Outer_Hole_Diameter; //calc the corner width from the flats for HEX nuts.	

divadj =   Edge_Profile < 4 ? res : Edge_Profile ; //use the requested number of facets for edge OR default to circle.

Sides = Node_Count;
polygon_radius = Node_Radius;  
grip_diameter = (Bearing_Grip_Diameter == 0)? Center_Bearing_Outer_Diameter+4:Bearing_Grip_Diameter;

polygonangle = 360/Sides;  //Angle betreen Sides
sidelength = 2 * polygon_radius * sin( 180 / Sides );  
polygonflatsradius = polygon_radius * cos( 180/Sides);

//need to change to fixed outer size for weights
inoutratio = Node_To_Notch_Ratio;
outersegdiam = sidelength/2*inoutratio;
innersegdiam = sidelength-outersegdiam;

notchangle = (Notch_Depth * 2.68) + 89 - 268; //-179 to 89 is the acceptable range for notchangle

//Radius of inner and out loops
outersegradiusadj = outersegdiam / 2;
innersegradiusadj = ((sidelength / (2 * cos(notchangle/2))) - outersegradiusadj>Height/2) ? (sidelength / (2 * cos(notchangle/2))) - outersegradiusadj : Height/2;
//Don't let the innersegradiusadj fall below the Height or the Rotate_Extrude will have -X stuff and fail.

//Radius of inner polygon centers
innerpolyradius = polygon_radius * cos(180/Sides)-(outersegradiusadj+innersegradiusadj)*sin(notchangle/2);
innerpolysidelength = 2 * innerpolyradius * sin( 180 / Sides );

//Minumum Outer Radius, ALT outer radius or outersegradiusadj chosen.
minposibleouterradius = (Height>Outer_Hole_Diameter) ? 0+.8:Outer_Hole_Diameter/2-Height/2+.8;

//Override the outer node radius if the user said to OR the node hole is too big for the node
minouterradius = Alt_Node_Diameter/2 > minposibleouterradius?Alt_Node_Diameter/2:minposibleouterradius; 

//if outersegradiusALT becomes <> 0 it will force the ALTnode to be used
outersegradiusALT = minouterradius > outersegradiusadj ? minouterradius:0;

//the overall diameter of the spinner including edge and everything
outside_edge_radius = minouterradius > outersegradiusadj ? polygon_radius+outersegradiusALT+Height/2:polygon_radius+outersegradiusadj+Height/2;	
	
inneroutercontactradius = sqrt(pow(innersegradiusadj*sin(notchangle/2)+innerpolyradius,2)+pow(innersegradiusadj*cos(notchangle/2),2));

//If Auto was selected for the cutout radius
Cutout_Radiusadj = (Cutout_Radius == 0) 
		? (polygon_radius - Outer_Hole_Diameter/2 - Center_Bearing_Outer_Diameter/2)/2 + Center_Bearing_Outer_Diameter/2 
		: Cutout_Radius;

}

Display();

//FUNCTIONS**************************************************************************************
function xpos(radius1, n1, sides1) = (radius1 * cos((360 * n1 / sides1)) );
function ypos(radius1, n1, sides1) = (radius1 * sin((360 * n1 / sides1)) );
function xcir(radius1,angle1) = (radius1 * cos(angle1));
function ycir(radius1,angle1) = (radius1 * sin(angle1));
function xycir(radius1,angle1) = [(radius1 * cos(angle1)),(radius1 * sin(angle1))];
function BearingContactAngle(BallDia) = acos((BallDia/2+X_Gap)/(BallDia/2+((X_Retainer*BallDia/2)/(BallDia/2+X_Gap-X_Retainer))));
function BandSeparation(BallDia) = 2*tan(BearingContactAngle(BallDia))*(BallDia/2+X_Gap)-tan(BearingContactAngle(BallDia))*X_Retainer;
//***********************************************************************************************

module type(var) {
	color("black")
	translate([0,-10,Height+1])
	linear_extrude(height = 1)
	text(str(var), halign="center", size = 3);
}

module Display() {
	if (Part == "Spinner") {
		viewSpinner();
	} 
}



module viewSpinner() {
	if (Display_Mode == 0) {
		ShowPreviewSpinner();
	}
	color("blue")
	SpinnerBody();
}

module viewGrip() {
	BearingGrips();
}

module viewInserts() {
	AccentInserts(Color_Insert_Scaling/100);
}
module viewAccessories() {
	ExtraItems(How_Many_Items);
}

module viewNodeTest() {
	ShowPreviewNode();
	color("blue")
	NodeTest();
	color("blue")
	ExtraItem();
}
module SpinnerBody () {
	translate([0,0,Height/2])
	union () {
		difference () {
			SpinnerBlank (); //Blank Positive space
			
			//subtract center bearing hole 
			CenterBearingHole();
			
			//subtract outer holes 
			OuterHoleSet();
			
			//subtract Cutout holes
			NegativeCutoutSet(1); //100% scale
		}
		//require minimum support for center bearing 
		CenterBearingMinWall();
	}
}

//Create spinner without any holes yet
module SpinnerBlank () {

	 union(){
		//Draw positive outer edge profile
		for (i=[1:1:Sides]) {
			translate([xpos(polygon_radius,i,Sides),ypos(polygon_radius,i,Sides),0])
			rotate([0,0,polygonangle * i]) 
			LoopPositiveSegment();
		}
	
		//draw disc and subtract negative pie slices
		difference() {
			color("yellow")
			cylinder(h=Height,r=(polygon_radius+outersegradiusadj+Height/2+adj),center=true); 

			//Draw inner negative loops and position them
			for (j=[1:1:Sides]) {
				translate([xpos(polygon_radius,j,Sides),ypos(polygon_radius,j,Sides),0])
				rotate([0,0,polygonangle * j]) 
				LoopNegativeSegment();
			}
		}
	}
}


//Preview mode shows bearings for viewing the fit and appearance
module ShowPreviewSpinner () {  
	//color("green"){
//	translate([0,0,-//Bearing_Grip_Thickness-//Bearing_Grip_Shoulder_Thickness])
	//Gripbase();	
	//translate([0,0,Height+//Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness])
	//rotate([180,0,0])
//	Gripbase();}

	//color("yellow")
	//translate([0,0,-Color_Insert_Surface_Ring_Height-Color_Insert_Extra_Height/2])
	//AccentInserts(Color_Insert_Scaling/100);
	
	color([.8,.8,.8,1])
	//loop through each slice
	for (i=[1:1:Sides]) {
		translate([xpos(polygon_radius,i,Sides),ypos(polygon_radius,i,Sides),0])
		rotate([0,0,polygonangle * i]) 
		ShowPreviewNode();
	}
}

module ShowPreviewNode () { 
	color([.5,.5,.5,1])
	if (Display_Mode == 0) {
		if (Outer_Hole_Type == 2) { //Ball Bearing
			translate([0,0,Height/2])
			sphere(r=Outer_Hole_Diameter/2); //sample bearing
		}	
		if (Outer_Hole_Type == 3) { //Hex Nut	
			translate([0,0,Height/2])
			difference() {
				scale([.95,.95,.9])
				OuterHole();
				cylinder(d=Outer_Hole_Diameter/2, h=Height+adj, center=true);
			}
		}
	}
}

//Positive Edge profile for each pie slice
module LoopPositiveSegment() {
	//calc an adjusted Height to keep flats even with spinner Height if a polygon edge shape is chosen.
	heightadj = (divadj <= 12) ? Height/cos(180/divadj) : Height;
	//calc the amount to shift the radius of polygons that have the point at leading edge so the profile stays Height/2.
	widthadj = (divadj <= 12) ? (heightadj/2 - Height/2)*((divadj/2)%2) : 0;
	//Connecting spot lined up with X axis
	//rotate to be ready to place first seg along +X axis		
	rotate([0,0,90+polygonangle/2 + (notchangle)/2])   
	union(){
		if (outersegradiusALT > 0) {
			AltNode(outersegradiusALT); //if normal node is too small for the outer hole or user overrode
		}
		else {
			//Outside
			color("blue")
			//render(convexity = 4)
			//Make Outer Semi-Loop (.1 to ensure overlap)
			rotate_extrude2(angle=-(notchangle+180)-polygonangle-.1, convexity=4, size=outersegradiusadj*2)
			difference() {
				translate([outersegradiusadj-widthadj, 0])
				//rotate shapes with odd number of exposed faces to avoid shallow print angle.
				rotate([0,0,(((Edge_Profile/2)%2)-1)*180/divadj]) 
				circle(heightadj/2, $fn = divadj);
				//used to erase anything overlapping into -X
				translate([-outersegradiusadj-Height, -Height/2])
				square([outersegradiusadj+Height,Height]);
			}
		}
		//Inside
		color("red") 		
		render(convexity = 4) //have to keep this render or thingiverse zooms out with large rotate_extrude diff.
		//Make Inner Semi-Loop and position it
		translate([outersegradiusadj + innersegradiusadj, 0]) 
		rotate([0,0,-notchangle]) 
		//Make the Actual Inner Semi-Loop (.1 to ensure overlap)
		rotate_extrude2(angle= (notchangle+180+.1), convexity=4, size=innersegradiusadj*2)		
			translate([innersegradiusadj+widthadj, 0]) //width
			//rotate shapes with odd number of exposed faces to avoid shallow print angle.
			rotate([0,0,(((Edge_Profile/2)%2)-1)*180/divadj]) 
			circle(heightadj/2, $fn = divadj);
	}
}

//Negative space pie slice
module LoopNegativeSegment() {
	//.1 degree of overlap for artifact rendering removal
	e=.1; 
	w=polygon_radius+outersegradiusadj+Height+Height-inneroutercontactradius;
	r=inneroutercontactradius;
	a=polygonangle;
	an=notchangle;
	pr = polygon_radius;
	rin = innersegradiusadj;
	rout = outersegradiusadj;

	xbi=r;
	ybi=0;
	xbo=r+w;
	ybo=0;
	xmi=xcir(r,a/3);
	ymi=ycir(r,a/3);
	xmo=xcir(r+w,a/3);
	ymo=ycir(r+w,a/3);
	xmi2=xcir(r,2*a/3);
	ymi2=ycir(r,2*a/3);
	xmo2=xcir(r+w,2*a/3);
	ymo2=ycir(r+w,2*a/3);	
	xti=xcir(r,a+e);
	yti=ycir(r,a+e);
	xto=xcir(r+w,a+e);
	yto=ycir(r+w,a+e);

	translate([0,0, -Height/2-adj/2-adj/2])
	linear_extrude(Height+adj+adj) {
		//rotate to be ready to place first node along +X axis
		rotate(90+a/2 + (an)/2)   
		union() {
			rotate(-90-a/2 - (an)/2)
			difference() {
				translate([-pr,0,0 ])
				rotate(-a/2) 
				color("blue")
				polygon(points=[[xbi,ybi],[xbo,ybo],[xmo,ymo],[xmo2,ymo2],[xto,yto],[xti,yti],[xmi2,ymi2],[xmi,ymi]], convexity=4);
				rotate(90+a/2 + (an)/2)
				//Make Outer Semi-Loop	
				color("green")
				circle(rout);
				//Make Center circle	
				translate([-pr,0,0 ])
				color("orange")
				circle(r);				
			}
			if (pr > innerpolyradius) {
				color("black") //inside loop
				translate([rout + rin, 0]) 	
				circle(rin);		
			}
			else {
				//Polygon 2D circle
				A = notchangle+180;
				//resolution to use
				n = (A/360*2*PI*rin > $fs) ? round(A/360*2*PI*rin/$fs) : round($fa*A/360);
				rcut = (rin-Height-Height < 0) ? 0 : rin-Height-Height;
				step = A/n;
				pts1 = [for (Ar=[0:step:A+step+step]) xycir(rin,Ar)]; //2 extra steps to prevent artifacts
				pts2 = [for (Ar=[A:-A:0]) xycir(rcut,Ar)];  //  
				pts = concat(pts1,pts2);
				color("pink") //inside loop
				translate([rout + rin, 0])
				rotate([0,0,(-notchangle)-step]) //1 extra step to prevent artifacts
				polygon(pts, convexity=6);
			}
		}
	}	
}

//Negative space center bearing hole
module CenterBearingHole() {
	color("grey") 
	cylinder(r=Center_Bearing_Outer_Diameter/2, h=Height + adj, center=true);
}
//Add minimum support wall for center bearing
module CenterBearingMinWall() {
	rotate_extrude(angle=360, convexity=2)
		translate([Center_Bearing_Outer_Diameter/2, -Height/2])
		square([Center_Bearing_Support_Ring_Width,Height]);
}
//Negative space outer hole collection
module OuterHoleSet() {
	for (i=[1:1:Sides]) {
		translate([xpos(polygon_radius,i,Sides),ypos(polygon_radius,i,Sides),0])
		rotate([0,0,polygonangle * i])
		OuterHole();
	}
}
//Negative space outer hole
module OuterHole () {
	//make single outer hole
	if (Outer_Hole_Type == 1) { //  smooth bore
		translate([0,0,-Height/2-adj/2])
		cylinder(r=Outer_Hole_Diameter/2, h=Height+adj);
	}
	if (Outer_Hole_Type == 2) {  //  ball bearing
		BallBearingHoleNegative(Outer_Hole_Diameter, Height);
	}
	if (Outer_Hole_Type == 3) { //  hex nut
		translate([0,0,-Height/2-adj/2])
		rotate([0,0,30])
		cylinder(r=cornerwidth/2, h=Height+adj, $fn = 6);
	}
	if (Outer_Hole_Type == 4) { //  well with caps
		translate([0,0,-Height/2])
		union()	{	
			translate([0,0,Well_Floor])   //neg hole - floor
			cylinder(r=Outer_Hole_Diameter/2, h=Height-Well_Floor+adj/2);  
			
			translate([0,0,Height-Well_Lip_Height])  //lip
			cylinder(r1=Outer_Hole_Diameter/2+Well_Lip_Width+Well_Lip_Bevel, r2=Outer_Hole_Diameter/2+Well_Lip_Width, h=Well_Lip_Height+adj/2);
		}
	}
}
//Make a negative with retainer
module BallBearingHoleNegative(BallDia, CutoutHeight) {
	Y_Retainer = (CutoutHeight-BandSeparation(BallDia))/2;
	union() {
		sphere(r=BallDia/2+X_Gap); //hollow sphere + X_Gap oversize diameter for bearing play	
		translate([0,0,-CutoutHeight/2-adj/2])
		cylinder(r=BallDia/2+X_Gap-X_Retainer, h=CutoutHeight+adj);  //basic hole
		translate([0,0,-(CutoutHeight-2*Y_Retainer)/2])
		cylinder(r=BallDia/2+X_Gap, h=CutoutHeight-2*Y_Retainer);  //retainer negative space
	}	
}

//Other needed items
module ExtraItems (How_Many) {
	Node_Radius_Actual = (outersegradiusALT > 0)?outersegradiusALT+Height/2:outersegradiusadj+Height/2;
	print_radius = (How_Many>1) ?(Node_Radius_Actual*How_Many/PI)+2:0;
	if (Outer_Hole_Type == 4) { //currently only one item offered
		for (i=[0:1:How_Many-1]) {
			translate([xpos(print_radius,i,How_Many),ypos(print_radius,i,How_Many),0])
			rotate([0,0,polygonangle * i]) 
			ExtraItem();
		}
	}
	else{
		type("You have chosen the Well Caps but they are");
		translate([0,-10,0])
		type("only needed when the Outer Hole Type = Well");	
	}
}
module ExtraItem() {	
	//  well cap.  Shaped like <> with center at bevel/2	
	if (Outer_Hole_Type == 4) { 
		union () { //Well_Lid_Adjustment is a fudge factor +-
			cylinder(r2=Outer_Hole_Diameter/2+Well_Lip_Width-.25+Well_Lip_Bevel/2+Well_Lid_Adjustment,r1=Outer_Hole_Diameter/2+Well_Lip_Width-.25+Well_Lid_Adjustment,h=Well_Lip_Height/2);
			translate([0,0,Well_Lip_Height/2])
			cylinder(r1=Outer_Hole_Diameter/2+Well_Lip_Width-.25+Well_Lip_Bevel/2+Well_Lid_Adjustment,r2=Outer_Hole_Diameter/2+Well_Lip_Width-.25+Well_Lid_Adjustment,h=Well_Lip_Height/2);			
		}
	}
}


//Outer hole alternate node
module AltNode (RadiusNeeded) {
	//if the space required by the outer hole (bearing, hex nut etc) is larger than the calculated outer radius...
	//then the design cannot have a single smooth outer edge so this will create a "pod" instead.
	//calc an adjusted height to keep flats even with spinner height if a polygon edge shape is chosen.
	heightadj = Height/cos(180/divadj);
	//calc the amount to shift the radius of polygons that have the point at leading edge so the profile stays Height/2.
	widthadj = (heightadj/2 - Height/2)*((divadj/2)%2);

	rotate_extrude(angle=360, convexity=6)
	difference() {	
		union() {
			translate([RadiusNeeded-widthadj, 0]) //width
			//rotate shapes with odd number of exposed faces to avoid shallow print angle.
			rotate([0,0,(((Edge_Profile/2)%2)-1)*180/divadj]) 
			circle(heightadj/2, $fn = divadj);
			translate([0, -Height/2]) 
			square([RadiusNeeded,Height]);
		}
		//used to erase anything overlapping into -X
		translate([-outersegradiusadj-Height, -Height/2])
		square([outersegradiusadj+Height,Height]);
	}
}
//Negative space Cutout
module NegativeCutoutSet (Insert_Scale) {
	rotate([0,0,Cutout_Rotation_Degrees]) {
		if (Cutout_Multiplier == 0)	{
			NegativeCutoutLoop(0, Sides, Insert_Scale);
		}
		if (Cutout_Multiplier == 1)	{
			//loop through left and right Cutout at each slice
			for (d=[-Dual_Cutout_Separation_Degrees/2:Dual_Cutout_Separation_Degrees:Dual_Cutout_Separation_Degrees/2]) {
				NegativeCutoutLoop(d, Sides, Insert_Scale);
			}
		}
		if (Cutout_Multiplier == -1)	{
			NegativeCutoutLoop(0, round(Sides/2+.1), Insert_Scale);
		}
	}
}
module NegativeCutoutLoop (d, Count, Insert_Scale) {
	for (i=[1:1:Count]) {
		rotate([0,0,d])
		translate([xpos(Cutout_Radiusadj,i,Count),ypos(Cutout_Radiusadj,i,Count),0])
		rotate([0,0,Cutout_Orientation_Degrees])
		rotate([0,0,360/Count * i])
		NegativeCutout(Insert_Scale);
	}
}
//Negative space Cutout
module NegativeCutout (Insert_Scale) {
	//can be scaled down for making accent inserts
	scale([Insert_Scale,Insert_Scale,1]) {	
	
	myfs = ($fs < .5) ? .5 : $fs/2;
	myfa = ($fa < .5) ? .5 : $fa/2;
		
	if (Cutout_Shape == 0) {	//none
	}
	if (Cutout_Shape == 1) {	//triangle
		linear_extrude(height = Height + adj, center = true, convexity = 2, twist = 0)
		rotate(-90)
		translate([0,-sqrt(pow(Cutout_Height,2)-pow(Cutout_Width/2,2))/2])
		polygon(points=[[-Cutout_Width/2,0],[Cutout_Width/2,0],[0,sqrt(pow(Cutout_Height,2)-pow(Cutout_Width/2,2))]], convexity=2);
	}
	if (Cutout_Shape == 2) {	//arc
		//render(convexity = 2)
		translate([-Cutout_Radiusadj,0])
		rotate([0,0,-Cutout_Width/2])
		rotate_extrude2(angle=Cutout_Width, convexity=2, $fs=myfs, $fa=myfa, size=Cutout_Radiusadj*2)  
		translate([Cutout_Radiusadj-Cutout_Height/2, -Height/2-adj/2])
		square([Cutout_Height,Height+adj]); 
	}	
	if (Cutout_Shape == 3) {	//circle
		cylinder(r=Cutout_Height/2, h=Height + adj, center=true, $fs=myfs, $fa=myfa);
	}	
	if (Cutout_Shape == 4) {	//square
		cube([Cutout_Height, Cutout_Width, Height + adj], center=true);
	}	
	if (Cutout_Shape == 5) {	//diamond
		scale([1,.65,1])
		cylinder(r=Cutout_Height/2, h=Height + adj, $fn = 4, center=true);
	}	
	if (Cutout_Shape == 6) {	//trapezoid
		ANG = (Cutout_Multiplier == 0) 	? polygonangle: 
			  (Cutout_Multiplier == 1) 	? polygonangle/2: //Dual
			  (Sides > 4) 				? 360/round(Sides/2+.1): //Half
										45;	//(Half would have resulted in 180deg for 4 nodes or less.)
		SW=Cutout_Width;  
		SH=Cutout_Height;  
		TB=tan(ANG/2)*SH; 
		linear_extrude(height = Height + adj, center = true, convexity = 2, twist = 0)
			rotate([0,0,90])
			translate([-(TB+SW+TB)/2,-SH/2])
			polygon(points=[[0,0],[TB+SW+TB,0],[TB+SW,SH],[TB,SH],[0,0]], convexity=2);
	}	
	}
}
//Decorative inserts (or functional)
module AccentInserts (Insert_Scale) {
	if (Cutout_Shape != 0) {
		union () {
			if (Color_Insert_Surface_Ring_Height > 0) {
				AccentInsertSurfaceRing(Color_Insert_Surface_Ring_Height);
			}
			translate([0,0,Color_Insert_Surface_Ring_Height])
			translate([0,0,Height/2+Color_Insert_Extra_Height/2])
			resize([0,0,Height+Color_Insert_Extra_Height]) 
			NegativeCutoutSet(Insert_Scale);
		}
	}
}
//Make a surface ring to connect the accent inserts
module AccentInsertSurfaceRing (ringheight) {
	Cutout_Heightadj = (Cutout_Shape==1) ? sqrt(pow(Cutout_Height,2)-pow(Cutout_Width/2,2)) : Cutout_Height;
	rotate_extrude(angle=360, convexity=4)  
		translate([Cutout_Radiusadj, ringheight/2])
		square([Cutout_Heightadj,ringheight],center=true);
}
//Bearing grips
module BearingGrips () {
	//See if the pin is able to fit a hole for the screw and leave 1mm walls
	MF = ((Center_Bearing_Inner_Bore_Diameter*.7-.4) - (Bearing_Grip_Center_Hole + .1) >= 1) ? 1 : 0;
	//Hole for a fixing screw (diameter + .0mm)
	BGCH = Bearing_Grip_Center_Hole > 0 ? Bearing_Grip_Center_Hole + 0 : 0;
	difference () {
		union () {
			//if a screw cannot fit with the male/female version then don't use it.
			if (MF==1) {//Make male and female versions since there is room
				//female half
				translate([0,(grip_diameter+Bearing_Grip_Thickness+3)/2])
				Gripfemale();
				
				//male half
				translate([0,-(grip_diameter+Bearing_Grip_Thickness+3)/2])	
				Gripmale();
			}
			else {
				union() {
					//first half
					translate([0,(grip_diameter+Bearing_Grip_Thickness+3)/2])	
					Gripbase();
					
					//second half
					translate([0,-(grip_diameter+Bearing_Grip_Thickness+3)/2])	
					Gripbase();
				}	
			}
		}
		translate([0,(grip_diameter+Bearing_Grip_Thickness+3)/2])
		GripScrewHole(BGCH);  //make screw hole for part 1
		translate([0,-(grip_diameter+Bearing_Grip_Thickness+3)/2])
		GripScrewHole(BGCH);  //make screw hole for part 2
		translate([0,(grip_diameter+Bearing_Grip_Thickness+3)/2])	
		GripScrewHoleRecess(6); //make 6mm recess for part 2
	}
	//for better printing-this piece will come off and be disposed of after printing
	translate([0,(grip_diameter+Bearing_Grip_Thickness+3)/2])
	cylinder(h=.90, d=Bearing_Grip_Center_Hole+.7, center=false, $fn=res);
}
	
module GripScrewHole(HoleSize) {
	//Hole for a fixing screw (diameter + .1mm)
	if (HoleSize > 0) {	//hole
		translate([0,0,-adj/2])
		cylinder(h=Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness+Height+adj,d=HoleSize,center=false, $fn=res);
	}
}	
module GripScrewHoleRecess(RecessSize) {
	if (Bearing_Grip_Center_Hole > 0) {
		//Recess (6mm dia, 1.2mm high) for screw head as an alignment for two spinner used together.
		translate([0,0,-.1])
		cylinder(h=1.3, d=RecessSize, center=false, $fn=res);
	}
}
//Create male grip
module Gripmale() {
	//male half
	union() {
		Gripbase ();
		cylinder(h=Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness+Height-.5,d=Center_Bearing_Inner_Bore_Diameter*.7-.4,center=false, $fn=res);
	}
}
//Create female grip
module Gripfemale() {
	//female half
	difference () {
		Gripbase ();
		translate([0,0,Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness])
		cylinder(h=Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness+Height,d=Center_Bearing_Inner_Bore_Diameter*.7+.4,center=false, $fn=res);
	}
}
//Create the grip base
module Gripbase() {
	difference () {
		union() {
			//finger plate (diameter = bearing dia + 4mm)
			rotate_extrude(angle=360, convexity=2, $fn=res)     
			union() { 
				translate([grip_diameter/2-Bearing_Grip_Thickness/2, Bearing_Grip_Thickness/2]) 
				circle(Bearing_Grip_Thickness/2, $fn=res);
				square([grip_diameter/2-Bearing_Grip_Thickness/2, Bearing_Grip_Thickness]);
			}
			//shoulder (diameter = Bore + 4mm)
			cylinder(h=Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness,d=Center_Bearing_Inner_Bore_Diameter+4,center=false, $fn=res);

			//shaft (diameter = Bore - .2mm, Height = .3 less than half bearing Height above platform)
			cylinder(h=Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness+Height/2-.3,d=Center_Bearing_Inner_Bore_Diameter-.2,center=false, $fn=res);
						
			//chamfer on shaft 30deg/2		
			translate([0,0,Bearing_Grip_Thickness+Bearing_Grip_Shoulder_Thickness]) 
			cylinder(h = .5, r2 = (Center_Bearing_Inner_Bore_Diameter-.2)/2 , r1 = (Center_Bearing_Inner_Bore_Diameter-.2)/2+Height/8*tan(30/2),center=false, $fn=res);
		}
	}
}
//Create a single node for size testing the ball bearing, hex nut etc
module NodeTest () {
	node_radius = (outersegradiusALT > 0)?outersegradiusALT:outersegradiusadj;
	translate([0,0,Height/2])
	difference() {
		AltNode(node_radius);
		OuterHole();
	}
	if (Outer_Hole_Type == 4) { //well
		translate([-node_radius*2-Height/2-3,0,0])
		ExtraItems(1); //lid
	}
}

module rotate_extrude2(angle=360, convexity=2, size=outside_edge_radius*2) {
//http://forum.openscad.org/rotate-extrude-angle-always-360-td19035.html
//Thanks to thehans for posting this. (rotate_extrude2)
  module angle_cut(angle=90,size=outside_edge_radius*2) {
    x = size*cos(angle/2);
    y = size*sin(angle/2);
    translate([0,0,-size]) 
      linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
  }
  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation
  if (angleSupport) {
    rotate_extrude(angle=angle,convexity=convexity)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}


		
	