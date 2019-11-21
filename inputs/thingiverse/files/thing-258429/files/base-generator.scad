// Base generator and customizer script
// developed by Daniel Joyce
// 3D-Miniatures.com

/* [Global] */

// Polygon
base_style = 4; // [3:triangle,4:square,5:pentagon,6:hexagon,7:heptagon,8:octagon,50:round]

// Base diameter, 
diameter = 25; // [15:250]

// Thickness of base, ~3 mm is std
thickness = 3; // [1:25]

// Should base have a slot
slot = 1; // [1:yes, 2:no]

// Orientation of slot
slot_orientation = 1; // [1:sides, 2:verts]

// Normally 25 mm square / hex base diameter is measured side to side
across_sides = 1; // [0:no, 1:yes]

// Number of rows of bases
rows = 1; // [1:10]

// Number of columns of bases
columns = 1; // [1:10]


/* [Hidden] */

radius = diameter / 2;

cos_r = cos(360/(2*base_style));

scale_factor = across_sides == 0 ? 1 : 1 / cos_r;

offset = (diameter * scale_factor) + 2;

module base(sides, 
	diameter = 25, 
	slot = false, 
	height = 3.33,
	slot_x = true,
	inset = false ){
	radius = diameter / 2;
	cos_r = cos(360/(2*sides));

	scale_factor = inset ? 1 : 1 / cos_r;
	slot_width = cos(360/(2*sides))*diameter*0.9*scale_factor;
	even = sides % 2 == 0;
	slot_angle = even ? 360 / (2*sides) : 90;
	slot_r = slot_x ? 0 : slot_angle;
	difference(){
		scale([scale_factor,scale_factor,1]) rotate([0,0,360/(2*sides)]) cylinder(h = height, r1=radius, r2=radius-0.5, $fn=sides);
		if(slot){
			rotate([0,0, slot_r]) cube([2.3,slot_width,height+10], center=true);
		}
	}
}

module make_x_by_y(x,y,offset){
	for(j = [0:y]){
		for(i = [0:x]){
			translate([i*offset,j*offset,0]) child(0);
		}
	}
	
}

make_x_by_y(rows - 1,columns - 1,offset){
	base(base_style, 
		diameter = diameter, 
		slot = (slot==1),
		height = thickness,
		inset = (across_sides == 0),
		slot_x = (slot_orientation==1) );
}
