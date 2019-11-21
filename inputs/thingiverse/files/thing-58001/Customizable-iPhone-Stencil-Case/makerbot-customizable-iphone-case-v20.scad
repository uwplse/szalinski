//preview[view:west,tilt:bottom]

////////////////////////////////////////////////////////////////////////////////////////////
///////////////////          *Customizer variables*          ////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

/* [Basics] */
//Remember to use all of the tabs!
//What color is the case?
primary_color="red"; //[black,silver,gray,white,maroon,red,purple,fuchsia,green,lime,olive,yellow,navy,blue,teal,aqua,brown,sienna]

iphone_version = 1; //[1:iPhone 4,1:iPhone 4S,2:iPhone 5]
case_thickness = 1.8; //[1.8:Slim,2.4:Sturdy]
type_of_case = 3; //[1:Stencil,2:Makerbot Geometric Design,3:Mashup]

//Should the case have hooks for a rubber band that holds cash, cards, etc?
include_hooks="no"; //[yes,no]

/* [Stencil] */

//Use http://chaaawa.com/stencil_factory/ then paste here after "Convert&Copy"
input = "no_input";

//If you want to scale your image to less or more than 100% width
image_scale=100;//[10:500]

//If you don't want to center your design on the case
offX =0;
offY =0;
image_rotation =30; //[-180:180]


/* [Geometrics] */

//Select the pattern shape
pattern_shape =6; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]

//Paremeters in mm:
pattern_radius =17; //[4:22]
pattern_overlap = 18; //[0:100]

//Parameters in degrees:
pattern_rotation = 13; //[0:180]

//In .4 mm increments:
pattern_thickness = 5; //[2:30]


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
5_perimeter_tolerance=.5;
5_height_tolerance=.2;
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
color(primary_color)rotate([0,0,90]){
	if(iphone_version == 1){
		translate([0,0,(4height+cthk/2+2*4htol)/2])iPhone4Case();
	}else{
		translate([0,0,(5height+cthk+2*5htol)/2])iPhone5Case();
	}
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

			translate([0,0,0])iPhone5(w=5width+2*5ctol,
					l=5length+2*5ctol,
					h=5height+2*5htol,
					cR=5cornerR+5ctol,
					sw=5swidth+2*5ctol,
					st=5sthick,
					taper=case_taper);

			iPhoneGlass(w=5width+2*5ctol+.05,
					l=5length+2*5ctol+.05,
					h=5height+2*5htol+cthk+.01,
					r=5cornerR+5ctol,
					st=5sthick,
					taper=case_taper);

			translate([0,0,cthk/2])
				cube([44,5length+20,5height+cthk/2],center = true);
			
			translate([-5width/2-cthk*.8,30,4.5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(30,cthk*2,8);
		}
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
					iPhoneCameraHole(7.8,cthk/2,7.8+1.6);
			}
			translate([15,52.4,0])
				scale([1,1,2])
				iPhoneCameraHole(7.8,cthk/2,7.8);
	
	
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
			if(iphone_version==1 && type_of_case==2)
				honeycomb(4width+2*4ctol,4length+2*4ctol,4height,
					honeycomb_radius,honeycomb_radius_modifier,
					honeycomb_thickness,honeycomb_sides);
			if(iphone_version==2 && type_of_case==2)
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