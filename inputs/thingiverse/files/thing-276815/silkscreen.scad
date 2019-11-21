use <write/Write.scad>

//------------------------------------------------------------
//	
//
//	input comes from:
//	http://chaaawa.com/stencil_factory/
//
//	
//	http://www.thingiverse.com/thing:55821
// Modified by James Newton to make a silkscreen stencil 
// with optional frame and squeegee
// Also added text to 
//------------------------------------------------------------

// preview[view:south, tilt:top]


/* [Screen] */

// Can't be more than your printable area. Default is ~ business card size
screen_width = 90;
screen_height= 50;

// Should be a multiple of layer height.
screen_thickness=.2;

grid_spacing = 2;
// Not less than printer nozzle diameter.
grid_thickness = .5;

/* [Polygon Image] */

// Paste from http://chaaawa.com/stencil_factory/
input = "no_input";

// Adjust to fit available area
stencil_width = 50;
margin = 10;

//If you don't want to center 
offX = 0;
offY = 0;
image_rotation =0; //[-180:180]


/* [Text] */

// Optional text with or in place of image
text1 = " your   text";
textX = 0;
textY = 0;
text_rotation = 0; //[-180:180]


/* [Options] */

// Optional dam to hold in the ink. Increases required print size.
frame_height = 7;
frame_thickness = 5;

// Optional squeegee to spread the ink. Cut off for accurate edge. Increases required print size.
squeegee_height = 30;

// fudge factor to accomodate spread of filiment
spread=1;


module void() {}

dispo_width = stencil_width - 2*margin;
stencil_thickness = screen_thickness;


points_array = (input=="no_input"? [[179,268],[[199.26,15.12],[189.19,15.56],[181.5,16.45],[175.52,17.83],[169.55,19.42],[163.57,21.55],[157.55,24.22],[151.62,27.5],[145.87,31.09],[140.35,35.49],[135,40.71],[130.05,46.71],[125.52,53],[121.87,59.06],[119.06,64.5],[117.12,69.21],[115.55,73.5],[114.31,77.65],[113.16,82],[112.07,87.29],[110.96,93.7],[110.36,99.39],[110.49,102.95],[111.13,105],[136.96,105],[158.46,104.73],[163.39,103.42],[163.83,101.08],[164.04,97.67],[164.46,93.04],[165.44,87.75],[167.04,82.4],[168.96,77.59],[171.9,73.02],[175.98,68.21],[180.98,63.93],[186.13,60.62],[192.15,58.45],[201.05,58],[208.86,58.34],[214.1,59.16],[217.74,60.82],[221.73,63.19],[225.41,66.46],[228.34,70.28],[230.39,74.63],[231.97,79.15],[232.75,85.01],[232.85,92.65],[232.01,100.96],[229.51,107.41],[225.45,113.48],[218.91,119.91],[211.35,126.37],[203.83,132.63],[197.2,138.54],[191.77,144.13],[187.33,150.15],[183.1,157.07],[179.62,164.83],[176.98,172.85],[175.42,181.69],[175.22,192.28],[175.5,203.5],[199,203.5],[222.5,203.5],[222.74,198.5],[223.25,193.21],[224.15,187.5],[225.64,181.94],[227.6,177],[230.92,172.02],[235.69,166.37],[243.47,159.38],[254,151.21],[264.03,143.56],[270.61,137.84],[274.46,133.36],[277.95,128.69],[281.05,123.47],[283.96,117.69],[286.32,111.7],[288.09,106],[289.06,98.48],[289.47,88],[289.05,76.45],[287.17,68],[284.48,60.83],[281.31,54.14],[276.58,47.41],[270.1,40.14],[262.4,33.38],[254.68,28.12],[246.8,24.2],[238.72,20.92],[230.05,18.48],[220.76,16.55],[210.43,15.49],[199.26,15.12]],[[198.05,226.08],[178.93,226.28],[170.25,226.66],[169.27,232.87],[169,254.48],[169.27,277.23],[170.58,282.39],[179.4,282.82],[198.38,283],[218.91,282.73],[225.8,281.8],[226.73,274.94],[227,254.5],[226.73,234.06],[225.8,227.2],[218.87,226.29],[198.05,226.08]]]: input);

input_width = points_array[0][0];
input_height= points_array[0][1];
tVersion = points_array[0][2] == undef ? 0: points_array[0][2];
sTrace = dispo_width/input_width;
stencil_height = input_height*sTrace + 2*margin;

union() {
difference() {
	cube([screen_width+.1,screen_height+.1,screen_thickness], center=true);

//cut out the text
	translate([textX, textY, 0])
	rotate([0,0,text_rotation])
	write(text1,h=min(screen_height*.75, screen_width/(len(text1)-1)),t=stencil_thickness*2, center=true);

//cut out the poly
	if (tVersion == 0) {
		echo("'version 0 array in ", (len(points_array)-1)," parts, 400 by 300");
		translate([offX, offY, -stencil_thickness])
		rotate([0,0,image_rotation])
		scale([sTrace, -sTrace, 1])
		translate([-400/2, -300/2, 0])
			union() {
				for (i = [1:len(points_array) -1] ) {
					echo(" - part ",i," with ", len(points_array[i]) , " points");
					linear_extrude(height=stencil_thickness*2) {polygon(points_array[i]);}
				}
			}
		}
	}

	if (tVersion == 1) {
		echo("version 1 array of ",len(points_array)-1," parts", input_width, "by", input_height )
		translate([offX, offY, -stencil_thickness])
		rotate([0,0,image_rotation])
		scale([sTrace, -sTrace, 1])
		translate([-input_width/2, -input_height/2, 0]) 
		union() {
			for (i = [1:len(points_array) -1] ) {
				if (points_array[i][0] == 1) {
					linear_extrude(height=stencil_thickness*2) {polygon(points_array[i][1]);}
				}
			}
		}
	}



//add the screen to the screen
translate([-screen_width/2,-screen_height/2,-stencil_thickness/2]) 
for (i = [1:(screen_height/grid_spacing)]) {
	translate([0,i*grid_spacing])
	cube([screen_width,grid_thickness,stencil_thickness]);
	}

translate([-screen_width/2,-screen_height/2,-stencil_thickness/2]) 
for (i = [1:(screen_width/grid_spacing)]) {
	translate([i*grid_spacing,0])
	cube([grid_thickness,screen_height,stencil_thickness]);
	}

//add the frame if desired.
translate([-screen_width/2,-screen_height/2-frame_thickness+0.01,-stencil_thickness/2])
	cube([screen_width,frame_thickness,frame_height]);
translate([-screen_width/2,screen_height/2-.1,-stencil_thickness/2])
	cube([screen_width,frame_thickness,frame_height]);

translate([-screen_width/2-frame_thickness+.1,-screen_height/2-frame_thickness,-stencil_thickness/2])
	cube([frame_thickness,screen_height+frame_thickness*2,frame_height]);

translate([screen_width/2-.1,-screen_height/2-frame_thickness,-stencil_thickness/2])
	cube([frame_thickness,screen_height+frame_thickness*2,frame_height]);


//add a cutaway squeegee if desired.
translate([screen_width/2+frame_thickness-.2,-screen_height/2,-stencil_thickness/2]) 
	 rotate([-90]) 
		linear_extrude(screen_height-spread) 
			polygon( points=[[0,-.1],[0,0],[squeegee_height,0],[squeegee_height,-frame_height],[squeegee_height/2,-frame_height]] );
}
