// stuff for Thingiverse Customizer
//---------------------------------------------
// (mm)
	diameter=30;
// (mm)
	thickness=4;
// (mm) - measured point-to-point
	hexNutWidth=7;
// (mm)
	holeDiameter=4;

// ensure base is at least 1mm thick
	hexHoleDepth=thickness-1;

//---------------------------------------------

// this geometry works nicely - don't adjust!!!
//---------------------------------------------
	distFromCentre=0.75*diameter;
//---------------------------------------------

// construction
//---------------------------------------------
render(){ // some wrapping to work with Sublime and OpenSCAD
difference(){
//main body
	cylinder(h=thickness, r=diameter/2, center=true, $fn=50);

//cut outs
	rotate([0, 0, 60]) 
	translate([distFromCentre, 0, 0]) 
		cylinder(h=thickness+2, r=diameter/2, center=true, $fn=50);
	translate([-distFromCentre, 0, 0]) 
		cylinder(h=thickness+2, r=diameter/2, center=true, $fn=50);
	rotate([0, 0, -60]) 
	translate([distFromCentre, 0, 0]) 
		cylinder(h=thickness+2, r=diameter/2, center=true, $fn=50);

//hex hole
	rotate([0, 0, 0]) 
	translate([0, 0, thickness-hexHoleDepth]) 
		cylinder(h=thickness, r=hexNutWidth/2, center=true, $fn=6);
		cylinder(h=thickness+2, r=holeDiameter/2, center=true, $fn=50);
}
}
//---------------------------------------------