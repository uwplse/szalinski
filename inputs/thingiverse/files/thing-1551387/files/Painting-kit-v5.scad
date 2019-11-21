// preview[view:west, tilt:top]

//Number of facets
$fn=100;

baseDiameter = 150;
baseThickness = 3;
//thickness of water container and color spots
verticalWallThickness = 2;
waterContainerBottomDiameter = 52;
waterContainerTopDiameter = 60;
waterContainerHeight = 40;
//distance between water container edge and base edge
waterContainerDiff = 10; 

colorSpotDiameter = 25;
colorSpotHeight = 5;
//angle of inner color spot wall, 0=perpendicular.
colorSpotAngle = 45; //[0,30,45,60]
//distance among color spot edges
colorSpotDiff = 5; //distance among color spot edges

textTag = "MyTAG";
//you can select font name from here https://www.google.com/fonts
textFont = "Open Sans";
textStyle = "Bold";
textSize = 8;
//text extrusion
textHeight = 2;
//text distance from base center
textDist = 2;

/* [Hidden] */


Base();
WaterContainer();
ColorSpots();


module Base() {
	cylinder(d=baseDiameter, h=baseThickness);
    translate([textDist,0,baseThickness-0.01])
        rotate([0,0,-90]) 
            linear_extrude (height=textHeight)
                text(text=textTag, font=str(textFont,":style=",textStyle), size=textSize, halign="center");
}

module WaterContainer() {
	translate([baseDiameter/2 -waterContainerBottomDiameter/2 - waterContainerDiff,0,baseThickness])
		difference() {
			cylinder (d1=waterContainerBottomDiameter+2*verticalWallThickness, d2=waterContainerTopDiameter+2*verticalWallThickness, h=waterContainerHeight);
			translate([0,0,-0.01])
	      cylinder (d1=waterContainerBottomDiameter, d2=waterContainerTopDiameter, h=waterContainerHeight+0.02);
		}
}

module ColorSpot() {
	translate([0,0,baseThickness])
		difference() { 
			cylinder (d=colorSpotDiameter, h=colorSpotHeight);
			translate([0,0,-0.01]) {
                innerDiameter = colorSpotDiameter - 2*verticalWallThickness - 2*colorSpotHeight*tan(colorSpotAngle);
				cylinder (d1=innerDiameter, d2=colorSpotDiameter - 2*verticalWallThickness, h=colorSpotHeight+0.02);
            }
		}
}

module ColorSpots() {
	//first ring
	angle_start1 = asin ((waterContainerBottomDiameter/2 + verticalWallThickness) / (baseDiameter/2 - waterContainerDiff)); //angle of the first color spot
	number_spots1 = floor((360 - 2*angle_start1)/ (2*asin((colorSpotDiameter+colorSpotDiff)/2/(baseDiameter/2 - colorSpotDiff -  colorSpotDiameter/2))));	
    angle_rot1 = (360 - 2*angle_start1) / number_spots1;
    if (number_spots1 > 1) {
	for(i=[1:number_spots1 - 1]) 
			rotate([0,0,angle_start1 + i*angle_rot1])
			translate([baseDiameter/2 -colorSpotDiameter/2 - colorSpotDiff,0,0])
			ColorSpot();
    }

    //second ring
	angle_start2 = angle_start1 + angle_rot1/2;
	number_spots2 = floor((360 - 2*angle_start2)/ (2*asin((colorSpotDiameter+colorSpotDiff)/2/(baseDiameter/2 - 2* colorSpotDiff -  1.5*colorSpotDiameter))));
	angle_rot2 = (360 - 2*angle_start2) / number_spots2;
    if (number_spots2 > 1) {
	for(i=[1:number_spots2 - 1]) 
			rotate([0,0,angle_start2 + i*angle_rot2])
			translate([baseDiameter/2 -1.5*colorSpotDiameter - 2* colorSpotDiff,0,0])
			ColorSpot();
    }

    //third ring
	angle_start3 = angle_start2 + angle_rot2/2;
	number_spots3 = floor((360 - 2*angle_start3)/ (2*asin((colorSpotDiameter+colorSpotDiff)/2/(baseDiameter/2 - 3* colorSpotDiff -  2.5*colorSpotDiameter))));
	angle_rot3 = (360 - 2*angle_start3) / number_spots3;
    if (number_spots3 > 1) {
	for(i=[1:number_spots3 - 1]) 
			rotate([0,0,angle_start3 + i*angle_rot3])
			translate([baseDiameter/2 -2.5*colorSpotDiameter - 3* colorSpotDiff,0,0])
			ColorSpot();
    }

}


