module otverstie(y) {
    translate ([5,y,1,])
        cube([3,5,5], center=true);
    translate ([5,y-2.5,-1])
        cylinder(r=1.5,h=5,$fn=50);
    translate ([5,y+2.5,-1])
        cylinder(r=1.5,h=5,$fn=50);
}
difference (){
    cube([10,34,3]);
    otverstie(8);
    otverstie(26);
    otverstie(17);
}