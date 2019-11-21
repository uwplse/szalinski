$fn = 50;

/* Ceiling Loop Spindle (Allow for adjusting height of light hanging models) */

/* [Enable/Disable Loops] */
loop_pos = "c"; // [c:center,l:left,r:right, a:all, s:side only]

/* [Mounting Strip Base]  */
/* Command Strip dimentions is typically 50mmx15mm */
sx = 50 ; // length of mounting strip base
sy = 15 ; // widith of mounting strip base
sh = 2  ; // height of mounting strip base

/* [Loop Sizing] */
lt = 2; // loop thickness
lh = 5; // loop holesize

/* Hook function and module */
function loop_width(thickness, holesize) = holesize+thickness*2;

module handle(x, z, thickness, holesize)
{
    /* Hook centre */
    difference()
    {
        outerdia = (holesize+thickness*2);
        translate([0, 0  , 0])
            rotate([-90,,0])
            cylinder(r=holesize/2, h=sy*3);
        translate([-outerdia/2  , -1/2  , -outerdia/2])
            cube([outerdia,sy*3+1,outerdia/2]);
    }
}

module spindle(x, z, thickness, holesize)
{
    /* Hook centre */
    translate([0, sy  , 0])
    difference()
    {
        rotate([-90,,])
        union()
        {
            cylinder(r1=holesize, r2=holesize/2, h=sy);
            cylinder(r1=holesize/2, r2=holesize, h=sy);
        }
        translate([-holesize*2/2  , -1/2  , -holesize*2/2])
            cube([holesize*2, sy*1+1, holesize*2/2]);
    }
}

difference()
{
  union() {
      handle(sx/2, sh, lt, lh-2);
      spindle(sx/2, sh, lt, lh);
  }
  translate([0, sy*1.5  , 0])cylinder(r=1, h=10);

}