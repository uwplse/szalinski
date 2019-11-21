scale(.45){
	intersection(){
		scale([.1, .1, 0.02]) surface(file = "pluto.png", center = true, invert = false);
		cylinder(r=28, h=10);
	}
}

translate([0,0,-1]) cylinder(d=25.4, h=1, $fn=50 );