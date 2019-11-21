/*translate([0,56,-5])cylinder(d1=109, d2 = 121, h = 80, $fn = 90);
hull(){
translate([0,2,12.5])cube([25,30,25],center = true);
translate([0,50,12.5])cube([108,1,25],center = true);
}
translate([0,-6,15])cube([15.5,10,33],center = true);


difference(){
union(){
hull(){
translate([0,0,2])cube([21,17,4],center = true);
translate([0,16,0])cylinder(d=9, h = 4, $fn = 90);}
translate([0,0,12.5])cube([21,17,25],center = true);
}
translate([0,0,17.5])cube([15.5,10.5,25],center = true);
translate([0,16,-15])cylinder(d=4.5, h = 33, $fn = 90);}
*/
color("red")difference(){
cylinder(d=98, h = 2.5, $fn = 290);
 for (i = [1:5]){
rotate([0,0,30*i+90])translate([0,40,-5])
cylinder(h =37, d =5.1, $fn =50,centr = true);}

translate([0,-18,-6])cylinder(h =37, d =6, $fn =50,centr = true);
translate([0,50,1])cube([100,100,6],center = true);
}
color("red")hull(){
translate([49-5.1/2,-1,2.5])rotate([0,80,90])cylinder(h =2.5, d =5.1, $fn =50,centr = true);
 translate([-(49-5.1/2),-1,2.5])rotate([0,80,90])cylinder(h =2.5, d =5.1, $fn =50,centr = true);   
translate([49-5.1/2,-5,25])rotate([0,80,90])cylinder(h =2.5, d =5.1, $fn =50,centr = true);
translate([-(49-5.1/2),-5,25])rotate([0,80,90])cylinder(h =2.5, d =5.1, $fn =50,centr = true);
}