//tip outer diameter
top_od = 4.5;
//1cm down outer diameter
one_cm_od = 7.15 ;
//inner diameter of opening
top_id = 2.3;
//thickness of walls in the x-y axis
wall_thickness = 1.6;
//height of cap (not including wall thickness)
height = 20;
//ammount your 3d printer erodes holes and dialates outer diameters.
compensation_factor = 0.2;



cf = compensation_factor*1;
slope = (one_cm_od-top_od)/10;

translate([0,0,height+wall_thickness])
rotate([0, 180, 0])
union() {
	difference() {
		cylinder(h=height+wall_thickness,d1=top_od+cf+slope*height+2*wall_thickness,
			d2=top_od+cf+2*wall_thickness-wall_thickness*slope,$fn=70);
		cylinder(h=height,d1=top_od+cf+slope*height,d2=top_od+cf,$fn=70);
	}
	translate([0, 0, height-10])
	cylinder(h=10,d1=top_id,d2=top_id+cf,$fn=70 );
}