// All measurements in MM
// Inner diameter
ind =8.2;

// Outer diameter bottom
od1=10;

// Outer diameter top 
od2=10;

// Cylinder hight 
ch=32;

translate([0, 0, 0]) {
    difference() {
		translate([0, 0, 0]) cylinder(h = ch, r1 =od1/2,r2=od2/2,$fn=50);  //cylinder
		translate([0, 0, 0]) cylinder(h = ch, r= ind/2, $fn=50);               
    }
}

