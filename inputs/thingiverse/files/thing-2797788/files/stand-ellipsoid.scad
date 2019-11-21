difference() {
cylinder(10,15,15,true,$fn=200);
translate([0,0,35]) 
    scale([1.0,1.0,1.75]) sphere(r=20, $fn=400); 
}