
$fn=80;

difference() {
union(){
// three sphere which are snow man's body and head
translate([0,0,25]){
difference(){
color("snow"){
	sphere(r=25,center=true);
translate([0,0,32])
	sphere(r=18.7,center=true);
translate([0,0,55])
	sphere(r=13, center=true);
			}
translate([0,0,66.5])
	cylinder(r=10,h=5,center=true);
}
// snow man's eye, i rotate that, let it be printable
color("black"){
	translate([-10.2,-5.5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
	translate([-10.2,5,60.5])
		rotate([0,50,0])
			cube([2.5,2.5,2.5],center=true);
			 }
// snow man's mouth, i rotate them, let them be printable
color("black"){
	translate([-12,-3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,-1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,0,51.6])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,1.5,52])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,2,52.4])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3,52.8])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);
	translate([-12,3.4,53.3])
		rotate([0,50,0])
			cube([1.5,1.5,1.5],center=true);

// snow man's arm
	translate([0, 26, 46])
		rotate([50,0,180])
			cylinder(r=2.15,h=35,center=true);
	translate([0, -26, 46])
		rotate([-50,0,-180])
			cylinder(r=2.15,h=35,center=true);
			}

}
// the bottom of snow man, let the sphere be printable
color("deepskyblue"){
	translate([0,0,5])
		cylinder(r=25,h=10,center=true);
					}
// snow man's nose
color("orangered"){
	translate([-18,50,4.5])	
		cylinder(h=9,r1=1.7,r2=0,center=true);
// this is a cylinder which is flat, snow man's nose can be connected on that.
translate([-12.13,0,81.7])
	rotate([0,90,0])
		cylinder(r=1.7,h=1.7,center=true);
}
// snow man's hat.
color("black"){
	translate([3,-65,2])
		rotate([-90,90,-90])
			cube([2,30,30],center=ture);
translate([18,-50,10])
	cylinder(r=8,h=20,center=true);

			}
	}
}
