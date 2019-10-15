Length=130;
Width=70;

difference(){cube([Length+6,Width+4,10]);
translate([1,2,2])cube([Length,Width,10]);
translate([Length,Width/3.4,2])cube([50,Width/2.4,10]);}


translate([Length-130,Width-69,0])
union(){difference(){translate([50,72,0])cube([30,12,10]);
translate([55,72,-17.5])cube([20,10,20]);
translate([60,72,-15])cube([10,10,30]);}}

translate([Length-130,5,0])
union(){difference(){translate([50,-17,0])cube([30,12,10]);
translate([55,-15,-17.5])cube([20,10,20]);
translate([60,-15,-15])cube([10,10,30]);}}

translate([0,(Width/2)-35,0])
union(){difference(){translate([-12,15,0])cube([12,40,10]);
translate([-10,25,-17.5])cube([10,20,20]);
translate([-10,30,-15])cube([10,10,30]);
translate([-5,21.5,-6])cylinder(r=3,h=15);
translate([-5,48.5,-6])cylinder(r=3,h=15);
}}


