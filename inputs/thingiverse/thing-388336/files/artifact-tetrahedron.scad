
// 2014 Lukas Süss aka mechadense
// public domain
// OpenSCAD: infinite volumes desired


/*
The lack of (semi)-infinite volumes (like halfspaces) introduce a lot of unnecessary variables. If they are not kept big enough in all conceivable cases
(there are too many cases to conceive in any sufficiently complex model)
bugs can be expected to slowly and continulally drizzle in from the run time user side. Furthermore the unnecessary surfaces potentially waste computing power.

I invite you to play with this demo-"artifact-tetrahedron" in customizer to get the picture.

Semi-infinite volumes are implemented in my miniSageCAD experiment:
http://www.thingiverse.com/thing:40210

sidenote: there are some similarities to lazy evaluation
*/


// ##################

/* [the parameter] */

size = 7;

/* [non-infinite bug-parameters] */

r0=20;
rzyl=14;
hzyl=16;

/* [Resolution] */

$fa = 5;
$fs = 0.2;

// ##################

difference()
{
  sphere (r=r0);

  translate([0,0,0])
  {
    rotate(  0,[0,0,1]) cutter();
    rotate(180,[0,0,1]) cutter();
    scale([1,1,-1]) rotate(  90,[0,0,1]) cutter();
    scale([1,1,-1])rotate(270,[0,0,1]) cutter();
  }
}

module cutter()
{
  rotate(45,[0,0,1])
  rotate(-atan(1/sqrt(2)),[0,1,0])
  translate([size,0,0])
  rotate(90,[0,1,0])
    cylinder(r=rzyl,h=hzyl);
}