use <utils/build_plate.scad>
/***************************************************************************************
 * Tapered pocket coin-op by Brett Beauregard (br3ttb)
 * Modified by mphardy for easier customization
 * Version 1.1 Modified by ALittleSlow
 --------------------------------------
 * Added image customization
 * Eliminated some non-manifold surfaces
 * Made build plate optional
 * Made trapezoid angle adjustable to fit more text or larger images
 * Converted from obsolete write() to text()
 *
 * Notes:  
 * -  with the non-tapered pocket coin-op I tested changing all the input variables.  I'm pretty confident in the 
 *    geometry now, so I don't think people will need to adjust very much.  I did test the coin and thickness
 *    variables though, as those may actually be modified.
 *
 * - if you adjust the coin size you may get an error when trying to export the stl.  this is likely due to an 
 *   intersection between the coin hole and the key ring slot.  you can either adjust the slot dimensions or
 *   the coin overhang to correct this
 ***************************************************************************************/

/* Licenses
 * OpenSCAD_surface_example_input_image.png licensed by CC-BY-SA 3.0
 */
 
// preview[view:north east, tilt:top diagonal]

/* [Text] */
// The text to use
Text="Text";
// Size of letters
TextHieght=90; // [20 : 170]
// Depth/hieght of text (0=no text)
TextRelief=-10; // [-10 : 20]
// Text offset from slot
TextPositionX=-30; // [-120 : 0]
// Left/right text position
TextPositionY=0; // [-120 : 120]
// Spacing between letters
TextSpacing=10; // [6 : 20]
// The fontface to use. See https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Text
Font = "";  
/* [Image] */
// 100 x 100 PNG image to convert to height map. Blank for no image. Doesn't work on Thingiverse, sorry.
image="OpenSCAD_surface_example_input_image.png"; // [image_surface:100x100]
// max height of image
image_height=0.9;
// image width. 0 for automatic
image_width=0; // [0:0.5:50]
// move image up or down
ImageOffsetX=0; //[-10:0.5:10]

/* [Coin] */
// Type of coin to use
CoinType = "US"; // [US:US 1 Cent, CA:CA 1 Cent, EU:EU 5 Cent, UK:UK 1 Penny, XX:Manual]
// Manual coin radius
ManualRadius=9.5;
// Manual coin thickness
ManualThickness=1.75;
// Manual coin overhang
ManualOverhang=3;

/* [Opener Shape] */
// Width of the key ring end
base=22;
// angle of the key ring corner
corner_angle=103.5; // [90.0:0.5:106]

/* [Plate] */
//for display only, doesn't contribute to final object
build_plate_selector = -1; //[-1:None,0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//manual x-dimensino
build_plate_manual_x = 100; //[`100:400]
//manual y-dimension
build_plate_manual_y = 100; //[100:400]
// Number of rows
NumberOfRows=1; // [1 : 6]
// Gap between rows
RowSpacing=0; // [0 : 10]
// Number of columns
NumberOfColumns=1; // [1 : 6]
// Gap between columns
ColumnSpacing=0; // [0 : 10]

/* [Hidden] */
spacing = TextSpacing / 10;
xpos = TextPositionX / 10;
ypos = TextPositionY / 10;
relief = TextRelief / 10;
hieght = TextHieght / 10;

//Thickness / Taper
thickness=6;
inset=1.75;
centerthickness=2.5;

//Overall Opener Configuration 
length=50;
baseR1=5;
baseR2=5;
angle=corner_angle-90;

//Hole Configuration
holeBaseLoc=25.5;
holeLength=19.5;
// calculate base minimum base width to get 30 mm at the top
//extra=sin(angle)*holeLength
holeTopWidthMinimum=30; //=holeBaseWidth+2*extra
holeBaseWidth=max(23, holeTopWidthMinimum-2*holeLength*sin(angle));
holeR1=2;
holeR2=6;

//KeyRingSlot
slotWidth=17;
slotHeight=5;
slotInset=2.5;

rowoffset=35 + RowSpacing;
columnoffset=51 + ColumnSpacing;


$fs=1;

module placeImage() {
	imageWidth=(image_width==0) ? holeBaseWidth : image_width;
	translate([0, -length/6+ImageOffsetX, thickness+image_height]) 
//	intersection()
	{
		resize([imageWidth, 0,image_height], auto=true) surface(file=image, center=true, invert=true);
//		translate([0, 0, -image_height/2]) cube(size=[imageWidth, 100, image_height*2], center=true); 
	}
}

module opener_row() {
  difference() {
    union() {
      rotate([0,0,90]) translate([-0.5*length, -0.5*base,0]) {
        if (CoinType=="US") {
		    opener(9.5, 1.75, 3);
        }
        if (CoinType=="CA") {
	  	    opener(9.5, 1.97, 3);
        }
  		  else if (CoinType=="EU") {
	 	    opener(9.4, 2.11, 3);
        }
		  else if (CoinType=="UK") {
		    opener(10.2, 2.07, 3);
        }
		  else if (CoinType=="XX") {
		    opener(ManualRadius, ManualThickness, ManualOverhang);
        }
	  }
	  if (relief>0) 
		translate([ypos,xpos-(hieght/2),thickness+relief/2]) 
		linear_extrude(relief) text(text=Text, size=hieght, font=Font, halign="center", valign="center", spacing=spacing);

	}
    translate([0,-20,14.5]) rotate([90,90,0]) cylinder(r=12,h=6);
    if (relief<0) translate([ypos,xpos-(hieght/2),thickness+relief/2]) 
		linear_extrude(-relief) text(text=Text, size=hieght, font=Font, halign="center", valign="center", spacing=spacing);
  }
  if (image!="") placeImage();

}

module opener(coinRadius, coinThickness, coinOverhang) {
  difference() {
		// the body
		roundedInsetTrapezoid(length=length, r1=baseR1, r2=baseR2,mainthick=thickness,
					        baseW=base, angle=angle, inset=inset, centerthick=centerthickness);
		// over-thick holes to prevent non-manifold surfaces
		translate([holeBaseLoc,(base-holeBaseWidth)/2,-thickness/2]) 
			roundedTrapezoid(thick=thickness*2, baseW=holeBaseWidth, angle=angle, length=holeLength, r1=holeR1, r2=holeR2);
		translate([slotHeight/2+slotInset,(base-slotWidth+slotHeight)/2, -thickness/2]) cylinder(r=slotHeight/2, h=thickness*2);
		translate([slotHeight/2+slotInset,(base+slotWidth-slotHeight)/2, -thickness/2]) cylinder(r=slotHeight/2, h=thickness*2);
		translate([slotInset,(base-slotWidth+slotHeight)/2, -thickness/2])cube([slotHeight,slotWidth-slotHeight,thickness*2]);
		
		translate([holeBaseLoc-coinRadius+coinOverhang,base/2,(thickness-coinThickness)/2])
		{
			translate([0,-coinRadius,0])cube([coinRadius,2*coinRadius,coinThickness]);
			cylinder(r=coinRadius,h=coinThickness);
		}
	} 
}

module roundedTrapezoid(thick=5, length=19.5, r1=2, r2=9.5, angle=13.5, baseW=23)
{
	x1 = length*sin(angle);
	difference()
	{
	trapezoidSolid(thick = thick, length = length, r1=r1, r2=r2, angle = angle, baseW=baseW);
		translate([length,-1*x1,0])cube([2*r2-length,baseW+2*x1,thick]);
		rotate([0,0,-1*angle])translate([0,-1*(r1+r2),0])cube([length,r1+r2, thick]);
		translate([0,baseW,0]) rotate([0,0,angle])cube([ length,r1+r2, thick]);
	}
}


module trapezoidSolid(thick=5, length=19.5, r1=1, r2=9.5, angle=13.5, baseW=23)
{
	r1oSet = length/cos(angle)-r1*tan((90+angle)/2);// -r1-r1*tan(angle);//-r1/cos(angle);
	sideoSet = r2*tan((90-angle)/2);// r2*(1- tan(angle));
	sidelen = r1oSet-sideoSet;
	bottomoSet = (length*sin(angle))-r1*tan((90+angle)/2);
	
	rotate([0,0,-1*angle])
	{
		translate([r1oSet,r1,0])cylinder(h=thick, r=r1);
		translate([sideoSet,r2,0])cylinder(h=thick,r=r2);
		translate([sideoSet,0,0]) cube([sidelen,2*r1,thick]);
	}
	translate([0,baseW,0])rotate([0,0,angle])
	{
		translate([0,-2*r1,0])
		{
			translate([r1oSet,r1,0])cylinder(h=thick, r=r1);
			translate([sideoSet,-r2+2*r1,0])cylinder(h=thick,r=r2);
			translate([sideoSet,0,0]) cube([sidelen,2*r1,thick]);
		}
	}
	translate([0,sideoSet,0])cube([length,baseW-2*sideoSet,thick]);
	translate([r2,-bottomoSet,0])cube([length-r2,baseW+2*bottomoSet,thick]);
}

module MakerbotM(height, thickness) 
{
	radius = height/5.5;
	translate([-1.25*radius,1.5*radius,0])
	{
		difference() {
			cylinder(r=radius,h = thickness, $fn=20);
			translate([0,-1*radius,0])cube([radius,radius,thickness]);
		}
		translate([2.5*radius,0,0])difference() {
			cylinder(r=radius,h = thickness, $fn=20);
			translate([-1*radius,-1*radius,0])cube([radius,radius,thickness]);
		}
		translate([-1*radius,0,0]) {
			translate([0,-3.5*radius,0])cube([radius,3.5*radius,thickness]);
			translate([radius/2,-3.5*radius,0])cylinder(r=radius/2,h=thickness, $fn=20);
		}
		translate([0.75*radius,0,0]) {
			translate([0,-3.5*radius,0])cube([radius,4.5*radius,thickness]);
			translate([radius/2,-3.5*radius,0])cylinder(r=radius/2,h=thickness, $fn=20);
		}
		translate([2.5*radius,0,0]) {
			translate([0,-3.5*radius,0])cube([radius,3.5*radius,thickness]);
			translate([radius/2,-3.5*radius,0])cylinder(r=radius/2,h=thickness, $fn=20);
		}
		cube([2.5*radius,radius,thickness]);
	}
}


module roundedInsetTrapezoid(mainthick=6, length=19.5, r1=2, r2=9.5, angle=13.5, baseW=23, inset =1.75, centerthick=2.5) 
{
	thick = (mainthick-centerthick)/2;
	 topr1=r1-inset;
	topr2=r2-inset;
	x1 = length*sin(angle);
	r1oSet = length/cos(angle)-r1*tan((90+angle)/2);// -r1-r1*tan(angle);//-r1/cos(angle);
	sideoSet = r2*tan((90-angle)/2);// r2*(1- tan(angle));
	sidelen = r1oSet-sideoSet;
	bottomoSet = (length*sin(angle))-r1*tan((90+angle)/2);
	sideangle = atan(inset/thick);
	difference()
	{
		union(){
			translate([0,0,thick+centerthick])roundedInsetSolid(thick=thick, length=length, r1=r1, r2=r2, angle=angle, baseW=baseW, inset =inset);
			translate([0,0,thick])roundedInsetSolid(thick=centerthick, length=length, r1=r1, r2=r2, angle=angle, baseW=baseW, inset =0);
			translate([0,baseW,thick])rotate([180,0,0])
				roundedInsetSolid(thick=thick, length=length, r1=r1, r2=r2, angle=angle, baseW=baseW, inset =inset);
		}
	
		//top angles
		translate([0,0,thick+centerthick])
		{
			translate([0,baseW,0]) rotate([0,0,angle])rotate([sideangle,0,0])cube([ length,r1+r2, thick+r1]);
			rotate([0,0,-1*angle])translate([0,-1*(r1+r2),0])translate([0,(r1+r2),0])
				rotate([-1*sideangle,0,0])translate([0,-1*(r1+r2),0])cube([length,r1+r2, thick+r1]);
			rotate([0,sideangle,0])translate([-2*thick,0,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
			translate([length,-1*length*tan(angle),0])rotate([0,-1*sideangle,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
		}
		
		//side angles	
		rotate([0,0,-1*angle]) translate([0,-1*(r1+r2), -mainthick/2])cube([length,r1+r2, mainthick*2]);
		translate([0,baseW, -mainthick/2]) rotate([0,0,angle])cube([ length,r1+r2, mainthick*2]);
		
		
		//bottom angles
		translate([0,baseW,thick])rotate([180,0,0])
		{
			translate([0,baseW,0]) rotate([0,0,angle])rotate([sideangle,0,0])cube([ length,r1+r2, thick+r1]);
			rotate([0,0,-1*angle])translate([0,-1*(r1+r2),0])translate([0,(r1+r2),0])rotate([-1*sideangle,0,0])
				translate([0,-1*(r1+r2),0])cube([length,r1+r2, thick+r1]);
			rotate([0,sideangle,0])translate([-2*thick,0,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
			translate([length,-1*length*tan(angle),0])rotate([0,-1*sideangle,0])cube([2*thick,baseW+2*length*tan(angle),2*thick]);
		}

		//top bottom
		translate([0,-1*length*tan(angle),mainthick])cube([length,baseW+2*length*tan(angle),2*mainthick]);
		translate([0,-1*length*tan(angle),-2*mainthick])cube([length,baseW+2*length*tan(angle),2*mainthick]);
	}

}

module roundedInsetSolid(thick=2, length=19.5, r1=2, r2=9.5, angle=13.5, baseW=23, inset =1) 
{
	 topr1=r1-inset;
	topr2=r2-inset;
	x1 = length*sin(angle);
	r1oSet = length/cos(angle)-r1*tan((90+angle)/2);// -r1-r1*tan(angle);//-r1/cos(angle);
	sideoSet = r2*tan((90-angle)/2);// r2*(1- tan(angle));
	sidelen = r1oSet-sideoSet;
	bottomoSet = (length*sin(angle))-r1*tan((90+angle)/2);
	sideangle = atan(inset/thick);
	rotate([0,0,-1*angle])
	{
		translate([r1oSet,r1,0])cylinder(h=thick, r1=r1, r2=topr1,$fn=20);
		translate([sideoSet,r2,0])cylinder(h=thick,r1=r2, r2=topr2,$fn=20);
		translate([sideoSet,0,0])rotate([-1*sideangle,0,0]) cube([sidelen,2*r1,thick+r1]);
	}
	translate([0,baseW,0])rotate([0,0,angle])
	{
		translate([0,-2*r1,0])
		{
			translate([r1oSet,r1,0])cylinder(h=thick, r1=r1, r2=topr1,$fn=20);
			translate([sideoSet,-r2+2*r1,0])cylinder(h=thick,r1=r2, r2=topr2,$fn=20);
			translate([sideoSet,0,0])translate([0,2*r1,0])rotate([sideangle,0,0])translate([0,-2*r1,0]) cube([sidelen,2*r1,thick+r1]);
		}
	}
	translate([0,sideoSet,0])cube([length,baseW-2*sideoSet,thick]);
	translate([r2,-bottomoSet,0])cube([length-r2,baseW+2*bottomoSet,thick]);
}

module main() {
	rotate([0,0,90])
	  translate([-((rowoffset*(NumberOfRows-1))/2),-((columnoffset*(NumberOfColumns-1))/2),0])
    for (column = [0 : NumberOfColumns-1])
      translate([0,column*columnoffset,0])
        for (row = [0 : NumberOfRows-1])
          translate([row*rowoffset,0,0])
            rotate([0,0,(row%2)*180])
              opener_row();
	if (build_plate_selector>=0) build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}

main();
