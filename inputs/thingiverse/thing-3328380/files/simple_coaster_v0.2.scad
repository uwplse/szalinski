//inner diameter
diameter=80;

//total height
height=10;

//wall & bottom thickness
thickness=3;

// calculate radius
radius=(diameter/2)+thickness;
innerradius=diameter/2;

// define the object
difference(){
	cylinder(h=height, r=radius, center=false, $fn=2*diameter);
	translate([0,0,thickness]){
		cylinder(h=height, r=innerradius, center=false, $fn=2*diameter);
	}
};