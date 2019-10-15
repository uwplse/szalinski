/*   	MY Libraries v1.1 - Common Components
		Unless stated otherwise, all modules
		are by Randy Young <dadick83@hotmail.com>
		2010, 2011.   License, GPL v2 or later
**************************************************/

displayMode= rezScreen();  // (resolution)

function rezPrinter()=0;
function rezScreen()=1;

function resolution(value) =
	displayMode==1 ? 360 : value*2*3.141592; // ~1mm resolution for printer
$fn=resolution(4); // default for cylinder & sphere

function vectorDistance(v1, v2) =
	sqrt((pow(v2[0]-v1[0],2)+pow(v2[1]-v1[1],2))+pow(v2[2]-v1[2],2));
// function for linear measurement from 2, 3d vectors)

ep=0.01; //small number to avoid overlaps (non-manifold models)
in=25.4; //inches to millimeter conversion


/***** ROTATION & TRANSLATION SHORTCUTS  *****
Used for common, easy to type single axis moves 
with names I can actually remember (since I never
get the rotation directions right on first try. :o)   */

function tighten (angle=90) =
		[0,0,-1*angle];

function loosen (angle=90) =
		[0,0,angle];

function righty (angle=90) =
		[0,angle,0];

function lefty (angle=90) =
		[0,-1*angle,0];

function backward (angle=90) =
		[-1*angle,0,0];

function forward (angle=90) =
		[angle,0,0];

function push(distance=1) =
		[0,distance,0]; 

function lift(distance=1) =
		[0,0,distance];

function slide(distance=1) =
		[distance,0,0]; 

/*************************************************
BASIC ENGINEERING SHAPES */

module hex (width=10, height=10, flats= true, center=false){
	radius= (flats == true ? width/sin(60)/2 : width/2 );
		cylinder (r=radius, h=height, center=center, $fn=6);
}

module equilateralTriangle (side=10, height=10, center=false){
	translate(center==true ? [-side/2,-sqrt(3)*side/6,-height/2] : [0,0,0])	
		linear_extrude(height=height)
			polygon(points=[[0,0],[side,0],[side/2,sqrt(3)*side/2]]);
}

module pyramid(side=10, height=-1, square=false, centerHorizontal=true, centerVertical=false){
// creates a 3 or 4 sided pyramid.  -1 height= tetrahedron or Johnson's Solid square pyramid
	mHeight= height!=-1 ? height:
		square == true ? (1/sqrt(2))*side:		//square
			sqrt(6)/3*side;						//tetra
	vert= centerVertical!=true ? [0,0,0]:
		square==false ? [0,0,-mHeight/4] :	 //inscribes a tetra inside a sphere, not 1/2 ht
			[0,0,-mHeight/2];	//for squares, center=false inscribes, so true is just 1/2 ht
	horiz= centerHorizontal!= true ? [0,0,0] :
		square == true ? [-side/2, -side/2, 0] : 	//square
			[-side/2,-sqrt(3)*side/6 ,0];			//tetra
	translate(vert+horiz){
		if (square == true){
			polyhedron (	points = [[0,0,0],[0,side,0],[side,side,0],
								[side,0,0],[side/2,side/2,mHeight]], 
						triangles = [[1,0,2], [2,0,3], [0,4,3], 
								[3,4,2], [2,4,1], [1,4,0]]);
		}
		if (square != true){
			polyhedron (	points = [[0,0,0],[side,0,0],[side/2,sqrt(3)*side/2,0],
								[side/2,sqrt(3)*side/6,mHeight]], 
						triangles = [[0,1,2], [1,0,3], [2,1,3],[2,3,0]]);			
		}
}	}

module tube(r=2, thickness=1, height=1, center=false, outline=false){
	translate(lift(center == true ?  0 : 0.5*height)) 
	difference(){
		cylinder(r=r, h=height, center=true, $fn=resolution(r));
		if (outline!=true)
			cylinder(r=r-thickness+ep, h=height+2*ep, center=true, $fn=resolution(r-thickness));
}	}

module roundRect (size=[10,10,10], round=3, center=false){
	$fn=resolution(round);
	radius = min(round, size[0]/2, size[1]/2);
	union(){
		translate(center==true ? [-size[0]/2,-size[1]/2,-size[2]/2] : [0,0,0]){
			translate([radius,radius,0])
				cylinder (r=radius, h=size[2]);
			translate([size[0]-radius,radius,0])
				cylinder (r=radius, h=size[2]);
			translate([size[0]-radius,size[1]-radius,0])
				cylinder (r=radius, h=size[2]);
			translate([radius,size[1]-radius,0])
				cylinder (r=radius, h=size[2]);
			translate([0,radius,0]) 
				cube(size-[0,radius*2,0]);
			translate([radius,0,0]) 
				cube(size-[radius*2,0,0]);
}	}	}

module keyhole(r1, r2, length, height) {
	translate ([0,length/2,0]) union(){
		translate ([0,length/2-r1,0]) 
			cylinder (r=r1, height, $fn=resolution(r1));
		translate ([0,0-(length/2-r2),0]) 
			cylinder (r=r2, height, $fn=resolution(r2));
		translate ([-r1,r1-length/2,0]) 
			cube ([r1*2,length-(r1*2),height]);
	}
}

module slot(size=[4,10,1], startRound=true, endRound=true, centerXYZ=[1,0,0]){
	$fn=resolution(size[0]/2);
	radius=size[0]/2;
	start= startRound==true ? radius : 0;
	end= endRound==true ? radius : 0;
	translate([-size[0]/2*centerXYZ[0],
			-size[1]/2*centerXYZ[1],
			-size[2]/2*centerXYZ[2]]) 
	union(){
		translate([0,start,0]) cube (size-[0,start+end,0]);
		if (startRound==true) translate ([radius,radius,0])
			cylinder (r=size[0]/2, h=size[2]);
		if (endRound==true) translate ([radius,size[1]-radius,0])
			cylinder (r=size[0]/2, h=size[2]);
	
}	}

module dovetail (width=9, height=10, male=true){
	w= (male==true) ? width*0.975 : width;
	translate(slide(2.4)) union(){
		rotate(tighten(30))
			equilateralTriangle(w,height, center=true);
		translate(slide(-4.5)) cube([4.2,width*1.5,height], center=true);}
}

module teardrop(radius=5, length=10, angle=90) {
// teardrop module by whosawhatsis <www.thingiverse.com/thing:3457>
// Creative Commons LGPL, 2010.  I added default values and resolution code
	$fn=resolution(radius);
	rotate([0, angle, 0]) union() {
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			circle(r = radius, center = true);
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			projection(cut = false) rotate([0, -angle, 0]) 
			translate([0, 0, radius * sin(45) * 1.5]) 
			cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, 
					center = true);
	}
}


/*************************************************
HARDWARE COMPONENTS */

module hexNut(size="M3", center=false, outline=false, pos=[0,0,0]){
	if (tableRow(size) == -1)	echo(str("hexNut ERROR: size of '",size,"' is undefined."));
	width = tableEntry (size, "nutWidth");
	height = tableEntry (size, "nutThickness");
	hole = tableEntry (size, "nutID");
	translate(pos+lift(center == true ?  0 : 0.5*height)) difference(){
		hex(width, height, center=true);
		if (outline!=true)
			cylinder(r=hole/2+0.01, h=height+0.02, center=true, $fn=resolution(hole/2));
}	}

module washer(size="M3", center=false, outline=false, pos=[0,0,0]){
	if (tableRow(size) == -1)	echo(str("washer ERROR: size of '",size,"' is undefined."));
	width = tableEntry (size, "washerOD");
	height = tableEntry (size, "washerThickness");
	hole = tableEntry (size, "washerID");
	translate(pos) tube(width/2,(width-hole)/2,height,center,outline);
}

module capBolt (size="M3", length= 16, center=false, pos=[0,0,0])	{
	if (tableRow(size) == -1)	echo(str("capBolt ERROR: size of '",size,"' is undefined."));
	diameter = tableEntry (size, "headDiameter");
	head = tableEntry (size, "headThickness");
	stud = tableEntry (size, "studDiameter");	
	translate(pos+[0,0,center == true ? -length/2 : 0]) union()	{
		translate(lift(-head)){
			cylinder(r=diameter/2, h=head, $fn=resolution(diameter/2));
			cylinder(r=stud/2, h=length+head, $fn=resolution(stud/2));
}	}	}

module hexBolt (size="M3", length= 16, center=false, pos=[0,0,0])	{
	if (tableRow(size) == -1)	echo(str("hexBolt ERROR: size of '",size,"' is undefined."));
	width = tableEntry (size, "headDiameter");
	head = tableEntry (size, "headThickness");
	stud = tableEntry (size, "studDiameter");	
	translate(pos+[0,0,center == true ? -length/2 : 0]) union()	{
		translate(lift(-head)){
			hex(width, head, $fn=6);
			cylinder(r=stud/2, h=length+head, $fn=resolution(stud/2));
}	}	}

module bearing (size="Skate", center=false, outline=false, pos=[0,0,0]){
// The Elmom MCAD has a much better version of a bearing module.  
// This is a basic donut shape but gets the job done for construction.
	if (tableRow(size) == -1)	echo(str("bearing ERROR: type of '",type,"' is undefined."));
	hole = tableEntry (size, "bearingID");
	thickness = tableEntry (size, "bearingThickness");
	diameter = tableEntry (size, "bearingOD");
	translate(pos) 
		tube(diameter/2, (diameter-hole)/2, thickness, center, outline);
}

/*************************************************
/****  TABLE DATA AND SUPPORT FUNCTIONS		****
The following functions contain various engineering tables but you can add whatever data
you'd like.  I've also used it for translation landmarks.  The table itself is arranged with an array of arrays (vectors) and stored within the "tableRow" function with each row having a string identifier.  Thus, you can retrieve a vector by name without storing a bunch of variables.
	A second array function, called "columnNames" is simply a convenient way to refer to each element within a vector by an element name.  The values overlap, depending on what data type you're working with.  For instance, "bearingWidth" = "headThickness" = z-vector element = 2.
	You can find a specific variable within the data, using "rowElement" that uses row, column strings to identify the element desired.  Uncomment the example below to see it in action. 
						*****/
//testTable();
		module testTable(){
			column = "nutWidth";
			row =	"M3";
			
			echo (str(column," is found in column #",
				columnName(column)	));
			echo (str("The row named ",row," contains: ",
				tableRow(row)		));
			echo (str("The ",column," field of the ",row," row is: ",
				tableEntry(row,column)	));	
		}

function columnName(name)=
	// Bearings
		name == "bearingID" 		? 0 :
		name == "bearingOD" 		? 1 :
		name == "bearingThickness"?2 :
	// Bolts
		name == "studDiameter" 	? 0 :
		name == "headDiameter" 	? 1 :
		name == "headThickness" 	? 2 :
	// Nuts
		name == "nutID"	 		? 0 :
		name == "nutWidth" 		? 3 :
		name == "nutThickness" 	? 4 :
	// Washers
		name == "washerID"	 	? 0 :
		name == "washerOD"	 	? 5 :
		name == "washerThickness"? 6 :
	-1; // Not Found.  Results in Undef fields.

function tableRow (name)=
	// Bearing Names
		name == "606" 		? [6, 13, 6] :
		name == "608" 		? [8, 22, 7] :
		name == "624" 		? [4, 13, 5] :
		name == "Skate" 		? [8, 22, 7] :
	// Bolt, Nut, Washer Sizes
	// It seems hardware size standards are loose, so these dimensions may not match your hardware.
		name == "M2" 		? [2, 4, 2, 4, 1.6, 5.5, 0.3] :		
		name == "M2.5" 		? [2.5, 5, 2.5, 5, 2, 7, 0.5] :		
		name == "M3" 		? [3, 5.5, 3, 5.5, 2.4, 7, 0.5] :		
		name == "M4" 		? [4, 7.0, 4, 7, 3.2, 9, 0.8] :
		name == "M5" 		? [5, 8.5, 5, 8, 4.7, 10, 1] :
		name == "M6" 		? [6, 10, 6, 10, 5.2, 12.5, 1.6 ] :
		name == "M8" 		? [8, 13, 8, 13, 6.8, 17, 1.8] :
		name == "#8"		 	? [0.164*in, 7.1, 0.164*in, 11/32*in, 3.05, in/2, in*0.04] :
		name == "1/4 Hex" 	? [in/4, in*0.505, in*11/64, in*7/16, in*5/32, in*0.734, in*0.063] :
		name == "5/16 Hex"	? [in*5/16, in*0.577, in*7/32, in/2, in*3/16, in*0.875, in*0.063] :
	-1; //Not found in Table

function tableEntry (rowName, fieldName) =
	tableRow(rowName)[columnName(fieldName)];	


/*************************************************
OPENSCAD INTERFACE & EXAMPLES */

libEcho=true;
if (libEcho!=false){ 
	echo ("****************************************************************  ");
	echo ("  'Libs' library loaded. For a list of modules, use libHelp();            ");
	echo ("   For help with translation/rotation functions, use libMoveHelp();");
	echo ("   For examples of each object, use libDemo();                             ");
	echo ("   To turn off this header, place libEcho=false; in your script        ");
	echo ("   libs.scad is @ http://www.thingiverse.com/thing:6021             ");
	echo ("****************** By randyy, 2011, LGPL v2+ ******************  ");
}

module libDemo(){
	translate(slide(15)) pyramid();
	translate(lift(5)) equilateralTriangle(center=true);
	translate(slide(-15)) pyramid(square=true);
	translate(slide(15)+push(15)) tube(5,2, height=10);
	translate([-5,10,0]) roundRect();
	translate([-15,15,0]) hex();
	translate([15,-25,0]) slot([4,15,4],true,false);
	translate([0,-25,0]) keyhole(2,4,15,4);
	translate([-30,-10,0]) hexNut();
	translate([-30,-20,0]) washer();
	translate([-30,0,tableEntry("#8","headThickness")]) capBolt("M3",12);
	translate([-30,15,tableEntry("#8","headThickness")]) hexBolt("#8",12);
	translate([-15,-18,0]) rotate(tighten()) dovetail(9,4);
}

module libHelp(){
	echo();
	echo("  ***********************   libHelp   **************************");
	echo("  displayMode= 1;  // 0=printer, 1=screen (resolution)  ");
	echo("  hex (width=10, height=10, flats= true, center=false)  ");
	echo("  equilateralTriangle (side=10, height=10, center=false)  ");
	echo("  pyramid(side=10, height=-1, square=false, centerHorizontal=true, centerVertical=false)  ");
	echo("  tube(r=2, thickness=1, height=1, center=false, outline=false)  ");
	echo("  roundRect (size=[10,10,10], round=3, center=false)  ");
	echo("  keyhole(r1, r2, length, height)  ");
	echo("  slot(size=[4,10,1], startRound=true, endRound=true, centerXYZ=[1,0,0])  ");
	echo("  dovetail (width=9, height=10, male=true)  ");
	echo("  teardrop(radius=5, length=10, angle=90)  ");
	echo("  hexNut(size='M3', center=false, outline=false, pos=[0,0,0])  ");
	echo("  washer(size='M3', center=false, outline=false, pos=[0,0,0])  ");
	echo("  capBolt (size='M3', length= 16, center=false, pos=[0,0,0])  ");
	echo("  hexBolt (size='M3', length= 16, center=false, pos=[0,0,0])  ");
	echo("  bearing (size='Skate', center=false, outline=false, pos=[0,0,0])  ");
	echo("  TABLE FUNCTIONS  ");
	echo("  function columnName(name)  ");
	echo("  function tableRow (name)  ");
	echo("  function tableEntry (rowName, fieldName)  ");
	echo();
}

module libMoveHelp(){
	echo();
	echo("  *********************   libMoveHelp   ************************");
	echo("  ROTATION - default is 90 degrees, but you can use any value in ().  ");
	echo("     tighten(), clockwise, along z                                                       ");
	echo("     loosen(), counterclockwise, along z                                            ");
	echo("     righty(), leans right, along y axis                                                ");
	echo("     lefty(), leans left, along y axis                                                     ");
	echo("     backward() falls away, along x axis                                             ");
	echo("     forward() falls toward you, along x axis                                      ");
	echo("  TRANSLATION - negative numbers move in opposite direction      ");
	echo("     push(distance) moves object away, along y                                 ");
	echo("     lift(distance) moves object up, along z                                        ");
	echo("     slide(distance) moves object right, along x                                 ");
	echo();
}