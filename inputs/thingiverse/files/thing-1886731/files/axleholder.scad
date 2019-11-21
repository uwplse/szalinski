wall = 1.2;         // [0.5:0.1:3]
wire = 3.6;         // [2:0.1:5]
recess = 8;         // [2:16]
axle = 6.5;         // [2:0.1:48]
extent = 16;        // [5:64]

cap = recess+wall;
len = extent+wall+cap+axle*1.5;
block = wire+2*wall;
outer = axle+2*wall;
outer_r = outer/2;

little = 0+0.01;
spacing = 0+10;

axleholder();
translate([0, outer+spacing, 0])
axleholder();

module axleholder()  {
   difference()  {
      linear_extrude(block) {
         square([cap, block]);
         square([len-outer/2, wall]);
         translate([len-outer/2, outer/2])
         hanger();
         translate([len-(axle+wall), 0])  {
            translate([0, wall])
            circle(r=wall, $fn=100);

            translate([0, axle+wall])  {
               square([axle/2, wall]);
               circle(r=wall, $fn=100);
            }
         }
      }
      translate([wall+little/2, block/2, block/2])
      rotate([0, 90, 0])
      cylinder(h=recess+little, d=wire, $fn=100);
   }

   module hanger()  {
      difference()  {
         circle(d=outer, $fn=100);
         circle(d=axle, $fn=100);
         translate([-outer/2, -outer/2])
         square([outer/2, outer]);
      }
   }
}
