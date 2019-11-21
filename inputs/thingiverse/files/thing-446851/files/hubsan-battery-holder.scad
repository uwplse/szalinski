/* [Common] */
battery_number = 7;
// For no tray, use 0.
tray_depth = 50;

/* [Full] */
// For walls and dividers
gap = 3;
battery_width = 22;
battery_height = 16;
battery_depth = 9;
base_thickness = 4;

/* [Hidden] */
real_tray_depth = (tray_depth == "") ? 0 : tray_depth;

module hubsan_battery_holder(
	bat_num = 7,
	gap = 3,
	bat_width = 9,
	bat_height = 16,
	bat_depth = 22,
	holder_base = 4,
	tray_depth = 50
	){

	total_width  = bat_num * (bat_width + gap) + gap;

	difference(){
		cube([  bat_depth + (gap * 2), 
				total_width,
				bat_height + holder_base]);

		translate([gap,gap,holder_base])
		for (i = [0 : bat_num-1])
		{
			translate([0,i*(gap + bat_width),0])
				cube([bat_depth,bat_width,bat_height]);
		}
		
	}
	translate([bat_depth + (gap*2),0,0])
	difference(){
		cube([tray_depth,total_width,6]);
		translate([0,gap,2])
			cube([tray_depth-gap,total_width-gap*2,4]);
	}
}

hubsan_battery_holder(
	battery_number,
	gap,
	battery_depth,
	battery_height,
	battery_width,
	base_thickness,
	real_tray_depth);
