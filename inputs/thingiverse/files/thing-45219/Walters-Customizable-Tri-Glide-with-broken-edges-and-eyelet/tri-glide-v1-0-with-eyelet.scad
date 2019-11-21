//=== Flat Tri Glide ===//

//width of the webbing opening (1in = 25.4 mm)
_1_webbingWidth = 26;

// width of the gap for the webbing
_2_webbingGap = 4.5;

// thickness of the edge
_3_edgeThickness = 3.5;

// thickness of the center beam
_4_centerThickness = 4.5;

// height of the tri glide
_5_height = 3;

// percent corner rounding
_6_cornerRounding = 75; // [1:100]

// ho much to break off the edges
_7_cornerBreakage = 0.66;

// diameter of eyelet
_8_eyeDiameter = 7;

// thicknes of the eyelets rim
_9_eyeRimThickness = 4;




module makeBody(xsize, ysize, height, radius,edgeThickness,eyeRad,eyeRim) {
	translate([0,0,height/2]) {
		minkowski() {
			cube(size=[xsize-2*radius,ysize-2*radius, height/2], center = true);
			cylinder(r=radius, h=height/2, center=true);
		}
	}
	translate([0,ysize/2+eyeRad,0]) 
		cylinder(r=eyeRad+eyeRim,h=height);
}

module makeCuts(width, gap, thickness, height,b,eyeRad,eyeRim) {
    eps=0.05;
	offset = (thickness+gap)/2;
	for (y = [-offset, offset]) {
		translate([0, y, 0]) {

			translate([0, 0, height/2])
				cube(size=[width, gap, height*2], center=true);
			translate([0, 0, 0])
				makeCutEnd(width, gap, thickness, height,b);
			translate([0, 0, height]) scale([1,1,-1])
				makeCutEnd(width, gap, thickness, height,b);
		}
	translate([0,2*offset+gap/2 +eyeRad,-height*0.1]) 
		cylinder(r=eyeRad,h=height*1.2);
	translate([0,2*offset+gap/2 +eyeRad,-eps]) 
		cylinder(r1=eyeRad+b,r2=eyeRad,h=b);
	translate([0,2*offset+gap/2 +eyeRad,height-b+eps]) 
		cylinder(r1=eyeRad,r2=eyeRad+b,h=b);
	}
}

module makeCutEnd(width, gap, thickness, height,b)
{
	hull(){
		translate([0,0,+b/2])
			cube(size=[width, gap, b], center=true);
		translate([0,0,-b/2])
			cube(size=[width+2*b, gap+2*b, b], center=true);			
	}
}

module makeTriGlide(width, gap, edgeThickness, centerThickness, height, rounding, 
                    b, eyeDiam, eyeRim ,$fn=90) {
	xsize = width + edgeThickness * 2;
	ysize = centerThickness + edgeThickness * 2 + gap * 2;
	radius = edgeThickness*(rounding/100);
	difference() {
        hull()
        {
		  makeBody(xsize-2*b, ysize-2*b, height, radius,edgeThickness,eyeDiam/2,eyeRim);
          translate([0,0,b])
		  makeBody(xsize, ysize, height-2*b, radius,edgeThickness,eyeDiam/2,eyeRim);
        }
		makeCuts(width, gap, centerThickness, height,b,eyeDiam/2,eyeRim);
	}
}


makeTriGlide(_1_webbingWidth, _2_webbingGap, _3_edgeThickness, _4_centerThickness, _5_height, _6_cornerRounding,_7_cornerBreakage,_8_eyeDiameter,_9_eyeRimThickness);
