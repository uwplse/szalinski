// low profile nut cover
// Hussein Suleman
// 22 April 2019

// nut height 
height = 3;

// nut diameter 
diameter = 7.66;

// curvature (higher numbers generate flatter covers)
curve = 2;

rheight = height + 0.5;
rdiameter = diameter + 0.5;
hypo = sqrt (pow (rheight+curve,2) + pow (rdiameter/2, 2));

$fn = 50 * 1;

difference () {
   translate ([0,0,-curve]) sphere (r=hypo + 0.5);
   translate ([0,0,-1]) cylinder ($fn=6, d=rdiameter, h=rheight+1);
   translate ([0,0,0]) cylinder (d=diameter-2, h=rheight+0.5);
   translate ([0,0,-(2*(hypo+1))]) cylinder (h=2*(hypo+1), r=hypo+1);
}
