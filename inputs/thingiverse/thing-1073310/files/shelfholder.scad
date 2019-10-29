// This makes a simple shelf holder made up of a spoke that fits into a drill hole and a tab that holds up a shelf.

//radius of spoke in mm
rad=3.05;
//height of spoke in mm
hs=12;
//radius of tab
rt=10;
// height of tab in mm
ht=30;
$fn=50;

union(){
    translate([-rad,0,0])cylinder(r=rad,h=hs+ht);
    difference(){
    cylinder(r=rt, h=ht);
    translate([0,-rt,-1])cube([2*rt+2,2*rt+2,hs+ht]);
}
}
