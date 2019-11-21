/*translate([0,56,-5])cylinder(d1=109, d2 = 121, h = 80, $fn = 90);
hull(){
translate([0,2,12.5])cube([25,30,25],center = true);
translate([0,50,12.5])cube([108,1,25],center = true);
}
translate([0,-6,15])cube([15.5,10,33],center = true);
*/

color("red")difference(){
union(){
hull(){
translate([0,0,2])cube([21,17,4],center = true);
translate([0,16,0])cylinder(d=9, h = 4, $fn = 90);}
translate([0,0,12.5])cube([21,17,25],center = true);
}
translate([0,0,17.5])cube([15.5,10.5,25],center = true);
translate([0,16,-15])cylinder(d=4.5, h = 33, $fn = 90);}