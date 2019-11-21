$fn = 100;
// The height of the Acrylic used for the keyguard
acrylicHeight = 3;

roundedRect([230, 25.4, 1], 5, $fn=12);
roundedRect([230, 12, acrylicHeight-1], 5, $fn=12);

translate([0,-13.4,acrylicHeight-1]){
	difference(){
    difference(){
        roundedRect([230, 25.4, 2], 5, $fn=12);
        translate ([10,7,-1]){
            cylinder(h=2,r=5);
        }
        translate ([25,7,-1]){
            cylinder(h=2,r=5);
        }

	   translate ([200,7,-1]){
            cylinder(h=2,r=5);
        }
        translate ([215,7,-1]){
            cylinder(h=2,r=5);
        }
    }
	translate([33,0,0]) cube([160, 10, 3]);
}

}




module roundedRect(size, radius) {
x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
hull() {
translate([radius, radius, 0])
circle(r=radius);

translate([x - radius, radius, 0])
circle(r=radius);

translate([x - radius, y - radius, 0])
circle(r=radius);

translate([radius, y - radius, 0])
circle(r=radius);
}
}