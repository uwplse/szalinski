//------------------------------------------------------------------
/*

Adapters for connecting a tool to a dust collector.

The adapter fits around the outside diameter of the pipes on the
tool and the vaccuum. Measure the diameter of the pipes with a set
of calipers. Enter the values and the script will take care of
the rest.

*/
//------------------------------------------------------------------
// Parameters:

// outside diameter of pipe 1 (mm)
od_pipe_1 = 57.4;
// adapter length for pipe 1 (mm)
len_pipe_1 = 40;
// outside diameter of pipe 1 (mm)
od_pipe_2 = 42.1;
// adapter length for pipe 2 (mm)
len_pipe_2 = 30;
// transition length (mm)
transition_length = 20;
// wall thickness (mm)
wall_thickness = 4;
// The adapter ID will be larger than the pipe OD by this factor
clearance = 1.017;
// internal taper (degrees)
taper = 1;

//------------------------------------------------------------------
// Set the scaling value to compensate for print shrinkage

scale = 1/0.995; // ABS ~0.5% shrinkage
//scale = 1/0.998; // PLA ~0.2% shrinkage

function dim(x) = scale * x;

//------------------------------------------------------------------
// derived values

r1 = dim(od_pipe_1) / 2;
r2 = dim(od_pipe_2) / 2;

len1 = dim(len_pipe_1);
len2 = dim(len_pipe_2);

tlen = dim(transition_length);

wt = dim(wall_thickness);

//------------------------------------------------------------------
// control the number of facets on cylinders

facet_epsilon = 0.01;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

//------------------------------------------------------------------
// generate a 2D polygon for the adapter wall

module adapter_wall() {

  ir1 = r1 * clearance;
  ir2 = r2 * clearance;
  or1 = ir1 + wt;
  or2 = ir2 + wt;
  t1 = len1 * tan(taper);
  t2 = len2 * tan(taper);

  echo("nominal od1 is ", or1 * 2, "mm");
  echo("nominal od2 is ", or2 * 2, "mm");

  points = [
    [ir1, 0],
    [or1, 0],
    [or1, len1],
    [or2, len1 + tlen],
    [or2, len1 + tlen + len2],
    [ir2, len1 + tlen + len2],
    [ir2 - t2, len1 + tlen],
    [ir1 - t1, len1],
  ];
  polygon(points=points, convexity = 2);
}

//------------------------------------------------------------------

module adapter() {
  overhang_angle = atan2(abs(r2 - r1), transition_length);
  echo("overhang angle is ", overhang_angle, "degrees");
  rotate_extrude(angle = 360, $fn = facets(r1)) {
    adapter_wall();
  }
}

adapter();

//------------------------------------------------------------------


