$fn=50;
holderHeight=100;
holderDepth=120;
laptopThickness=29;
leftLegLength=20;
rightLegLength=50;
quarterRound=12;



union(){
    //left holder upgright
    roundedcube([holderDepth,5,5+holderHeight], false,2,"zmax");

    //right holder upgright
    translate([0,5+laptopThickness,0]) roundedcube([holderDepth,5,5+holderHeight], false,2,"zmax");

    //base under laptop
    roundedcube([holderDepth,10+laptopThickness,5],false,2,"zmax");

    //left leg
    translate ([0,-leftLegLength],0) roundedcube([holderDepth,leftLegLength+5,5],false,2,"zmax");

    //right leg
    translate ([0,5+laptopThickness,0]) roundedcube([holderDepth,rightLegLength+5,5],false,2,"zmax");

    // left holder quarter round
    difference(){
        union() {
            translate([quarterRound,0,5]) rotate([0,90,0]) cylinder(r=quarterRound, h=holderDepth-quarterRound*2);
            translate([quarterRound,0,5]) sphere(r=quarterRound);
            translate([quarterRound+holderDepth-quarterRound*2,0,5]) sphere(r=quarterRound);

            // right holder quarter round
            translate([quarterRound,10+laptopThickness,5]) rotate([0,90,0]) cylinder(r=quarterRound, h=holderDepth-quarterRound*2);
            translate([quarterRound,10+laptopThickness,5]) sphere(r=quarterRound);
            translate([quarterRound+holderDepth-quarterRound*2,10+laptopThickness,5]) sphere(r=quarterRound);
        }
    translate([0,-leftLegLength,-50])cube([holderDepth,leftLegLength+10+rightLegLength,50]);
    translate([0,5-1,4]) cube([holderDepth,laptopThickness+2,quarterRound+1]);    
        
    }

}















// More information: https://danielupshaw.com/openscad-rounded-corners/ for below module
module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}