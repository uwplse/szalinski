// ctc_spool_bush.scad

echo(version=version());

spool_dia = 58;

	hollow_cyl(spool_dia-1, 22, 37.5);
	hollow_cyl(80, 22, 5);


module hollow_cyl(od, id, len) {
	difference(){
		cylinder(h = len, r=od/2, center = false);
 		cylinder(h = len, r=id/2, center = false);
	}
}

