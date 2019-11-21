$fn=128;
overlap = 0.1;

module solid(){
union() {
cylinder(h=5.74, d=50.6);
}
}

module remove(){

translate([0,0,3]) linear_extrude(height = 10, convexity = 10) circle(r=13.15/2, $fn=6);


}

difference(){
    solid();
    remove();
}

