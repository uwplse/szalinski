$fn=32;



module template(){
	import("camera_microscope_adapter_2_holes_repaired.stl");
} //template();

module adapter(){
difference(){
	union(){
		translate([0,0,2]) cylinder(h=10, d=34, center=true);
		translate([0,0,7]) cylinder(h=3,r1=17,r2=21.5,center=false);
		translate([0,0,10]) cylinder(h=20,r=25,center=false, $fn=6);
	}
	translate([0,0,3]) cylinder(h=15, d=30, center=true);
	translate([0,0,10]) cylinder(h=21,r=20,center=false, $fn=6);
	for(i=[0:60:360]){
	rotate([0,0,i]) M3();
}
}
} adapter();

module M3(){
	rotate([0,0,30])
	translate([16.5,00,20])
	rotate([0,90,0])
	union() {
		translate([0,0,4]) cylinder(h=10, d=3.5, center=false);
		cylinder(h=4, d=8, center=false,$fn=6);
	}
} //M3();



