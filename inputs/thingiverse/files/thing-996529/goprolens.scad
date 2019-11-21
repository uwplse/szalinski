lensDepth = 2;
goProDepth = 5;
lensWidth = 51.5;
goProWidth = 23;
margin = 2;

difference(){
	cylinder(lensDepth+goProDepth, r=lensWidth/2+margin, $fn=100);
	translate([0,0,goProDepth]) cylinder(h=200, r=lensWidth/2, $fn=100);
	translate([0,0,-1]) cylinder(h=200, r=goProWidth/2, $fn=100);

}
