// Water bottle, canteen, drying mug (whatever you call it) drying stand

// inside diameter of bottle mouth
other_mouthi = 67.5;
// outside diameter of bottle mouth
other_moutho = 71;

// or pick a predefined size
preset = 0; // [ 0:other, 1:contigo 16 oz, 2:smartsource 27 oz, 3:aladdin 12 oz ]

// thickness of the drying cone
dripwall = 0.8;
// diameter of the round part replacing the  tip of the cone >5 for mm or <1 for fraction of diameter
driphat_p = 5;

/* [hidden] */
presets = [
  [other_mouthi, other_moutho],  // other
  [67.5, 71 ], // contigo 27 oz travel mug
  [50, 56 ],   // SmartSource 27oz water bottle
  [71, 74 ],  // Aladdin 12 oz flip and sip vacuum insulated mug
];

mouthi = presets[preset][0];
moutho = presets[preset][1];

driphat = driphat_p<1 ? mouthi*driphat_p : driphat_p;

/* [extra] */
// height of the foot that holds up the bottle
footh = 12;
// height of the slot in the foot
detent = 2;
// thickness of the walls of the foot
footwall = 2;
// number of feet
nfoot = 3;


// width of the bottom ring, 0 to disable
lipwidth = 1;
// height of the bottom ring, 0 to disable
lipheight = 0.5;

// openscad rendered circle fragments
$fn=60;

// calculated stuff
footangle = 360/nfoot;
footw = moutho-mouthi+footwall;

driph = (mouthi-driphat)/2;

//  http://mathworld.wolfram.com/SphericalCap.html
// contact angle = 45 (hardcoded for now)
dripr = driphat/2;
hatoff = sin(45)*dripr;
hatr = sqrt(hatoff*hatoff + dripr*dripr);
driphatd = hatr*2;



// drip wall
difference() {
    cylinder(d1=mouthi, d2=driphat, h=driph);
    cylinder(d1=mouthi-dripwall/sin(45), d2=driphat-dripwall/sin(45), h=driph);
}
translate([0,0,driph-hatoff]) difference() {
    sphere(d=driphatd);
    sphere(d=driphatd-dripwall);
    translate([-driphatd/2,-driphatd/2,-driphatd+hatoff]) cube(driphatd);
}
// feet
difference() {
  for (i=[0:nfoot]){
     rotate([0,0,footangle*i]) translate([mouthi/2-footwall, -footw/2,0]) 
        cube([footw, footw, footh]);
  }
  translate([0,0,footh-detent]) difference() {
      cylinder(h=detent+1, d=moutho);
      cylinder(h=detent+2, d=mouthi);
  }
}
// bottom lip
if (lipwidth>0 && lipheight>0) {
  difference() {
    cylinder(h=lipheight, d=mouthi);
    cylinder(h=lipheight, d=mouthi-lipwidth*2);
  }
}
