scale([3,1,1])
difference(){
cylinder(h=30,r1=15,r2=0,$fn=300);
    cylinder(h=27,r1=13,r2=0,$fn=300);
}
translate([0,0,29])
sphere(2,$fn=300);