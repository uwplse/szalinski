use <utils/build_plate.scad>

//preview[view:east,tilt:top]

/*Customizer Variables*/

iphone_version = 1; //[1:iPhone 4,1:iPhone 4S,2:iPhone 5]
case_thickness = 1.8; //[1.8:Slim,2.4:Sturdy]
pattern_shape = 6; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]
//in mm:
pattern_radius = 8; //[4:22]
pattern_overlap = 15; //[0:100]
//in degrees:
pattern_rotation = 0; //[0:180]
//in .4 mm increments:
pattern_thickness = 2; //[2:30]
//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic]


/*Non customizer variables*/

honeycomb_radius = pattern_radius;
honeycomb_radius_modifier = pattern_overlap;

honeycomb_sides = pattern_shape;

caseThickness = case_thickness;
honeycomb_rotation = pattern_rotation;

line_thickness = pattern_thickness;

caseTolerance = .2/1;

4width=58.55/1;	
4length=115.15/1;
4height=9.34/1;
4cornerR = 8.77/1;
4swidth=6.17/1;
4sthick=.6/1;

5width = 57.57/1;
5length = 122.83/1;
5height = 7.6/1;
5cornerR = 9.28/1;
5sthick = 1.44/1;
5swidth = 5height - 5sthick*1.5;


heightvar=.24/1;

homebuttonR = 5.6/1;
homebuttonD = homebuttonR*2;



top_bottom_opening_width = 50/1;

leftholelength = 25.43/1;
leftholeR = 2.4/1;
topholelength = 38.57/1;
topholeR = 2.5/1;
bottomholelength1 = 43.97/1;
bottomholelength2 = 26.05/1;
bottombigR = 1.53/1;
bottomsmallR = 1.15/1;

corner_resolution = 6/1;
circle_resolution = corner_resolution*4;



fudge = .05/1;



honeycomb_thickness = line_thickness*.4;


//iPhone4Case();
//translate([70,0,20])
//iPhone5Case();
//color([.5,0,0])
//iPhone5();
//translate([100,0,0])
//iPhone4();

build_plate(build_plate_selector);

rotate([0,0,90])
if(iphone_version == 1){
	iPhone4Case();
	//iPhoneGlass(4width,4length,4height,4cornerR);
	//iPhoneStrip(4width,4length,4height,4cornerR,4swidth,4sthick);
}else{
	iPhone5Case();
}
	



module iPhoneGlass(	w,		//width
					l,		//length
					h,		//height
					r	)	//corner radius
{
	union(){

		cube([w,l-r*2,h],center = true);

		cube([w-r*2,l,h],center = true);

		//top right corner
		translate([w/2-r,l/2-r,0])
			cylinder(	h = h,
						r = r,
						center = true,
						$fn = circle_resolution);
	
		//top left corner
		translate([-(w/2-r),l/2-r,0])
			cylinder(	h = h,
						r = r,
						center = true,
						$fn = circle_resolution);
		
		//bottom right corner
		translate([w/2-r,-(l/2-r),0])
			cylinder(	h = h,
					 	r = r,
						center = true,
						$fn = circle_resolution);
	
		//bottom left corner
		translate([-(w/2-r),-(l/2-r),0])
			cylinder(	h = h,
						r = r,
						center = true, 
						$fn = circle_resolution);
		
	}
}

module iPhoneStrip(	w,		//width
					l,		//length
					h,		//height
					r,		//corner radius
					sw,		//strip width
					st	)	//strip thickness
						
{
	union(){
		
		cube([w+st*2,l-r*2,sw],center = true);

		cube([w-r*2,l+st*2,sw],center = true);

		//top right corner
		translate([w/2-r,l/2-r,0])

			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
	
		//top left corner
		translate([-(w/2-r),l/2-r,0])

			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
		
		//bottom right corner
		translate([w/2-r,-(l/2-r),0])

			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
	
		//bottom left corner
		translate([-(w/2-r),-(l/2-r),0])

			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
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


module iPhone5(w,l,h,cR,sw,st){
	hull(){
		iPhoneGlass(w,l,h,cR);
		iPhoneStrip(w,l,h,cR,sw,st);
	}
}


module iPhone4(w,l,h,cR,sw,st){
	union(){
		hull(){
			iPhoneGlass(w,l,sw+st,cR);
			iPhoneStrip(w,l,h,cR,sw,st);
		}
		iPhoneGlass(w,l,h,cR);
	}
}

module iPhone5Case(){
	translate([0,0,(5height+caseThickness)/2]){
		difference(){
			hull(){
				iPhoneGlass(5width+caseThickness*2,5length+caseThickness*2,5height+caseThickness,5cornerR+caseThickness);
				iPhoneStrip(5width+caseThickness*2,5length+caseThickness*2,5height+caseThickness*2,5cornerR+caseThickness,5swidth,5sthick);
			}
			iPhone5(5width-caseTolerance*3,5length-caseTolerance*2,5height+caseTolerance,5cornerR,5swidth+caseTolerance*2,5sthick+caseTolerance);
			translate([0,0,-5height*.5])
				iPhoneGlass(5width-caseThickness*2,5length-caseThickness*2,5height,5cornerR);
			translate([0,0,5height*.5])
				iPhoneGlass(5width-caseTolerance*3,5length-caseTolerance*2,5height+caseTolerance,5cornerR);
			translate([0,0,caseThickness/2])
			cube([44,5length+20,5height+caseThickness/2],center = true);
			translate([-5width/2-caseThickness*.8,30,4.5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(30,caseThickness*2,8);
		}
		difference(){
			union(){
				intersection(){
					translate([0,0,-(5height/2 + caseThickness/4 + caseTolerance/4)])
						iPhoneGlass(5width-caseThickness*2+fudge,5length-caseThickness*2+fudge,caseThickness/2-caseTolerance/2,5cornerR-fudge);
	
					
					
					translate([0,0,-(5height/2 + caseThickness/4)])
						scale([1,1,5])
							honeycomb(5width,5length,5height,honeycomb_radius,honeycomb_radius_modifier,honeycomb_thickness,honeycomb_sides);
	
				}
				translate([15,52.4,-(5height/2 + caseThickness/4)])
					iPhoneCameraHole(7.8,caseThickness/2,7.8+1.6);
			}
			translate([15,52.4,-(5height/2 + caseThickness/4)])
				scale([1,1,2])
				iPhoneCameraHole(7.8,caseThickness/2,7.8);
	
	
		}
	}	
}

module iPhone4Case(){
	translate([0,0,(4height+caseThickness)/2]){
		difference(){
			hull(){
				iPhoneGlass(4width+caseThickness*2,4length+caseThickness*2,4height+caseThickness,4cornerR+caseThickness);
				iPhoneStrip(4width+caseThickness*2,4length+caseThickness*2,4height+caseThickness*2,4cornerR+caseThickness,4swidth,4sthick);
			}
			iPhone4(4width-caseTolerance*3,4length-caseTolerance*2,4height+caseTolerance,4cornerR,4swidth+caseTolerance*2,4sthick+caseTolerance);
			translate([0,0,4height*.5])
				iPhoneGlass(4width-caseTolerance*3,4length-caseTolerance*2,4height,4cornerR);
			translate([0,0,-4height*.5])
				iPhoneGlass(4width-caseThickness*2,4length-caseThickness*2,4height,4cornerR);
			translate([0,0,caseThickness/2])
			cube([44,4length+20,4height+caseThickness/2],center = true);
			translate([-4width/2-caseThickness*.8,30,5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(24,caseThickness*2,8);
		}
		difference(){
			union(){
				intersection(){
					translate([0,0,-(4height/2 + caseThickness/4 + caseTolerance/4)])
						iPhoneGlass(4width-caseThickness*2+fudge,4length-caseThickness*2+fudge,caseThickness/2-caseTolerance/2,4cornerR+fudge);
	
					
					
					translate([0,0,-(4height/2 + caseThickness/4)])
						scale([1,1,5])
							honeycomb(4width,4length,4height,honeycomb_radius,honeycomb_radius_modifier,honeycomb_thickness,honeycomb_sides);
	
				}
				translate([15,48.2,-(4height/2 + caseThickness/4)])
					iPhoneCameraHole(7.8,caseThickness/2,7.8+1.6);
			}
			translate([15,48.2,-(4height/2 + caseThickness/4)])
				scale([1,1,2])
				iPhoneCameraHole(7.8,caseThickness/2,7.8);
	
	
		}
	}	
}

module honeycomb(w,l,h,r,rmod,th,sides){
	
	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);

	translate([-w/2,l/2,0])
		rotate([0,0,-90])
			for(i = [0:rows]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
				//scale([1*(1+(i/10)),1,1])
					for(i = [0:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*1.5*i,r*sqrt(3)/2*i,0])
									rotate([0,0,honeycomb_rotation])
									difference(){
										if(sides < 5){
											cylinder(height = h, r = r+th+(r*rmod/50), center = true, $fn = sides);
										} else {
											cylinder(height = h, r = r+(r*rmod/50), center = true, $fn = sides);
										}
										cylinder(height = h+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}

