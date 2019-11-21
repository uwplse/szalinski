/* [General] */
fan_size = 120; // [80:80mm,92:92mm,120:120mm,140:140mm]

/* [Hex Fill] */

hex_scale = 1; // [0.2:0.1:2]
// The height of the hex mesh
hex_height = 1.2;

/* [Frame] */

// The height of the outer frame
height = 2.8;
// The radius of the outside corners
edge_radius = 5;
// The minimum thickness of the outer frame around the hole
frame_thickness = 2;

/* [Hidden] */

// these numbers come from googling the sizing specifications
holeRatio140 = 124.5 / 140;
holeRatio120 = 104 / 120;
holeRatio92 = 82.5 / 92;
holeRatio80 = 71.5 / 80;

holeRatio = fan_size == 80 ? holeRatio80 : (fan_size == 92 ? holeRatio92 : (fan_size == 120 ? holeRatio120 : (fan_size == 140 ? holeRatio140 : (.9))));

holeSpace = fan_size*holeRatio;
holeOffset = (fan_size - holeSpace) / 2;

difference(){    
    union(){
		frame();
		intersection() {
			outsideFrame();
			grid();
		}
    }
    screwHoles();
}

module frame(){
	difference(){  
		outsideFrame();
		translate([fan_size/2,fan_size/2,-1]){
			cylinder(r=(fan_size/2)-frame_thickness, h=height + 2, $fn=120);
		}
	}
}


module outsideFrame(){
    translate([edge_radius,edge_radius,0]){
		minkowski(){
			cube([fan_size-(edge_radius * 2),fan_size-(edge_radius * 2),1]);
			cylinder(r=edge_radius,h=height-1, $fn=60);
		}
    }
}


module screwHoles(){
    translate([holeOffset,holeOffset,-1]){
        cylinder(r=2.25, h=height + 2, $fn=60);
    }
    translate([fan_size-holeOffset,fan_size-holeOffset,-1]){
        cylinder(r=2.25, h=height + 2, $fn=60);
    }
            translate([fan_size-holeOffset,holeOffset,-1]){
        cylinder(r=2.25, h=height + 2, $fn=60);
    }
    translate([holeOffset,fan_size-holeOffset,-1]){
        cylinder(r=2.25, h=height + 2, $fn=60);
    }
}



module grid(){
	hexWidth = 33 * hex_scale;
	hexHeight = 19 * hex_scale;
    for (i =[0:(fan_size / hexHeight)]){
        for (j =[0:(fan_size / hexWidth)]){
            translate([hexWidth * j, hexHeight * i, 0]){
				scale(hex_scale)
					hexagon();
            }
        }
    }
    translate([16.5*hex_scale,9.5*hex_scale,0]){
        for (i =[0:(fan_size / hexHeight)]){
            for (j =[0:(fan_size / hexWidth)]){
                translate([hexWidth * j, hexHeight * i, 0]){
					scale(hex_scale)
						hexagon();
                }
            }
        }
    }
}
module hexagon(){
    difference(){
        cylinder(r=11,$fn=6,h=hex_height);
		translate([0,0,-1]) {
			minkowski(){
			    cylinder(r=8.5,$fn=6,h=hex_height + 2);
				cylinder(r=1,h=hex_height,$fn=30);
			}
        }
    }
}