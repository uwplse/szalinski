// Created in 2016 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:1693052


thread_diam = 1;
thread_clearance = 0.6;
//thread_diam = 1.5;
//thread_clearance = 1.0;
fabric_type_123 = 0;  // [0:Demo, 1:Flat, 2:Helical, 3:YFlex]
x_len = 60;
y_len = 60;


// i = number of steps - 0.5
// a = angle step
// z = z step
// c = clearance to z axis
// s = length of octagonal side, d / (1+sqrt(2))
// u = s / sqrt(2)
function HelicalThreadPoints(i,a,z,c,s,u) = (i<-1) ? [] :
  concat(HelicalThreadPoints(i-1,a,z,c,s,u),
  [
    [(c) * cos(a*i), (c) * sin(a*i), u + i*z],
    [(c+u) * cos(a*i), (c+u) * sin(a*i), 0 + i*z],
    [(c+s+u) * cos(a*i), (c+s+u) * sin(a*i), 0 + i*z],
    [(c+s+2*u) * cos(a*i), (c+s+2*u) * sin(a*i), u + i*z],
    [(c+s+2*u) * cos(a*i), (c+s+2*u) * sin(a*i), s+u + i*z],
    [(c+s+u) * cos(a*i), (c+s+u) * sin(a*i), s+2*u + i*z],
    [(c+u) * cos(a*i), (c+u) * sin(a*i), s+2*u + i*z],
    [(c) * cos(a*i), (c) * sin(a*i), s+u + i*z]
  ]
);


function FabricThreadFacesRec(i) = (i<0) ? [] :
  concat(FabricThreadFacesRec(i-8),
  [
    [i, i+1, i+9], [i+9, i+8, i],
    [i+1, i+2, i+10], [i+10, i+9, i+1],
    [i+2, i+3, i+11], [i+11, i+10, i+2],
    [i+3, i+4, i+12], [i+12, i+11, i+3],
    [i+4, i+5, i+13], [i+13, i+12, i+4],
    [i+5, i+6, i+14], [i+14, i+13, i+5],
    [i+6, i+7, i+15], [i+15, i+14, i+6],
    [i+7, i, i+8], [i+8, i+15, i+7]
  ]
);


function FabricThreadFaces(n) = concat(
  [
    [7,6,5],[5,4,3],[3,2,1],[1,0,7],[7,5,3],[3,1,7],
    [n*8, n*8+1, n*8+2], [n*8+2, n*8+3, n*8+4], [n*8+4, n*8+5, n*8+6],
    [n*8+6, n*8+7, n*8], [n*8,n*8+2,n*8+4], [n*8+4,n*8+6,n*8],
  ], FabricThreadFacesRec(n*8)
);


function XZRot(v, ang) =
  [v[0]*cos(ang)+v[2]*sin(ang), v[1], -v[0]*sin(ang)+v[2]*cos(ang)];

function BaseFlat(i,a,z,c,s,u) = [(c+u+s/2) * cos(a*i), 0, i*z];

function FlatAng(i,a,z,c,s,u) = atan(-(c+u+s/2)*(sin(a*i)+pow(sin(a*i),3))/2);

// i = number of steps - 0.5
// a = angle step
// z = z step
// c = clearance to z axis
// s = length of octagonal side, d / (1+sqrt(2))
// u = s / sqrt(2)
function FlatThreadPoints(i,a,z,c,s,u) = (i<-1) ? [] :
  concat(FlatThreadPoints(i-1,a,z,c,s,u),
  [
    BaseFlat(i,a,z,c,s,u) + XZRot([-s/2-u, -s/2, 0], FlatAng(i,a,z,c,s,u)),
    BaseFlat(i,a,z,c,s,u) + XZRot([-s/2, -s/2-u, 0], FlatAng(i,a,z,c,s,u)),
    BaseFlat(i,a,z,c,s,u) + XZRot([s/2, -s/2-u, 0], FlatAng(i,a,z,c,s,u)),
    BaseFlat(i,a,z,c,s,u) + XZRot([s/2+u, -s/2, 0], FlatAng(i,a,z,c,s,u)),
    BaseFlat(i,a,z,c,s,u) + XZRot([s/2+u, s/2, 0], FlatAng(i,a,z,c,s,u)),
    BaseFlat(i,a,z,c,s,u) + XZRot([s/2, s/2+u, 0], FlatAng(i,a,z,c,s,u)),
    BaseFlat(i,a,z,c,s,u) + XZRot([-s/2, s/2+u, 0], FlatAng(i,a,z,c,s,u)),
    BaseFlat(i,a,z,c,s,u) + XZRot([-s/2-u, s/2, 0], FlatAng(i,a,z,c,s,u))
  ]
);



module FabricThread(length, diam, axial_pitch, radial_clearance, helical=false) {
  // If (thread_diam / thread_clearance) > 15, perloop might need increasing.
  perloop = 16;
  steps = round(perloop * length / axial_pitch);
  point_steps = steps - 0.5;
  angle_step = 360 / perloop;
  z_step = axial_pitch / perloop;
  side_len = diam/(1+sqrt(2));
  angled_len = diam/(sqrt(2)*(1+sqrt(2)));

  points = helical ?
    HelicalThreadPoints(point_steps, angle_step, z_step,
      radial_clearance, side_len, angled_len) :
    FlatThreadPoints(point_steps, angle_step, z_step,
      radial_clearance, side_len, angled_len);
  faces = FabricThreadFaces(steps);

  polyhedron(points=points, faces=faces);
}


module MakeXThreads(x_len, y_len, diam, pitch, clearance, helical=false) {
  count = round(y_len/pitch-1);
  for (i=[1:count]) {
    translate([0, i*pitch, 0])
      scale([1,pow(-1,(i)),pow(-1,(i+1))])
      rotate([0,90,0])
      FabricThread(x_len, diam, 2*pitch, clearance/2, helical);
  }
}


module MakeYThreads(x_len, y_len, diam, pitch, clearance, helical=false) {
  count = round(x_len/pitch-1);
  for (i=[1:count]) {
    translate([(i)*pitch, 0, 0])
      scale([pow(-1,(i)),1,pow(-1,(i))])
      rotate([0,90,90])
      FabricThread(y_len, diam, 2*pitch, clearance/2, helical);
  }
}


// Creates a flat fabric weave with overall fabric dimensions of x_len by
// y_len.  Each thread has a diameter of diam, and the threads print with a
// minimum distance between each other of approximately clearance.
module MakeFlatFabric(x_len, y_len, diam, clearance) {
  thread_xy_pitch = sqrt(pow((diam + 2*clearance),2) - pow(clearance,2)) + diam;
  translate([0, 0, diam + clearance/2]) {
    MakeXThreads(x_len, y_len, diam, thread_xy_pitch, clearance);
    MakeYThreads(x_len, y_len, diam, thread_xy_pitch, clearance);
  }
}


// Creates a helical/counterhelical fabric weave with overall fabric dimensions
// of x_len by y_len.  Each thread has a diameter of diam, and the threads
// print with a minimum distance between each other of approximately clearance.
module MakeHelicalFabric(x_len, y_len, diam, clearance) {
  thread_xy_pitch = 2*diam + 2*clearance;
  translate([0, 0, diam + clearance]) {
    translate([-diam/2,diam/2, 0])
      MakeXThreads(x_len, y_len, diam, thread_xy_pitch, clearance, true);
    MakeYThreads(x_len, y_len, diam, thread_xy_pitch, clearance, true);
  }
}


// Creates an interlocking x-oriented helical weave with overall fabric
// dimensions of x_len by y_len.  Each thread has a diameter of diam, and the
// threads print with a minimum distance between each other of approximately
// clearance.  This pattern naturally flexes and stretches well in the y
// direction as generated, while being more rigid in the x direction.
module MakeYFlexFabric(x_len, y_len, diam, clearance) {
  int_thread_clearance = 0.5*diam+clearance;
  thread_xy_pitch = diam+clearance;
  count = round(y_len/thread_xy_pitch-1);
  translate([0, 0, diam + int_thread_clearance]) {
    for (i=[1:count]) {
      translate([0, i*thread_xy_pitch, 0])
        scale([1,pow(-1,(i)),pow(-1,(i+1))])
        rotate([0,90,0])
        FabricThread(x_len, diam, (3*diam+3*clearance)*sqrt(2),
          int_thread_clearance, helical=true);
    }
  }
}


if (fabric_type_123 == 1) {
  MakeFlatFabric(x_len, y_len, thread_diam, thread_clearance);
}

else if (fabric_type_123 == 2) {
  MakeHelicalFabric(x_len, y_len, thread_diam, thread_clearance);
}

else if (fabric_type_123 == 3) {
  MakeYFlexFabric(x_len, y_len, thread_diam, thread_clearance);
}

else {
  translate([-10-x_len, 0, 0])
    MakeFlatFabric(x_len, y_len, thread_diam, thread_clearance);
  translate([-10-x_len, -10-y_len, 0])
    MakeHelicalFabric(x_len, y_len, thread_diam, thread_clearance);
  translate([0, -10-y_len, 0])
    MakeYFlexFabric(x_len, y_len, thread_diam, thread_clearance);
  translate([0,30,0]) text("fabric_type_123 =", size=x_len/11);
  translate([0,20,0]) text("    1 for Flat", size=x_len/11);
  translate([0,10,0]) text("    2 for Helical", size=x_len/11);
  text("    3 for Y-Flex", size=x_len/11);
}

