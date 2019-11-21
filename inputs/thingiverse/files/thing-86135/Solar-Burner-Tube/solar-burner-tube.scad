// Choose Solar Burner Tube or its lid
print_object=1;  // [1:Solar Burner Tube,2:Lid]

// The height of the reflector. I propose a ratio height/focus_area of 2.215 
height=40; // [10:200]

// The focus point is at the smaller aperture. This defines the radius of it.
focus_area=18; //[1:80]

// The resolution of the reflector.
resolution= 45; //[45,80,120]

// Horizontal wall thickness. Set to 0 for a solid body. Try to find a good value for your nozzle size.
wall=1.7; 

// The height of the lid ring. Set to 0 for no lid friction ring.
lid=3; // [0:10]

// The clearence for printing the lid ring and its friction.
clr=0.2; 


//////////////////////////////////////////////////////////////////////////////////////////////
// Solar Burner Tube
// 
// Copyright (C) 2013  Lochner, Juergen
// http://www.thingiverse.com/Ablapo/designs
//
// Warning: It is not recommanded to build this thing out of mirroring materials!
// It could cause fire and eye damage. Sun glases will not protect your eyes.
// Think of it as a big magnifying lens, laser beam and lighter when using it. 
// Remove the reflecting surface for a save storage.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
//
// This program is free software. It is 
// licensed under the Attribution - Creative Commons license.
// http://creativecommons.org/licenses/by/3.0/
//////////////////////////////////////////////////////////////////////////////////////////////

module paraboloid (y=50, f=10, rfa=0, fc=1, detail=44){
	// y = height of paraboloid
	// f = focus distance 
	// fc : 1 = center paraboloid in focus point(x=0, y=f); 0 = center paraboloid on top (x=0, y=0)
	// rfa = radius of the focus area : 0 = point focus
	// detail = $fn of cone

	hi = (y+2*f)/sqrt(2);								// height and radius of the cone -> alpha = 45° -> sin(45°)=1/sqrt(2)
	x =2*f*sqrt(y/f);									// x  = half size of parabola
	
   translate([0,0,-f*fc])								// center on focus 
	rotate_extrude(convexity = 10,$fn=detail )		// extrude paraboild
	translate([rfa,0,0])								// translate for fokus area	 
	difference(){
		union(){											// adding square for focal area
			projection(cut = true)																			// reduce from 3D cone to 2D parabola
				translate([0,0,f*2]) rotate([45,0,0])													// rotate cone 45° and translate for cutting
				translate([0,0,-hi/2])cylinder(h= hi, r1=hi, r2=0, center=true, $fn=detail);   	// center cone on tip
			translate([-(rfa+x ),0]) square ([rfa+x , y ]);											// focal area square
		}
		translate([-(2*rfa+x ), -1/2]) square ([rfa+x ,y +1] ); 					// cut of half at rotation center 
	}
}

module reflector(hr=40, xr=20, details=80){
	// for optimum covered area:    hr/xr = 2.215  -> hr = 2x distance(from focus to parabola slope of 45°)  
	fr= xr/2;  						// xr= 2*f*sqrt(f/f)
	yr=hr+fr;
	
	translate([0,0,hr])rotate([180,0,0])	
	difference(){
		if (wall>0) {
			paraboloid (yr ,fr , wall , 1,details );
			if (lid>0) {
				translate([0,0, hr-lid/2])cylinder(h=lid,r=wall+2*sqrt(yr*yr-yr*hr),center=true,$fn=details);
				}
			}
		translate([0,0, -0.01])paraboloid (yr+0.02 ,fr , 0, 1,details );
		translate([0,0,-(fr+1)/2])cube([xr*2+wall*4+1,xr*2+wall*4+1,fr+1],center=true);
	}
}


module  print_lit(hr=40, xr=20, details=80){

	fr= xr/2;  						// xr= 2*f*sqrt(f/f)
	yr=hr+fr;
	
	if (wall>0) {
			if (lid>0) {
				difference(){
					translate([0,0,0])cylinder(h=lid+2+wall,r=wall+2*sqrt(yr*yr-yr*hr)+wall+clr,center=true,$fn=details);
					translate([0,0,wall])cylinder(h=lid+2+wall,r=wall+2*sqrt(yr*yr-yr*hr) +clr,center=true,$fn=details);
				}
			}
	}
}

if (print_object==2) print_lit(height,focus_area,resolution);
if (print_object==1) reflector(height,focus_area,resolution);