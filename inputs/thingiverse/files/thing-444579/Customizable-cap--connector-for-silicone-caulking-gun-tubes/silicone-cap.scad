/*
This is for generating caps and connectors for silicone and other caulking gun tubes.

This is released under Creative Commons - Attribution - Share alike

For the attribution part, you can reference:
	http://www.thingiverse.com/thing:444579
	
*/

/* [main] */

// What do we want to create
goal=0; // [0:complete, 1:just the inside fitting]

// What do we want this cap to fit
cap_for=-1; // [-1:Universal,0:DAP Alex Plus,1:GE Silicone I,2:PL Construction Adhesive,3:Loctite Power Grab,4:QuickCrete polyurethane construction adhesive]

// Used to make the fit a little looser than the exact size of the nozzle (0=exact size of the tube .. 3=very loose)
fitting_slop=1;

// How thick the walls of the cap are (when goal=complete)
thickness=1.5;

// The tip on the tubes are usually not sharp, but blunted.  This will extend the tip to a sharp point. 
extend_tip=true;

// If you want to include a hole for attaching your tube to something else (like a mold or an applicator tip)
hole=0;

// If you want to extend the cap for attaching your tube to something else (like a mold or an applicator tip)
extend=0;

// The diameter of the extension (if 0, then it will be simply the dia of the last section)
extend_dia=0;

// For visualization purposes.  TURN OFF WHEN CREATING STL!!!
cutaway=false;

/* [hidden] */

// this is the table of known caulking tube tips.  The numbers are dia,len,dia,... of each sloped section from top to bottom.
t=[["DAP Alex Plus",3.54,22.3,11.49,52.04,15.78,0,15.78],
["GE Silicone I",3.41,22.59,11.20,51.97,15.54,0,15.54],
["PL Construction Adhesive",3.35,20.05,10.64,36.64,12.57,14.53,17.21],
["Loctite Power Grab",2.62,28.67,12.36,30.96,15.20,7.35,15.20],
["QuickCrete polyurethane construction adhesive",5.01,20.06,11.41,42.97,14.92,6.68,15.90]];

module capsection(a,oversize_r=0,inside=false,i=2){
	r1=a[i-1]/2+oversize_r;
	h=a[i];
	r2=a[i+1]/2+oversize_r;
	projected_r=a[1]/2+oversize_r;
	projected_angle=asin(projected_r/a[2]);
	projected_h=(extend_tip==true)?projected_r/sin(projected_angle):0;
	extend_dia=extend_dia<=0?projected_r*2:extend_dia;
	extend=extend<=0?0:extend;
	nudge=i==2?max(extend,projected_h):0;
	translate([0,0,nudge]) if(a[i]!=undef&&a[i]>0) {
		echo(str("r1=",r1," r2=",r2," h=",h," projected_angle=",projected_angle));
		if(projected_h>0&&i==2&&inside==false){
			translate([0,0,-projected_h]) color([1,0,0]) cylinder(r1=0.001,r2=projected_r,h=projected_h,$fn=32);
			if(inside==false&&extend>0){
				translate([0,0,-max(extend,projected_h)]) cylinder(r=extend_dia/2,h=max(extend,projected_h),$fn=32);
			}
		}else{
			if(inside==false&&extend>0){
				translate([0,0,-extend]) cylinder(r=extend_dia/2,h=max(extend,projected_h),$fn=32);
			}
		}
		cylinder(r1=r1,r2=r2,h=h,$fn=32);
		if(inside==false&&extend>0){
			cylinder(r=extend_dia/2,h=max(extend,h),$fn=32);
		}
		translate([0,0,a[i]]) capsection(a,oversize_r,inside,i+2);
	}
}

module conehead(i,oversize_r=0,inside=false) {
	echo(str("----->",t[i][0]));
	capsection(t[i],oversize_r,inside);
}

module conehead_all(oversize_r=0,inside=false){
	union() {
		for(i=[0:len(t)-1]){
			//translate([i*10,0,0]) 
			conehead(i,oversize_r,inside);
		}
	}
}

if (cap_for<0){
	difference() {
		if(goal==0) {
			translate([0,0,-scoche]) conehead_all(fitting_slop+thickness);
		}
		conehead_all(fitting_slop,true);
		if(cutaway) translate([0,0,-100]) cube([100,100,200]); // cutaway
		if(hole>0){
			translate([0,0,-250]) cylinder(r=hole,h=500,$fn=32);
		}
	}
}else{
	difference() {
		if(goal==0){
			translate([0,0,-scoche]) conehead(cap_for,fitting_slop+thickness);
		}
		conehead(cap_for,fitting_slop,true);
		if(cutaway) translate([0,0,-100]) cube([100,100,200]); // cutaway
		if(hole>0){
			translate([0,0,-250]) cylinder(r=hole,h=500,$fn=32);
		}
	}
}
	
	
	