// Author: K1nc41d
// http://www.thingiverse.com/thing:38001



/*Customizer Variables*/

/*[Box]*/
//in mm:
case_thickness = 4; //[2:10]
//17mm per deck:
case_Width = 17; //[5:500]
case_Height = 74; //[25:500]
case_Length = 56; //[5:500]
case_Lip = 7; //[2:15]
case_Top_Height = 24; //[15:100]
//top fit in mm:
case_Lip_Tollerance = .25; 


/*[Pattern]*/
pattern_shape = 6; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]
//in mm:
pattern_radius = 6; //[4:22]
pattern_overlap = 28; //[0:100]
//in degrees:
pattern_rotation = 21; //[0:180]
//in .4 mm increments:
pattern_thickness = 6; //[2:30]

/*[Hidden]*/

preview_tab = "Box";

honeycomb_thickness = pattern_thickness*.4;
BoxHeight = case_Height+case_thickness/2;
BoxLength = case_Length+case_thickness;
BoxWidth = case_Width+case_thickness;
BoxLip = case_Lip;
topHeight = case_Top_Height+case_thickness/2;

if(preview_tab == "Box"){
        translate([0,0,case_thickness/2])
		difference(){
            baseBox();
            boxLipCut();
        }
        translate([0,BoxWidth*2+case_thickness,case_thickness/2])
        difference(){
            topBox();
            boxTopLipCut();
        }
	}
    else {
        honeycombwall(BoxLength,BoxHeight,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
    }

module boxTopLipCut(){
    translate([-(BoxLength+case_thickness)/2, -(BoxWidth+case_thickness)/2,case_thickness/2])
    cube([BoxLength+case_thickness,BoxWidth+case_thickness,topHeight+1]);
}

module topBox(){
    length = BoxLength + 2*case_thickness;
    width = BoxWidth + 2*case_thickness;
    height = topHeight + case_thickness;
    union(){
       //bottom
        honeycombwall(length,width,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
        //front
        translate([0,(BoxWidth+case_thickness)/2,topHeight/2])
        rotate([90,0,0])
        honeycombwall(length,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
        //Back
        translate([0,-(BoxWidth+case_thickness)/2,topHeight/2])
        rotate([90,0,0])
        honeycombwall(length,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
    }
    //left
        translate([(BoxLength+case_thickness)/2,0,topHeight/2])
        rotate([90,0,90])
        honeycombwall(width,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
    //right
        translate([-(BoxLength+case_thickness)/2,0,topHeight/2])
        rotate([90,0,90])
        honeycombwall(width,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
    reinforce(length,width,height,0);
}

module baseBox(){
    length = BoxLength + 2*case_thickness;
    width = BoxWidth + 2*case_thickness;
    height = BoxHeight + case_thickness;
    union(){
       //bottom
        honeycombwall(length,width,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
        //front
        translate([0,(BoxWidth+case_thickness)/2,BoxHeight/2])
        rotate([90,0,0])
        honeycombwall(length,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
        //Back
        translate([0,-(BoxWidth+case_thickness)/2,BoxHeight/2])
        rotate([90,0,0])
        honeycombwall(length,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
    }
    //left
        translate([(BoxLength+case_thickness)/2,0,BoxHeight/2])
        rotate([90,0,90])
        honeycombwall(width,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
    //right
        translate([-(BoxLength+case_thickness)/2,0,BoxHeight/2])
        rotate([90,0,90])
        honeycombwall(width,height,case_thickness,pattern_radius,pattern_overlap,honeycomb_thickness,pattern_shape,pattern_rotation);
    reinforce(length,width,height,BoxLip);
}

module boxLipCut(){
    length = BoxLength + 2*case_thickness;
    width = BoxWidth + 2*case_thickness;
    translate([-(length/2+1),-(width/2+1),BoxHeight+case_thickness/2-BoxLip]){
        difference(){
            cube([length+2,width+2,BoxLip+2]);
            translate([case_thickness/2+1+case_Lip_Tollerance/2,case_thickness/2+1+case_Lip_Tollerance/2,-1])cube([(length - case_thickness)-case_Lip_Tollerance, (width - case_thickness)-case_Lip_Tollerance, BoxLip+4]);
        }
    }
}

module reinforce(l,w,h,topadd){
    translate([-l/2,-w/2,-case_thickness/2])
    difference(){
        cube([l,w,h]);
        union(){
        translate([case_thickness, case_thickness, -1])cube([l-(case_thickness*2),w-(case_thickness*2),h+2]);
        translate([-1, case_thickness, case_thickness])cube([l+2,w-(case_thickness*2),h-(case_thickness*2+topadd)]);
        translate([case_thickness, -1, case_thickness])cube([l-(case_thickness*2),w+2,h-(case_thickness*2+topadd)]);    }
    }
}

module honeycombwall(w,l,h,rad,radmod,thickness,sides,rot){
    linear_extrude(h, center = true, convexity = 10)intersection(){
    honeycomb(w,l,rad,radmod,thickness,sides,rot);
    translate([-(w/2),-(l/2),0])square([w,l]);
    }
}

module honeycomb(w,l,r,rmod,th,sides,rot){
    fudge = .05;
	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);

	translate([-w/2,l/2,0])
		rotate([0,0,-90])
			
			for(i = [-1:rows+1]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
					for(i = [0:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*1.5*i,r*sqrt(3)/2*i,0])
									rotate([0,0,rot])
									difference(){
										if(sides < 5){
											circle(r = r+th+(r*rmod/50)+fudge, center = true, $fn = sides);
										} else {
											circle(r = r+(r*rmod/50)+fudge, center = true, $fn = sides);
										}
										circle(r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}

