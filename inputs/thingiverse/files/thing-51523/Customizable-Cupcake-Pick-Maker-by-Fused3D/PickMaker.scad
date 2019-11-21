//	My first OpenSCAD Thingiverse MakerBot Customizer by Fused3D
//	The Cupcake Pick Maker
//	Brought to you by www.fused3d.com
// Get Wood Filament in 1.75mm and 3mm sizes at www.fused3d.com
// We also stock 6in wide Scotchblue Painter's Tape and 12 x 7.25 Inch Sheets that come with the Rep2

// preview[view:south east, tilt:top diagonal]

use <MCAD/fonts.scad>

//	Build Plate Selector: 
//
//	Option ?:   Preset Theme Selection (Prefilled options to base customization on)
//
//   Option 0:   Overall Size Slider
overallSizeOfCupcakePick = 5;  //  [1:10]
//
//	Option 2:	Pick Holder (Toothpick Part) Style (Option 1 is selected as Picks)
//						Rectangle
//						Triangular 1
//						Circular
//						Other ?
toothpickStyle = 2;  //  [0:No Pick,1:Rectangle,2:Triangular 1,3:Triangular 2,4:Circular]
toothpickThicknessRatioToLayer1Thickness = 10; // [1:20]
toothpickHeightScale = 25; // [1:75]
toothpickWidthScale = 18; // [1:50]
//If Great than Zero, the toothpick will have a hole inside shaped like the main toothpick
toothpickBorderSize = 75; // [0:99]

//	Option 2.5:	Number of Picks (Centered)
//						1 Pick total
//						1 Pick per Letter
//						2 Picks per Letter
//						Pick Slider Option (Works if all one 
numberOfToothpicks = 1;  
//  [0:1 Pick Overall,1:1 Toothpick per Letter,2:2 Picks per Letter]

//Negative Moves Toothpick Left, Positive Moves Toothpick Right
xPositionOfToothpick = 0; // [-50:50]
//Negative Moves Toothpick Down, Positive Moves Toothpick Up
yPositionOfToothpick = -10; // [-50:50]
//						
//
//   Option 3: 	2D or 3D (3D allows detachable Pick, disallows certain selections)
//					2D (Flat Layers)
//					3D (Pick is Detachable)
//2dOr3DCupcakePick = 0;  //  [0:2D Layers,1:3D]

use <MCAD/fonts.scad>
thisFont=8bit_polyfont();

//   Option 4: 	Text
//					Line 1: 
line1Text = "HAPPY";
//						Size Ratio Slider
line1FontScale = 22; // [1:100]
//	Distance between Characters, Value of 25 or Less needed to make Without Line Through Text
line1CharacterSpacing = 25; // [1:50]
	line1x_shift=thisFont[0][0] * (((.745 - .5)/25) * line1CharacterSpacing)  + .5;
	line1y_shift=thisFont[0][1];
	line1TheseIndicies=search(line1Text,thisFont[2],1,1);
	line1wordlength = (len(line1TheseIndicies))* line1x_shift;

// Position the First Line of Text on the X and Y 
line1TextXPosition = 21; // [-50:50]
line1TextYPosition = 0; // [-50:50]
line1EveryOtherCharacterIsThicker = 4; // [0:10]
//Sometimes Text needs a line through it to keep everything together
line1PutLineThroughTextThicknessScale = 0; // [0:10]
line1LineThroughTextWidth = 5; // [1:16]
line1LineThroughTextHeight = 3; // [0:8]
//
//					Line 1: 
line2Text = "EASTER";
//						Size Ratio Slider
line2FontScale = 22; // [1:100]
//						Distance between Characters - Slider
line2CharacterSpacing = 25; // [1:50]
	line2x_shift=thisFont[0][0] * (((.745 - .5)/25) * line2CharacterSpacing)  + .5;
	line2y_shift=thisFont[0][1];
	line2TheseIndicies=search(line2Text,thisFont[2],1,1);
	line2wordlength = (len(line2TheseIndicies))* line2x_shift;
echo (line2wordlength);
// Position the First Line of Text on the X and Y 
line2TextXPosition = 17; // [-50:50]
line2TextYPosition = -4; // [-50:50]
line2EveryOtherCharacterIsThicker = 5; // [0:10]
//Sometimes Text needs a line through it to keep everything together
line2PutLineThroughTextThicknessScale = 0; // [0:10]
line2LineThroughTextWidth = 5; // [1:16]
line2LineThroughTextHeight = 4; // [0:8]
//
//					Line 3: 
line3Text = "";
//						Size Ratio Slider
line3FontScale = 15; // [1:100]
//						Distance between Characters - Slider
line3CharacterSpacing = 25; // [1:50]
	line3x_shift=thisFont[0][0] * (((.745 - .5)/25) * line3CharacterSpacing)  + .5;
	line3y_shift=thisFont[0][1];
	line3TheseIndicies=search(line3Text,thisFont[2],1,1);
	line3wordlength = (len(line3TheseIndicies))* line3x_shift;
echo (line3wordlength);

// Position the First Line of Text on the X and Y 
line3TextXPosition = 25; // [-50:50]
line3TextYPosition = 2; // [-50:50]
//Make the Odd Characters slightly raised from the even characters to make them stand out
line3EveryOtherCharacterIsThicker = 5; // [0:10]
//Sometimes Text needs a line through it to keep everything together
line3PutLineThroughTextThicknessScale = 0; // [0:10]
line3LineThroughTextWidth = 5; // [1:16]
line3LineThroughTextHeight = 4; // [0:8]




//   Option 8:	Pick Display Type
//
//	Option  :	Main Display Height Offset Slider (Ratio)
//
//	Option 9:	Pick Main Layer Type
//						Shape Design
//						Text (If selected as text, then no other layers can be used)
bottomLayerType = 0;  //  [0:Shape or Design Layers,1:Text which Disables other Layers]

//		Layer 1: Number of Layers if Shape Design.
//duplicateNumberofMainLayer = 0; // [0:3]
//		Pick Layer 1 Color (Just for looks)
//		Pick Layer 1 Theme/Style/Design
layerOneStyle = 1; // [0:Bumpy Circle,1:Easter Bunny,2:Shamrock for St. Patrick's Day,3:Heart,4:Star,5:Flag,6:Sesame Street Sign,7:Dove,8:Rock and Roll Sign,9:Yoda,10:Top Hat,11:Circle,12:Square]
//Negative Moves Layer One Left, Positive Moves Layer One Right
xPositionOfLayerOne = 0; // [-50:50]
//Negative Moves Toothpick Down, Positive Moves Layer One Up
yPositionOfLayerOne = 0; // [-50:50]
//What Height should the entire Layer Be?
overallLayerOneHeight = 50; // [1:100]
//What Width should the entire Layer Be?
overallLayerOneWidth = 50; // [1:100]
layerOneThickness = 20; // [1:20]

//		Pick Layer 1 Edge Type: Chamfer or Square
//      Layer 1 Rotation Slider
layerOneRotation = 0; // [0:359]
//


//
//	Option 10:  Pick Layer 2
//						Shape Design
//						Text (If selected as text, no more layers can be used
//						Same as Main Layer but smaller
layer2Type = 0;  //  [0:Shape or Design Layers,1:Text which Disables other Layers]
//		Pick Layer 2 Indent into Previous Layer 
//		Pick Layer 2 Color (Just for looks)
//		Pick Layer 2 Theme/Style
layerTwoStyle = 1; // [0:Bumpy Circle,1:Easter Bunny,2:Shamrock for St. Patrick's Day,3:Heart,4:Star,5:Flag,6:Sesame Street Sign,7:Dove,8:Rock and Roll Sign,9:Yoda,10:Top Hat,11:Circle,12:Square]

//Negative Moves Layer One Left, Positive Moves Layer Two Right
xPositionOfLayerTwo = 2; // [-50:50]
//Negative Moves Toothpick Down, Positive Moves Layer Two Up
yPositionOfLayerTwo = -15; // [-50:50]

//What Height should the entire Layer Be?
overallLayerTwoHeight = 35; // [1:100]
//What Width should the entire Layer Be?
overallLayerTwoWidth = 35; // [1:100]
layerTwoThickness = 3; // [1:20]

//      Layer 2 Rotation Slider
layerTwoRotation = 0; // [0:359]
//

//
//	Option 11:  Pick Layer 3
//						Text (If selected as text, no more layers can be used
//						Shape Design
//						Same as Layer 2 but smaller
//		Layer 3 Size Slider: Ratio (.9 - .1)
layer3Type = 1;  //  [0:Shape or Design Layers,1:Text which Disables other Layers,3:Nothing]
//		Layer 3 Offset Sliders: X, Y : Ratio
//		Pick Layer 3 Indent into Previous Layer 
//			Slider: 0 - 10?  (If more than 0, the next layers will not work)
//		Pick Layer 3 Color (Just for looks)
//		Pick Layer 3 Theme/Style
layerThreeStyle = 0; // [0:Bumpy Circle,1:Easter Bunny,2:Shamrock for St. Patrick's Day,3:Heart,4:Star,5:Flag,6:Sesame Street Sign,7:Dove,8:Rock and Roll Sign,9:Yoda,10:Top Hat,11:Circle,12:Square]

//Negative Moves Layer One Left, Positive Moves Layer Three Right
xPositionOfLayerThree = -8; // [-50:50]
//Negative Moves Toothpick Down, Positive Moves Layer Three Up
yPositionOfLayerThree = -12; // [-50:50]

//What Height should the entire Layer Be?
overallLayerThreeHeight = 35; // [1:100]
//What Width should the entire Layer Be?
overallLayerThreeWidth = 35; // [1:100]
layerThreeThickness = 7; // [1:20]
//		Pick Layer 3 Edge Type: Chamfer or Square
//      Layer 3 Rotation Slider
layerThreeRotation = 0; // [0:359]


module createTextLayer(TextThickness){
 
		lineText(line1Text,line1CharacterSpacing,line1FontScale,line1TextXPosition,line1TextYPosition-.1,TextThickness,line1EveryOtherCharacterIsThicker,line1PutLineThroughTextThicknessScale,line1LineThroughTextWidth,line1LineThroughTextHeight);
		lineText(line2Text,line2CharacterSpacing,line2FontScale,line2TextXPosition,line2TextYPosition-6,TextThickness,line2EveryOtherCharacterIsThicker,line2PutLineThroughTextThicknessScale,line2LineThroughTextWidth,line2LineThroughTextHeight);
		lineText(line3Text,line3CharacterSpacing,line3FontScale,line3TextXPosition,line3TextYPosition-11.9,TextThickness,line3EveryOtherCharacterIsThicker,line3PutLineThroughTextThicknessScale,line3LineThroughTextWidth,line3LineThroughTextHeight);
}

module lineText(text,charSpacingRatio=10,fontScale=10,xPos,yPos,thickness,everyOtherCharHeight,lineThickness,lineWidth,lineYAxis)
{
charSpacing = ((.725 - .5)/25) * charSpacingRatio  + .5;


thisFont=8bit_polyfont();
x_shift=thisFont[0][0] * charSpacing;

y_shift=thisFont[0][1];
	theseIndicies=search(text,thisFont[2],1,1);
	wordlength = (len(theseIndicies))* x_shift;
	//create line through text if required
	
			union() {
		// Create the Text //
			scale([(fontScale/5),(fontScale/5),1])
			translate([-15,0,0])
			if(everyOtherCharHeight>0){
				for( j=[0:(len(theseIndicies)-1)] ) {
					if( (j % 2) == 1 ) // Make every other height thickness different
					{
						translate([ j*8bit_polyfontHW[theseIndicies[j]][1][0]*charSpacing -15.5 + xPos, -8bit_polyfontHW[theseIndicies[j]][1][1]/2 + yPos ,0]) 
						{
							translate([0,lineYAxis,0])
							if(lineThickness > 0) {
								cube([8,lineWidth/8,thickness/10*lineThickness]);
							}
							linear_extrude(height=thickness+(everyOtherCharHeight*(thickness/10)), center=false) polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
						}
					}
					else{
						translate([ j*8bit_polyfontHW[theseIndicies[j]][1][0]*charSpacing -15.5 + xPos, -8bit_polyfontHW[theseIndicies[j]][1][1]/2 + yPos ,0]) 
						{
							translate([0,lineYAxis,0])
							if(lineThickness > 0) {
								cube([8,lineWidth/8,thickness/10*lineThickness]);
							}
							linear_extrude(height=thickness, center=false) polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
						}
					} // Keep Height Thickness the Same
				}
			}
			else{
				for( j=[0:(len(theseIndicies)-1)] ) {
					translate([ j*8bit_polyfontHW[theseIndicies[j]][1][0]*charSpacing -15.5 + xPos, -8bit_polyfontHW[theseIndicies[j]][1][1]/2 + yPos ,0]) 
					{
						translate([0,lineYAxis,0])
						if(lineThickness > 0) {
							cube([8,lineWidth/8,thickness/10*lineThickness]);
						}
						linear_extrude(height=thickness, center=false) polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
					}
				}
			}
		}
}

8bit_polyfontHW = [[0,[8,8]],[1,[8,8]],[2,[8,8]],[3,[8,8]],[4,[8,8]],[5,[8,8]],[6,[8,8]],[7,[8,8]],[8,[8,8]],[9,[8,8]],[10,[8,8]],[11,[8,8]],[12,[8,8]],[13,[8,8]],[14,[8,8]],[15,[8,8]],[16,[8,8]],[17,[8,8]],[18,[8,8]],[19,[8,8]],[20,[8,8]],[21,[8,8]],[22,[8,8]],[23,[8,8]],[24,[8,8]],[25,[8,8]],[26,[8,8]],[27,[8,8]],[28,[8,8]],[29,[8,8]],[30,[8,8]],[31,[8,8]],[32,[8,8]],[33,[8,8]],[34,[8,8]],[35,[8,8]],[36,[8,8]],[37,[8,8]],[38,[8,8]],[39,[8,8]],[40,[8,8]],[41,[8,8]],[42,[8,8]],[43,[8,8]],[44,[8,8]],[45,[8,8]],[46,[8,8]],[47,[8,8]],[48,[8,8]],[49,[8,8]],[50,[8,8]],[51,[8,8]],[52,[8,8]],[53,[8,8]],[54,[8,8]],[55,[8,8]],[56,[8,8]],[57,[8,8]],[58,[8,8]],[59,[8,8]],[60,[8,8]],[61,[8,8]],[62,[8,8]],[63,[8,8]],[64,[8,8]],[65,[8,8]],[66,[8,8]],[67,[8,8]],[68,[8,8]],[69,[8,8]],[70,[8,8]],[71,[8,8]],[72,[8,8]],[73,[8,8]],[74,[8,8]],[75,[8,8]],[76,[8,8]],[77,[8,8]],[78,[8,8]],[79,[8,8]],[80,[8,8]],[81,[8,8]],[82,[8,8]],[83,[8,8]],[84,[8,8]],[85,[8,8]],[86,[8,8]],[87,[8,8]],[88,[8,8]],[89,[8,8]],[90,[8,8]],[91,[8,8]],[92,[8,8]],[93,[8,8]],[94,[8,8]],[95,[8,8]],[96,[8,8]],[97,[8,8]],[98,[8,8]],[99,[8,8]],[100,[8,8]],[101,[8,8]],[102,[8,8]],[103,[8,8]],[104,[8,8]],[105,[8,8]],[106,[8,8]],[107,[8,8]],[108,[8,8]],[109,[8,8]],[110,[8,8]],[111,[8,8]],[112,[8,8]],[113,[8,8]],[114,[8,8]],[115,[8,8]],[116,[8,8]],[117,[8,8]],[118,[8,8]],[119,[8,8]],[120,[8,8]],[121,[8,8]],[122,[8,8]],[123,[8,8]],[124,[8,8]],[125,[8,8]],[126,[8,8]],[127,[8,8]]];

			

module bumpy_circle(bumpycirclethickness) {
	union() {
		echo ("test");
		linear_extrude( height=bumpycirclethickness, center=false, convexity = 10, twist = 0, $fn = 15) 
		circle(22);
		linear_extrude( height=bumpycirclethickness, center=false, convexity = 10, twist = 0, $fn = 20) 
		union(){
			for (i = [0:24]){
				rotate([0,0,i*360/25])translate([-22,0,0])circle(6);
			}
		}
	}
}
module  shamrock(shamrockthickness) {
	translate([-20,18,0])
	color  ([1,1,0.2]) { 
      linear_extrude( height = shamrockthickness, center=false, convexity = 10, twist = 0, $fn = 15) 
            polygon(points = [[23.95,5.15],[25.05,5.55],[26.35,6.05],[27.30,6.65],[28.50,7.00],[29.65,7.40],[30.85,7.60],[31.80,7.55],[32.90,7.25],[33.85,6.75],[34.65,6.00],[35.35,5.25],[35.95,4.30],[36.50,3.45],[37.05,2.00],[37.20,1.10],[37.10,0.10],[36.90,-0.90],[36.60,-1.85],[36.15,-2.90],[35.65,-3.85],[34.75,-5.40],[33.50,-6.75],[31.75,-8.80],[29.65,-10.80],[27.70,-12.60],[25.60,-14.45],[26.00,-14.50],[26.50,-14.35],[27.15,-13.95],[28.55,-13.15],[29.90,-12.30],[31.15,-11.40],[32.55,-10.50],[34.00,-9.55],[35.05,-8.90],[36.40,-8.65],[37.70,-8.55],[39.25,-8.60],[40.55,-8.80],[41.85,-9.25],[43.05,-9.70],[44.05,-10.25],[45.05,-10.95],[45.95,-11.75],[46.60,-12.85],[47.05,-13.65],[47.35,-14.80],[47.50,-15.85],[47.40,-17.05],[47.10,-18.05],[46.35,-19.30],[45.60,-20.45],[44.40,-21.75],[43.35,-23.15],[42.20,-24.55],[41.55,-26.00],[41.20,-27.05],[41.30,-27.95],[41.30,-28.85],[41.25,-30.30],[41.20,-32.05],[41.00,-33.25],[40.85,-34.25],[40.55,-35.20],[40.25,-36.10],[39.75,-36.90],[39.15,-37.80],[38.25,-38.50],[37.10,-39.10],[35.95,-39.35],[34.60,-39.50],[33.05,-39.45],[31.50,-39.20],[30.10,-38.80],[28.80,-38.20],[27.55,-37.25],[26.35,-36.05],[25.75,-35.35],[24.80,-34.25],[24.10,-33.35],[22.95,-31.90],[21.75,-30.20],[21.85,-32.10],[22.00,-34.00],[22.25,-36.15],[22.60,-38.05],[23.10,-39.30],[23.70,-40.50],[24.30,-41.45],[24.90,-42.20],[25.55,-43.00],[26.65,-44.15],[28.20,-45.55],[26.55,-44.70],[25.40,-44.10],[24.55,-43.90],[23.75,-43.65],[22.95,-43.75],[22.20,-44.15],[20.95,-44.95],[19.80,-45.75],[18.75,-46.75],[17.60,-43.95],[16.85,-42.00],[16.10,-39.45],[15.65,-37.55],[15.40,-35.85],[15.40,-34.30],[15.50,-32.45],[15.85,-30.55],[15.95,-29.55],[14.95,-30.50],[13.85,-31.85],[12.30,-33.80],[10.95,-35.05],[9.60,-36.00],[8.50,-36.45],[7.10,-36.95],[5.90,-37.05],[4.60,-37.00],[3.00,-36.85],[1.90,-36.55],[0.50,-36.10],[-0.80,-35.35],[-2.20,-34.40],[-3.40,-33.05],[-4.05,-31.80],[-4.30,-30.30],[-4.30,-28.60],[-4.30,-27.50],[-4.10,-26.40],[-3.60,-25.30],[-2.85,-23.90],[-2.50,-23.00],[-2.30,-22.05],[-2.45,-21.05],[-2.90,-20.15],[-3.70,-19.00],[-4.50,-17.90],[-5.35,-16.75],[-6.05,-15.60],[-6.40,-14.20],[-6.40,-12.55],[-5.95,-10.90],[-5.40,-9.55],[-4.75,-8.60],[-4.10,-7.65],[-3.15,-6.75],[-2.05,-6.05],[-0.75,-5.40],[0.60,-5.15],[2.00,-5.15],[3.65,-5.55],[5.35,-6.10],[6.75,-6.75],[8.30,-7.75],[9.85,-8.85],[11.60,-10.35],[13.10,-11.70],[15.05,-13.90],[14.95,-12.85],[14.75,-11.95],[14.30,-11.00],[13.50,-10.00],[12.40,-8.90],[11.10,-7.45],[9.35,-5.55],[8.45,-4.30],[7.60,-2.70],[7.20,-1.40],[6.90,-0.25],[6.85,1.25],[6.95,2.55],[7.20,3.95],[7.55,4.95],[8.05,5.85],[8.65,6.80],[9.25,7.40],[10.15,8.15],[11.10,8.65],[12.15,9.10],[13.40,9.35],[14.60,9.40],[16.00,9.20],[17.20,8.75],[18.40,8.25],[19.40,7.55],[20.40,6.70],[21.55,5.90],[22.35,5.35],[23.10,5.10]]
,paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191]]
            );
			}
		}
module  bunny_poly(bunnythickness) 
{ 
	translate([-22,38,0])
	scale([1.3,1.3,1])
	color  ([0,0.6,0]) 
	{ 
      linear_extrude( height = bunnythickness, center=false, convexity = 10, twist = 0, $fn = 10) 
         polygon(points = [[19.25,-16.25],[17.35,-16.10],[15.70,-16.40],[15.30,-12.35],[14.90,-9.10],[14.15,-5.35],[13.05,-2.20],[11.50,1.35],[10.20,3.25],[8.30,5.20],[5.90,6.65],[3.90,7.40],[1.35,7.60],[-0.75,7.20],[-2.45,6.40],[-4.10,4.80],[-5.20,3.00],[-5.90,0.85],[-6.45,-1.45],[-6.45,-4.40],[-5.80,-6.65],[-4.95,-8.70],[-3.80,-10.75],[-2.45,-12.85],[-1.00,-15.10],[0.05,-16.50],[1.05,-18.05],[2.15,-19.50],[3.15,-20.80],[0.90,-22.65],[-0.55,-24.25],[-1.65,-26.00],[-2.25,-28.00],[-2.45,-30.40],[-2.20,-32.00],[-1.40,-34.20],[-0.70,-35.70],[0.55,-37.30],[1.95,-38.65],[3.55,-39.80],[5.70,-40.90],[8.05,-41.70],[10.90,-42.35],[14.50,-42.80],[17.05,-43.05],[20.10,-42.80],[23.00,-42.35],[25.25,-42.00],[28.75,-40.85],[31.75,-39.30],[33.95,-37.65],[35.15,-35.90],[36.25,-34.05],[37.05,-31.50],[37.10,-29.15],[36.80,-27.55],[35.85,-25.75],[34.90,-24.25],[33.50,-22.75],[32.45,-21.80],[31.15,-20.75],[34.00,-17.45],[36.00,-14.80],[37.55,-12.75],[38.75,-10.65],[40.30,-8.15],[40.90,-6.05],[41.35,-3.75],[41.35,-1.70],[41.00,0.20],[40.55,1.65],[39.80,3.10],[38.85,4.45],[37.90,5.40],[36.75,6.35],[35.20,7.15],[33.70,7.40],[31.80,7.40],[30.15,7.00],[28.15,6.10],[26.35,5.00],[24.50,3.15],[23.25,1.25],[22.40,-0.50],[21.50,-2.65],[21.05,-4.45],[20.50,-6.45],[19.85,-8.90],[19.50,-11.05],[19.25,-13.10]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89]]);
		}
}
module  heart_polygon(heartThickness) 
{ 
	translate([-22,19.5,0])
	scale([1.05,1.05,1])
	color  ("red") 
	{ 
      linear_extrude( height = heartThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
      polygon(points = [[20.85,-0.55],[21.95,1.35],[23.05,2.80],[24.05,3.70],[25.00,4.55],[26.00,5.20],[26.95,5.70],[28.20,6.20],[29.40,6.60],[30.75,6.90],[32.10,7.10],[33.45,7.20],[34.80,7.25],[36.45,7.00],[38.10,6.65],[39.80,6.10],[41.55,5.20],[42.95,4.40],[44.00,3.55],[45.00,2.75],[45.70,2.00],[46.60,0.85],[47.40,-0.20],[48.05,-1.25],[48.55,-2.45],[49.00,-3.60],[49.35,-4.75],[49.65,-5.85],[49.80,-7.10],[49.95,-8.45],[49.95,-10.00],[49.75,-11.70],[49.40,-13.70],[49.00,-15.30],[48.40,-16.85],[47.80,-18.50],[47.05,-20.00],[46.30,-21.35],[45.45,-22.85],[44.55,-24.20],[43.45,-25.75],[41.50,-28.15],[39.10,-30.70],[36.50,-33.20],[32.50,-36.50],[29.35,-38.90],[25.15,-41.85],[21.00,-44.60],[16.90,-41.90],[13.15,-39.40],[9.75,-36.90],[6.40,-34.00],[3.10,-30.95],[0.35,-28.00],[-1.65,-25.50],[-3.15,-23.35],[-4.30,-21.45],[-5.60,-19.30],[-6.50,-17.15],[-7.10,-15.35],[-7.70,-13.05],[-7.95,-10.95],[-8.10,-9.15],[-8.10,-7.65],[-7.95,-6.45],[-7.55,-4.90],[-7.15,-3.55],[-6.85,-2.65],[-6.40,-1.70],[-5.90,-0.75],[-5.30,0.25],[-4.60,1.15],[-3.95,1.95],[-3.00,2.95],[-1.90,3.90],[-0.80,4.75],[0.35,5.35],[1.55,6.00],[2.80,6.40],[4.05,6.85],[5.25,7.05],[6.50,7.20],[8.05,7.20],[9.45,7.15],[11.20,6.90],[12.35,6.70],[13.35,6.35],[13.95,6.10],[14.80,5.75],[15.55,5.40],[16.25,4.95],[17.05,4.45],[17.75,3.85],[18.40,3.20],[19.05,2.55],[19.50,2.00],[20.00,1.30],[20.50,0.60]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97]]);
		}
	}
module  star_poly(starThickness) 
{ 
	translate([-30,33,0])
	scale([1.5,1.5,1])
	color  ([1,1,1]) 
	{ 
      linear_extrude( height = starThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
      	polygon(points = [[20.55,8.50],[14.05,-11.05],[-7.05,-10.95],[10.00,-24.60],[3.85,-45.25],[21.30,-32.15],[38.70,-45.25],[31.70,-24.50],[49.45,-11.05],[27.45,-10.90]],paths = [[0,1,2,3,4,5,6,7,8,9]]);
	}
}
module  flag_poly(flagThickness) 
{ 
	translate([5,17,0])
	scale([1,1,1])
	color  ([0,0.8,0.6]) 
	{ 
      linear_extrude( height = flagThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
      polygon(points = [[-7.40,1.80],[56.00,-16.95],[-7.40,-35.70]],paths = [[0,1,2]]);
	}
}
module  sesamest_poly(sesameThickness) 
{ 
	translate([-24.5,37,0])
	scale([1,1,1])
	color  ([0.2,1,0.6]) 
	{ 
      linear_extrude( height = sesameThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
      polygon(points = [[-7.25,-42.10],[-7.25,-32.05],[-6.95,-30.85],[-6.40,-30.00],[-5.55,-29.35],[-4.50,-28.70],[11.90,-28.45],[12.95,-27.35],[14.25,-26.10],[15.25,-24.85],[16.30,-23.70],[17.35,-22.55],[18.55,-21.45],[19.80,-20.55],[21.20,-19.90],[22.60,-19.40],[24.10,-19.30],[26.05,-19.35],[27.85,-19.80],[29.30,-20.55],[30.50,-21.50],[31.55,-22.45],[32.60,-23.35],[33.75,-24.50],[34.85,-25.70],[36.40,-27.15],[37.65,-28.35],[53.30,-28.45],[54.45,-28.70],[55.30,-29.35],[55.95,-30.15],[56.40,-30.90],[56.55,-31.85],[56.55,-42.30],[56.25,-43.30],[55.75,-44.00],[55.10,-44.65],[54.15,-45.20],[53.40,-45.30],[-3.95,-45.55],[-4.70,-45.25],[-5.55,-44.75],[-6.10,-44.20],[-6.75,-43.55],[-7.05,-43.00]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44]]);
	}
}
module 3d_egg(){
	egginess = 0; //[-100:100]

	translate([28,0,0])
	rotate([0,270,0])
	scale([.57,.57,.57])
	egg(curveFactor = (100 + egginess) / 100);

	//This makes an egg
	//New
	//-Fixed egg floating above 0 now sits on 0 like a cylinder
	module egg( steps = 60, height = 100, curveFactor = 1, faces = 60 ) {

    	a = height;
    	b = height * (0.78 * curveFactor);  //Through keen observation I have determined that egginess should be 0.78

    	//Equation for the egg curve
    	function eggCurve( offset ) = sqrt( 
                                  a - b - 2 * offset * step 
                                  + sqrt( 4 * b * offset * step + pow(a - b, 2) ) ) 
                                  * sqrt(offset * step) / sqrt(2);
	
		step = a / steps;
		union() {
        	//This resembles the construction of a UV sphere
        	//A series of stacked cylinders with slanted sides
        	for( i = [0:steps]) {
		  	//echo(i * step);
		  	translate( [0, 0, a - ( i + 1 ) * step - 0.01] )
		    	cylinder( r1 = eggCurve( i + 1 ),
		              r2 = eggCurve( i ), 
		              h = step,
		              $fn = faces );
			}
    	}
	}
}
module  dove_poly(doveThickness) 
{ 
	translate([0,-4,0])
	scale([1.7,1.7,1])
	color  ([1,0.5176470588235295,0.058823529411764705]) 
	{ 
      linear_extrude( height = doveThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
            polygon(points = [[6.10,9.90],[5.55,10.45],[4.60,11.30],[4.00,12.15],[3.25,12.80],[2.45,13.25],[1.55,13.50],[0.75,13.50],[-0.30,13.30],[-1.05,13.00],[-1.85,12.45],[-2.45,11.70],[-2.70,10.80],[-2.75,9.75],[-2.80,8.50],[-2.90,6.40],[-3.10,5.65],[-3.60,5.25],[-4.20,5.00],[-4.75,5.05],[-5.60,5.45],[-6.35,6.05],[-6.75,6.80],[-7.35,7.80],[-7.75,9.00],[-8.30,10.15],[-8.90,11.05],[-9.50,11.60],[-10.55,12.30],[-11.30,12.55],[-12.55,12.80],[-13.50,12.85],[-14.50,12.75],[-15.50,12.55],[-16.45,12.25],[-17.60,11.90],[-18.75,11.55],[-19.80,11.20],[-30.05,10.30],[-29.60,9.60],[-29.05,9.10],[-28.40,8.90],[-27.55,8.50],[-26.70,8.30],[-26.15,8.15],[-25.60,7.80],[-25.10,7.30],[-24.70,6.75],[-24.70,6.10],[-24.75,5.65],[-24.50,5.05],[-23.65,4.80],[-22.90,4.65],[-22.70,4.15],[-22.55,3.65],[-22.10,3.00],[-21.65,2.80],[-20.90,2.80],[-19.95,2.80],[-19.40,2.90],[-18.80,2.95],[-18.15,2.95],[-17.60,2.65],[-17.35,2.20],[-17.25,1.75],[-17.00,1.15],[-16.50,0.75],[-15.90,0.50],[-15.15,0.25],[-14.55,-0.10],[-14.20,-0.75],[-13.90,-1.20],[-13.45,-1.70],[-12.60,-2.10],[-11.80,-2.25],[-10.90,-2.05],[-10.00,-1.90],[-9.40,-2.70],[-9.00,-3.75],[-8.85,-4.45],[-8.95,-5.25],[-9.10,-5.90],[-9.25,-6.80],[-9.65,-7.25],[-9.95,-7.90],[-10.50,-8.35],[-11.10,-8.75],[-11.90,-9.20],[-13.00,-9.75],[-15.00,-10.50],[-15.95,-10.90],[-16.50,-11.25],[-16.65,-11.60],[-16.50,-12.05],[-16.10,-12.15],[-15.40,-12.30],[-14.70,-12.50],[-14.90,-12.90],[-15.40,-13.65],[-16.00,-14.60],[-16.20,-15.30],[-16.05,-16.00],[-15.65,-16.35],[-15.10,-16.45],[-14.45,-16.65],[-13.75,-16.80],[-13.95,-18.10],[-14.40,-19.25],[-14.75,-19.95],[-15.15,-20.40],[-15.45,-20.75],[-15.40,-21.15],[-15.10,-21.45],[-14.60,-21.60],[-13.80,-21.55],[-12.80,-21.35],[-12.00,-20.95],[-11.15,-20.75],[-11.05,-21.60],[-10.75,-22.45],[-10.50,-22.90],[-10.15,-23.35],[-9.80,-23.75],[-9.40,-23.90],[-9.10,-23.55],[-8.75,-23.20],[-7.05,-21.15],[-6.45,-21.40],[-6.00,-21.80],[-5.20,-22.00],[-4.65,-21.90],[-4.15,-21.50],[-4.10,-20.85],[-4.10,-20.10],[-3.85,-19.55],[-3.45,-19.25],[-3.05,-19.35],[-2.45,-19.65],[-2.05,-19.90],[-1.35,-20.05],[-0.65,-19.75],[-0.55,-19.05],[-0.75,-18.05],[-1.10,-17.20],[-1.90,-15.40],[-2.65,-14.15],[-3.55,-13.00],[-3.80,-12.30],[-4.00,-11.55],[-3.75,-10.95],[-3.15,-10.50],[-2.55,-10.00],[-1.90,-9.65],[-0.95,-9.45],[-0.10,-9.10],[0.80,-8.65],[1.50,-8.25],[2.15,-7.50],[2.75,-6.85],[3.15,-5.95],[3.75,-5.15],[4.45,-4.65],[5.40,-4.50],[6.05,-4.65],[6.75,-4.75],[7.45,-4.70],[8.10,-4.65],[8.50,-4.25],[8.85,-3.70],[9.15,-3.00],[9.50,-2.50],[9.90,-2.10],[10.45,-1.90],[11.05,-1.80],[11.70,-1.95],[12.35,-2.00],[12.85,-2.00],[13.30,-1.75],[13.70,-1.05],[13.85,-0.45],[14.05,0.00],[14.45,0.35],[15.00,0.60],[15.70,0.90],[16.45,1.15],[17.20,1.45],[17.75,1.65],[18.35,2.00],[18.75,2.75],[19.00,3.50],[19.15,4.10],[19.35,4.75],[19.85,5.15],[20.40,5.30],[21.10,5.45],[21.75,5.55],[22.35,5.70],[23.05,6.05],[23.45,6.60],[24.10,7.50],[24.75,8.10],[25.30,8.65],[25.95,9.05],[26.80,9.25],[27.70,9.40],[29.95,9.40],[28.90,10.35],[28.25,10.80],[27.30,11.10],[26.35,11.30],[25.40,11.45],[23.35,11.65],[21.30,11.65],[18.90,11.70],[17.20,11.65],[15.70,11.35],[14.90,11.15],[13.80,10.75],[12.95,10.35],[12.20,9.90],[11.45,9.55],[10.25,9.00],[9.20,8.45],[8.40,7.95],[7.70,7.25],[7.05,6.50],[6.55,5.75],[5.90,5.05],[5.35,4.70],[4.90,4.50],[4.45,4.50],[3.85,4.55],[3.50,4.90],[3.25,5.30],[3.20,5.85],[3.30,6.45],[3.50,7.15],[3.80,7.65],[4.30,8.35],[4.85,8.95],[5.50,9.50]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240]]            );
	}
}
module  rockrollsign_poly(rockrollThickness) 
{ 
	translate([0,0,0])
	scale([1.3,1.3,1])
	color  ([0.4,0.6,0]) 
	{ 
      linear_extrude( height = rockrollThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
            polygon(points = [[4.55,21.40],[4.85,20.25],[5.15,19.20],[5.60,18.45],[6.30,17.65],[6.95,17.10],[7.95,16.40],[8.80,15.85],[9.75,15.70],[10.55,15.55],[11.30,15.50],[11.85,15.15],[12.20,14.65],[12.30,13.90],[12.00,13.30],[11.35,12.80],[10.45,12.30],[9.95,11.90],[9.00,11.25],[8.30,10.70],[8.20,5.55],[13.55,5.65],[14.50,5.65],[15.30,6.00],[15.95,6.60],[16.30,7.30],[16.05,7.95],[15.75,8.70],[16.00,9.35],[16.65,9.75],[17.40,10.10],[18.10,9.95],[18.70,9.35],[18.95,8.35],[19.15,7.50],[19.55,6.70],[20.30,5.80],[21.30,5.00],[22.30,4.50],[23.35,4.30],[24.55,4.20],[25.55,3.70],[25.40,3.05],[25.40,2.30],[24.90,1.50],[23.90,0.90],[21.45,-0.60],[21.30,-6.00],[21.55,-6.90],[22.05,-7.50],[22.75,-8.05],[23.25,-8.50],[24.15,-8.55],[24.55,-8.55],[25.10,-9.05],[25.40,-9.70],[25.65,-10.30],[25.60,-11.00],[25.25,-11.75],[24.40,-11.80],[23.30,-11.90],[20.20,-14.25],[20.20,-14.90],[20.20,-15.35],[19.60,-16.00],[18.95,-16.40],[17.85,-16.55],[16.65,-15.90],[15.60,-15.10],[14.65,-14.70],[9.00,-14.50],[8.25,-14.00],[7.40,-13.50],[6.55,-13.60],[5.85,-14.00],[4.25,-14.85],[-10.15,-15.00],[-11.05,-15.50],[-11.25,-16.15],[-11.40,-16.95],[-11.30,-17.75],[-11.15,-18.60],[-11.40,-19.10],[-12.15,-19.40],[-13.50,-19.35],[-14.05,-18.45],[-14.15,-17.25],[-14.50,-16.15],[-16.85,-13.75],[-17.75,-13.35],[-18.75,-13.50],[-19.65,-13.65],[-20.45,-13.20],[-20.80,-12.35],[-21.00,-11.50],[-20.50,-11.05],[-19.60,-10.85],[-18.60,-10.50],[-16.90,-8.75],[-16.80,-3.00],[-17.00,-2.05],[-17.70,-2.20],[-17.70,-2.70],[-17.60,-3.75],[-17.70,-4.65],[-18.00,-5.50],[-19.00,-5.85],[-20.15,-5.80],[-20.90,-5.30],[-21.10,-4.15],[-21.25,-3.15],[-21.90,-1.90],[-23.20,-0.85],[-24.25,-0.35],[-25.40,-0.10],[-26.45,-0.10],[-27.30,0.50],[-27.65,2.05],[-27.00,2.65],[-26.00,3.15],[-25.10,3.80],[-24.10,4.70],[-23.20,5.55],[-23.15,8.20],[-23.85,9.35],[-24.80,10.50],[-26.15,10.75],[-27.00,10.65],[-27.70,11.10],[-28.10,11.85],[-27.95,12.85],[-27.20,13.50],[-26.25,13.90],[-24.95,14.15],[-21.90,17.10],[-22.00,18.55],[-21.90,19.55],[-21.25,20.40],[-20.45,20.65],[-19.40,20.35],[-18.70,19.40],[-18.20,18.25],[-17.85,17.55],[-16.60,16.65],[0.75,16.60],[1.65,16.70],[2.40,17.65],[2.95,18.65],[2.80,19.40],[2.70,20.15],[3.25,20.90],[3.85,21.45]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151]]            );
	}
}
module  yoda_poly(yodaThickness) 
{ 
	translate([0,0,0])
	scale([1.3,1.3,1])
	color  ([0.4,0.8,0.2]) 
	{ 
      linear_extrude( height = yodaThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
            polygon(points = [[-1.00,19.85],[0.65,19.80],[1.75,19.50],[3.45,18.95],[4.65,18.40],[6.00,17.30],[7.30,15.85],[9.40,14.15],[10.10,13.25],[12.00,12.70],[12.65,12.05],[13.75,11.55],[14.90,10.80],[16.00,10.05],[17.05,9.30],[18.00,8.90],[19.35,8.90],[20.90,9.35],[22.05,9.80],[23.25,10.30],[24.75,10.65],[26.00,10.35],[27.35,9.85],[28.55,9.20],[29.15,8.35],[29.35,7.70],[28.10,7.65],[26.80,7.75],[25.70,7.65],[24.60,6.95],[23.95,6.15],[21.90,4.20],[20.90,3.05],[20.05,2.30],[19.35,1.55],[18.25,1.25],[17.20,1.10],[16.65,0.50],[16.20,-0.05],[16.05,-1.00],[15.60,-1.90],[15.15,-2.60],[14.50,-3.20],[13.40,-4.35],[12.90,-5.15],[12.65,-5.75],[12.50,-7.55],[13.05,-8.25],[13.80,-8.70],[15.05,-9.10],[16.40,-9.50],[17.60,-9.95],[18.60,-10.70],[19.20,-11.60],[19.90,-12.85],[20.65,-14.15],[21.40,-15.50],[22.05,-16.65],[22.45,-17.90],[-19.10,-17.85],[-18.50,-16.10],[-17.60,-13.95],[-16.85,-12.30],[-16.20,-11.15],[-15.35,-10.20],[-14.25,-9.45],[-13.30,-9.25],[-12.20,-8.65],[-10.95,-8.10],[-9.80,-7.60],[-11.00,-5.70],[-12.70,-3.15],[-13.40,-1.95],[-14.35,-1.85],[-15.40,-1.80],[-17.15,-1.15],[-18.50,-0.35],[-19.75,0.70],[-21.05,1.65],[-22.30,2.80],[-23.95,4.50],[-25.35,5.80],[-26.40,7.25],[-27.00,8.35],[-27.50,9.35],[-28.05,9.90],[-27.95,10.45],[-27.30,10.65],[-26.50,10.55],[-25.60,10.20],[-23.90,9.90],[-21.95,9.50],[-20.25,8.95],[-18.45,8.50],[-17.30,8.20],[-15.50,7.60],[-14.75,8.50],[-13.65,9.90],[-12.80,10.85],[-11.95,11.55],[-11.05,11.85],[-11.05,12.85],[-10.35,13.45],[-9.50,14.40],[-8.60,15.30],[-7.20,16.95],[-6.40,17.70],[-5.55,18.60],[-4.55,19.05],[-3.30,19.50],[-2.15,19.80]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110]]            );
	}
}
module  tophat_poly(hat_thickness) 
{ 
	translate([0,0,0])
	scale([1.3,1.3,1])
	color  ("green") 
	{ 
      linear_extrude( height = hat_thickness, center=false, convexity = 10, twist = 0, $fn = 10) 
            polygon(points = [[-20.65,11.90],[-18.00,13.65],[-14.60,14.95],[-11.10,15.80],[-8.00,16.30],[-4.05,16.45],[-0.55,16.55],[3.15,16.40],[6.90,15.85],[10.55,15.15],[12.90,14.45],[14.35,13.95],[15.20,13.15],[15.55,12.20],[15.10,10.45],[14.75,8.75],[14.50,6.40],[14.15,-3.95],[15.55,-3.70],[16.70,-3.60],[18.90,-3.40],[20.75,-3.45],[22.50,-4.10],[23.85,-5.00],[24.75,-6.35],[24.95,-7.60],[24.75,-9.15],[23.95,-10.60],[22.50,-11.70],[19.30,-13.75],[16.75,-14.75],[12.20,-16.35],[8.10,-17.00],[3.25,-17.50],[-10.45,-17.50],[-17.40,-17.55],[-21.15,-17.65],[-23.65,-17.25],[-25.50,-16.45],[-26.65,-15.45],[-27.35,-13.80],[-27.10,-12.85],[-26.55,-11.85],[-25.70,-11.20],[-24.40,-10.40],[-23.10,-9.85],[-21.35,-9.70],[-19.20,-9.95],[-19.30,-0.10],[-19.55,2.70],[-19.95,5.85],[-20.35,8.90]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51]]            );
	}
} 
module  triangularpick1(pickThickness) 
{ 
	translate([0,5,0])
	scale([1,1,1])
	color  ([0.6,0.4,0.2]) 
	{ 
      linear_extrude( height = pickThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
            polygon(points = [[-4.00,0.00],[4.00,0.00],[2.55,-47.80],[2.40,-48.60],[2.15,-49.10],[1.65,-49.45],[1.15,-49.75],[0.35,-49.95],[-0.30,-49.95],[-0.95,-49.65],[-1.55,-49.15],[-1.90,-47.90]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11]]            );
	}
}
module  triangularpick2() 
{ 
	scale([1,1,1])
	color  ([0.4,0.2,0.6]) 
	{ 
      linear_extrude( height = pickThickness, center=false, convexity = 10, twist = 0, $fn = 10) 
            polygon(points = [[4.00,0.00],[3.10,-27.65],[2.85,-29.30],[2.50,-31.35],[2.15,-33.35],[1.85,-35.00],[1.60,-36.25],[1.25,-37.35],[0.75,-38.05],[0.15,-38.55],[-0.60,-38.55],[-1.15,-38.05],[-1.55,-37.05],[-2.20,-34.75],[-2.75,-32.40],[-3.25,-29.05],[-3.40,-27.85],[-4.00,0.00]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]]            );
	}
}


//Create Pick
scale([.5*(overallSizeOfCupcakePick/10),.5*(overallSizeOfCupcakePick/10),.5*(overallSizeOfCupcakePick/10)])
union() {
	// Create Toothpick
color("white")
	scale([toothpickWidthScale/2,toothpickHeightScale/3,1])
	translate([xPositionOfToothpick,yPositionOfToothpick,0])
	createToothpick(toothpickThicknessRatioToLayer1Thickness,layerOneThickness);
color("white")
	translate([xPositionOfLayerOne,yPositionOfLayerOne,0])
	Layer(bottomLayerType,overallLayerOneHeight, overallLayerOneWidth,layerOneThickness,layerOneStyle,layerOneRotation); // Render first layer
	if(bottomLayerType != 1) { // This means that the Bottom Layer does not have text, and that a second layer can be added
		//Render 2nd layer
		
		translate([xPositionOfLayerTwo,yPositionOfLayerTwo,layerOneThickness])
		color("pink")
		Layer(layer2Type,overallLayerTwoHeight,overallLayerTwoWidth,layerTwoThickness,layerTwoStyle,layerTwoRotation);
		//Render 3rd Layer
		if(layer2Type != 1) {
			translate([xPositionOfLayerThree,yPositionOfLayerThree,layerTwoThickness+layerOneThickness])
			Layer(layer3Type,overallLayerThreeHeight,overallLayerThreeWidth,layerThreeThickness,layerThreeStyle,layerThreeRotation);
		} 
	}
}

module Layer(layerType,layerHeight,layerWidth,layerThickness,layerStyle,rotateDeg){
	rotate(rotateDeg)
	if(layerType == 1) {
		scale([layerHeight/50,layerWidth/50,1])
		createTextLayer(layerThickness);
	}
	else if (layerType == 0) { //Layer is a Shape
		scale([layerWidth/13,layerHeight/13,1])
		translate([2,-3,0])
//[0:Bumpy Circle,1:Easter Bunny,2:Shamrock for St. Patrick's Day,3:Heart,4:Star,5:Flag,6:Sesame Street Sign,7:Dove,8:Rock and Roll Sign,9:Yoda,10:Top Hat,11:Circle,12:Square,13:Rectangle]
		if(layerStyle == 0) {bumpy_circle((layerThickness+.2));}
		else if (layerStyle == 1) {bunny_poly((layerThickness+.2));}
		else if (layerStyle == 2) {shamrock((layerThickness+.2));}
		else if (layerStyle == 3) {heart_polygon((layerThickness+.2));}
		else if (layerStyle == 4) {star_poly((layerThickness+.2));}
		else if (layerStyle == 5) {flag_poly((layerThickness+.2));}
		else if (layerStyle == 6) {sesamest_poly((layerThickness+.2));}
		else if (layerStyle == 7) {dove_poly((layerThickness+.2));}
		else if (layerStyle == 8) {rockrollsign_poly((layerThickness+.2));}
		else if (layerStyle == 9) {yoda_poly((layerThickness+.2));}
		else if (layerStyle == 10) {tophat_poly((layerThickness+.2));}
		else if (layerStyle == 11) {
			cylinder (h = layerThickness+.2, r=27, center = false, $fn=100);
		}
		else if (layerStyle == 12) {
			translate([-26,-26,0])			
			cube([52,52,layerThickness+.2], center = false);
		}
	}
}


	module createToothpick(toothpickThickness,layerThickness){	
		thickness = (toothpickThickness/20)*layerThickness;
		if(toothpickStyle == 0) { } // No Toothpick 
		else if (toothpickStyle == 1) // Rectangular Toothpick
		{
			difference(){
				translate([-16,-25,0])
				cube([35,35,thickness], center = false);
				translate([-16+((toothpickBorderSize/100)/2),-25+((toothpickBorderSize/100)/2),-5])
				scale([toothpickBorderSize/100,toothpickBorderSize/100,1])
				cube([35,35,thickness+10], center = false);
			}
		}
		else if (toothpickStyle == 2) {triangularpick1(thickness);}
		else if (toothpickStyle == 3) {triangularpick2(thickness);}//
		else if (toothpickStyle == 4) // Circular Toothpick
		{
			difference(){
				translate([.5,-2,0])
				cylinder (h = thickness, r=14, center = false, $fn=100);
				translate([.5,-2,-2])
				scale([toothpickBorderSize/100,toothpickBorderSize/100,1])
				cylinder (h = thickness+5, r=14, center = false, $fn=100);
			}
		}
	}
