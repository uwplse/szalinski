//preview[view:east,tilt:bottom]

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

//in case you need to adjust the case tolerance for fit
perimeter_tolerance=.55;
height_tolerance=.1;

//if you want to scale your image to less or more than 100% width
image_scale=100;//[10:500]


/*Non customizer variables*/
module Void(){}

honeycomb_radius = pattern_radius;
honeycomb_radius_modifier = pattern_overlap;
honeycomb_sides = pattern_shape;
honeycomb_rotation = pattern_rotation;
line_thickness = pattern_thickness;
honeycomb_thickness = line_thickness*.4;

stencil_thickness = 10;

cthk = case_thickness;
ctol = perimeter_tolerance;
htol = height_tolerance;

4width=58.55;	
4length=115.15;
4height=9.34;
4cornerR = 8.77;
4swidth=6.17;
4sthick=.6;
4margin=4width/2-(4width/2-3)*image_scale/100;

5width = 57.57;
5length = 122.83;
5height = 7.6;
5cornerR = 9.28;
5sthick = 1.44;
5swidth = 5height - 5sthick*1.5;
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

//rotate([0,0,90])


if(iphone_version == 1){
	iPhone4Case();
}else{
	iPhone5Case();
}
	




module iPhoneGlass(	w,		//width
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

module iPhoneStrip(	w,		//width
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
		iPhoneGlass(w,l,h,cR,st);
		iPhoneStrip(w,l,sw,cR,st);
	}
}


module iPhone4(w,l,h,cR,sw,st){
	union(){
		hull(){
			iPhoneGlass(w,l,sw+(h-sw)/2,cR,st);
			iPhoneStrip(w,l,sw,cR,st);
		}
		iPhoneGlass(w,l,h,cR,st);
	}
}

module iPhone5Case(){
	translate([0,0,(5height+cthk+2*htol)/2]){
		difference(){
			iPhone5(w=5width+2*(cthk+ctol),
					l=5length+2*(cthk+ctol),
					h=5height+cthk+2*htol,
					cR=5cornerR+cthk+ctol,
					sw=5swidth+cthk+2*ctol,
					st=5sthick);

			iPhone5(w=5width+2*ctol,
					l=5length+2*ctol,
					h=5height+2*htol,
					cR=5cornerR+ctol,
					sw=5swidth+2*ctol,
					st=5sthick);

			scale([1,1,2])iPhoneGlass(w=5width+2*ctol,
					l=5length+2*ctol,
					h=5height+2*htol,
					r=5cornerR+ctol,
					st=5sthick);

			translate([0,0,cthk/2])
				cube([44,5length+20,5height+cthk/2],center = true);
			
			translate([-5width/2-cthk*.8,30,4.5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(30,cthk*2,8);
		}
		difference(){
			union(){
				translate([0,0,-(5height/2 + cthk/4 + htol)])intersection(){
					iPhoneGlass(w=5width+2*ctol+fudge,
							l=5length+2*ctol+fudge,
							h=cthk/2,
							r=5cornerR+ctol-fudge,
							st=5sthick);
	
					scale([-1,1,5])
						honeycomb(5width,5length,5height,honeycomb_radius,honeycomb_radius_modifier,honeycomb_thickness,honeycomb_sides);
	
				}
				translate([15,52.4,-(5height/2 + cthk/4+htol)])
					iPhoneCameraHole(7.8,cthk/2,7.8+1.6);
			}
			translate([15,52.4,-(5height/2 + cthk/4+htol)])
				scale([1,1,2])
				iPhoneCameraHole(7.8,cthk/2,7.8);
	
	
		}
	}	
}


module iPhone4Case(){
	translate([0,0,(4height+cthk+2*htol)/2]){
		difference(){
			iPhone5(w=4width+2*(cthk+ctol),
					l=4length+2*(cthk+ctol),
					h=4height+cthk+2*htol,
					cR=4cornerR+cthk+ctol,
					sw=4swidth+cthk+2*ctol,
					st=4sthick);

			iPhone4(w=4width+2*ctol,
					l=4length+2*ctol,
					h=4height+2*htol,
					cR=4cornerR+ctol,
					sw=4swidth+2*ctol,
					st=4sthick);

			scale([1,1,2])iPhoneGlass(w=4width+2*ctol,
					l=4length+2*ctol,
					h=4height+2*htol,
					r=4cornerR+ctol,
					st=4sthick);

			translate([0,0,cthk/2])
				cube([44,4length+20,4height+cthk/2],center = true);
			
			translate([-4width/2-cthk*.8,30,5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(24,cthk*2,8);
		}
		difference(){
			union(){
				translate([0,0,-(4height/2 + cthk/4 + htol)])intersection(){
						iPhoneGlass(w=4width+2*ctol+fudge,
							l=4length+2*ctol+fudge,
							h=cthk/2,
							r=4cornerR+ctol-fudge,
							st=4sthick);
	
						scale([-1,1,5])
							honeycomb(4width,4length,4height,honeycomb_radius,honeycomb_radius_modifier,honeycomb_thickness,honeycomb_sides);
	
				}
				translate([15,48.2,-(4height/2 + cthk/4+htol)])
					iPhoneCameraHole(7.8,cthk/2,7.8+1.6);
			}
			translate([15,48.2,-(4height/2 + cthk/4+htol)])
				scale([1,1,2])
				iPhoneCameraHole(7.8,cthk/2,7.8);
	
	
		}
	}	
}

module stencil(stencil_width,stencil_height,margin){

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


