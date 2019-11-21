// cupcake wrapper planter-pot
// 2018-08-16 Lucina
// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
// preview[view:south east, tilt:top diagonal]
/* [cupcake wrapper settings] */
// scaler to resize keeping the same proportions
scaler = 1.0 ;   //[.25:.25:4]
// wall thickness (mm)
wall = .9; // [.6:.1:10]
// cut out drain hole
drainHole = "yes";   // [yes, no]
// which model to render: planter, saucer or both
selection = "planter";   // [planter, saucer]

/* [hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
// planter width (mm)
planterWidth = 70*scaler;
// planter height (mm)
planterHeight = 35*scaler;
// base width as percentage of top width
baseWidthPercent = 71;
// saucer height
sauHeight = 12*scaler;
// drain hole (mm)
hole = 8*scaler;
// number of sides
numberOfSides = 32;
allow = 4;
baseWidth = (baseWidthPercent/100)*planterWidth;
inner = .9;
layer = .1;
nLayers = round(planterHeight/layer);
zStep = layer;
xStep = (planterWidth-baseWidth)/nLayers;
innerbaseWidth = baseWidth-2*wall;
sauLayers = sauHeight/layer;

module rstar(xx, zz) {
   linear_extrude(height=zz, convexity=10, twist=0)
      Star(numberOfSides, xx*.5, inner*xx*.5);
}

module planter() {
   difference() {
      for ( i = [0:nLayers] ) {
         translate([0, 0, i*zStep])
         rstar(baseWidth+i*xStep, layer);
      }
      for ( i = [0:nLayers] ) {
         translate([0, 0, i*zStep+wall])
         rstar(innerbaseWidth+i*xStep, layer);
      }
   }
}
module saucer() {
   difference() {
      for ( i = [0:sauLayers] ) {
         translate([0, 0, i*zStep])
         rstar(baseWidth+allow+i*xStep, layer);
      }
      for ( i = [0:sauLayers] ) {
         translate([0, 0, i*zStep+wall])
         rstar(innerbaseWidth+allow+i*xStep, layer);
      }
   }
}
module Star(points, outer, inner) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

			x_outer = x(outer, increment * p);
         y_outer = y(outer, increment * p);
         x_inner = x(inner, (increment * p) + (increment/2));
         y_inner = y(inner, (increment * p) + (increment/2));
         x_next  = x(outer, increment * (p+1));
         y_next  = y(outer, increment * (p+1));
				polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}
   }
}
if ( selection == "saucer" ) {
   saucer();
}
if ( selection == "planter" ) {
   difference() {
      planter();
      if ( drainHole == "yes" ) {
         translate([0, 0, -wall])
            cylinder(h=2*wall, d=hole);
      }
   }
}