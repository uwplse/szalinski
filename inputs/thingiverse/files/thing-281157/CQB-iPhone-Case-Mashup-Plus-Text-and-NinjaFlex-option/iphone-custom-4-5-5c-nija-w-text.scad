//preview[view:west,tilt:bottom]

////////////////////////////////////////////////////////////////////////////////////////////
///////////////////          *Customizer variables*          ////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

/* [Basics] */
//Remember to use all of the tabs!
//What color is the case?
primary_color="red"; //[black,silver,gray,white,maroon,red,purple,fuchsia,green,lime,olive,yellow,navy,blue,teal,aqua,brown,sienna]


// Phone type:  If using flex material set the perimiter and height tolerance to 0.1
iphone_version = 2; //[1:iPhone 4,1:iPhone 4S,2:iPhone 5, 3:iPhone 5c, 4:Flex iPhone5(use sturdy+100%infill)]
case_thickness = 2.6; //[1.8:Slim,2.4:Sturdy, 2.6:Flex]
type_of_case = 1; //[1:Stencil,2:Makerbot Geometric Design,3:Mashup]

//Should the case have hooks for a rubber band that holds cash, cards, etc?
include_hooks="no"; //[yes,no]

/* [Stencil] */

//Use http://chaaawa.com/stencil_factory/ then paste here after "Convert&Copy"
input = [[180,162],[[262.67,45.07],[258.26,45.51],[253.5,46.5],[247.86,48.34],[241.32,50.85],[234.4,54.2],[227.82,58.08],[222.44,61.88],[218.36,65.04],[214.84,67.19],[210.68,68.42],[206.75,69.47],[203.66,71.05],[201.26,72.43],[198.97,73],[197.37,73.28],[198.13,74.66],[199.06,77.19],[199.14,81.38],[198.44,85.43],[197.14,87.7],[196.39,88.62],[198.74,88.36],[201.87,88.28],[204.84,88.93],[208.62,91.74],[213.68,96.81],[218.24,102.16],[220.8,105.62],[222.24,107.15],[224.42,107.26],[226.55,107.38],[227.56,109.39],[228.22,112],[234.07,112],[239.52,111.47],[243.41,108.94],[246.89,105.89],[249.45,107.56],[251.25,108.43],[252,108.17],[251.47,107.04],[250.19,105.81],[248.23,103.95],[246.06,101.33],[244.24,97.62],[244.44,91.67],[245.14,85.17],[247.82,86.51],[251.47,88.15],[256.49,90.22],[262.49,92.59],[268.24,101.05],[273.13,109.28],[275.99,117],[277.56,122.33],[277.51,119.7],[276.43,114.47],[274.51,108.62],[272.73,103.33],[271.98,99.42],[271.4,96.12],[270.04,92.27],[267.36,87.99],[263.61,83.66],[259.54,80.2],[256.06,78.02],[253.9,76.9],[253,75.99],[253.51,75.19],[254.75,74.38],[260.69,73.77],[272.5,73.51],[288.5,73.48],[288.5,71.02],[287.86,68.85],[286,67.22],[282.31,66.33],[276,66.41],[267.77,67.58],[258.5,69.66],[249.05,71.74],[241,72.17],[234.02,71.52],[227.76,70.23],[223.7,68.83],[222.01,67.89],[223.75,66.24],[227.94,63.13],[234.42,59.09],[241.69,55.24],[249.53,52.13],[257.5,51.22],[263.81,50.87],[267.75,50.44],[269.39,49.58],[270,48.09],[269.54,46.59],[268.42,45.61],[266.08,45.2],[262.67,45.07]],[[158.6,55],[157.11,55.46],[155.56,56.58],[154.15,58.26],[152.96,60.08],[152.2,63.34],[151.82,68.46],[151.71,74.91],[149.91,73.95],[148.46,72.98],[147.5,72.01],[145.77,70.42],[142.45,67.96],[139.16,66.05],[138,66.24],[138.88,67.7],[141.01,69.35],[144.91,72.24],[150.04,76.7],[154.45,80.48],[156.6,81.73],[156.51,80.42],[155.52,78.04],[154.2,74.4],[153.32,70.08],[153.26,65.63],[153.94,61.69],[155.34,58.97],[157.06,57.48],[159.09,57.25],[161.25,57.56],[163.62,58.61],[166.15,60.13],[168.25,61.45],[169.56,62],[169.53,61.37],[168.4,59.86],[166.11,57.95],[163.28,56.36],[160.58,55.4],[158.6,55]],[[116.77,58.05],[111.72,58.44],[109.34,60.6],[108.15,63.55],[108.88,67.83],[110.52,72.14],[112.74,75.98],[115.49,79.29],[118.43,82.31],[121.5,85.13],[118.64,84.52],[115.91,84.48],[113.39,85.48],[111.7,87.06],[111,88.68],[111.7,90.75],[113.37,93.42],[117.57,97.16],[124.31,101.77],[130.52,105.46],[133.44,107],[133.83,106.76],[134,106.19],[131.68,104.24],[126.09,100.68],[119.56,96.28],[114.97,92.31],[111.76,88.65],[113.54,87.35],[115.55,86.59],[117.91,86.64],[121.43,87.73],[126.26,89.51],[130.46,90.89],[132.48,91.04],[130.76,89.13],[125.99,85.56],[120.16,81.16],[115.9,77.23],[113.27,73.73],[111.37,70.35],[110.4,67.13],[110,64.01],[110.51,61.44],[112.27,60.09],[115.33,59.72],[119.52,60.03],[124.17,61.09],[128.35,62.48],[131.28,63.47],[131.77,62.81],[130.16,61.39],[126.92,59.8],[122.12,58.59],[116.77,58.05]],[[173.92,68],[174.13,69.38],[175.92,72.7],[177.99,76.74],[177.93,79.14],[177.27,80.82],[177,82.43],[177.23,83.54],[177.77,84],[178.87,82.97],[180.43,80.49],[182.8,77.5],[186.41,75.88],[189.67,74.99],[191.75,74.42],[192.63,73.83],[193,72.9],[192.11,72.17],[189.47,72.31],[186.06,73.17],[182.81,74.45],[180.55,75.48],[179.51,75.75],[178.73,74.47],[177.09,71.75],[175.23,69.1],[173.92,68]],[[217.23,74.19],[215.53,74.48],[214.52,75.93],[214.25,77.68],[214.49,78.99],[215.36,79.7],[216.58,80],[217.56,80.56],[217.44,82.39],[217.48,84.6],[219.14,86.39],[220.98,87.53],[222.15,88],[223.11,87.54],[224.43,86.43],[225.54,85.03],[226,83.88],[225.34,82.51],[223.75,80.59],[221.84,78.4],[220.4,76.38],[219.01,74.96],[217.23,74.19]],[[161.62,88],[161.71,88.87],[162.98,90.97],[164.75,93.24],[166.05,94.53],[166.72,94.54],[167,93.73],[166.32,92.12],[164.69,90.17],[162.83,88.64],[161.62,88]],[[176.16,88],[175.21,89.1],[174.41,91.75],[173.65,94.77],[172.75,96.75],[171.54,97.63],[170.03,98],[167.6,98.88],[164.17,100.99],[160.15,104.56],[156.27,108.93],[153.23,112.45],[151.22,113.94],[148.87,113.25],[145.02,111.51],[141.26,109.96],[139.48,110.03],[140.7,111.51],[144.5,113.63],[150.14,116.21],[147.82,117.76],[145.2,119.76],[142.16,122.4],[139.38,125.4],[137.38,128.26],[136.5,130.83],[136.97,132.94],[137.7,135.91],[138,140.34],[138.61,145.6],[141.54,150.04],[145.09,153.87],[148.67,157.14],[153.54,159.89],[160.19,162.5],[166.86,164.26],[171.8,164.99],[175.5,164.69],[179.21,163.96],[181.91,162.83],[182.35,161.47],[181.71,160.59],[180.94,160.54],[178.52,160.61],[173.87,160.06],[168.24,158.59],[164.29,155.79],[161.75,152.85],[160.38,150.36],[160.32,148.21],[160.95,146.09],[161.55,144.41],[160.56,144],[158.86,142.76],[156.89,139.79],[155.57,136.55],[155.87,135.21],[156.67,134.51],[157,133.36],[156.71,132.5],[156,132.5],[155.26,132.55],[154.88,131.81],[154.87,130.3],[154.99,128.5],[155.56,126.28],[156.63,123.74],[158.85,120.99],[162.19,118.24],[165.75,115.87],[168.51,114],[170.83,112.4],[173.33,110.65],[176.19,109.34],[179.37,108.8],[182.78,108.8],[182.28,104.65],[181.19,100.82],[178.86,97.67],[176.58,94.73],[176.58,91.42],[176.77,88.9],[176.16,88]],[[258.29,96.11],[255.3,93.16],[254.04,92.55],[254.33,93.61],[255.07,94.67],[255.88,96.79],[256.32,100.37],[256.54,103.64],[256.8,105],[257.34,104.07],[258.2,101.85],[259.3,98.7],[261.75,102.85],[263.76,105.78],[265.16,107],[265.3,106.08],[264.31,103.86],[261.79,100.29],[258.29,96.11]],[[193.1,95],[193.34,95.95],[195.97,98.25],[200.82,102.03],[206.4,106.55],[213.57,112.39],[222.25,119.32],[229.14,124.37],[232,125.68],[227.23,120.91],[215.75,111.34],[203.55,101.68],[197.03,96.68],[194.85,95.49],[193.1,95]],[[190.75,107.11],[188.78,105.63],[187.91,105.56],[187.72,107.98],[187.39,112.46],[186.64,117.34],[185.46,120.7],[183.61,122.5],[181.24,123.64],[178.6,124.66],[176.1,126.17],[173.69,128.03],[171.81,126.32],[169.92,124.62],[171.45,127.56],[172.54,130.04],[172.99,131.86],[172.37,132.75],[170.25,132.55],[167.5,131.89],[169.75,133.5],[171.34,135.05],[172,136.52],[171.44,138.04],[170.08,139.71],[168.16,141.5],[173.25,141.14],[177.95,141.22],[182.11,141.91],[185.01,143.28],[186.51,145.02],[187.26,146.42],[188.17,147],[188.73,146.56],[188.61,145.5],[187.98,143.96],[187.34,142.36],[187.71,141.1],[192.09,141.35],[199.98,141.99],[211.36,142.64],[225.21,143.31],[226.19,146.1],[227.77,148.5],[230.65,150.05],[233.28,150.69],[234.73,150.61],[234.21,150],[232.14,149.38],[229.71,148.64],[228.35,147.76],[228.33,146.81],[229.12,145.9],[231.12,145.48],[234,145.67],[237.14,146.55],[239.77,147.78],[241.31,149.15],[241.85,150.37],[241.95,151.98],[242.45,154.25],[243.25,156.19],[244.11,157],[244.74,156.77],[245,156.2],[244.65,155.29],[243.82,154.22],[243.11,153.26],[243.07,152.6],[244.21,152.46],[246.35,152.72],[248.9,153.92],[250.97,156.19],[252.52,158.22],[253.37,157.47],[253.82,156.03],[254,154.84],[252.35,152.41],[248.37,147.95],[244.11,143.95],[241.78,142.64],[242.21,144.2],[244.61,147.12],[247.17,150.13],[246.69,151],[244.65,150.08],[242.16,147.85],[238.68,145.12],[233.43,143.49],[227.5,142.27],[232.18,141.53],[235.73,140.57],[237.46,139.25],[237.79,138.1],[237.77,137.5],[235.52,136.73],[230.5,135.17],[223.67,132.57],[217.08,129.28],[210.03,124.28],[202.08,117.55],[195.21,111.21],[190.75,107.11]],[[267.73,112],[267.26,112.51],[267.46,113.75],[268.24,116.45],[269.16,120.5],[270.15,125.06],[271.08,129],[271.68,130.46],[271.48,126.12],[270.8,120.48],[269.84,115.87],[268.75,113.14],[267.73,112]],[[152.13,118.02],[151.28,118.28],[150.11,118.91],[149.07,120.95],[148.66,125.14],[149.08,129.93],[150.55,133.46],[152.5,136.43],[153.15,129.96],[153.45,124.59],[153.27,120.75],[152.72,118.81],[152.13,118.02]],[[277.72,128.9],[277.33,127.38],[277.13,128.5],[276.73,130.99],[275.97,134.17],[274.65,137.45],[272.92,140.17],[270.89,142.5],[271.51,140.25],[271.66,138.63],[271.07,138],[270.31,138.43],[270,139.48],[269.28,140.99],[267.54,142.57],[264.89,143.63],[261.79,143.47],[258.66,142.55],[255.75,141.35],[253.49,140.45],[253,141.37],[254.18,142.84],[257.02,144.39],[261.14,145.53],[265.4,146],[269.5,145.4],[272.77,142.92],[275.25,139.49],[276.98,135.57],[277.69,131.85],[277.72,128.9]],[[242.94,132.73],[239.37,130.39],[238,130.31],[238.71,131.93],[240.43,133.93],[242,135.9],[242.38,137.44],[242.81,138.35],[244.96,138.67],[247.09,138.35],[247.94,137.58],[246.45,135.71],[242.94,132.73]],[[213.24,131],[212.37,131.32],[211.8,132.09],[210.07,133.24],[206.4,134.49],[201.5,135.26],[196.93,134.94],[193.36,134.33],[191,134.06],[190.02,134.2],[190.93,134.94],[193.64,135.78],[198.14,136.52],[203.27,136.69],[207.33,136.06],[210.27,134.68],[212.53,132.96],[213.47,131.58],[213.24,131]],[[133.43,149.59],[131.18,142.5],[130.46,145.33],[130.12,148.76],[130.31,153.01],[131.46,157.88],[133.4,162.8],[136.58,167.55],[140.7,172.01],[145.86,175.86],[151.53,179.13],[156.45,182.02],[159.34,184.99],[160.89,187.12],[162.12,188],[162.67,187.49],[162.58,186.25],[162.95,184.86],[166.84,184.83],[171.41,184.63],[175.56,183.54],[179.46,181.91],[180.73,183.65],[181.63,185.32],[182,186.89],[182.25,187.8],[183.09,187.31],[183.52,185.71],[182.45,182.91],[181.33,180.14],[182.12,179.14],[184.17,177.76],[187.15,175.06],[190.07,171.32],[191.89,167.41],[192.45,163.62],[192.07,160.24],[191.59,157.41],[191.7,155.04],[191.76,153.59],[191.12,153],[190.33,153.57],[190,154.94],[189.71,156.49],[189,157.5],[188.29,158.45],[188,159.86],[186.9,162.16],[184.25,165.25],[179.98,168.41],[174.54,170.45],[169.12,171.55],[164.47,172],[159.83,171.68],[154.43,170.91],[149.28,169.56],[145.24,167.82],[142.01,165.07],[138.83,161.25],[135.95,155.94],[133.43,149.59]],[[217.58,152.75],[216.16,149.5],[216.08,152.68],[216.63,155.62],[218.72,157.99],[221.17,159.52],[222.58,158.56],[224.68,157.37],[228.61,156.9],[232.12,156.69],[230.48,156.07],[227.58,155.06],[224.85,153.64],[222.25,151.93],[221.72,153.97],[221.02,155.4],[220.1,156],[218.91,155.05],[217.58,152.75]],[[181.25,153.09],[179.72,153.86],[177.1,155.59],[174.82,157.5],[175.63,158],[177.64,157.54],[179.78,156.44],[181.35,155.07],[182,153.94],[181.78,153.3],[181.25,153.09]],[[229.01,162.02],[227.5,162.31],[226,163],[225.32,163.78],[227.03,163.98],[229.34,164.61],[231.35,166.1],[233.15,168.2],[241.32,167.49],[247.79,166.56],[251.25,165.24],[252.49,163.88],[253,162.79],[252.35,162.61],[250.78,163.44],[248.71,164.54],[246.86,165],[245.54,164.64],[244.75,163.76],[244.03,163.2],[242.6,164.26],[240.27,165.53],[236.94,166],[233.63,165.54],[231.77,164],[230.44,162.59],[229.01,162.02]],[[174.44,195.57],[169.78,192.66],[167.55,191.92],[168.92,193.71],[172.93,196.87],[178.95,200.67],[185.16,204],[190.44,206.12],[194.25,207],[196.19,206.86],[197,206.51],[196.05,204.9],[193.75,201.73],[190.97,197.98],[188.86,194.97],[187.47,193.45],[186.43,193.26],[186.95,195.32],[189.28,199.22],[191.73,203.01],[192.52,204.82],[190.58,204.33],[186.47,202.62],[180.6,199.48],[174.44,195.57]]];

//If you want to scale your image to less or more than 100% width
image_scale=100;//[10:500]

//If you don't want to center your design on the case
offX =0;
offY =10;
image_rotation =0; //[-180:180]

//First word - consider spaces between letters
word1="E D I N A";

//Font - some may not be available in Thingiverse Customizer
Font = "write/stencil_fix.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy,"write/knewave.dxf":thick,"write/stencil_fix.dxf":stencil(OpenSCAD only)]

//Font Size [4,5,6,7,8,9,10,11,12,13,14,15]
fontSize = 8;

//Font ScaleX (stretch width) [1,1.1,1.2,1.4,1.5,1.6,1.8,2.0,2.2,2.4,2.6]
fontScaleX = 1;

//Font ScaleY (stretch height) [1,1.1,1.2,1.4,1.5,1.6,1.8,2.0,2.2,2.4,2.6]
fontScaleY = 1.5;

//Font Move Vertical  0=Centered 40=Name toward bottom [-60:60]
fontMoveVert=40;

//Font Move Horizontal  0=Centered [-30:30]
fontMoveHoriz=0;

//Word Depth in mm (>1.8 is a cutout on slim, >2.4 is cutout on sturdy,  >4 on 5c) [0:6]
wdepth=5;


	




/* [Geometrics] */

//Select the pattern shape
pattern_shape =6; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]

//Paremeters in mm:
pattern_radius =17; //[4:22]
pattern_overlap = 0; //[0:100]

//Parameters in degrees:
pattern_rotation = 13; //[0:180]

//In .4 mm increments:
pattern_thickness = 25; //[2:30]


/* [Mashup] */
//Select if you want your stencil overlaid on top or fit inside one of the base shapes in the pattern
mashup_type=1;//[1:Stencil Inside Base Shape,2:Stencil On Top]

//Use these index variables to move the stencil to different base shapes, if using that type of mashup
index_i=1;//[-20:20:1]
index_j=0;//[-10:10:1]


/* [Phone Dimensions] */

//Taper angle - this tapers the sides of the case for better grip on your phone
case_taper=3;

//iPhone 4 Variables - Width, Length, Height, Corner Radius, Strip Width, Strip Thickness
4_perimeter_tolerance=.5;
4_height_tolerance=.2;
4width=58.55;	
4length=115.25;
4height=9.5;
4cornerR = 8;
4swidth=6.17;
4sthick=.6;

//iPhone 5 Variables - Width, Length, Height, Corner Radius, Strip Width, Strip Thickness
5_perimeter_tolerance=0.5; //[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]
5_height_tolerance=0.5; //[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]
5width = 58.6;
5length = 123.8;
5height = 7.6;
5cornerR = 8;
5swidth=6.1;
5sthick = 1.0;


////////////////////////////////////////////////////////////////////////////////////////////
///////////////////          *Non customizer variables*          ////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////



module Void(){}

mode="render";

honeycomb_radius = pattern_radius;
honeycomb_radius_modifier = pattern_overlap;
honeycomb_sides = pattern_shape;
honeycomb_rotation = pattern_rotation;
line_thickness = pattern_thickness;
honeycomb_thickness = line_thickness*.4;

stencil_thickness = 10;

cthk = case_thickness;

4ctol = 4_perimeter_tolerance;
4htol = 4_height_tolerance;

5ctol = 5_perimeter_tolerance;
5htol = 5_height_tolerance;

4margin=4width/2-(4width/2-3)*image_scale/100;

5margin=5width/2-(5width/2-3)*image_scale/100;

heightvar=.24;

homebuttonR = 5.6;
homebuttonD = homebuttonR*2;



top_bottom_opening_width = 50;

leftholelength = 25.43;
leftholeR = 2.4;
topholelength = 38.57;
topholeR = 2.5;
bottomholelength1 = 43.97;
bottomholelength2 = 26.05;
bottombigR = 1.53;
bottomsmallR = 1.15;

corner_resolution = 6;
circle_resolution = corner_resolution*4;

fudge = .05;


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////              Final Render                  ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

if(mode=="render")
  difference() {
    color(primary_color)rotate([0,0,90]){
     if (iphone_version ==1){
	     translate([0,0,(4height+cthk/2+2*4htol)/2])iPhone4Case();
     }
     if (iphone_version ==2){
        translate([0,0,(5height+cthk+2*5htol)/2])iPhone5Case();
     }
     if (iphone_version ==3){
        translate([0,0,(5height+cthk+2*5htol)/2])iPhone5cCase();
     }
     if (iphone_version ==4){
        translate([0,0,(5height+cthk+2*5htol)/2])iPhone5CaseNinja();
     }
    }
   words(wordText=word1,
      wordDepth=wdepth,
      textFont=Font,
      fontSize=fontSize,
      moveX=fontMoveVert,
      moveY=fontMoveHoriz,
      scaleX=fontScaleX,
      scaleY=fontScaleY,
      rotateZ=90);
}

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////              test fit                           ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

if(mode=="testfit")
intersection(){
	rotate([0,0,90]){
		if(iphone_version == 1){
			union(){
				color("red")iPhone4Case();
				color("green")translate([0,0,cthk/4])oldiPhone4(w=4width,
						l=4length,
						h=4height,
						cR=4cornerR,
						sw=4swidth,
						st=4sthick,
						taper=case_taper);
			}
		}else{
			union(){
				color("red")iPhone5Case();
				color("green")translate([0,0,0])oldiPhone5(w=5width,
						l=5length,
						h=5height,
						cR=5cornerR,
						sw=5swidth,
						st=5sthick,
						taper=case_taper);
			}
		}
	}
	
	color("white")translate([-100,0,0])cube(200,center=true);

}



/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////             Scratch                         ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

if(mode=="test"){

	%color("red")translate([-4width/2,0,0])rotate([0,10,0])cube(5);

	%color("green")intersection(){
		oldiPhone5(w=5width,
						l=5length,
						h=5height,
						cR=5cornerR,
						sw=5swidth,
						st=5sthick);
		translate([-500,-500,0])cube(1000,center=true);
	}

	%difference(){
		iPhone5(w=5width,
						l=5length,
						h=5height,
						cR=5cornerR,
						sw=5swidth,
						st=5sthick,
						taper=10);
		translate([-500,-500,0])cube(1000,center=true);
	}

iPhone5(w=5width+2*(cthk+5ctol),
					l=5length+2*(cthk+5ctol),
					h=5height+cthk+2*5htol,
					cR=5cornerR+cthk+5ctol,
					sw=5swidth+cthk+2*5ctol,
					st=5sthick,
					taper=case_taper);


}

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////              Modules                        ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


use <write/Write.scad> 

module words(wordText,wordDepth,textFont,fontSize=5,moveX,moveY=0,scaleX=1,scaleY=1,rotateZ=90)
{
   useDepth=wordDepth;
   translate([moveX,moveY,0]) 
     rotate([0,180,rotateZ])
        scale([scaleX,scaleY,1]) 
          write(word1,t=useDepth,h=fontSize,center=true,font=textFont);
}




module oldiPhoneGlass(	w,		//width
				l,		//length
				h,		//height
				r,		//corner radius
				st)   {	//strip thickness



	wi=w-2*st;
	li=l-2*st;
	ri=r-st;

	union(){

		cube([wi,li-ri*2,h],center = true);

		cube([wi-ri*2,li,h],center = true);

		for(i=[1,-1]){
			for(j=[1,-1]){
				translate([i*(wi/2-ri),j*(li/2-ri),0])
					cylinder(	h = h,
							r = ri,
							center = true,
							$fn = circle_resolution);
			}
		}
	}


}

module iPhoneGlass(	w,		//width
				l,		//length
				h,		//height
				r,		//corner radius
				st,		//strip thickness
				taper){	//taper


	wi=w-2*st;
	li=l-2*st;
	ri=r-st;

	tap=h*tan(taper);

	hull(){

		union(){
	
			translate([0,0,-h/2+.005])cube([wi,li-ri*2,.01],center = true);
	
			translate([0,0,-h/2+.005])cube([wi-ri*2,li,.01],center = true);
	
			translate([0,0,-h/2+.005])for(i=[1,-1]){
				for(j=[1,-1]){
					translate([i*(wi/2-ri),j*(li/2-ri),0])
						cylinder(	h = .01,
								r = ri,
								center = true,
								$fn = circle_resolution);
				}
			}
		}

		union(){
	
			translate([0,0,h/2-.005])cube([wi-tap*2,li-ri*2-tap*2,.01],center = true);
	
			translate([0,0,h/2-.005])cube([wi-ri*2-tap*2,li-tap*2,.01],center = true);
	
			translate([0,0,h/2-.005])for(i=[1,-1]){
				for(j=[1,-1]){
					translate([i*(wi/2-ri-tap),j*(li/2-ri-tap),0])
						cylinder(	h = .01,
								r = ri,
								center = true,
								$fn = circle_resolution);
				}
			}
		}

	}

}

module oldiPhoneStrip(	w,		//width
				l,		//length
				h,		//height
				r,		//corner radius
				st	) {	//strip thickness
						
	union(){
		
		cube([w,l-r*2,h],center = true);

		cube([w-r*2,l,h],center = true);

		for(i=[1,-1]){
			for(j=[1,-1]){
				translate([i*(w/2-r),j*(l/2-r),0])
		
					cylinder(	h = h,
								r = r,
								center = true,
								$fn = circle_resolution);
			}
		}
	}
}

module iPhoneStrip(	w,		//width
				l,		//length
				h,		//height
				r,		//corner radius
				st,		//strip thickness
				taper){	//taper

	tap=h*tan(taper);
	
	hull(){					
		union(){
			
			translate([0,0,-h/2+.005])cube([w,l-r*2,.01],center = true);
	
			translate([0,0,-h/2+.005])cube([w-r*2,l,.01],center = true);
	
			translate([0,0,-h/2+.005])for(i=[1,-1]){
				for(j=[1,-1]){
					translate([i*(w/2-r),j*(l/2-r),0])
			
						cylinder(	h = .01,
									r = r,
									center = true,
									$fn = circle_resolution);
				}
			}
		}

		union(){
			
			translate([0,0,h/2-.005])cube([w-2*tap,l-r*2-2*tap,.01],center = true);
	
			translate([0,0,h/2-.005])cube([w-r*2-2*tap,l-2*tap,.01],center = true);
	
			translate([0,0,h/2-.005])for(i=[1,-1]){
				for(j=[1,-1]){
					translate([i*(w/2-r-tap),j*(l/2-r-tap),0])
			
						cylinder(	h = .01,
									r = r,
									center = true,
									$fn = circle_resolution);
				}
			}
		}
	}
}

module iPhoneCameraHole(w,h,r){
	hull(){
		translate([w/2,0,0])
			cylinder(h = h,r = r,center = true, $fn = circle_resolution);
		translate([-w/2,0,0])
			cylinder(h = h,r = r,center = true, $fn = circle_resolution);
	}
}


module rounder(r,len) {
   difference() {
     cube([r,r,len],center=true);
     translate([r/2,r/2,0]) cylinder(r=r,h=len+1,center=true,$fn=16);
   }
}

module MinusRoundedRect(w,h,r){
     difference() {
       cube([w,h,5],center=true);
       union() {
          //bottom right
          translate([-(w/2-r/2+0.1),-(h/2-r/2+0.1),0]) rounder(r,8);
			 //bottom left
          translate([(w/2-r/2+0.1),-(h/2-r/2+0.1),0]) rotate([0,0,90]) rounder(r,8);
       }
     }
}


 

module CooliPhoneCameraHole(w,h,r){
	hull(){
		translate([w/2+(r-r/1.5),(r-r/1.5),0])
			cylinder(h = h,r = r/1.5,r2=r/1.5+.1,center = true, $fn = circle_resolution);
		translate([-w/2-(r-r/2.5),(r-r/1.5),0])
			cylinder(h = h,r = r/2.5,r2=r/2.5+.1,center = true, $fn = circle_resolution);
	}
}


module oldiPhone5(w,l,h,cR,sw,st){
	hull(){
		oldiPhoneGlass(w,l,h,cR,st);
		oldiPhoneStrip(w,l,sw,cR,st);
	}
}

module iPhone5(w,l,h,cR,sw,st,taper){
	hull(){
		iPhoneGlass(w,l,h,cR,st,taper);
		iPhoneStrip(w,l,sw,cR,st,taper);
	}
}


module oldiPhone4(w,l,h,cR,sw,st){
	union(){
		hull(){
			oldiPhoneGlass(w,l,sw+(h-sw)/4,cR,st);
			oldiPhoneStrip(w,l,sw,cR,st);
		}
		oldiPhoneGlass(w,l,h,cR,st);
	}
}

module iPhone4(w,l,h,cR,sw,st,taper){
	union(){
		hull(){
			iPhoneGlass(w,l,sw+(h-sw)/4,cR,st,taper);
			iPhoneStrip(w,l,sw,cR,st,taper);
		}
		iPhoneGlass(w,l,h,cR,st,taper);
	}
}

module 5ccase() {
  difference() {
    union() {
      scale([1.01,1,1]) 
import("iphone_5c_case_9_rep.stl");
      *translate([4.6,44.8,0]) cube([22,14,2],center=false);
    }
    *translate([0,2,0]) hull() {
      translate([21,52.5,0]) cylinder(h=7,r1=6.5,r2=5.2,center=true);
      translate([11,52.5,0]) cylinder(h=7,r1=5.5,r2=4.2,center=true);
    }
  }
}

module loadiPhone5cCase() {
   difference() {
      union() {  // stuff to add
         translate([0,0,-1*(5height+cthk+2*5htol)/2])
             scale([1.01,1,1]) 
					import("iphone_5c_case_shell.stl");
    
      }
      translate([0,0,1.6]) cube(10,center=true);
      union() { // stuff to remove
        scale([-1,1,5])  stencil5c(5width+2*5ctol+5,5length+2*5ctol+5,image_rotation,5margin);
      }
   
   
  }
}


module iPhone5cCase() {
  difference() {
    union() {
     loadiPhone5cCase();  // phone with stencil 
     // hide old camera hole
     translate([0,0,-1*(5height+cthk+2*5htol)/2]) 
        translate([4.6,44.8,0]) cube([22,14,2],center=false);
    }
    // build new camera hole
    translate([0,2,-4]) hull() {
        translate([21,52.5,0]) cylinder(h=7,r1=6.5,r2=5.2,center=true);
        translate([11,52.5,0]) cylinder(h=7,r1=5.5,r2=4.2,center=true);
    }
  }
}

module iPhone5Case(){
		difference(){
			union(){
				iPhone5(w=5width+2*(cthk+5ctol),
					l=5length+2*(cthk+5ctol),
					h=5height+cthk+2*5htol,
					cR=5cornerR+cthk+5ctol,
					sw=5swidth+cthk+2*5ctol,
					st=5sthick,
					taper=case_taper);
				if(include_hooks=="yes")translate([0,0,-(5height+cthk+2*5htol)/2])
					3hooks(w=5width+2*(cthk+5ctol),
						h=5length/3,
						bandd=3.5,
						thick=2,
						depth=8,
						closure=60);
			}

			//taper on inside edge top and bottom
         translate([0,0,0])iPhone5(w=5width+2*5ctol,
					l=5length+2*5ctol,
					h=5height+2*5htol,
					cR=5cornerR+5ctol,
					sw=5swidth+2*5ctol,
					st=5sthick,
					taper=case_taper);

			// cut out top layer
        iPhoneGlass(w=5width+2*5ctol+.05,
					l=5length+2*5ctol+.05,
					h=5height+2*5htol+cthk+.01,
					r=5cornerR+5ctol,
					st=5sthick,
					taper=case_taper);

         // hole through top and bottom
			translate([0,0,cthk/2])
				cube([44,5length+20,5height+cthk/2],center = true);

         // ninjaflex hole through bottom
			*difference() {
            // right side is shorter by 1.5 
            union() {
              translate([-1.5,-20,cthk/2-(4/2)+1])
				   cube([42,5length+20,5height+cthk/2-4],center = true);
              //speaker plug needs some space on bottom
               translate([-20,-20,cthk/2-2.5])
				      cube([3,5length+20,5height+cthk/2-5],center = true);
            }
            union () {
               //posts surrounding power cord
               translate([6.5,-20,cthk/2-(4/2)+1])
				      cube([2,5length+20,5height+cthk/2-4+1],center = true);
               translate([-6.5,-20,cthk/2-(4/2)+1])
				      cube([2,5length+20,5height+cthk/2-4+1],center = true);
               
            }
         }

         // ninjaflex hole through top
			*translate([-14.5,20,cthk/2-(4/2)+1])
				   cube([15,5length+20,5height+cthk/2-4],center = true);
          
			
         //hole on left side
			translate([-5width/2-cthk*.8,32,4.5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(26,cthk*2,8);
       
		}
      // back section
		translate([0,0,-(5height+cthk+2*5htol)/2+cthk/4])difference(){
			union(){
				intersection(){
					iPhoneGlass(w=5width+2*5ctol+fudge,
							l=5length+2*5ctol+fudge,
							h=cthk/2,
							r=5cornerR+5ctol-fudge,
							st=5sthick,
							taper=0);
	
					backpat();
	
				}
				translate([15,52.4,0])
					CooliPhoneCameraHole(7.8,cthk/2,7.8+1.6);
			}
         // real camera hole
			translate([15,52.4,0])
				scale([1,1,2])
				CooliPhoneCameraHole(7.8,cthk/2,7.8);
	
	
		}
}


 

module iPhone5CaseNinja(){
		difference(){
			union(){
            // draw phone as big as outside of case
				iPhone5(w=5width+2*(cthk+5ctol),
					l=5length+2*(cthk+5ctol),
					h=5height+cthk+2*5htol, // add a bit for the back since it is so flexible
					cR=5cornerR+cthk+5ctol,
					sw=5swidth+cthk+2*5ctol,
					st=5sthick,
					taper=case_taper);
				if(include_hooks=="yes")translate([0,0,-(5height+cthk+2*5htol)/2])
					3hooks(w=5width+2*(cthk+5ctol),
						h=5length/3,
						bandd=3.5,
						thick=2,
						depth=8,
						closure=60);
			}

			//taper on inside edge top and bottom
         translate([0,0,0])iPhone5(w=5width+2*5ctol,
					l=5length+2*5ctol,
					h=5height+2*5htol,
					cR=5cornerR+5ctol,
					sw=5swidth+2*5ctol,
					st=5sthick,
					taper=case_taper);

			// cut out top layer
        iPhoneGlass(w=5width+2*5ctol+.05,
					l=5length+2*5ctol+.05,
					h=5height+2*5htol+cthk+.01,
					r=5cornerR+5ctol,
					st=5sthick,
					taper=case_taper);

         // hole through top and bottom
			*translate([0,0,cthk/2])
				cube([44,5length+20,5height+cthk/2],center = true);

         // ninjaflex hole through bottom
			difference() {
            // right side is shorter by 1.5 
            union() {
              translate([-1.5,-20,cthk/2-(4/2)+1])
				   cube([42,5length+20,5height+cthk/2-4],center = true);
              //speaker plug needs some space on bottom
               translate([-20,-20,cthk/2-2.5])
				      cube([3,5length+20,5height+cthk/2-5],center = true);
            }
            union () {
               //posts surrounding power cord
               translate([6.5,-20,cthk/2-(4/2)+1])
				      cube([2,5length+20,5height+cthk/2-4+1],center = true);
               translate([-6.5,-20,cthk/2-(4/2)+1])
				      cube([2,5length+20,5height+cthk/2-4+1],center = true);
               
            }
         }

         // ninjaflex hole through top
			translate([14.5,20,cthk/2-(4/2)+1])
				   cube([15,5length+20,5height+cthk/2-4],center = true);
          
			
         //hole on left side
			*translate([-5width/2-cthk*.8,32,4.5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(26,cthk*2,8);
         translate([-5width/2-cthk*.8,32,4.5])
				rotate([90,0,90])
				scale([1,1,2])
				MinusRoundedRect(32,15,3);

		}
      // back section
		translate([0,0,-(5height+cthk+2*5htol)/2+cthk/4])difference(){
			union(){
				intersection(){
					iPhoneGlass(w=5width+2*5ctol+fudge,
							l=5length+2*5ctol+fudge,
							h=cthk/2,
							r=5cornerR+5ctol-fudge,
							st=5sthick,
							taper=0);
	
					backpat();
	
				}
				translate([15,52.4,0])
					CooliPhoneCameraHole(7.8,cthk/2,7.8+1.6);
			}
         // real camera hole
			translate([15,52.4,0])
				scale([1,1,2])
				CooliPhoneCameraHole(7.8,cthk/2,7.8);
	
	
		}
}


module iPhone4Case(){
		difference(){
			union(){
				iPhone5(w=4width+2*(cthk+4ctol),
					l=4length+2*(cthk+4ctol),
					h=4height+cthk/2+2*4htol,
					cR=4cornerR+cthk+4ctol,
					sw=4swidth+cthk+2*4ctol,
					st=1.5*4sthick,
					taper=case_taper);
				if(include_hooks=="yes")translate([0,0,-(4height+cthk/2+2*4htol)/2])3hooks(w=4width+2*(cthk+4ctol),
					h=4length/3,
					bandd=3.5,
					thick=2,
					depth=8,
					closure=60);
			}

			translate([0,0,
				-(4height+cthk/2+2*4htol)/2
				+cthk/2
				+(4height/2+(4swidth+(4height-4swidth)/4)/2+2*4htol)/2])
				iPhone5(w=4width+2*4ctol,
					l=4length+2*4ctol,
					h=4height/2+(4swidth+(4height-4swidth)/4)/2+2*4htol,
					cR=4cornerR+4ctol,
					sw=4swidth/2+4height/2,
					st=4sthick,
					taper=case_taper);

			iPhoneGlass(w=4width+2*4ctol+.05,
					l=4length+2*4ctol+.05,
					h=4height+2*4htol+cthk/2+.01,
					r=4cornerR+4ctol,
					st=4sthick,
					taper=case_taper);

			translate([0,0,cthk])
				cube([44,4length+20,4height+cthk/2],center = true);
			
			translate([-4width/2-cthk*.8,30,(4height+cthk/2+2*4htol)/2])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(24,cthk*2,4height+cthk/2+2*4htol-cthk-4sthick);
		}
		translate([0,0,-(4height+cthk/2+2*4htol)/2+cthk/4])difference(){
			union(){
				intersection(){
						iPhoneGlass(w=4width+2*4ctol+fudge,
							l=4length+2*4ctol+fudge,
							h=cthk/2,
							r=4cornerR+4ctol-fudge,
							st=4sthick,
							taper=0);
					
						backpat();
	
				}
				translate([15,48.2,0])
					iPhoneCameraHole(7.8,cthk/2,7.8+1.6);
			}
			translate([15,48.2,0])
				scale([1,1,2])
				iPhoneCameraHole(7.8,cthk/2,7.8);
	
	
		}
}



module stencil(stencil_width,stencil_height,stencil_rotation,margin){

	dispo_width = stencil_width - 2*margin;
	
	points_array = (input=="no_input"? [[179,268],[[199.26,15.12],[189.19,15.56],[181.5,16.45],[175.52,17.83],[169.55,19.42],[163.57,21.55],[157.55,24.22],[151.62,27.5],[145.87,31.09],[140.35,35.49],[135,40.71],[130.05,46.71],[125.52,53],[121.87,59.06],[119.06,64.5],[117.12,69.21],[115.55,73.5],[114.31,77.65],[113.16,82],[112.07,87.29],[110.96,93.7],[110.36,99.39],[110.49,102.95],[111.13,105],[136.96,105],[158.46,104.73],[163.39,103.42],[163.83,101.08],[164.04,97.67],[164.46,93.04],[165.44,87.75],[167.04,82.4],[168.96,77.59],[171.9,73.02],[175.98,68.21],[180.98,63.93],[186.13,60.62],[192.15,58.45],[201.05,58],[208.86,58.34],[214.1,59.16],[217.74,60.82],[221.73,63.19],[225.41,66.46],[228.34,70.28],[230.39,74.63],[231.97,79.15],[232.75,85.01],[232.85,92.65],[232.01,100.96],[229.51,107.41],[225.45,113.48],[218.91,119.91],[211.35,126.37],[203.83,132.63],[197.2,138.54],[191.77,144.13],[187.33,150.15],[183.1,157.07],[179.62,164.83],[176.98,172.85],[175.42,181.69],[175.22,192.28],[175.5,203.5],[199,203.5],[222.5,203.5],[222.74,198.5],[223.25,193.21],[224.15,187.5],[225.64,181.94],[227.6,177],[230.92,172.02],[235.69,166.37],[243.47,159.38],[254,151.21],[264.03,143.56],[270.61,137.84],[274.46,133.36],[277.95,128.69],[281.05,123.47],[283.96,117.69],[286.32,111.7],[288.09,106],[289.06,98.48],[289.47,88],[289.05,76.45],[287.17,68],[284.48,60.83],[281.31,54.14],[276.58,47.41],[270.1,40.14],[262.4,33.38],[254.68,28.12],[246.8,24.2],[238.72,20.92],[230.05,18.48],[220.76,16.55],[210.43,15.49],[199.26,15.12]],[[198.05,226.08],[178.93,226.28],[170.25,226.66],[169.27,232.87],[169,254.48],[169.27,277.23],[170.58,282.39],[179.4,282.82],[198.38,283],[218.91,282.73],[225.8,281.8],[226.73,274.94],[227,254.5],[226.73,234.06],[225.8,227.2],[218.87,226.29],[198.05,226.08]]]: input);
	
	input_width = points_array[0][0];
	input_height= points_array[0][1];
	sTrace = dispo_width/input_width;
	//stencil_height = input_height*sTrace + 2*margin;
	
	difference() {
		translate([0, 0, stencil_thickness/2])
		cube([stencil_width, stencil_height,3* stencil_thickness], center=true);
		translate([offX, offY, -stencil_thickness/2])
		rotate([0,0,stencil_rotation])
		scale([sTrace, -sTrace, 1])
		translate([-200, -150, 0]) {
			union() {
				for (i = [1:len(points_array) -1] ) {
					linear_extrude(height=stencil_thickness*2) {polygon(points_array[i]);}
				}
			}
		}
	}
}




module stencil5c(stencil_width,stencil_height,stencil_rotation, margin){

	dispo_width = stencil_width - 2*margin;
	
	points_array = (input=="no_input"? [[179,268],[[199.26,15.12],[189.19,15.56],[181.5,16.45],[175.52,17.83],[169.55,19.42],[163.57,21.55],[157.55,24.22],[151.62,27.5],[145.87,31.09],[140.35,35.49],[135,40.71],[130.05,46.71],[125.52,53],[121.87,59.06],[119.06,64.5],[117.12,69.21],[115.55,73.5],[114.31,77.65],[113.16,82],[112.07,87.29],[110.96,93.7],[110.36,99.39],[110.49,102.95],[111.13,105],[136.96,105],[158.46,104.73],[163.39,103.42],[163.83,101.08],[164.04,97.67],[164.46,93.04],[165.44,87.75],[167.04,82.4],[168.96,77.59],[171.9,73.02],[175.98,68.21],[180.98,63.93],[186.13,60.62],[192.15,58.45],[201.05,58],[208.86,58.34],[214.1,59.16],[217.74,60.82],[221.73,63.19],[225.41,66.46],[228.34,70.28],[230.39,74.63],[231.97,79.15],[232.75,85.01],[232.85,92.65],[232.01,100.96],[229.51,107.41],[225.45,113.48],[218.91,119.91],[211.35,126.37],[203.83,132.63],[197.2,138.54],[191.77,144.13],[187.33,150.15],[183.1,157.07],[179.62,164.83],[176.98,172.85],[175.42,181.69],[175.22,192.28],[175.5,203.5],[199,203.5],[222.5,203.5],[222.74,198.5],[223.25,193.21],[224.15,187.5],[225.64,181.94],[227.6,177],[230.92,172.02],[235.69,166.37],[243.47,159.38],[254,151.21],[264.03,143.56],[270.61,137.84],[274.46,133.36],[277.95,128.69],[281.05,123.47],[283.96,117.69],[286.32,111.7],[288.09,106],[289.06,98.48],[289.47,88],[289.05,76.45],[287.17,68],[284.48,60.83],[281.31,54.14],[276.58,47.41],[270.1,40.14],[262.4,33.38],[254.68,28.12],[246.8,24.2],[238.72,20.92],[230.05,18.48],[220.76,16.55],[210.43,15.49],[199.26,15.12]],[[198.05,226.08],[178.93,226.28],[170.25,226.66],[169.27,232.87],[169,254.48],[169.27,277.23],[170.58,282.39],[179.4,282.82],[198.38,283],[218.91,282.73],[225.8,281.8],[226.73,274.94],[227,254.5],[226.73,234.06],[225.8,227.2],[218.87,226.29],[198.05,226.08]]]: input);
	
	input_width = points_array[0][0];
	input_height= points_array[0][1];
	sTrace = dispo_width/input_width;
	//stencil_height = input_height*sTrace + 2*margin;
	
	difference() {
		*translate([0, 0, stencil_thickness/2])
		*cube([stencil_width, stencil_height,3* stencil_thickness], center=true);
		translate([offX, offY, -stencil_thickness/2])
		rotate([0,0,stencil_rotation])
		scale([sTrace, -sTrace, 1])
		translate([-200, -150, 0]) {
			union() {
				for (i = [1:len(points_array) -1] ) {
					linear_extrude(height=stencil_thickness*2) {polygon(points_array[i]);}
				}
			}
		}
	}
}



module honeycomb(w,l,h,r,rmod,th,sides){
	
	columns = l/(r*3)+2;
	rows = w/(r*sqrt(3)/2*2)+1;

	translate([-w/2,l/2,0])
		rotate([0,0,-90])
			for(i = [-1:rows]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
					for(i = [-1:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*1.5*i,r*sqrt(3)/2*i,0])
									rotate([0,0,honeycomb_rotation])
									difference(){
										if(sides < 5){
											cylinder(h = h, r = r+th+(r*rmod/50), center = true, $fn = sides);
										} else {
											cylinder(h = h, r = r+(r*rmod/50), center = true, $fn = sides);
										}
										cylinder(h = h+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}


module backpat(){
	
	scale([-1,1,5]){
			if(iphone_version==1 && type_of_case==1)
				stencil(4width+2*4ctol,4length+2*4ctol,image_rotation,4margin);
			if(iphone_version==2 && type_of_case==1)
				stencil(5width+2*5ctol,5length+2*5ctol,image_rotation,5margin);
			if(iphone_version==4 && type_of_case==1)
				stencil(5width+2*5ctol,5length+2*5ctol,image_rotation,5margin);
			if(iphone_version==3 && type_of_case==1)
				stencil(5width+2*5ctol,5length+2*5ctol,image_rotation,5margin);
			if(iphone_version==1 && type_of_case==2)
				honeycomb(4width+2*4ctol,4length+2*4ctol,4height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides);
			if(iphone_version==2 && type_of_case==2)
				honeycomb(5width+2*5ctol,5length+2*5ctol,5height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides);
			if(iphone_version==4 && type_of_case==2)
				honeycomb(5width+2*5ctol,5length+2*5ctol,5height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides);
			if(iphone_version==1 && type_of_case==3 && mashup_type==1)
				mashup1(image_rotation,
					4width+2*4ctol,4length+2*4ctol,4height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides,
					index_i,index_j);
			if(iphone_version==2 && type_of_case==3 && mashup_type==1)
				mashup1(image_rotation,
					5width+2*5ctol,5length+2*5ctol,5height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides,
					index_i,index_j);
			if(iphone_version==4 && type_of_case==3 && mashup_type==1)
				mashup1(image_rotation,
					5width+2*5ctol,5length+2*5ctol,5height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides,
					index_i,index_j);
			if(iphone_version==1 && type_of_case==3 && mashup_type==2)
				mashup2(4width+2*4ctol,4length+2*4ctol,image_rotation,4margin,
					4width+2*4ctol,4length+2*4ctol,4height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides);
			if(iphone_version==2 && type_of_case==3 && mashup_type==2)
				mashup2(5width+2*5ctol,5length+2*5ctol,image_rotation,5margin,
					5width+2*5ctol,5length+2*5ctol,5height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides);
         if(iphone_version==2 && type_of_case==3 && mashup_type==2)
				mashup2(5width+2*5ctol,5length+2*5ctol,image_rotation,5margin,
					5width+2*5ctol,5length+2*5ctol,5height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides);
	}
}



module mashup1(stencil_rotation,w,l,h,r,rmod,th,sides,index_i,index_j){
	
	stencil_width=1*(r+(r*rmod/50));
	stencil_height=2*h;
	margin=0;


	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);
	imod=floor(columns)-(round(columns/2)-floor(columns/2))+index_i;
	jmod=floor(rows)-(round(rows/2)-floor(rows/2))+index_j*2+ceil(index_i/2)-floor(index_i/2);

	echo(columns,rows);
	echo(index_i,index_j);
	echo(imod,jmod);

	
	points_array = (input=="no_input"? [[179,268],[[199.26,15.12],[189.19,15.56],[181.5,16.45],[175.52,17.83],[169.55,19.42],[163.57,21.55],[157.55,24.22],[151.62,27.5],[145.87,31.09],[140.35,35.49],[135,40.71],[130.05,46.71],[125.52,53],[121.87,59.06],[119.06,64.5],[117.12,69.21],[115.55,73.5],[114.31,77.65],[113.16,82],[112.07,87.29],[110.96,93.7],[110.36,99.39],[110.49,102.95],[111.13,105],[136.96,105],[158.46,104.73],[163.39,103.42],[163.83,101.08],[164.04,97.67],[164.46,93.04],[165.44,87.75],[167.04,82.4],[168.96,77.59],[171.9,73.02],[175.98,68.21],[180.98,63.93],[186.13,60.62],[192.15,58.45],[201.05,58],[208.86,58.34],[214.1,59.16],[217.74,60.82],[221.73,63.19],[225.41,66.46],[228.34,70.28],[230.39,74.63],[231.97,79.15],[232.75,85.01],[232.85,92.65],[232.01,100.96],[229.51,107.41],[225.45,113.48],[218.91,119.91],[211.35,126.37],[203.83,132.63],[197.2,138.54],[191.77,144.13],[187.33,150.15],[183.1,157.07],[179.62,164.83],[176.98,172.85],[175.42,181.69],[175.22,192.28],[175.5,203.5],[199,203.5],[222.5,203.5],[222.74,198.5],[223.25,193.21],[224.15,187.5],[225.64,181.94],[227.6,177],[230.92,172.02],[235.69,166.37],[243.47,159.38],[254,151.21],[264.03,143.56],[270.61,137.84],[274.46,133.36],[277.95,128.69],[281.05,123.47],[283.96,117.69],[286.32,111.7],[288.09,106],[289.06,98.48],[289.47,88],[289.05,76.45],[287.17,68],[284.48,60.83],[281.31,54.14],[276.58,47.41],[270.1,40.14],[262.4,33.38],[254.68,28.12],[246.8,24.2],[238.72,20.92],[230.05,18.48],[220.76,16.55],[210.43,15.49],[199.26,15.12]],[[198.05,226.08],[178.93,226.28],[170.25,226.66],[169.27,232.87],[169,254.48],[169.27,277.23],[170.58,282.39],[179.4,282.82],[198.38,283],[218.91,282.73],[225.8,281.8],[226.73,274.94],[227,254.5],[226.73,234.06],[225.8,227.2],[218.87,226.29],[198.05,226.08]]]: input);

	dispo_width = stencil_width - 2*margin;

	input_width = points_array[0][0];
	input_height= points_array[0][1];
	sTrace = dispo_width/input_width*image_scale/100;
	//stencil_height = input_height*sTrace + 2*margin;



	color("red")translate([-w/2,l/2,0])
		rotate([0,0,-90]){
			difference(){
				for(i = [0:rows]){
					translate([0,r*sqrt(3)/2*i*2,0])
						for(i = [0:columns]){
							translate([r*i*3,0,0])
								for(i = [0:1]){
									translate([r*1.5*i,r*sqrt(3)/2*i,0])
										rotate([0,0,honeycomb_rotation])
										difference(){
											if(sides < 5){
												cylinder(h = h, r = r+th+(r*rmod/50), center = true, $fn = sides);
											} else {
												cylinder(h = h, r = r+(r*rmod/50), center = true, $fn = sides);
											}
											cylinder(h = h+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
										}
								}
						}
				}
				translate([r*imod*1.5,r*sqrt(3)/2*jmod,0])
						rotate([0,0,honeycomb_rotation])
							cylinder(h = h+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
			}

			
			translate([r*imod*1.5,r*sqrt(3)/2*jmod,0])difference(){
					rotate([0,0,honeycomb_rotation])
						cylinder(h = h, r = r-th+(r*rmod/50), center = true, $fn = sides);
					translate([offX, offY, -stencil_thickness/2])
						rotate([0,0,90-stencil_rotation])
						scale([sTrace, -sTrace, 1])
						translate([-200, -150, 0]) {
							union() {
								for (i = [1:len(points_array) -1] ) {
									linear_extrude(height=stencil_thickness*2){
										polygon(points_array[i]);
									}
								}
							}
						}
			}
			
		}
}

module mashup2(stencil_width,stencil_height,stencil_rotation,margin,w,l,h,r,rmod,th,sides){
	
	dispo_width = stencil_width - 2*margin;

	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);

	
	points_array = (input=="no_input"? [[179,268],[[199.26,15.12],[189.19,15.56],[181.5,16.45],[175.52,17.83],[169.55,19.42],[163.57,21.55],[157.55,24.22],[151.62,27.5],[145.87,31.09],[140.35,35.49],[135,40.71],[130.05,46.71],[125.52,53],[121.87,59.06],[119.06,64.5],[117.12,69.21],[115.55,73.5],[114.31,77.65],[113.16,82],[112.07,87.29],[110.96,93.7],[110.36,99.39],[110.49,102.95],[111.13,105],[136.96,105],[158.46,104.73],[163.39,103.42],[163.83,101.08],[164.04,97.67],[164.46,93.04],[165.44,87.75],[167.04,82.4],[168.96,77.59],[171.9,73.02],[175.98,68.21],[180.98,63.93],[186.13,60.62],[192.15,58.45],[201.05,58],[208.86,58.34],[214.1,59.16],[217.74,60.82],[221.73,63.19],[225.41,66.46],[228.34,70.28],[230.39,74.63],[231.97,79.15],[232.75,85.01],[232.85,92.65],[232.01,100.96],[229.51,107.41],[225.45,113.48],[218.91,119.91],[211.35,126.37],[203.83,132.63],[197.2,138.54],[191.77,144.13],[187.33,150.15],[183.1,157.07],[179.62,164.83],[176.98,172.85],[175.42,181.69],[175.22,192.28],[175.5,203.5],[199,203.5],[222.5,203.5],[222.74,198.5],[223.25,193.21],[224.15,187.5],[225.64,181.94],[227.6,177],[230.92,172.02],[235.69,166.37],[243.47,159.38],[254,151.21],[264.03,143.56],[270.61,137.84],[274.46,133.36],[277.95,128.69],[281.05,123.47],[283.96,117.69],[286.32,111.7],[288.09,106],[289.06,98.48],[289.47,88],[289.05,76.45],[287.17,68],[284.48,60.83],[281.31,54.14],[276.58,47.41],[270.1,40.14],[262.4,33.38],[254.68,28.12],[246.8,24.2],[238.72,20.92],[230.05,18.48],[220.76,16.55],[210.43,15.49],[199.26,15.12]],[[198.05,226.08],[178.93,226.28],[170.25,226.66],[169.27,232.87],[169,254.48],[169.27,277.23],[170.58,282.39],[179.4,282.82],[198.38,283],[218.91,282.73],[225.8,281.8],[226.73,274.94],[227,254.5],[226.73,234.06],[225.8,227.2],[218.87,226.29],[198.05,226.08]]]: input);
	
	input_width = points_array[0][0];
	input_height= points_array[0][1];
	sTrace = dispo_width/input_width;
	//stencil_height = input_height*sTrace + 2*margin;

	union(){
	
		translate([offX, offY, -stencil_thickness/2])
			rotate([0,0,stencil_rotation])
			scale([sTrace, -sTrace, 1])
			translate([-200, -150, 0]) {
				union() {
					for (i = [1:len(points_array) -1] ) {
						linear_extrude(height=stencil_thickness*2) {polygon(points_array[i]);}
					}
				}
			}
		honeycomb(w=w,l=l,h=h,r=r,rmod=rmod,th=th,sides=sides);
	}
}

module bandhook(bandd,thick,w,closure){

	bandr=bandd/2;

	translate([0,-w/2,0]){
		difference(){
			union(){
				translate([-bandd-thick,0,0])cube([2*(bandd+thick),w,bandr+thick]);
				translate([bandr,0,thick+bandr])rotate([-90,0,0])
					cylinder(r=bandr+thick,h=w,$fn=20);
			}
			union(){
				translate([-bandd-thick,-fudge/2,thick+bandr])
					cube([bandr+bandd+thick,w+fudge,bandd+thick]);
				translate([bandr,-fudge/2,thick+bandr])rotate([-90,0,0])
					cylinder(r=bandr,h=w+fudge,$fn=20);
				translate([thick+bandr,-fudge/2,0])rotate([0,45,0])cube([2*thick,w+fudge,2*thick]);
				translate([bandr,-fudge/2,thick+bandr])
					rotate([0,-closure,0])cube([bandr+2*thick,w+fudge,2*thick]);
			}		
		
		}
	
		translate([bandr,0,thick+bandr])
			rotate([0,-closure,0])translate([bandr+thick/2,0,0])
			rotate([-90,0,0])cylinder(r=thick/2,h=w,$fn=20);
	}

}

module 3hooks(w,h,bandd,thick,depth,closure){

	scale([-1,1,1])translate([w/2,0,0])bandhook(bandd,thick,depth,2);

	for(i=[1,-1])scale([1,i,1])translate([w/2,h/2,0])bandhook(bandd,thick,depth,closure);



}