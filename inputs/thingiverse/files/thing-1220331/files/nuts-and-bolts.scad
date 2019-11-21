/*
  Aaron Ciuffo
  Released under GPL V3


  Metric nut and bolt sizes based on 
  http://www.roymech.co.uk/Useful_Tables/Screws/Hex_Screws.htm
  http://www.numberfactory.com/nf%20metric%20screws%20and%20bolts.htm
  http://www.csgnetwork.com/screwsochdcaptable.html

  NOTE: OpenSCAD 2015.03-2 crashes *HARD* if the called m bolt size does not exist due
  to a bug in the lookup() function. A bug report has been filed and should be fixed
  in the next release:
  https://github.com/openscad/openscad/issues/1528

  TODO:
  * Add circular releif cuts in corners of tSlot to prevent cracking in acrylic

  Usage:
  mBolt(
    size = mX, // defined m bolt size (default: m3) 
    len = N, // length of bolt shaft (default: 10)
    center = true/false, // center the shaft (not including the head) (default: true)
    style = "socket"/"hex" // default is socket drive (default: socket)
    tolerance = N // positve or negative number to add to the shaft diameter (def: 0)
  );

  mNut(
    size = mX, // defined m bolt size (default: m3)
    center = true/false // center the nut (default: true)
    tolerance = N // positive or negative number to add to the hole and body diameter
  );

  mWasher(
    size = mX, // defined m bolt size (default: m3)
    tolerance = N // positive or negative number to add to the inner and outer diameter
  );
    
  This module creates a t-shaped slot for making perpendicular joints in laser cut
  objects. By default the bolt slot is 0.5mm larger than the distance across the 
  nut FLATS. This shold make it easy to slot in a nut, but it should not be able
  to spin to make tightening easier.

  tSlot(
    size = mX, // defined m bolt size (default: m3)
    material = N, // thickness of material in mm (default: 3)
    len = N, // total length of bolt to be used (default: 15)
    tolerence = N // positive or negative number to add to the bolt size (def 0.5)
  );

*/


/* 
  Add additional M sizes in the section below
  Fastner Dimensions:
  mX = [
    [boltDia, D], // D = bolt shaft diameter
    [headHexThick, T], // T = thickness of head
    [boltNut, N], // N = width across flats, wrench size for bolt head or nut
    [boltNutMax, M], // M = maximum width of bolt head or nut
    [nutThick, Q] // Q = nutThickness
    [washerDia, W], // W = external diameter of washer
    [washerThick, E] // E = washer thickness
    [socketHeadThick, H], // H = thickness of hex socket head
    [socketDia, S], // S = diameter hex socket head
    [socketSize, Z] // Z = socket wrench size
  ];

  BLANK 

  mX = [
    [boltDia, ],
    [headHexThick, ],
    [boltNut, ],
    [boltNutMax, ], 
    [nutThick, ],
    [washerDia, ],
    [washerThick, ],
    [socketHeadThick, ],
    [socketDia, ],
    [socketSize, ]
  ];
*/


/* [Hidden] */
// This is a bit of an abuse of the lookup() function; the temporary values
// need to be the *actual* values used in at least one of the defined sets
// values for lookup function
boltDia =  3;
headHexThick = 2;
boltNut = 5.5;
boltNutMax = 6.4; 
nutThick = 2.4;
washerDia = 7;
washerThick = 0.5;
socketHeadThick = 3;
socketDia = 5.5;
socketSize = 2.5;



// Meric Fastner Sizes
m2 = [
  [boltDia, 2],
  [headHexThick, 2],
  [boltNut, 4],
  [boltNutMax, 4.6], 
  [nutThick, 1.2], 
  [washerDia, 5.5],
  [washerThick, 0.3],
  [socketHeadThick, 2],
  [socketDia, 3.5],
  [socketSize, 1.5]
];

m3 = [
  [boltDia, 3],
  [headHexThick, 2],
  [boltNut, 5.5],
  [boltNutMax, 6.4], 
  [nutThick, 2.4], 
  [washerDia, 7],
  [washerThick, 0.5],
  [socketHeadThick, 3],
  [socketDia, 5.5],
  [socketSize, 2.5]
];

m4 = [
  [boltDia, 4],
  [headHexThick, 4],
  [boltNut, 7],
  [boltNutMax, 8.1],
  [nutThick, 3.2], 
  [washerDia, 9],
  [washerThick, 0.8],
  [socketHeadThick, 4],
  [socketDia, 7],
  [socketSize, 3]
];

m6 = [
  [boltDia, 6],
  [headHexThick, 4],
  [boltNut, 10],
  [boltNutMax, 11.5],  
  [nutThick, 5], 
  [washerDia, 12],
  [washerThick, 1.6],
  [socketHeadThick, 6],
  [socketDia, 10],
  [socketSize, 5]
];

m8 = [
  [boltDia, 8],
  [headHexThick, 5.5],
  [boltNut, 13],
  [boltNutMax, 15], 
  [nutThick, 6.5], 
  [washerDia, 17],
  [washerThick, 2],
  [socketHeadThick, 8],
  [socketDia, 13],
  [socketSize, 6]
];

m10 = [
  [boltDia, 10],
  [headHexThick, 7],
  [boltNut, 17],
  [boltNutMax, 19.6],
  [nutThick, 8], 
  [washerDia, 21],
  [washerThick, 2],
  [socketHeadThick, ],
  [socketDia, 16],
  [socketSize, 8]
];

m12 = [
  [boltDia, 12],
  [headHexThick, 8],
  [boltNut, 19],
  [boltNutMax, 22.1],
  [nutThick, 9.5], 
  [washerDia, 24],
  [washerThick, 2.5],
  [socketHeadThick, 12],
  [socketDia, 18],
  [socketSize, 10]
];

types = [m2, m3, m4, m6, m8, m10, m12];

/* [Customize] */
//Type of M series fastner
typeMeta = 1; //[0:m2,1:m3,2:m4,3:m6,4:m8,5:m10,6:m12]
// Length of Bolt
customizerLen = 10; //[1:40] 

/*[Hidden]*/
customizerType = types[typeMeta];

echo (typeMeta, customizerType);

module mNut(size = m3, center = true, tolerance = 0) {
  fastnerType = size;
  t = tolerance; 

  // lookup values
  boltDiaL = lookup(boltDia, fastnerType);
  headHexThickL = lookup(headHexThick, fastnerType);
  boltNutL = lookup(boltNut, fastnerType);
  boltNutMaxL = lookup(boltNutMax, fastnerType);
  nutThickL = lookup(nutThick, fastnerType);
  washerDiaL = lookup(washerDia, fastnerType);
  washerThickL = lookup(washerThick, fastnerType);
  socketHeadThickL = lookup(socketHeadThick, fastnerType);
  socketDiaL = lookup(socketDia, fastnerType);
  socketSizeL = lookup(socketSize, fastnerType);

  echo ("type M", boltDiaL);
  difference() {
    cylinder(center = center, r = boltNutMaxL/2 + t/2, h = nutThickL + t , $fn = 6);
    cylinder(center = true, r = boltDiaL/2 + t/2, h = nutThickL*3, $fn = 72);

 
  echo ("nut thickness:", nutThickL+t);
  }
}

//mNut();

module mBolt(size = m3, len = 10, center = true, style = "socket", tolerance = 0) {
  fastnerType = size;
  t = tolerance; 

  // lookup values
  boltDiaL = lookup(boltDia, fastnerType);
  headHexThickL = lookup(headHexThick, fastnerType);
  boltNutL = lookup(boltNut, fastnerType);
  boltNutMaxL = lookup(boltNutMax, fastnerType);
  nutThickL = lookup(nutThick, fastnerType);
  washerDiaL = lookup(washerDia, fastnerType);
  washerThickL = lookup(washerThick, fastnerType);
  socketHeadThickL = lookup(socketHeadThick, fastnerType);
  socketDiaL = lookup(socketDia, fastnerType);
  socketSizeL = lookup(socketSize, fastnerType);

  echo ("type M", boltDiaL);
  $fn = 72;
  socketRad = (socketSizeL/2)/sin(60); // socket hole diameter
  headRad = boltNutMaxL/2;

  centerTranslate = center == true ? len/2 : len;

  union() {
    cylinder(r = boltDiaL/2 + t, h = len, center = center );

    if (style == "socket") {
      translate([0, 0, centerTranslate+socketHeadThickL/2])
        difference() {
          cylinder(r = socketDiaL/2, h = socketHeadThickL, center = true);
          translate([0, 0, socketHeadThickL/2 - socketHeadThickL*.74/2])
            cylinder(r = socketRad, h = socketHeadThickL*.75, center = true, $fn = 6);
        }

      echo ("total length:", len + socketHeadThickL);
      echo ("head thickness:", socketHeadThickL);
      echo ("bolt length:", len);
    }
    
    if (style == "hex") {
      //translate([0, 0, len/2+headHexThickL/2])
      translate([0, 0, centerTranslate+headHexThickL/2])
        cylinder(h = headHexThickL, r = headRad, center = true, $fn = 6);

      echo ("total length:", len + headHexThickL + t);
      echo ("head thickness:", headHexThickL);
      echo ("bolt length:", len);


    }
  }

}


module mWasher(size = m3, tolerance = 0) {
  fastnerType = size; 
  t = tolerance; 

  // lookup values
  boltDiaL = lookup(boltDia, fastnerType);
  headHexThickL = lookup(headHexThick, fastnerType);
  boltNutL = lookup(boltNut, fastnerType);
  boltNutMaxL = lookup(boltNutMax, fastnerType);
  nutThickL = lookup(nutThick, fastnerType);
  washerDiaL = lookup(washerDia, fastnerType);
  washerThickL = lookup(washerThick, fastnerType);
  socketHeadThickL = lookup(socketHeadThick, fastnerType);
  socketDiaL = lookup(socketDia, fastnerType);
  socketSizeL = lookup(socketSize, fastnerType);

  difference() {
    cylinder(r = washerDiaL/2+t/2, h = washerThickL+t, center = true, $fn = 36);
    cylinder(r = boltDiaL/2+t/2, h = washerThickL*3, center = true, $fn = 36);
  }
  
}


module tSlot(size = m3, material = 3, bolt = 15, tolerance = 0.5) {
  fastnerType = size;
  t = tolerance; 
  // lookup values
  boltDiaL = lookup(boltDia, fastnerType);
  headHexThickL = lookup(headHexThick, fastnerType);
  boltNutL = lookup(boltNut, fastnerType);
  boltNutMaxL = lookup(boltNutMax, fastnerType);
  nutThickL = lookup(nutThick, fastnerType);
  washerDiaL = lookup(washerDia, fastnerType);
  washerThickL = lookup(washerThick, fastnerType);
  socketHeadThickL = lookup(socketHeadThick, fastnerType);
  socketDiaL = lookup(socketDia, fastnerType);
  socketSizeL = lookup(socketSize, fastnerType);
  
  boltSlot = bolt + t - material; // length of nut slot - material + tolerence
  nutTh = nutThickL + t; // thickness of nut + tolerence


  cube([boltNutL+t, nutTh, material*2], center = true);
  translate([0, (boltSlot)/2-nutTh, 0])
    cube([boltDiaL+t, boltSlot, material*2], center=true);
  echo("tslot total length:", boltSlot);
  echo("length above bolt:" , boltSlot-nutTh);
}

module demo() {
  for (i = types) {
    fastnerType = i;
    boltDiaL = lookup(boltDia, fastnerType);
    headHexThickL = lookup(headHexThick, fastnerType);
    boltNutL = lookup(boltNut, fastnerType);
    boltNutMaxL = lookup(boltNutMax, fastnerType);
    nutThickL = lookup(nutThick, fastnerType);
    washerDiaL = lookup(washerDia, fastnerType);
    washerThickL = lookup(washerThick, fastnerType);
    socketHeadThickL = lookup(socketHeadThick, fastnerType);
    socketDiaL = lookup(socketDia, fastnerType);
    socketSizeL = lookup(socketSize, fastnerType);

    translate([0, socketDiaL*10-40, 0])
      color("red")
      mBolt(i, len = washerDiaL);
    translate([30, socketDiaL*10-40, 0])
      color("orange")
      mBolt(i, style = "hex", len = washerDiaL);
    translate([60, socketDiaL*10-40, 0])
      color("yellow")
      mNut(i);
    translate([90, socketDiaL*10-40, 0])
      color("green")
      mWasher(i);
    translate([120, 25, 0])
      tSlotDemo();
  }
}

module simpleDemo() {
  fastnerType = customizerType;
  boltDiaL = lookup(boltDia, fastnerType);
  headHexThickL = lookup(headHexThick, fastnerType);
  boltNutL = lookup(boltNut, fastnerType);
  boltNutMaxL = lookup(boltNutMax, fastnerType);
  nutThickL = lookup(nutThick, fastnerType);
  washerDiaL = lookup(washerDia, fastnerType);
  washerThickL = lookup(washerThick, fastnerType);
  socketHeadThickL = lookup(socketHeadThick, fastnerType);
  socketDiaL = lookup(socketDia, fastnerType);
  socketSizeL = lookup(socketSize, fastnerType);
  
  trans = washerDiaL*1.5;
  
  color("blue")
    mBolt(size = fastnerType, len = customizerLen);

  translate([trans, 0, 0])
    color("red")
    mBolt(size = fastnerType, style = "hex", len = customizerLen);
  
  translate([trans*2, 0, 0])
    color("green")
    mNut(size = fastnerType);

  translate([trans*3, 0, 0])
    color("orange")
    mWasher(size = fastnerType);
  
  translate([trans*4+15, 0, 0])
    tSlotDemo();
}

module tSlotDemo() {
  thick = 3; // material thickness
  sheet = [30, 20, thick];
  tol = 0.5; // tolerance

  difference() {
    color("blue")
      cube(sheet, center = true);
    translate([0, 10-4.6, 0])
      tSlot(size = m3, material = thick, bolt = 10, tolerance = tol);
  }
  
  difference() {
    color("yellow")
      translate([0, 10+3/2, 0])
      cube([30, thick, 25], center=true);
    translate([0, 10-4.6+thick])
      rotate([-90, 0, 0])
      mBolt(m3, len = 10, tolerance = 0.1);
  }

  translate([0, 10-4.6+thick-tol, 0])
    rotate([-90, 0, 0])
    color("silver")
    mBolt(m3, len = 10, tolerance = 0.01);

  translate([0, 10-4.6, 0])
    rotate([-90, 30, 0])
    color("gray")
    mNut(m3);

}

simpleDemo();
//demo();
//mWasher(m10);
//mNut(m3);
//mBolt(m3);
//mBolt(size = m3, style = "hex");
//mBolt(m3, tolerance = 0.02, center = false, style = "hex", len = 15);
//mBolt(m3, tolerance = 0.05, center = true, len = 6);
//tSlot(size = m3, bolt = 10);

//tSlotDemo();
