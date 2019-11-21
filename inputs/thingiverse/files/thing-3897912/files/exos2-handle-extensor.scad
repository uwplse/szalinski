fn = 100;
d = 6;
h = 12.5;

difference(){
    //Base
    cylinder(d= d, h = h, $fn = fn);
    //Screw part
    translate([d/2,0,h/2])
    cube(size = [d/3,d,h+1], center = true);
}
    cylinder(d= d*2, h = 2, $fn = fn);
