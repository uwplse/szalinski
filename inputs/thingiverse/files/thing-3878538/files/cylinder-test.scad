// All measurements in MM
// Inner diameter
ind =0;

// Outer diameter bottom
od1=25;

// Outer diameter top 
od2=25;

// Cylinder hight 
ch=35;

// Facets (increase number for smoother outside)
fct=256;

translate([0, 0, 0]) {
    difference() {
		translate([0, 0, 0]) cylinder(h = ch, r1 =od1/2,r2=od2/2,$fn=fct);  //cylinder
		translate([0, 0, 0]) cylinder(h = ch, r= ind/2, $fn=fct);               
    }
}


