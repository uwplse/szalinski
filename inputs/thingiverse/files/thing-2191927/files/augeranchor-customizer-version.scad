// Created in 2017 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:2191927


diam = 20;
holediam = 3.2;
roddiam = 8;
straightlen = 19.0;
angledlen = 9.6;
thread_pitch = 6;
cap_extra = 2;
cap_diam = diam + cap_extra;
cap_angle = 35;
holetopdiam = 1;
slit_width = 0.5;
nonslit_height = 12;
height = straightlen + angledlen;
slit_height = height - nonslit_height;

phillips_width = 7;
phillips_thick = 2.5;
phillips_straightdepth = 3.5;

quantity=6;


////// copied from threads.scad, http://www.thingiverse.com/thing:1686322 ////

screw_resolution = 0.2;  // in mm


// Provides standard metric thread pitches.
function ThreadPitch(diameter) =
  (diameter <= 64) ?
    lookup(diameter, [
      [2, 0.4],
      [2.5, 0.45],
      [3, 0.5],
      [4, 0.7],
      [5, 0.8],
      [6, 1.0],
      [7, 1.0],
      [8, 1.25],
      [10, 1.5],
      [12, 1.75],
      [14, 2.0],
      [16, 2.0],
      [18, 2.5],
      [20, 2.5],
      [22, 2.5],
      [24, 3.0],
      [27, 3.0],
      [30, 3.5],
      [33, 3.5],
      [36, 4.0],
      [39, 4.0],
      [42, 4.5],
      [48, 5.0],
      [52, 5.0],
      [56, 5.5],
      [60, 5.5],
      [64, 6.0]
    ]) :
    diameter * 6.0 / 64;


// This generates a closed polyhedron from an array of arrays of points,
// with each inner array tracing out one loop outlining the polyhedron.
// pointarrays should contain an array of N arrays each of size P outlining a
// closed manifold.  The points must obey the right-hand rule.  For example,
// looking down, the P points in the inner arrays are counter-clockwise in a
// loop, while the N point arrays increase in height.  Points in each inner
// array do not need to be equal height, but they usually should not meet or
// cross the line segments from the adjacent points in the other arrays.
// (N>=2, P>=3)
// Core triangles:
//   [j][i], [j+1][i], [j+1][(i+1)%P]
//   [j][i], [j+1][(i+1)%P], [j][(i+1)%P]
//   Then triangles are formed in a loop with the middle point of the first
//   and last array.
module ClosePoints(pointarrays) {
  function recurse_avg(arr, n=0, p=[0,0,0]) = (n>=len(arr)) ? p :
    recurse_avg(arr, n+1, p+(arr[n]-p)/(n+1));

  N = len(pointarrays);
  P = len(pointarrays[0]);
  NP = N*P;
  lastarr = pointarrays[N-1];
  midbot = recurse_avg(pointarrays[0]);
  midtop = recurse_avg(pointarrays[N-1]);

  faces_bot = [
    for (i=[0:P-1])
      [0,i+1,1+(i+1)%len(pointarrays[0])]
  ];

  loop_offset = 1;
  bot_len = loop_offset + P;

  faces_loop = [
    for (j=[0:N-2], i=[0:P-1], t=[0:1])
      [loop_offset, loop_offset, loop_offset] + (t==0 ?
      [j*P+i, (j+1)*P+i, (j+1)*P+(i+1)%P] :
      [j*P+i, (j+1)*P+(i+1)%P, j*P+(i+1)%P])
  ];

  top_offset = loop_offset + NP - P;
  midtop_offset = top_offset + P;

  faces_top = [
    for (i=[0:P-1])
      [midtop_offset,top_offset+(i+1)%P,top_offset+i]
  ];

  points = [
    for (i=[-1:NP])
      (i<0) ? midbot :
      ((i==NP) ? midtop :
      pointarrays[floor(i/P)][i%P])
  ];
  faces = concat(faces_bot, faces_loop, faces_top);

  polyhedron(points=points, faces=faces);
}



// This creates a vertical rod at the origin with external threads.  It uses
// metric standards by default.
module ScrewThread(outer_diam, height, pitch=0, tooth_angle=30, tolerance=0.4, tip_height=0, tooth_height=0, tip_min_fract=0) {

  pitch = (pitch==0) ? ThreadPitch(outer_diam) : pitch;
  tooth_height = (tooth_height==0) ? pitch : tooth_height;
  tip_min_fract = (tip_min_fract<0) ? 0 :
    ((tip_min_fract>0.9999) ? 0.9999 : tip_min_fract);

  outer_diam_cor = outer_diam + 0.25*tolerance; // Plastic shrinkage correction
  inner_diam = outer_diam - tooth_height/tan(tooth_angle);
  or = (outer_diam_cor < screw_resolution) ?
    screw_resolution/2 : outer_diam_cor / 2;
  ir = (inner_diam < screw_resolution) ? screw_resolution/2 : inner_diam / 2;
  height = (height < screw_resolution) ? screw_resolution : height;

  steps_per_loop_try = ceil(2*3.14159265359*or / screw_resolution);
  steps_per_loop = (steps_per_loop_try < 4) ? 4 : steps_per_loop_try;
  hs_ext = 3;
  hsteps = ceil(3 * height / pitch) + 2*hs_ext;

  extent = or - ir;

  tip_start = height-tip_height;
  tip_height_sc = tip_height / (1-tip_min_fract);

  tip_height_ir = (tip_height_sc > tooth_height/2) ?
    tip_height_sc - tooth_height/2 : tip_height_sc;

  tip_height_w = (tip_height_sc > tooth_height) ? tooth_height : tip_height_sc;
  tip_wstart = height + tip_height_sc - tip_height - tip_height_w;


  function tooth_width(a, h, pitch, tooth_height, extent) =
    let(
      ang_full = h*360.0/pitch-a,
      ang_pn = atan2(sin(ang_full), cos(ang_full)),
      ang = ang_pn < 0 ? ang_pn+360 : ang_pn,
      frac = ang/360,
      tfrac_half = tooth_height / (2*pitch),
      tfrac_cut = 2*tfrac_half
    )
    (frac > tfrac_cut) ? 0 : (
      (frac <= tfrac_half) ?
        ((frac / tfrac_half) * extent) :
        ((1 - (frac - tfrac_half)/tfrac_half) * extent)
    );


  pointarrays = [
    for (hs=[0:hsteps])
      [
        for (s=[0:steps_per_loop-1])
          let(
            ang_full = s*360.0/steps_per_loop,
            ang_pn = atan2(sin(ang_full), cos(ang_full)),
            ang = ang_pn < 0 ? ang_pn+360 : ang_pn,

            h_fudge = pitch*0.001,

            h_mod =
              (hs%3 == 2) ?
                ((s == steps_per_loop-1) ? tooth_height - h_fudge : (
                 (s == steps_per_loop-2) ? tooth_height/2 : 0)) : (
              (hs%3 == 0) ?
                ((s == steps_per_loop-1) ? pitch-tooth_height/2 : (
                 (s == steps_per_loop-2) ? pitch-tooth_height + h_fudge : 0)) :
                ((s == steps_per_loop-1) ? pitch-tooth_height/2 + h_fudge : (
                 (s == steps_per_loop-2) ? tooth_height/2 : 0))
              ),

            h_level =
              (hs%3 == 2) ? tooth_height - h_fudge : (
              (hs%3 == 0) ? 0 : tooth_height/2),

            h_ub = floor((hs-hs_ext)/3) * pitch
              + h_level + ang*pitch/360.0 - h_mod,
            h_max = height - (hsteps-hs) * h_fudge,
            h_min = hs * h_fudge,
            h = (h_ub < h_min) ? h_min : ((h_ub > h_max) ? h_max : h_ub),

            ht = h - tip_start,
            hf_ir = ht/tip_height_ir,
            ht_w = h - tip_wstart,
            hf_w_t = ht_w/tip_height_w,
            hf_w = (hf_w_t < 0) ? 0 : ((hf_w_t > 1) ? 1 : hf_w_t),

            ext_tip = (h <= tip_wstart) ? extent : (1-hf_w) * extent,
            wnormal = tooth_width(ang, h, pitch, tooth_height, ext_tip),
            w = (h <= tip_wstart) ? wnormal :
              (1-hf_w) * wnormal +
              hf_w * (0.1*screw_resolution + (wnormal * wnormal * wnormal /
                (ext_tip*ext_tip+0.1*screw_resolution))),
            r = (ht <= 0) ? ir + w :
              ( (ht < tip_height_ir ? ((2/(1+(hf_ir*hf_ir))-1) * ir) : 0) + w)
          )
          [r*cos(ang), r*sin(ang), h]
      ]
  ];


  ClosePoints(pointarrays);
}


// This creates a vertical rod at the origin with external auger-style
// threads.
module AugerThread(outer_diam, inner_diam, height, pitch, tooth_angle=30, tolerance=0.4, tip_height=0, tip_min_fract=0) {
  tooth_height = tan(tooth_angle)*(outer_diam-inner_diam);
  ScrewThread(outer_diam, height, pitch, tooth_angle, tolerance, tip_height,
    tooth_height, tip_min_fract);
}


// This inserts a Phillips tip shaped hole into its children.
// The rotation vector is applied first, then the position translation,
// starting from a position upward from the z-axis at z=0.
module PhillipsTip(width=7, thickness=0, straightdepth=0, position=[0,0,0], rotation=[0,0,0]) {
  thickness = (thickness <= 0) ? width*2.5/7 : thickness;
  straightdepth = (straightdepth <= 0) ? width*3.5/7 : straightdepth;
  angledepth = (width-thickness)/2;
  height = straightdepth + angledepth;
  extra_height = 0.001 * height;

  difference() {
    children();
    translate(position)
      rotate(rotation)
      union() {
        hull() {
          translate([-width/2, -thickness/2, -extra_height/2])
            cube([width, thickness, straightdepth+extra_height]);
          translate([-thickness/2, -thickness/2, height-extra_height])
            cube([thickness, thickness, extra_height]);
        }
        hull() {
          translate([-thickness/2, -width/2, -extra_height/2])
            cube([thickness, width, straightdepth+extra_height]);
          translate([-thickness/2, -thickness/2, height-extra_height])
            cube([thickness, thickness, extra_height]);
        }
      }
  }
}

////// end copied from threads.scad ////


module AugerAndCap() {
  //angled_extra = angledlen / (roddiam/holetopdiam - 1);
  difference() {
    AugerThread(diam, roddiam, height,
      thread_pitch, tooth_angle=15, tip_height=angledlen);
  }
  cylinder(r1=cap_diam/2, r2=roddiam/2,
    h=(((cap_diam-roddiam)/2)*tan(cap_angle)));
}


module AugerAnchor() {
  PhillipsTip(phillips_width, phillips_thick, phillips_straightdepth)
    difference() {
      AugerAndCap();

      translate([0,0,-0.01])
        cylinder(r=holediam/2, h=straightlen+0.02, $fs=0.02, $fa=1);
      translate([0,0,straightlen-0.01])
        cylinder(r1=holediam/2, r2=holetopdiam/2,
          h=angledlen+0.02, $fs=0.02, $fa=1);
      translate([-diam, -slit_width/2, height - slit_height])
        cube([diam*2, slit_width, slit_height]);
    }
}


// This creates an array of the specified number of its children, arranging
// them for the best chance of fitting on a typical build plate.
module MakeSet(quantity=1, x_len=30, y_len=30) {
  bed_yoverx = 1.35;
  x_space = ((x_len * 0.2) > 15) ? (x_len * 0.2) : 15;
  y_space = ((y_len * 0.2) > 15) ? (y_len * 0.2) : 15;
  function MaxVal(x, y) = (x > y) ? x : y;
  function MaxDist(x, y) = MaxVal((x_len*x + x_space*(x-1))*bed_yoverx,
    y_len*y + y_space*(y-1));
  function MinExtentX(x) = ((x >= quantity) ||
    (MaxDist(x+1, ceil(quantity/(x+1))) > MaxDist(x, ceil(quantity/x)))) ?
    x : MinExtentX(x+1);
  colmax = MinExtentX(1);

  for (i=[1:quantity]) {
    translate([(x_len + x_space)*((i-1)%colmax),
      (y_len + y_space)*floor((i-1)/colmax), 0])
      children();
  }
}


MakeSet(quantity, diam, diam)
AugerAnchor();

