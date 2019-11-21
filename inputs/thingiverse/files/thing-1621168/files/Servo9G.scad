$fn = 50;

servo9g();

module servo9g(){
    x1 = 23;
    y1=12.6;
    z1=22.9;
    x2 = 32.5;
    cube([x1,y1,z1]);
    translate([(x1-x2)/2,0,16.6]) cube([x2,12.6,2.5]);
    translate([x1/2,y1/2,z1]) cylinder(d=5,h=4.5);
    translate([x1/4+0.5,y1/2,z1]) cylinder(d=y1,h=4.5);
}