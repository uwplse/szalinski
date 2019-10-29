difference() {
cylinder(10,15,15,true,$fn=50);
translate([0,0,35]) 
    scale([1.0,1.0,1.75]) sphere(r=20, $fn=50); 
}