//Internal diameter of the lens cap
cap_diameter=41;

//height of the cap holder
height=5;

strap_width=12;

$fn=100;  //makes cylinder with more definition
//module from groovenectar
//https://gist.github.com/groovenectar/292db1688b79efd6ce11
module roundedcube_simple(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}

//Object creation
difference(){
    cylinder(height,d=cap_diameter+3,center=true);
    cylinder(height+1,d=cap_diameter,center=true);
}
translate([0,0,-1.5]){
    difference(){
        roundedcube_simple([strap_width+6,cap_diameter+20, height-3],center=true,1);
        //cube([16,width+20,height-3],center=true);
        cube([strap_width,cap_diameter+14,height-2],center=true);
    }
}
