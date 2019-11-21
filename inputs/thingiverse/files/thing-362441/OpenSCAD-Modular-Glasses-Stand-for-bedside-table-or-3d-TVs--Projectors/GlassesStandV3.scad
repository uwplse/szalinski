
/* [Configuration] */

// How many levels do you want to display?
Number_Of_Levels=2; // [1,2,3,4,5]

// What should the top size be?
Top_Size = "Medium"; // [Small,Medium,Large,Silly]

// Include Top Front Stopper?
Top_Front_Stopper = false; // [true,false]

// What would you like the Style to be?
Shape_Style = "Hull"; // [RoundedCorner,Hull]

// What would you like the roof to look like?
Hat_Style = "Pyramid"; // [Pyramid,Sphere,None]

// Add Printing frame for flat print?
Print_Tab = true; // [true,false]

// Separate object generation - Base, Back Bottom, Back Standard, Top Side, Top Front
part = "base"; // [base:Base Only,back:Back Only,topside:Top Side Only,topfront:Top Front Only,all:All]

/* [Hidden] */
fn= (Shape_Style == "Hull") ? 10 : 100;

// What should be the top side length?
Top_Side_Length= (Top_Size == "Silly") ? 80 : (Top_Size == "Medium") ? 40 : (Top_Size == "Large") ? 60 :  40;
Top_Front_Length= (Top_Size == "Silly") ? 110 : (Top_Size == "Medium") ? 60 : (Top_Size == "Large") ? 80 :  30;

bridge_height=60;
bridge_width=30;
bridge_length=40;
bridge_thickness=5;
bridge_forwardposition=30;
bridge_topposition1=0;
frame_height1=bridge_topposition1+25;
frame_thickness=12;
back_height=65;
wall_thick=6;
corner_radius = wall_thick*2;
bottomframeWidth1=100; // [80:200]
bottomframeWidth2=60; // [40:100]

sidebar_length=30;
frontbar_length=40;
feet_height=8;

// V4
// Another top which is slanted
// Mustash top?
// Add holes in top side for glasses frame (as guide on insertion)

//buildBridge(bridge_topposition1-20);
//buildBridge(bridge_topposition2-15);


print_part();


module print_part() {

	if (part == "base") {
		buildBase();
	} else if (part == "back") {
		buildBack(true,(back_height),(frame_height1));
	} else if (part == "topside") {
		smalltopside((frame_height1-5));
	} else if (part == "topfront") {
		smalltopfront((frame_height1-5));
	} else if (part == "all") {
		all();
	} else {
		all();
	}

}




module all() {

	translate([0,0,-10]) buildBase();
	rotate([0,-4,0]) buildBack(true,back_height,frame_height1);

	rotate([0,-4,0]) smalltopside(frame_height1);
	rotate([0,-4,180]) smalltopside(frame_height1);
	rotate([0,-4,0]) smalltopfront(frame_height1);

	for ( i = [2 : 1 : Number_Of_Levels] )
	{
		translate([(-3*i),0,(back_height)*(i-1)+5]) rotate([0,-4,0]) buildBack(true,(back_height),(frame_height1));
		translate([(-3*i),0,(back_height)*(i-1)+5]) rotate([0,-4,0]) smalltopside((frame_height1));
		translate([(-3*i),0,(back_height)*(i-1)+5]) rotate([0,-4,180]) smalltopside((frame_height1));
		translate([(-3*i),0,(back_height)*(i-1)+5]) rotate([0,-4,0]) smalltopfront((frame_height1));
	}

	// Build little pyramid hat to go on top
	rotate([0,-4,0]) translate([0,0,(back_height*Number_Of_Levels)+5]) buildRoof();
}




module fulltop() {
	//Wings for full frame holding
	//translate([-3,-10,frame_height1]) hmaleBar(sidebar_length, ginnerWidth, gouterWidth, gcrossOver);
	//rotate([0,0,180]) translate([-3,-10,frame_height1]) hmaleBar(sidebar_length, ginnerWidth, gouterWidth, gcrossOver);
	//rotate([0,0,90]) translate([-3,-10,frame_height1]) hmaleBar(frontbar_length, ginnerWidth, gouterWidth, gcrossOver);
}


module smalltopfront(iframeheight) {
	rotate([0,0,90]) translate([-gouterWidth/2,-30,iframeheight]) hmaleBar(9, ginnerWidth, gouterWidth, gcrossOver);

	rotate([0,0,90]) difference() {
		union() {
			translate([0,-40,iframeheight+5]) rotate([90,0,0]) scale([1.5,1,1]) cylinder(Top_Front_Length,7,7,$fn=fn);
			translate([0,-40,iframeheight+5+2.5]) cube(size=[20,2,20],center=true);
			if (Top_Front_Stopper) 
				translate([0,-(40+Top_Front_Length),iframeheight+5+2.5]) cube(size=[20,2,20],center=true);
		}
		translate([0,-12-Top_Front_Length,iframeheight-7]) cube(size=[22,Top_Front_Length*2,20],center=true);
	}
}

module smalltopside(iframeheight) {
	//Wings for small frame holding (colapsed)
	translate([-gouterWidth/2,-30,iframeheight]) hmaleBar(9, ginnerWidth, gouterWidth, gcrossOver);

	difference() {
		union() {
			translate([0,-39,iframeheight+5]) rotate([90,0,0]) cylinder(Top_Side_Length,5,5,$fn=fn);
			translate([0,-39,iframeheight+5+2.5]) cube(size=[12,2,15],center=true);
			translate([0,-39-Top_Side_Length,iframeheight+5+2.5]) cube(size=[12,2,15],center=true);
		}
		translate([0,-11-Top_Side_Length,iframeheight-7]) cube(size=[20,Top_Side_Length*2,20],center=true);
	}
}



module buildRoof() {

	translate([-(gouterWidth)/2,-(gouterWidth)/2,0]) rotate([-90,0,0]) hmaleBar(25, ginnerWidth, gouterWidth, gcrossOver);

	if (Hat_Style == "Pyramid") {
		hull() {
			translate([0,0,20]) rotate([90,0,45]) Isosceles_Triangle(angle=25, H=40, center=true);
			translate([0,0,20]) rotate([90,0,-45]) Isosceles_Triangle(angle=25, H=40, center=true);
		}
	} else if (Hat_Style == "Sphere") {
		translate([0,0,25]) sphere(r=11,center=true);
	} else {

	}
}



module buildBridge(z=0) {
	difference () {
		translate([bridge_forwardposition,0,z]) rotate([0,90,0]) scale([2,1,1]) cylinder(bridge_length,bridge_width,bridge_height,$fn=100);

		translate([bridge_forwardposition-2,0,z]) rotate([0,90,0]) scale([2,1,1]) cylinder(bridge_length+10,bridge_width-bridge_thickness,bridge_height-bridge_thickness,$fn=100);

		// Cut away bottom of bridge
		translate([49+bridge_forwardposition,0,-30+z]) cube(size=[100,100,100],center=true);
	}
}





module buildBack(center=true, ibackheight, iframeheight) {


	// Back
	translate([-(gouterWidth)/2,-(gouterWidth)/2,0]) rotate([-90,0,0]) hmaleBar(25, ginnerWidth, gouterWidth, gcrossOver);
	translate([-3,0,(ibackheight-8)/2]) cube(size=[frame_thickness,frame_thickness,(ibackheight-8)-25],center=true);
	translate([-gouterWidth/2,gouterWidth/2,ibackheight-8]) rotate([90,0,0]) hfemaleBar(25, ginnerWidth, gouterWidth, gwidthGap, gcrossOver);

	// Bottom of Back
if (Shape_Style == "Hull") {
	hull(){
	difference() {
		union() {
			translate([(frame_thickness/2)-3,frame_thickness/2,25]) rotate([0,-90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
			translate([(-frame_thickness/2)-3,-frame_thickness/2,25]) rotate([0,-90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
			translate([(frame_thickness/2)-3,-frame_thickness/2,25]) rotate([0,-90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		}

		translate([-3,(-5)-(gouterWidth/2),25]) cube(size=[15,10,10],center=true);
		translate([-3,(+5)+(gouterWidth/2),25]) cube(size=[15,10,10],center=true);
		translate([(+5)+(gouterWidth/2),0,25]) cube(size=[10,15,10],center=true);
	}
	}
}
else {
	difference() {
		union() {
			translate([(frame_thickness/2)-3,frame_thickness/2,25]) rotate([0,-90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
			translate([(-frame_thickness/2)-3,-frame_thickness/2,25]) rotate([0,-90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
			translate([(frame_thickness/2)-3,-frame_thickness/2,25]) rotate([0,-90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		}

		translate([-3,(-5)-(gouterWidth/2),25]) cube(size=[15,10,10],center=true);
		translate([-3,(+5)+(gouterWidth/2),25]) cube(size=[15,10,10],center=true);
		translate([(+5)+(gouterWidth/2),0,25]) cube(size=[10,15,10],center=true);
	}
}

	// Curve for middle joint
if (Shape_Style == "Hull") {
	difference() {
	hull() {
		translate([-(frame_thickness/2)-3,(frame_thickness/2),iframeheight]) rotate([0,90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		translate([(frame_thickness/2)-3,-(frame_thickness/2),iframeheight]) rotate([0,90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		if(center == true)
			translate([(frame_thickness/2)-3,(frame_thickness/2),iframeheight]) rotate([0,90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);

		translate([(frame_thickness/2)-3,(frame_thickness/2),iframeheight+gouterWidth]) rotate([0,-90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		translate([-(frame_thickness/2)-3,-(frame_thickness/2),iframeheight+gouterWidth]) rotate([0,-90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		if(center==true)
			translate([(frame_thickness/2)-3,-(frame_thickness/2),iframeheight+gouterWidth]) rotate([0,-90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
	}

	translate([0,0,iframeheight+gouterWidth/2]) cube(size=[18,50,gouterWidth-5],center=true);
	translate([0,0,iframeheight+gouterWidth/2]) cube(size=[50,18,gouterWidth-5],center=true);
	translate([0,0,iframeheight+gouterWidth*2]) cube(size=[gouterWidth,gouterWidth,30],center=true);
	}
}
else {
		translate([-(frame_thickness/2)-3,(frame_thickness/2)+2,iframeheight]) rotate([0,90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		translate([(frame_thickness/2)-3,-(frame_thickness/2)-2,iframeheight]) rotate([0,90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		if(center == true)
			translate([(frame_thickness/2)+2,(frame_thickness/2),iframeheight]) rotate([0,90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);

		translate([(frame_thickness/2)-3,(frame_thickness/2)+2,iframeheight+gouterWidth]) rotate([0,-90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		translate([-(frame_thickness/2)-3,-(frame_thickness/2)-2,iframeheight+gouterWidth]) rotate([0,-90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		if(center==true)
			translate([(frame_thickness/2)+2,-(frame_thickness/2),iframeheight+gouterWidth]) rotate([0,-90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
}

	// Middle Joint
	translate([-gouterWidth/2,39/2,iframeheight]) femaleBar(39, ginnerWidth, gouterWidth, gwidthGap, gcrossOver);
	if(center==true)
		translate([-gouterWidth/2+3,-gouterWidth/2,iframeheight]) rotate([0,0,90]) femaleBar(25, ginnerWidth, gouterWidth, gwidthGap, gcrossOver);

}






module buildBase() {


	// Bottom1
	translate([-gouterWidth/2,gouterWidth/2,0]) rotate([90,-5,0]) hfemaleBar(25, ginnerWidth, gouterWidth, gwidthGap, gcrossOver);


	difference() {
		translate([bridge_forwardposition/2,0,-21]) rotate([0,90,0]) cube(size=[feet_height,frame_thickness,bridge_forwardposition+60],center=true);

		translate([-31,-(frame_thickness+2)/2,-16]) rotate([-90,0,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness+2);
		translate([bridge_forwardposition+31,(frame_thickness+2)/2,-16]) rotate([-90,0,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness+2);
	}

	if(Print_Tab) {
		translate([-30,0,-24.75]) cube(size=[20,30,0.5],center=true);
	}

	// Curve for bottom joint
if (Shape_Style == "Hull") {
	difference() {
		hull() {
			translate([frame_thickness/2,gouterWidth/2-0.1,-17]) rotate([0,-90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
			translate([-frame_thickness/2,-gouterWidth/2+0.1,-17]) rotate([0,-90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
			translate([gouterWidth/2-0.1,-frame_thickness/2,-17]) rotate([0,-90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
			translate([-gouterWidth/2-0.1,frame_thickness/2,-17]) rotate([0,-90,90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);

			translate([0,0,-23]) cube(size=[gouterWidth,gouterWidth,4],center=true);
		}

		translate([0,0,0]) cube(size=[gouterWidth,gouterWidth,20],center=true);
	}
}
else {
		translate([frame_thickness/2,gouterWidth/2-0.1,-17]) rotate([0,-90,0]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		translate([-frame_thickness/2,-gouterWidth/2+0.1,-17]) rotate([0,-90,180]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		translate([gouterWidth/2-0.1,-frame_thickness/2,-17]) rotate([0,-90,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
		translate([-gouterWidth/2-0.1,frame_thickness/2,-17]) rotate([0,-90,90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness);
}
	// Base bottom
	difference() {
		translate([0,0,-21]) rotate([90,0,0]) cube(size=[frame_thickness,feet_height,bottomframeWidth1],center=true);

		translate([(frame_thickness+2)/2,-(bottomframeWidth1+2)/2,-16]) rotate([-90,0,90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness+2);
		translate([-(frame_thickness+2)/2,(bottomframeWidth1+2)/2,-16]) rotate([-90,0,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness+2);
	}

	if(Print_Tab) {
		translate([0,-(bottomframeWidth1/2),-24.75]) cube(size=[50,20,0.5],center=true);
		translate([0,(bottomframeWidth1/2),-24.75]) cube(size=[50,20,0.5],center=true);
	}

	// Front base1
	difference () {
		translate([bridge_forwardposition+frame_thickness,0,-21]) rotate([90,0,0]) cube(size=[frame_thickness,feet_height,bottomframeWidth2],center=true);

		translate([(bridge_forwardposition)+(frame_thickness*2)-5,-(bottomframeWidth2+2)/2,-16]) rotate([-90,0,90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness+2);
		translate([(bridge_forwardposition)+(frame_thickness)/2-1,(bottomframeWidth2+2)/2,-16]) rotate([-90,0,-90]) rounded_corner(0,0,corner_radius,corner_radius,frame_thickness+2);
	}

	if(Print_Tab) {
		translate([bridge_forwardposition+frame_thickness,-(bottomframeWidth2/2),-24.75]) cube(size=[30,10,0.5],center=true);
		translate([bridge_forwardposition+frame_thickness,(bottomframeWidth2/2),-24.75]) cube(size=[30,10,0.5],center=true);
	}
}






module rounded_corner(rx,ry,cx,cy,z) {
        difference() {
            translate(v=[rx,ry,0]) cube([corner_radius,corner_radius,z], center=false);
            translate(v=[cx,cy,-0.5]) cylinder(r=corner_radius, h=z+1, $fn=fn);
        }
}












































/*
Triangles.scad
 Author: Tim Koopman
 https://github.com/tkoopman/Delta-Diamond/blob/master/OpenSCAD/Triangles.scad

         angleCA
           /|\
        a / H \ c
         /  |  \
 angleAB ------- angleBC
            b

Standard Parameters
	center: true/false
		If true same as centerXYZ = [true, true, true]

	centerXYZ: Vector of 3 true/false values [CenterX, CenterY, CenterZ]
		center must be left undef

	height: The 3D height of the Triangle. Ignored if heights defined

	heights: Vector of 3 height values heights @ [angleAB, angleBC, angleCA]
		If CenterZ is true each height will be centered individually, this means
		the shape will be different depending on CenterZ. Most times you will want
		CenterZ to be true to get the shape most people want.
*/

/* 
Triangle
	a: Length of side a
	b: Length of side b
	angle: angle at point angleAB
*/
module Triangle(
			a, b, angle, height=1, heights=undef,
			center=undef, centerXYZ=[false,false,false])
{
	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCA = ((heights==undef) ? height : heights[2])/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCA);

	// Calculate Offsets for centering
	offsetX = (center || (center==undef && centerXYZ[0]))?((cos(angle)*a)+b)/3:0;
	offsetY = (center || (center==undef && centerXYZ[1]))?(sin(angle)*a)/3:0;
	
	pointAB1 = [-offsetX,-offsetY, centerZ-heightAB];
	pointAB2 = [-offsetX,-offsetY, centerZ+heightAB];
	pointBC1 = [b-offsetX,-offsetY, centerZ-heightBC];
	pointBC2 = [b-offsetX,-offsetY, centerZ+heightBC];
	pointCA1 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ-heightCA];
	pointCA2 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ+heightCA];

	polyhedron(
		points=[	pointAB1, pointBC1, pointCA1,
					pointAB2, pointBC2, pointCA2 ],
		triangles=[	
			[0, 1, 2],
			[3, 5, 4],
			[0, 3, 1],
			[1, 3, 4],
			[1, 4, 2],
			[2, 4, 5],
			[2, 5, 0],
			[0, 5, 3] ] );
}

/*
Isosceles Triangle
	Exactly 2 of the following paramaters must be defined.
	If all 3 defined H will be ignored.
	b: length of side b
	angle: angle at points angleAB & angleBC.
*/
module Isosceles_Triangle(
			b, angle, H=undef, height=1, heights=undef,
			center=undef, centerXYZ=[true, false, false])
{
	valid = 	(angle!=undef)?((angle < 90) && (b!=undef||H!=undef)) : (b!=undef&&H!=undef);
	ANGLE = (angle!=undef) ? angle : atan(H / (b/2));
	a = (b==undef)?(H/sin((180-(angle*2))/2)) : 
		 (b / cos(ANGLE))/2;
	B = (b==undef)? (cos(angle)*a)*2:b;
	if (valid)
	{
		Triangle(a=a, b=B, angle=ANGLE, height=height, heights=heights,
					center=center, centerXYZ=centerXYZ);
	} else {
		echo("Invalid Isosceles_Triangle. Must specify any 2 of b, angle and H, and if angle used angle must be less than 90");
	}
}

/*
Right Angled Triangle
	Create a Right Angled Triangle where the hypotenuse will be calculated.

       |\
      a| \
       |  \
       ----
         b
	a: length of side a
	b: length of side b
*/
module Right_Angled_Triangle(
			a, b, height=1, heights=undef,
			center=undef, centerXYZ=[false, false, false])
{
	Triangle(a=a, b=b, angle=90, height=height, heights=heights,
				center=center, centerXYZ=centerXYZ);
}

/*
Wedge
	Is same as Right Angled Triangle with 2 different heights, and rotated.
	Good for creating support structures.
*/
module Wedge(a, b, w1, w2)
{
	rotate([90,0,0])
		Right_Angled_Triangle(a, b, heights=[w1, w2, w1], centerXYZ=[false, false, true]);
}

/*
Equilateral Triangle
	Create a Equilateral Triangle.

	l: Length of all sides (a, b & c)
	H: Triangle size will be based on the this 2D height
		When using H, l is ignored.
*/
module Equilateral_Triangle(
			l=10, H=undef, height=1, heights=undef,
			center=undef, centerXYZ=[true,false,false])
{
	L = (H==undef)?l:H/sin(60);
	Triangle(a=L,b=L,angle=60,height=height, heights=heights,
				center=center, centerXYZ=centerXYZ);
}

/*
Trapezoid
	Create a Basic Trapezoid (Based on Isosceles_Triangle)

            d
          /----\
         /  |   \
     a  /   H    \ c
       /    |     \
 angle ------------ angle
            b

	b: Length of side b
	angle: Angle at points angleAB & angleBC
	H: The 2D height at which the triangle should be cut to create the trapezoid
	heights: If vector of size 3 (Standard for triangles) both cd & da will be the same height, if vector have 4 values [ab,bc,cd,da] than each point can have different heights.
*/
module Trapezoid(
			b, angle=60, H, height=1, heights=undef,
			center=undef, centerXYZ=[true,false,false])
{
	validAngle = (angle < 90);
	adX = H / tan(angle);

	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCD = ((heights==undef) ? height : heights[2])/2;
	heightDA = ((heights==undef) ? height : ((len(heights) > 3)?heights[3]:heights[2]))/2;

	// Centers
	centerX = (center || (center==undef && centerXYZ[0]))?0:b/2;
	centerY = (center || (center==undef && centerXYZ[1]))?0:H/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCD,heightDA);

	// Points
	y = H/2;
	bx = b/2;
	dx = (b-(adX*2))/2;

	pointAB1 = [centerX-bx, centerY-y, centerZ-heightAB];
	pointAB2 = [centerX-bx, centerY-y, centerZ+heightAB];
	pointBC1 = [centerX+bx, centerY-y, centerZ-heightBC];
	pointBC2 = [centerX+bx, centerY-y, centerZ+heightBC];
	pointCD1 = [centerX+dx, centerY+y, centerZ-heightCD];
	pointCD2 = [centerX+dx, centerY+y, centerZ+heightCD];
	pointDA1 = [centerX-dx, centerY+y, centerZ-heightDA];
	pointDA2 = [centerX-dx, centerY+y, centerZ+heightDA];

	validH = (adX < b/2);

	if (validAngle && validH)
	{
		polyhedron(
			points=[	pointAB1, pointBC1, pointCD1, pointDA1,
						pointAB2, pointBC2, pointCD2, pointDA2 ],
			triangles=[	
				[0, 1, 2],
				[0, 2, 3],
				[4, 6, 5],
				[4, 7, 6],
				[0, 4, 1],
				[1, 4, 5],
				[1, 5, 2],
				[2, 5, 6],
				[2, 6, 3],
				[3, 6, 7],
				[3, 7, 0],
				[0, 7, 4]	] );
	} else {
		if (!validAngle) echo("Trapezoid invalid, angle must be less than 90");
		else echo("Trapezoid invalid, H is larger than triangle");
	}
}


// Examples
//Triangle(a=5, b=15, angle=33, centerXYZ=[true,false,false]);
//translate([20,0,0]) Right_Angled_Triangle(a=5, b=20, centerXYZ=[false,true,false]);
//translate([45,0,0]) Wedge(a=5, b=20, w1=10, w2=5);
//translate([-20,0,0]) Trapezoid(b=20, angle=33, H=4, height=5, centerXYZ=[true,false,true]);

//translate([0,10,0]) Isosceles_Triangle(b=20, angle=33);
//translate([30,10,0]) Isosceles_Triangle(b=20, H=5);
//translate([-30,10,0]) Isosceles_Triangle(angle=33, H=5, center=true);

//translate([15,-25,0]) Equilateral_Triangle(l=20);
//translate([-15,-25,0]) Equilateral_Triangle(H=20);






































ginnerWidth = 12;
gouterWidth = 18;
gwidthGap = 0.5;
gcrossOver = 9;

// Bar Connect Male Structure
//maleBar(40, ginnerWidth, gouterWidth, gcrossOver);

// Bar Connect Female Structure
//translate([-20,0,0]) femaleBar(100, ginnerWidth, gouterWidth, gwidthGap, gcrossOver);


module maleCrossBar(length, innerWidth, outerWidth, crossOver)
{

	translate([0,length/2+(outerWidth/2),0]) maleBar(length, innerWidth, outerWidth, crossOver);
	rotate([0,0,90]) translate([0,length/2-(outerWidth/2),0]) maleBar(length, innerWidth, outerWidth, crossOver);
}


module maleBar(length, innerWidth, outerWidth, crossOver)
{
	screwHoleLength = outerWidth + 2;
	screwHoleWidth = 1.5;

	rotate([90,0,0]) translate([0,0,crossOver])
	difference()
	{
		union()
		{
			translate([(outerWidth-innerWidth)/2,(outerWidth-innerWidth)/2,-crossOver]) cube([innerWidth,innerWidth,length]);
			cube([outerWidth,outerWidth,length - (crossOver*2)]);
		}

		translate([outerWidth/2,outerWidth+1,-crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,-crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([outerWidth/2,outerWidth+1,length-crossOver-(crossOver/2)]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,length-crossOver-(crossOver/2)]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);
	}
}

module femaleBar(length, innerWidth, outerWidth, widthGap, crossOver)
{
	screwHoleLength = outerWidth + 2;
	innerWidth = innerWidth+widthGap;
	screwHoleWidth = 1.5;

	rotate([90,0,0])
	difference()
	{
		cube([outerWidth,outerWidth,length]);

		translate([(outerWidth-innerWidth-widthGap)/2,(outerWidth-innerWidth-widthGap)/2,-1]) cube([innerWidth+widthGap,innerWidth+widthGap,crossOver+2]);

		translate([(outerWidth-innerWidth-widthGap)/2,(outerWidth-innerWidth-widthGap)/2,length-(crossOver)-1]) cube([innerWidth+widthGap,innerWidth+widthGap,crossOver+2]);

		translate([outerWidth/2,outerWidth+1,crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([outerWidth/2,outerWidth+1,length-(crossOver/2)]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,length-(crossOver/2)]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

	}
}

module hmaleBar(length, innerWidth, outerWidth, crossOver)
{
	screwHoleLength = outerWidth + 2;
	screwHoleWidth = 1.5;

	rotate([90,0,0]) translate([0,0,crossOver])
	difference()
	{
		union()
		{
			translate([(outerWidth-innerWidth)/2,(outerWidth-innerWidth)/2,-crossOver]) cube([innerWidth,innerWidth,length]);
			cube([outerWidth,outerWidth,length - (crossOver)]);
		}

		translate([outerWidth/2,outerWidth+1,-crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,-crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);
	}
}

module hfemaleBar(length, innerWidth, outerWidth, widthGap, crossOver)
{
	screwHoleLength = outerWidth + 2;
	innerWidth = innerWidth+widthGap;
	screwHoleWidth = 1.5;


	rotate([90,0,0])
	difference()
	{
		cube([outerWidth,outerWidth,length]);

		translate([(outerWidth-innerWidth)/2,(outerWidth-innerWidth)/2,-1]) cube([innerWidth,innerWidth,crossOver+2]);

		translate([outerWidth/2,outerWidth+1,crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

	}
}