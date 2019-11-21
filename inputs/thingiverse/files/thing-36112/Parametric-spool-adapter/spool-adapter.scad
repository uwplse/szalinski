axis_diameter = 8.2;
spool_inter_diameter = 39;

spool_adapter(axis_diameter,spool_inter_diameter);

module spool_adapter(axis_dia=8,spool_dia=40)
difference(){
	union(){
		cylinder(r=spool_dia*.75, h=3, center = true);
		cylinder(r=spool_dia*.5, h=11);
	}
	cylinder(r=axis_dia*.5,h=40,center = true);
}
