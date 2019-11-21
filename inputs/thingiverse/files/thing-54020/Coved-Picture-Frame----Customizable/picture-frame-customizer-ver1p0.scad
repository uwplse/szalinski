// Parametric picture frame with text in cove
// For Thingiverse, with Makerbot Customizer controls
// version 1.0
// by Loren McConnell 2013.
// 
//
// The frame width is configurable, as is its thickness (depth).
// The design provides a rabbet in the back for artwork. 
// The default picture size is 101x152mm -- a 4"x6"print
// The default rabbet is sized to allow a 3mm backer and 3mm for glasss or plasic and the artwork.
// 

include <write/Write.scad>

//
// CUSTOMIZER VARIABLES
//

//
// Artwork Size
//
// artwork height (mm)
picture_height = 101; 
// artwork width (mm)
picture_width = 152; 

//
// Frame Size
//
// frame border size (mm)
frame_width = 40; 
// frame depth (mm)
frame_thickness = 15;  

// 
// Text Parameters
// 
// Text in Cove
top_message = "Thingiverse";
bottom_message = "Love";
left_message = "From";
right_message = "With";
// Text for backplate
back_message = "By Loren";

Font = "write/BlackRose.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose, "write/knewave.dxf":KnewWave,"write/braille.dxf":Braille]
//text height (mm)
font_size = 20; 
//extra space between characters
font_space = 1; //[-10:10]
// Height of the raised text
font_thickness = 2; //[0.1:10]

//
// Cove featrue parameters
//
//depth of cove feature (mm)
cove_depth = 5;  
//width of the boundary around the cove (mm)
cove_margin = 5;  
//width of cove feature less than frame_width (mm)
cove_width = frame_width - cove_margin*2;  

//
// Rabbet in the back to hold the picture. 
//
//width of rabbet in back (mm)
rabbet_width = 5;   
//depth of rabbet in back (mm)
rabbet_depth = 6;  


//
//CUSTOMIZER VARIABLES END
//
module null() {} // customizer parser stops at first module.
fudge = 0.001;  //fudge factor for boolean ops. 




//
// gen_cove_moulding
// Produces a length of cove moulding for a frame, with mitered ends.
// Uses most globals above. 
// length -- length of the frame segment, excluding miters
// tab_width -- size of retention tabs
// message -- text to engrave in the molding
//
module gen_cove_moulding(length,message,invert_message=false) {
	// overall length includes length for the miters
	oa_length = length + 2*frame_width - 2*rabbet_width;	

	// precision for cylinders
	cove_fn = 200;

	//
	// Compute a triangle for 3 points to describe the circle to make the cove. 
	//
	triangle_height = cove_depth;
	triangle_base = cove_width;

	// Pythagorean theorem
	triangle_side = sqrt((triangle_height*triangle_height) + ((triangle_base/2)*(triangle_base/2)));

	// law of cosines
	triangle_angle = acos((2 * (triangle_side * triangle_side) - (triangle_base * triangle_base)) / (2 * triangle_side * triangle_side));
	
	// The diameter of a circumcircle is the lenght of a 
	//   side of the inscribed triangle, divided by the 
	//   sine of the opposite angle. 
	cove_diameter= cove_width / sin(triangle_angle);
	
	translate(v=[-frame_width+rabbet_width,-rabbet_width,0] ){  //place rabbet at origin for easy assembly
	union () {
		difference() {
			// 
			// the frame stock
			//
			cube(size = [oa_length, frame_width, frame_thickness]);
			//
			// the rabbet
			//	
			cube(size = [oa_length, rabbet_width, rabbet_depth]);
			//
			// the cove cylinder
			// 
			rotate(a=[0,90,0]){
				translate(v=[(-1*(frame_thickness+cove_diameter/2-cove_depth)),frame_width/2,-0.5]) {
					cylinder(h=oa_length+1,r=cove_diameter/2,$fn=cove_fn);
				}
			}
			//
			// define triangles to miter the ends.
			// 
			linear_extrude(height=frame_thickness) polygon(points=[[0,0],[frame_width,0],[0,frame_width]]);
			linear_extrude(height=frame_thickness) translate(v=[oa_length,0,0]) polygon(points=[[0,0],[-frame_width,0],[0,-frame_width]]);
			linear_extrude(height=frame_thickness) translate(v=[oa_length,0,0]) polygon(points=[[0,0],[-frame_width,0],[0,frame_width]]);
		} //difference
		//
		// add text
		// 
		if (message != "") {
		rotate(a=[0,90,0]){
			translate(v=[(-1*(frame_thickness+cove_diameter/2-cove_depth)),frame_width/2,frame_width-(frame_width-cove_width)/2]) {
				difference() {
				intersection(){
				cylinder(h=length+fudge,r=cove_diameter/2 + fudge,$fn=cove_fn);

				// write on a cylinder
				translate (v=[0,0,length]) // fixme?

				if (invert_message == false) {
					mirror([0,0,1]) 
					writecylinder(text=message, where=[0,0,0], radius=cove_diameter/2-cove_depth/2-fudge, height=length,
								rotate=90, east=94, center=false,
								t=font_thickness*10,h=font_size, font=Font, space=font_space);
				} else {
					translate([0,0,-length])
					rotate(180,[0,1,0])	
					mirror([0,0,1]) 				
					writecylinder(text=message, where=[0,0,0], radius=cove_diameter/2-cove_depth/2-fudge, height=length,
								rotate=90, east=274, center=false,
								t=font_thickness*10,h=font_size, font=Font, space=font_space);
				}
				} // intersection
				cylinder(h=length+fudge,r=cove_diameter/2 - font_thickness  ,$fn=cove_fn);
				} // difference
			} //translate
		} // rotate

	} //if
		
	}//union
	}//translate
}

//
// gen_frame_backer
// Produces the back plate for the frame to retain the artwork. 
// uses Globals:  picture_width, picture_height, Font, font_size
// thickness -- thickness of the backer plate.  Also the diameter of retention tabs.
// clearance -- offset from base dimentions.  
// tab_width -- size of retention tabs
// message -- text to engrave in the backer plate.
//
module gen_frame_backer(thickness=3, clearance=1, tab_width=10, message="") {
	width = picture_width-clearance;
	height = picture_height-clearance;
  	// 
	// the backer stock
	//
	difference() {
	union() {
	cube(size = [width, height, thickness]);

	//
	// Cylindrical tab at the center of each side
	//
	translate([width/2-tab_width/2,     0,thickness/2]) rotate(90,[0,1,0]) cylinder(h=tab_width, r = thickness/2,$fn=50); //bottom
	translate([width/2-tab_width/2,height,thickness/2]) rotate(90,[0,1,0]) cylinder(h=tab_width, r = thickness/2,$fn=50); //top
	translate([      0,height/2+tab_width/2,thickness/2]) rotate(90,[1,0,0]) cylinder(h=tab_width, r = thickness/2,$fn=50); //left
	translate([  width,height/2+tab_width/2,thickness/2]) rotate(90,[1,0,0]) cylinder(h=tab_width, r = thickness/2,$fn=50); //right
	}

	//
	// Maker tag on the back!!
    //
	if (message != "") {
		writecube(text=message,where=[width/2,height/2,thickness/2],size=[width, height, thickness],face="top",t=thickness,h=font_size/2, font=Font);
	}
	} //difference
}


translate(v=[frame_width-rabbet_width,frame_width-rabbet_width,0]) { //place frame corner at origin.
	//
	// Frame
	//
	difference() {
	union() {
	//top
	translate(v=[0,picture_height,0])                                      gen_cove_moulding(length=picture_width+fudge, message=top_message);
	//bottom
	translate(v=[picture_width,0,0])               rotate(a=[  0,  0,180]) gen_cove_moulding(length=picture_width+fudge, message=bottom_message, invert_message=true);
	//left
	translate(v=[0,0,0])                           rotate(a=[  0,  0, 90]) gen_cove_moulding(length=picture_height+fudge, message=left_message);
	//right
	translate(v=[picture_width,picture_height,0])  rotate(a=[  0,  0,270]) gen_cove_moulding(length=picture_height+fudge, message=right_message);
	} //union
	//subtract the backer notches from the frame.
	gen_frame_backer(thickness=3, clearance=fudge, tab_width=10.5);
	} //difference
	
	//
	// Backing
	//
	translate([0.5,0.5,0]) gen_frame_backer(thickness=3, clearance=1, tab_width=10, message=back_message);
} //translate


frame_y = picture_height+2*frame_width-2*rabbet_width;
frame_x = picture_width+2*frame_width-2*rabbet_width;
echo ("Overall Height = ", frame_y);
echo ("Overall Width  = ", frame_x);


