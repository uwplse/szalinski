// Copyright 2019 Pascal de Bruijn
// Licensed Creative Commons - Attribution - Share Alike

/* [Building] */

// Base size of the building (peek-to-peek hex in millimeters)
hex_size = 37;

// Approximate building storey height (in millimeters)
storey_height = 9.8;

/* [Windows] */

// How high your windows should be (in millimeters)
window_height = 3;

// How wide your windows should be (in millimeters)
window_width = 5;

// How far the window cavity should protrude into the building (in millimeters)
window_depth = 2;

// How thick the window frame is (in millimeters) (needs to be twice your nozzle size to print vertically)
window_frame_width = 1.2;

// How deep the window frame is (in millimeters)
window_frame_depth = 0.5;

/* [Doors] */

// How high your door should be (in millimeters)
door_height = 7;

// How wide your doors should be (in millimeters)
door_width = 5;

// How far the door cavity should protrude into the building (in millimeters)
door_depth = 2;

// How thick the door frame is (in millimeters) (needs to be twice your nozzle size to print vertically)
door_frame_width = 1.2;

// How deep the door frame is (in millimeters)
door_frame_depth = 0.5;

/* [Base] */

// How high the base should be (in millimeters)
base_height = 4.2;

// How much clearance the base should have around the building (in millimeters)
base_top_clearance = 1.5;

// How much much larger the bottom of the base should be than the bottom (in millimeters)
base_bottom_clearance = 2;

// Should the base be hollowed out (in millimeters)
base_cavity_depth = -1;

// How thick in the base edge should be (in millimeters)
base_cavity_clearance = 3;

/* [Model] */

// Overall model scale (as percentage)
model_scale = 100;

// Size of the die that should fit in the die cavity (in millimeters)
die_size = 12;

// Rounding of the die cavity (in millimeters)
die_round_radius = 2;

// Do you want to model to be hollow
hollow = 0; // [0:Solid,1:Hollow]



/* [Hidden] */

door_div = 3;

ring_height = 1.2;
ring_shrink = 0.77;
hex_size_scaled = hex_size - (base_top_clearance * 2) - (base_bottom_clearance * 2);



scale(v=[model_scale / 100, model_scale / 100, model_scale / 100])
{
  difference()
  {
    union()
    {
    
      // base
      translate([0, 0, 0 - base_height])
        cylinder(base_height, (hex_size_scaled / 2) + base_top_clearance + base_bottom_clearance, (hex_size_scaled / 2) + base_top_clearance, $fn = 6);

      // main building
      cylinder(storey_height, (hex_size_scaled / 2), (hex_size_scaled / 2), $fn = 6);

      // upper building
      translate([0, 0, storey_height])
        cylinder(storey_height, (hex_size_scaled / 2), (hex_size_scaled / 2) / 3, $fn = 6);

      // ring support
      translate([0, 0, storey_height * 1.38 - ring_height])
        cylinder(ring_height, (hex_size_scaled / 2) * ring_shrink - (ring_height * 1.5), (hex_size_scaled / 2) * ring_shrink, $fn = 180);

      // ring
      translate([0, 0, storey_height * 1.38])
        cylinder(ring_height, (hex_size_scaled / 2) * ring_shrink, (hex_size_scaled / 2) * ring_shrink, $fn = 180);    
      
      // dome  
      translate([0, 0, storey_height * 1.38 + ring_height + (hex_size_scaled * 0.3)])
        rotate(180 + 54)
          geodesic_sphere(r = (hex_size_scaled - 2 ) / 2, $fn = 11);

      // door frames
      for (a = [1:6])
        rotate(a * 60)
          if ((a % door_div) == 0)
            translate([-(door_width / 2) - door_frame_width, (hex_size_scaled * (cos(30)/2)) - door_depth + door_frame_depth, 0])
              cube([door_width + (door_frame_width * 2), door_depth, door_height + door_frame_width]);
          else
            translate([-(door_width / 2) - window_frame_width, (hex_size_scaled * (cos(30)/2)) - window_depth + window_frame_depth, door_height - window_height - window_frame_width])
              cube([window_width + (window_frame_width * 2), window_depth, window_height + window_frame_width * 2]);

    }

    union()
    {
      // base cavity
      translate([0, 0, 0 - base_height - (base_height - base_cavity_depth)])
        cylinder(base_height, (hex_size_scaled / 2) + base_top_clearance + base_bottom_clearance - base_cavity_clearance, (hex_size_scaled / 2) + base_top_clearance - base_cavity_clearance, $fn = 6); 

      // hollow
      if (hollow)
        translate([0, 0, 0])
          minkowski ()
          {
            cylinder(storey_height * 5.5 - (hex_size / 2) - 13, 1, 1, $fn = 48);
            sphere(r = (hex_size / 2) - 13);
          }

      // hidden die cavity
      if (die_size > 0)
        rotate(45)
          translate([0, 0, 0 - base_height])
            minkowski()
            {
              cylinder(die_size, (die_size / 2) + die_round_radius, (die_size / 2), $fn = 4);
              sphere(r = die_round_radius, $fn = 30);
            }
      
      // door cavities
      for (a = [1:6])
        rotate(a * 60)
          if ((a % door_div) == 0)
            translate([-door_width / 2, (hex_size_scaled * (cos(30)/2)) - door_depth, 0])
              cube([door_width, door_depth + door_frame_depth + 1, door_height]);
          else
            translate([-door_width / 2, (hex_size_scaled * (cos(30)/2)) - door_depth, door_height - window_height])
              cube([window_width, window_depth + window_frame_depth + 1, window_height]);
        
      // make sure nothing protrudes down from the bottom
      translate([0, 0, 0 - base_height - hex_size_scaled])
        cylinder(hex_size_scaled, hex_size_scaled, hex_size_scaled, $fn = 6);        
        
    }
  }
}







//Geodesic Sphere for OpenSCAD by Jamie_K is licensed under the Creative Commons - Public Domain Dedication license.
    
// same syntax and semantics as built-in sphere, so should be a drop-in replacement
// it's a bit slow for large numbers of facets
module geodesic_sphere(r=-1, d=-1) {
  // if neither parameter specified, radius is taken to be 1
  rad = r > 0 ? r : d > 0 ? d/2 : 1;  
  
  pentside_pr = 2*sin(36);  // side length compared to radius of a pentagon
  pentheight_pr = sqrt(pentside_pr*pentside_pr - 1);
  // from center of sphere, icosahedron edge subtends this angle
  edge_subtend = 2*atan(pentheight_pr);

  // vertical rotation by 72 degrees
  c72 = cos(72);
  s72 = sin(72);
  function zrot(pt) = [ c72*pt[0]-s72*pt[1], s72*pt[0]+c72*pt[1], pt[2] ];

  // rotation from north to vertex along positive x
  ces = cos(edge_subtend);
  ses = sin(edge_subtend);
  function yrot(pt) = [ ces*pt[0] + ses*pt[2], pt[1], ces*pt[2]-ses*pt[0] ];
  
  // 12 icosahedron vertices generated from north, south, yrot and zrot
  ic1 = [ 0, 0, 1 ];  // north
  ic2 = yrot(ic1);    // north and +x
  ic3 = zrot(ic2);    // north and +x and +y
  ic4 = zrot(ic3);    // north and -x and +y
  ic5 = zrot(ic4);    // north and -x and -y
  ic6 = zrot(ic5);    // north and +x and -y
  ic12 = [ 0, 0, -1]; // south
  ic10 = yrot(ic12);  // south and -x
  ic11 = zrot(ic10);  // south and -x and -y
  ic7 = zrot(ic11);   // south and +x and -y
  ic8 = zrot(ic7);    // south and +x and +y
  ic9 = zrot(ic8);    // south and -x and +y
  
  // start with icosahedron, icos[0] is vertices and icos[1] is faces
  icos = [ [ic1, ic2, ic3, ic4, ic5, ic6, ic7, ic8, ic9, ic10, ic11, ic12 ],
    [ [0, 2, 1], [0, 3, 2], [0, 4, 3], [0, 5, 4], [0, 1, 5],
      [1, 2, 7], [2, 3, 8], [3, 4, 9], [4, 5, 10], [5, 1, 6], 
      [7, 6, 1], [8, 7, 2], [9, 8, 3], [10, 9, 4], [6, 10, 5],
      [6, 7, 11], [7, 8, 11], [8, 9, 11], [9, 10, 11], [10, 6, 11]]];
  
  // now for polyhedron subdivision functions

  // given two 3D points on the unit sphere, find the half-way point on the great circle
  // (euclidean midpoint renormalized to be 1 unit away from origin)
  function midpt(p1, p2) = 
    let (midx = (p1[0] + p2[0])/2, midy = (p1[1] + p2[1])/2, midz = (p1[2] + p2[2])/2)
    let (midlen = sqrt(midx*midx + midy*midy + midz*midz))
    [ midx/midlen, midy/midlen, midz/midlen ];
  
  // given a "struct" where pf[0] is vertices and pf[1] is faces, subdivide all faces into 
  // 4 faces by dividing each edge in half along a great circle (midpt function)
  // and returns a struct of the same format, i.e. pf[0] is a (larger) list of vertices and
  // pf[1] is a larger list of faces.
  function subdivpf(pf) =
    let (p=pf[0], faces=pf[1])
    [ // for each face, barf out six points
      [ for (f=faces) 
          let (p0 = p[f[0]], p1 = p[f[1]], p2=p[f[2]])
            // "identity" for-loop saves having to flatten
            for (outp=[ p0, p1, p2, midpt(p0, p1), midpt(p1, p2), midpt(p0, p2) ]) outp
      ],
      // now, again for each face, spit out four faces that connect those six points
      [ for (i=[0:len(faces)-1])
        let (base = 6*i)  // points generated in multiples of 6
          for (outf =
          [[ base, base+3, base+5], 
          [base+3, base+1, base+4],
          [base+5, base+4, base+2],
          [base+3, base+4, base+5]]) outf  // "identity" for-loop saves having to flatten
      ]
    ];

  // recursive wrapper for subdivpf that subdivides "levels" times
  function multi_subdiv_pf(pf, levels) =
    levels == 0 ? pf :
    multi_subdiv_pf(subdivpf(pf), levels-1);

  // subdivision level based on $fa:
  // level 0 has edge angle of edge_subtend so subdivision factor should be edge_subtend/$fa
  // must round up to next power of 2.  
  // Take log base 2 of angle ratio and round up to next integer
  ang_levels = ceil(log(edge_subtend/$fa)/log(2));
    
  // subdivision level based on $fs:
  // icosahedron edge length is rad*2*tan(edge_subtend/2)
  // actually a chord and not circumference but let's say it's close enough
  // subdivision factor should be rad*2*tan(edge_subtend/2)/$fs
  side_levels = ceil(log(rad*2*tan(edge_subtend/2)/$fs)/log(2));
  
  // subdivision level based on $fn: (fragments around circumference, not total facets)
  // icosahedron circumference around equator is about 5 (level 1 is exactly 10)
  // ratio of requested to equatorial segments is $fn/5
  // level of subdivison is log base 2 of $fn/5
  // round up to the next whole level so we get at least $fn
  facet_levels = ceil(log($fn/5)/log(2));
  
  // $fn takes precedence, otherwise facet_levels is NaN (-inf) but it's ok 
  // because it falls back to $fa or $fs, whichever translates to fewer levels
  levels = $fn ? facet_levels : min(ang_levels, side_levels);

  // subdivide icosahedron by these levels
  subdiv_icos = multi_subdiv_pf(icos, levels);
  
  scale(rad)
  polyhedron(points=subdiv_icos[0], faces=subdiv_icos[1]);
}
