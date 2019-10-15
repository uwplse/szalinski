union () {
	difference () {
		union(){
			cylinder(r=33, h=75, center=true, $fn=390); 
		}
		difference() {
			union() {
				translate([0,0,10])  cylinder(r=60/2, h=75, center=true, $fn=390); 
				translate([0,0,-50])  cylinder(r=55/2, h=75, center=true, $fn=390); 
			}        
		}
	}
}
