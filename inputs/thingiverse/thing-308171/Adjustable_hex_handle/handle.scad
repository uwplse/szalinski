/* [Global] */

thickness = 15;
armLength = 50;
armWidth = 15;
headDia = 30;
numArms = 2; // [1:8]
holeDia=3;
hexBoltSize=15;
hexHoleDepth = 8;

translate([0,0,thickness])
	rotate([180,0,0])
		difference(){
			union(){
				head();
				arm();
			}
			holes();
		}

module arm() {
	for (i=[0:numArms-1]){
		rotate([0,0,i*360/numArms]){
			translate([0,-armWidth/2,0])
				cube([armLength-armWidth/2,armWidth,thickness]);
			translate([armLength-armWidth/2,0,0])
				cylinder($fn = 30,r=armWidth/2,h=thickness);
		}
	}
}

module head() {
		cylinder(r=headDia/2, h=thickness);
}

module holes () {
	union(){
		translate([0,0,-hexHoleDepth])
			cylinder($fn = 6,r =hexBoltSize*0.5773502, h = hexHoleDepth*2);
		cylinder($fn = 30, r=holeDia/2,h=thickness*2);
	}
}
