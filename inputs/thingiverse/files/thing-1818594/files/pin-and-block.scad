// parametrized pin and block connectors
// v0.0.1 2016oct10, ls  initial version
// v0.0.2 2016oct10, ls  changing slot against wedge should increase stability
// v0.0.3 2016oct11, ls  wall parameter refers to real wall strength now. Neglected to 
//                       consider slack in earlier versions.
// v0.0.4 2016oct11, ls  made object height a seperate configuration item. Changed demo placement.

// ------ demonstration and test ------
//  remove for library inclusion

// of tongues plus bulge, but without optional "handle"
length = 20;						// [10:100]
// measured at tongues without bulge
width = 10;						// [4:24]
// or "thickness"
height = 6;						// [2:0.1:20]
// increases sizes of block where pin parts fit in
slack = 0.7;						// [0.2:0.1:2]
// size of block walls at flat sides of pin. also, remaining size at seat of bulge
wall = 1;						// [0.2:0.1:8]
// determines how much bulge protrudes over width
bulge = 0.8;						// [0.2:0.1:4]
// changes slot width and recess to modulate forces for connecting and holding
tension = 3.2;    					// [3:0.1:4]

spacing = 0+5;						// for item positioning 
over  = wall+slack+bulge;
outer = over+width+over;

translate([0, height+wall+slack+spacing, 0])  {
   cube([outer, height, height]);			// optional "handle"
   translate([over, height, 0])
   pin  (length, width, height, bulge, tension);
}

block(length, width, height, bulge, wall, slack);

// ------------------------------------

little = 0+0.01;					// improve preview quality

module wedge(length, width, height)  {
   linear_extrude(height)  {
      hull()  {
         circle(0.5, $fn=50);
         for (i=[-2,2])
         translate([width/i, length])
         circle(little);
      }
   }
}

module pin_and_block(len, width, height, bulge, slack)  {
   radius = min(width/2+bulge+slack, length/2);
   echo(radius);
   linear_extrude(height+2*slack) {  
      union()  {
         square([width+slack*2, len-radius]);
         translate([width/2+slack, len-radius])
         circle(radius, $fn=100);
      }
   }
}

module pin(len, width, height, bulge, tension) {
   radius = width/2+bulge;
   difference()  {
      pin_and_block(len, width, height, bulge, 0);
      translate([width/2, len-tension*radius, -little/2])
      wedge(tension*radius, tension*bulge, height+little);
   }
}


module block(len, width, height, bulge, wall, slack) {
   w = wall+slack;
   l = len+w;
   translate([0, 0, l])
   rotate([270, 0, 0])
   difference()  {
      cube([width+2*(bulge+w), l, height+2*w]);
      translate([bulge+wall-little/2, -little/2, wall-little/2])
      pin_and_block(len, width+little, height, bulge, slack);
   }
}
