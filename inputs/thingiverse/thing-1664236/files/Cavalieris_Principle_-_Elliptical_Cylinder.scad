scale([3,1,1])
difference(){
cylinder(h=30,r=10+2,$fn=300);
    translate([0,0,2])
    cylinder(h=28.5,r=10,$fn=300);
}