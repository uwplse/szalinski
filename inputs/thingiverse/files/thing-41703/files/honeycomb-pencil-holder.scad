// Cell Radius
cell_radius = 8; //[5:100]
// Honeycomb Radius (hexes from center to outside of holder)
honeycomb_radius = 3; //[2:5]
// Floor Thickness
floor_thickness = 2; //[0:5]
// Height (Base height; may be adjusted by rounded top)
height = 50; //[1:150]

module hexagon(radius){
	circle(r=radius,$fn=6);
}

module cell(radius, height, floor_thickness){
	difference(){
		linear_extrude(height=height){hexagon(radius*1.2);} // base
		translate([0,0,floor_thickness]) linear_extrude(height=height){hexagon(radius*1.1);} // hole
	}
}

module translate_to_hex(x_coord, y_coord, hex_width){
	x = x_coord*hex_width*1.75;
	y = (2*y_coord*hex_width)+(x_coord*hex_width);
	translate([x, y, 0]){
		child(0);
	}
}

module rounded_cap(radius, hex_width, height){
	difference(){
		translate([0,0,height]) cylinder(r=3*hex_width*radius,h=height,center=true);
		translate([0,0,height/2]) scale([1,1,1/radius]) sphere(r=3*hex_width*radius,center=true);
	}
}

module pencil_holder(radius, hex_width, height, floor_thickness){
	difference(){
		union(){
			for(x = [-radius:radius]){
				for(y = [-radius:radius]){
					assign(z=0-x-y){
						if(max(abs(x),abs(y),abs(z))<=radius){
							translate_to_hex(x, y, hex_width) cell(hex_width, height, floor_thickness);
						}
					}
				}
			}
		}
		rounded_cap(radius, hex_width, height);
	}
}

pencil_holder(honeycomb_radius, cell_radius, height, floor_thickness);