/* [Screw] */

diamScrew=3; // [1:14]
diamScrewHead=6; // [2:20]
heightScrew=20; // [5:100]
heightScrewHead=1.5; // [1:20]
screwHead = 30; // [4:60]

color("yellow")
  translate([0,0,heightScrew/2]) 
  cylinder( r1=diamScrew/2, r2=diamScrewHead/2, heightScrewHead, $fn=screwHead, center=true);
       color("yellow") cylinder(r=diamScrew/2, heightScrew, $fn=30, center=true);