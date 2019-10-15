$fn=25;
difference() {
    cube(10,true);
    translate([0,5,0]) sphere(.75,true);
    //translate([0,-2,5]) sphere(.75,true);
    translate([0,2,5]) sphere(.75,true);
    translate([5,0,0]) sphere(.75,true);
    translate([5,3,3]) sphere(.75,true);
    translate([5,-3,-3]) sphere(.75,true);
    translate([2,-5,2]) sphere(.75,true);
    translate([2,-5,-2]) sphere(.75,true);
    translate([-2,-5,2]) sphere(.75,true);
    translate([-2,-5,-2]) sphere(.75,true);
    translate([0,-5,0]) sphere(.75,true);
    translate([2,-2,-5]) sphere(.75,true);
    translate([2,2,-5]) sphere(.75,true);
    translate([-2,-2,-5]) sphere(.75,true);
    translate([-2,2,-5]) sphere(.75,true);
    translate([-5,2,2]) sphere(.75,true);
    translate([-5,2,0]) sphere(.75,true);
    translate([-5,2,-2]) sphere(.75,true);
    translate([-5,-2,2]) sphere(.75,true);
    translate([-5,-2,0]) sphere(.75,true);
    translate([-5,-2,-2]) sphere(.75,true);
}
