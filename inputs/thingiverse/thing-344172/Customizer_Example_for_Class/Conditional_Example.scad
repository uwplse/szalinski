/* [Global] */
object=2; //[0:cube,1:cylinder,2:both]

/* [Dimensions] */
height=20; //[1:100]
width=20; //[1:100]

module drwCb() {
		translate([width*1.5, 0, 0]) cube([width, width, height], center=true);
}

module drwCyl () {
	translate([width*-1.5, 0, 0]) cylinder(r=width/2, h=height, center=true);
}

if (object==0) {
	drwCb();
} 

if (object==1) {
	drwCyl();
}

if (object==2) {
	drwCyl();
	drwCb();
}