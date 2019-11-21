//Size on the y-Axis in mm
size = 15;

//Size on the z-Axis in mm
height = 5;

module half(){
	difference(){
		cylinder(r=size/2,h=height,$fn=50, center=true);
		translate([(size+1)/2,0,0]) cube([size + 1, size + 1,height + 1],center = true);
	}
}

module plate(){
	union() {
		half();
		translate([0,-size/2,-height/2]) cube([size,size,height]);
	}
}

//Top Knob Diameter
knob_diameter = 4;

//Top Knob Hight
knob_hight = 1.5;

//Bottom Hole Diameter
hole_diameter = 4;

//Bottom Hole Depth
hole_depth = 1.5;

//Keyring Hole Diameter
keyring_hole=1.5;

difference(){
	union(){
		plate();
		translate([size/4, size/4 , height/2]) cylinder(r=knob_diameter/2,h=knob_hight,$fn=50);
		translate([size/4, -size/4, height/2]) cylinder(r=knob_diameter/2,h=knob_hight,$fn=50);
		translate([3*(size/4), size/4, height/2]) cylinder(r=knob_diameter/2,h=knob_hight,$fn=50);
		translate([3*(size/4),-size/4, height/2]) cylinder(r=knob_diameter/2,h=knob_hight,$fn=50);
	}
	translate([size/4,size/4,-height/2-0.01]) cylinder(r=hole_diameter/2,h=hole_depth+0.01,$fn=50);
	translate([size/4,-size/4,-height/2-0.01]) cylinder(r=hole_diameter/2,h=hole_depth+0.01,$fn=50);
	translate([3*(size/4),size/4,-height/2-0.01]) cylinder(r=hole_diameter/2,h=hole_depth+0.01,$fn=50);
	translate([3*(size/4),-size/4,-height/2-0.01]) cylinder(r=hole_diameter/2,h=hole_depth+0.01,$fn=50);
	translate([-size/4,0,-height/2-0.01]) cylinder(r=keyring_hole, h=height+0.02, $fn=50);
}
