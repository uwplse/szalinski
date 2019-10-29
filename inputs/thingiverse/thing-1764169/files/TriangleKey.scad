//  original drwing by dybde - 6mm
// reworked by Paxy


/*Customizer Variables*/
triangleRadius=10;//[1:0.5:50]
outherRadius=11;//[1:0.5:50]
radiusLenght=10;//[1:0.5:50]
flatLength=15;//[1:1:80]
depth=10;//[1:1:80]

/* [Hidden] */
$fn=50;

difference() {
    union()
    {
    translate([0,0,-flatLength])  
        cylinder(r=outherRadius/2,h=flatLength);
	hull() {
		cylinder(r=outherRadius/2,h=radiusLenght);
		translate([0,0,radiusLenght+2.5]) cube([6,15,5],center=true);
		translate([0,-7.5,radiusLenght+2.5]) cylinder(r=3,h=radiusLenght/2,center=true);
		translate([0, 7.5,radiusLenght+2.5]) cylinder(r=3,h=radiusLenght/2,center=true);

	}
    }
		translate([0,0,-0.1-flatLength]) cylinder(r=triangleRadius/2,h=depth,$fn=3);
}

difference() {
	hull() {
		translate([0,0,radiusLenght+3.5]) cube([6,15,15],center=true);
		translate([0,12,radiusLenght+12.5]) cylinder(r=3,h=5,center=true);
		translate([0,12,radiusLenght+6]) sphere(r=3,center=true);
		translate([0,12,radiusLenght+15]) sphere(r=3,center=true);



		translate([0,-12,radiusLenght+12.5]) cylinder(r=3,h=5,center=true);
		translate([0,-12,radiusLenght+6]) sphere(r=3,center=true);
		translate([0,-12,radiusLenght+15]) sphere(r=3,center=true);


		translate([0,-7.5,radiusLenght+2.5]) cylinder(r=3,h=5,center=true);
		translate([0, 7.5,radiusLenght+12.5]) cylinder(r=3,h=5,center=true);
	}
	translate([-5,10,22]) rotate([0,90,0]) cylinder(r=1.5,h=10);

}
