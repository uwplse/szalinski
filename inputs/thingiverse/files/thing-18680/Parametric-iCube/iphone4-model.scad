//Safety = used for padding to avoid deletion with two overlapping surfaces
safety = 2;

//Quality - edges used for circles etc.
// Extra quality used for extreme geometries (the circle that makes the button)
quality = 30;
extra_quality = 30;

//shading factor - when doing single color version, some elements will be shown shaded for visibility
shadingFactor = 0.8;

//How deep a should flush compenent be embedded in the design?
flushEmbed = 3;

//Element corner radius for small elements with rounded corners
elementCornerRadius = 1;

//glass thickness
glassThick = 1.59;

//bevel size
bevel = 0.6;

// Layer dimensions
glassDepth = 9.34;
steelHeight =115.15;
steelWidth=58.55;
steelDepth=glassDepth - 2* glassThick;
glassHeight  = steelHeight - 2 * bevel;
glassWidth  = steelWidth-2 * bevel;

echo(glassHeight);
echo(glassWidth);

frontColor = [0, 0, 0];
sideColor = [0.6, 0.6, 0.6];

//corner
cornerRadius = 8.77;

//front speaker 
frontSpeakerWidth = 11.20;
frontSpeakerHeight = 2.7;
frontSpeakerVerticalCenter = 10.35;
frontSpeakerDepth = 2;
frontSpeakerColor = [0.25, 0.25, 0.25];

//button
frontButtonVerticalCenter = 104.79;
frontButtonRadius = 11.20/2;
frontButtonDepth = 1;
frontButtonColor = [0.25, 0.25, 0.25];
//Calculus to make a sphere to get the right button look
frontButtonSphereRadius = (pow(frontButtonRadius,2) / frontButtonDepth) ; 

//Proximity Sensor
proximityHeight = 1.20;
proximityWidth = 5.86;
proximityVerticalCenter = 5.25;
proximityColor = [.1, .1, .1];

//camera
backCameraCenter = 8.77;  //Both vertical and horizontal
backCameraRadius = 6.92/2;
backCameraColor = [.30,.30,.30];

//flash
flashVerticalCenter= backCameraCenter;
flashHorizontalCenter = 14.91;
flashRadius = 2.91/2;
flashColor = [.70,.70,.70];

//front camera
frontCameraVerticalCenter = frontSpeakerVerticalCenter;
frontCameraHorizontalCenter = 39.28;
frontCameraRadius = 3.68/2;
frontCameraColor = backCameraColor;

//screen
screenHeight = 74.88;
screenWidth = 49.22;
screenVerticalDistance = 20.13;
screenHorizontalDistance = 4.32+ screenWidth;
screenColor = [.1, .1, .1];

//mic & speaker
bottomMicSpeakerHeight = 5.82 - 3.52;
bottomMicSpeakerWidth = 51.26 - 44.28;
bottomMicSpeakerLeftHorizontalDistance = 51.26;
bottomMicSpeakerRightHorizontalDistance = 15.27;
bottomMicSpeakerDepth=frontSpeakerDepth;
bottomMicSpeakerColor = frontSpeakerColor;

//Sim slot
simVerticalDistance = 52.01;
simWidth = 69.98 - 52.01;
//simFrontDistance = 3.52;
simHeight = 5.83 - 3.52;	
simColor = [.70,.70,.70];

//jack 
jackHorizontalDistance = 46.51;
jackRadius = 5 / 2;
jackDepth = 10;
jackColor = [0.25, 0.25, 0.25];

//top mic
topMicHorizontalDistance = 41.82;
topMicRadius = 0.9 / 2; 
topMicDepth = 2;
topMicColor = jackColor;

//Connector
//connector_edge_distance = 3.14;
connectorHeight = 6.20 - 3.14;
connectorWidth = 40.28 - 18.27;
connectorDepth = 4;
connectorColor = jackColor;

//Mute switches
muteDepth =0.63;
muteTop = 10.17;
muteHeight = 16.13-muteTop;
muteWidth=6.17-3.17;
muteSlotColor=[.8,0,0];
muteButtonColor=sideColor;

//Up/down switches
upDownDepth = 0.58;
upDownRadius = 4.8 / 2; 
upCenter = 24.63;
downCenter = 34.92;
upDownColor = sideColor;

//sleep button
sleepHorizontalDistance = 19.54;
sleepWidth = sleepHorizontalDistance- 9.44;
sleepHeight = 6.17 - 3.17;
sleepDepth = 0.58;
sleepColor =[.75,.75,.75];

//show_flush - show/hide all flush components e.g. camera, flash, scren
//show_buttons - show side buttons
//show_front - show front items - button and speaker
//show_connector - show connector
//show_misc_side - show misc side items, speaker, mic, sim etc..
//singleColor - select which color to paint the entire phone to make it easy to see in drawings

iphone4(true, true, true, true, true);
translate([0, 70, 0]) iphone4(true, true, true, true, true, [0,.7,0]);

module iphone4(show_connector=false, show_buttons=false, show_front=false, show_flush=false, show_misc_side=false, singleColor=[-1, -1, -1]) {
	// Generate shaded color for single color use (which is really dual color)
	shadedSingleColor = singleColor*shadingFactor;

	//Color mingling - if no color is given we represent a fairly realistic view
	frontColor = singleColor[0] == -1 ?  frontColor : singleColor;
	sideColor = singleColor[0] == -1 ? sideColor :singleColor;
	frontSpeakerColor = singleColor[0] == -1 ?  frontSpeakerColor : shadedSingleColor;
	frontButtonColor = singleColor[0] == -1 ?  frontButtonColor: shadedSingleColor;
	proximityColor = singleColor[0] == -1 ?  proximityColor : shadedSingleColor;
	backCameraColor = singleColor[0] == -1 ?  backCameraColor : shadedSingleColor;
	flashColor = singleColor[0] == -1 ?  flashColor : shadedSingleColor;
	frontCameraColor = singleColor[0] == -1 ?  frontCameraColor : shadedSingleColor;
	screenColor = singleColor[0] == -1 ?  screenColor : shadedSingleColor;
	bottomMicSpeakerColor = singleColor[0] == -1 ?  bottomMicSpeakerColor : shadedSingleColor;
	simColor = singleColor[0] == -1 ?  simColor : shadedSingleColor;
	jackColor = singleColor[0] == -1 ?  jackColor : shadedSingleColor;
	topMicColor = singleColor[0] == -1 ?  topMicColor : shadedSingleColor;
	connectorColor = singleColor[0] == -1 ?  connectorColor : shadedSingleColor;
	muteSlotColor = singleColor[0] == -1 ?  muteSlotColor : shadedSingleColor;
	muteButtonColor = singleColor[0] == -1 ?  muteButtonColor : shadedSingleColor;
	upDownColor = singleColor[0] == -1 ?  upDownColor : shadedSingleColor;
	sleepColor = singleColor[0] == -1 ?  sleepColor : shadedSingleColor;

	union() 
	{
		difference() 
		{
		      base( frontColor,sideColor );	

			if (show_front) {
				frontSpeaker(frontSpeakerColor);
				frontButton(frontButtonColor);	
			}

			//cutout room for flush items to avoid overlapping surfaces
			if (show_flush) {
				proximity(safety,  proximityColor);
				backCamera(safety, backCameraColor);	
				flash(safety, flashColor);	
				frontCamera(safety, frontCameraColor);
				screen(safety, screenColor);
			}

			if (show_misc_side) {
				micSpeaker(bottomMicSpeakerColor);
				sim(safety, simColor);
				jack(jackColor);
				topMic(topMicColor);
			}

			if (show_connector) {	
				connector(connectorColor);
			}

			if (show_buttons) {
				muteSlot(muteSlotColor);
			}
		}

		//reinsert all flush items in the cutouts
		if (show_flush) {
			proximity(0, proximityColor);
			backCamera(0, backCameraColor);
			flash(0, flashColor);
			frontCamera(0, frontCameraColor);
			screen(0, screenColor);
		}

		if (show_buttons) {
			muteButton(muteButtonColor);
			upDown(upDownColor);
			sleepButton(sleepColor);
		}

		if (show_misc_side) {
			sim(0, simColor);
		} 
	}
}

module base(mainColor, sideColor) {
	union() {
		//Create glass-part
		color(mainColor) roundedRect([glassHeight, glassWidth, glassDepth], cornerRadius);
		//Create steel-part
		color(sideColor) translate([0, 0, glassThick]) roundedRect([steelHeight, steelWidth, steelDepth], cornerRadius);
	}
}  

module frontSpeaker(elementColor) {
	color(elementColor)
		translate([-(steelHeight/2-frontSpeakerVerticalCenter), 0 ,glassDepth-frontSpeakerDepth])
				roundedRect([frontSpeakerHeight, frontSpeakerWidth, frontSpeakerDepth+safety], elementCornerRadius);
}

module frontButton(elementColor) {
	color(elementColor) translate([steelHeight/2-(steelHeight-frontButtonVerticalCenter), 0, frontButtonSphereRadius + glassDepth - frontButtonDepth/2])
		sphere(r = frontButtonSphereRadius,$fn=extra_quality);
}

module proximity(space, elementColor) {
	color(elementColor)  
		translate([-(steelHeight/2-proximityVerticalCenter), 0 ,glassDepth-flushEmbed])
			roundedRect([proximityHeight, proximityWidth, flushEmbed + space], elementCornerRadius);
}

module backCamera(space, elementColor) {
	color(elementColor)  
		translate([-(steelHeight/2-backCameraCenter), (steelWidth/2 - backCameraCenter), -space]) 
			cylinder(h = flushEmbed+space, r = backCameraRadius, $fn=quality);
}

module flash(space, elementColor) {
	color(elementColor)  
		translate([-(steelHeight/2-flashVerticalCenter), (steelWidth/2 - flashHorizontalCenter),-space]) 
			cylinder(h = flushEmbed+space, r = flashRadius, $fn=quality);
}

module frontCamera(space, elementColor) {
	color(elementColor)  
		translate([-(steelHeight/2-frontCameraVerticalCenter), (steelWidth/2 - frontCameraHorizontalCenter), glassDepth - flushEmbed]) 
			cylinder(h = flushEmbed+space, r = frontCameraRadius, $fn=quality);
}

module screen(space, elementColor) {
	color(elementColor)  
		translate([-(steelHeight/2-screenVerticalDistance), (steelWidth/2 - screenHorizontalDistance), glassDepth-flushEmbed]) 
			cube([screenHeight, screenWidth, flushEmbed+space]);
}

module micSpeaker(elementColor) {
	color(elementColor)
	union() {
		translate([steelHeight/2-bottomMicSpeakerDepth, bottomMicSpeakerLeftHorizontalDistance-steelWidth/2-bottomMicSpeakerWidth/2, glassDepth/2])
			rotate([0,90,0])
				roundedRect([bottomMicSpeakerHeight, bottomMicSpeakerWidth, bottomMicSpeakerDepth + safety], elementCornerRadius);
		translate([steelHeight/2-bottomMicSpeakerDepth, bottomMicSpeakerRightHorizontalDistance-steelWidth/2-bottomMicSpeakerWidth/2, glassDepth/2])
			rotate([0,90,0])
				roundedRect([bottomMicSpeakerHeight, bottomMicSpeakerWidth, bottomMicSpeakerDepth + safety], elementCornerRadius);
	}
}

module sim(space, elementColor) {
	color(elementColor)  
		translate([-(steelHeight/2-simVerticalDistance-simWidth/2), steelWidth/2 - flushEmbed, glassDepth/2])
			rotate([-90,0,0])
				roundedRect([simWidth, simHeight,  flushEmbed + space], elementCornerRadius);
}

module jack(elementColor) {
	color(elementColor)
		translate([-(steelHeight/2+safety), (steelWidth/2 - jackHorizontalDistance), glassDepth/2]) 
			rotate([0,90,0])
				cylinder(h=jackDepth + safety, r= jackRadius, $fn=quality);
}

module topMic(elementColor) {
	color(elementColor)
		translate([-(steelHeight/2+safety), (steelWidth/2 - topMicHorizontalDistance),glassDepth/2]) 
		rotate([0,90,0])
			cylinder(h=topMicDepth + safety, r = topMicRadius, $fn=quality);
}

module connector(elementColor) {
	color(elementColor)
		translate([steelHeight/2-connectorDepth, 0, glassDepth/2])
		rotate([0,90,0])
			roundedRect([connectorHeight, connectorWidth, connectorDepth + safety], elementCornerRadius);
}

module muteSlot(elementColor) {
	color(elementColor) 
		translate([-(steelHeight/2)+muteHeight/2+muteTop,-steelWidth/2+muteDepth,glassDepth/2])
			rotate([90,0,0])
				roundedRect([muteHeight, muteWidth, muteDepth+safety], elementCornerRadius/2);
}

module muteButton(elementColor) {
	color(elementColor)
		translate([-(steelHeight/2)+muteHeight/2+muteTop,-steelWidth/2+muteDepth,glassDepth/2 - muteWidth/4])
			rotate([90,0,0])
				roundedRect([muteHeight, muteWidth/2, muteDepth*2], elementCornerRadius/2);
}

module upDown(elementColor) {
	color(elementColor)
		union() {
			translate([-(steelHeight/2)+upCenter, -steelWidth/2+safety, glassDepth/2])
				rotate([90,0,0])
					cylinder(h=upDownDepth+safety, r = upDownRadius, $fn=quality);
			translate([-(steelHeight/2)+downCenter, -steelWidth/2+safety, glassDepth/2])
				rotate([90,0,0])
					cylinder(h=upDownDepth+safety, r = upDownRadius, $fn=quality);
	}
}

module sleepButton(elementColor) {
	color(elementColor)
		translate([-(steelHeight/2)-sleepDepth,steelWidth/2-sleepHorizontalDistance+sleepWidth/2, glassDepth/2])
			rotate([90,0,90])
				roundedRect([sleepWidth, sleepHeight, sleepDepth+safety], elementCornerRadius*1.3);
}

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0]) circle(r=radius, $fn=quality);
		translate([(x/2)-(radius), (-y/2)+(radius), 0]) circle(r=radius, $fn=quality);
		translate([(-x/2)+(radius), (y/2)-(radius), 0]) circle(r=radius, $fn=quality);
		translate([(x/2)-(radius), (y/2)-(radius), 0]) circle(r=radius, $fn=quality);
	}
}
