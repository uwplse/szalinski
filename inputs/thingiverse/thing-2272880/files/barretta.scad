barretta();

module barretta(){
difference(){
 cube([10,60,2.5],center=true);
    translate([-1,0,0])
    cylinder(h=30,r=3.5/2,$fn=50,center=true);
    translate([-1,20,0])
    cylinder(h=30,r=3.5/2,$fn=50,center=true);
      translate([-1,-20,0])
    cylinder(h=30,r=3.5/2,$fn=50,center=true);
}
}