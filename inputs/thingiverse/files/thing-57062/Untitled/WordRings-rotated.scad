// preview[view:south, tilt:top diagonal]
//==USER DEFINED VARIABLES==////////////////////////////////////////////////////////////////////////////
//Width in mm
total_width=95; //[1:300]
// Height in mm
total_height=60; //[1:300]
//Text on the ring
desired_word = "WOW";
//Depth of item, from surface of letters to bottom of plate in mm
total_depth = 10; //[1:50]
//Diameter of your finger in mm plus some extra for comfort 
finger_size = 23;
//Distance between edges of rings in mm
finger_spacing = 23;
////////////////////////////////////////////////////////////////////////////////////////////////////////

use <MCAD/fonts.scad>

thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];

theseIndicies=search(desired_word,thisFont[2],1,1);
word_width = (len(theseIndicies))* x_shift;

module write_word(word_text="Fabulous", word_height=2.0) {
      for( j=[0:(len(theseIndicies)-1)] ) translate([j*x_shift,-y_shift/2]) {
		linear_extrude(height=word_height) polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
      }
}

module create_ring(){ //create an overall module out of the ring creation modules

union() {

	//build the plate
	translate(v=[0,-total_height/2,0]) { //Move the cube over so it lines up with the words
		scale(v=[1,total_height/total_width,total_depth/(2*total_width)]) { //Scale the cube to be half as thick as the words, and as wide/high as specified
			cube(total_width);
		}
	}
	
	//write the words
	translate(v=[5,0,0]) { //Move 5 mm over to make room for bezel
		scale(v=[(total_width-10)/word_width,(total_height-10)/8,1]) { //scale them to fit with a 10mm margin to the edges of the plate
			write_word(desiredWord,total_depth);
		}
	}

	difference() {
		//Build the top plate that we'll make into a frame
		translate(v=[0,-total_height/2,(total_depth-.1)/2]) { //Making another cube of the same dimensions and placing it on top the original plate
			scale(v=[1,total_height/total_width,(total_depth+.1)/(2*total_width)]) {
				cube(total_width);
			}
		}

		//Carve the frame
		translate(v=[5,5-(total_height/2),total_depth/2]) { //Subtracting out a cross-section 10mm from the edges
			scale(v=[1,(total_height-5)/total_width,total_depth/total_width]) {
				cube(total_width-10);
			}
		}
	}
	
	difference() {
		translate(v=[((total_width-finger_size-finger_spacing)/2)-3,0,-(finger_size/2)+3]) { //Create ring to left of center
			rotate(a=[90,0,0]) { 
				difference() {
					cylinder(h = 10, r1 = (finger_size/2)+3, r2 = (finger_size/2)+3, center = true );
					cylinder(h = total_depth+finger_size+5, r1 = (finger_size/2), r2 = (finger_size/2), center = true);
				}
			}
		}
	//Carve the frame again
		translate(v=[5,5-(total_height/2),total_depth/2]) { //Subtracting out a cross-section 10mm from the edges
			scale(v=[1,(total_height-5)/total_width,total_depth/total_width]) {
				cube(total_width-10);
			}
		}	
	}
	
	difference() {
		translate(v=[((total_width+finger_size+finger_spacing)/2)+3,0,-(finger_size/2)+3]) { //Create ring to right of center
			rotate(a=[90,0,0]) { 
				difference() {
					cylinder(h = 10, r1 = (finger_size/2)+3, r2 = (finger_size/2)+3, center = true );
					cylinder(h = total_depth+finger_size+5, r1 = (finger_size/2), r2 = (finger_size/2), center = true);
				}
			}
		}
		//Carve the frame one last time
		translate(v=[5,5-(total_height/2),total_depth/2]) { //Subtracting out a cross-section 10mm from the edges
			scale(v=[1,(total_height-5)/total_width,total_depth/total_width]) {
				cube(total_width-10);
			}
		}
	}
}
}

rotate(a=[0,180,0]){create_ring(); //now we can rotate and call the ring creation module
};