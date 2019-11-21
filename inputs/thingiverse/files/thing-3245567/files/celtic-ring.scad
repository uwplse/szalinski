
/* [Size] */

//Inner radius of the ring (mm)
radius=9;

//Width of the ring (mm)
width=10;

//Thickness of the ring (mm)
thickness=2.4;

//Depth of the relief (relative to thickness)
depth=0.15;          // [0:0.01:0.99]

//How smooth the model is (segments per circle)
smoothness=50;     // [4:1:200]

/* [Decoration] */

//Width of the bands (relative to height)
bwidth=0.3;        // [0:0.01:1]

//Thickness of the pen for drawing the ornaments (mm)
linethickness=0.7;

//Number of circles in the ornament
circles=3;           // [2:1:10]

//Overlap of the circles (relative to their radius)
overlap=0.2;       // [-1:0.01:1]

//Rotation of the ornament (degrees)
rotation=30;        // [0:1:360]

//Correction of the ornament size
sizecorrection=1.3; // [0.5:0.01:2]

//Density of the ornaments
density=2;   // [0:No Ornaments,1:Single row,2:Two mirrored rows]

//Correction of the position of the ornament row(s) [mm]
divergency=0.8;


$fn=smoothness;


module ring(r=25, h=5, t=2) {
       difference() {
         cylinder(r=r+t, h=h);
         translate([0,0,-1])
           cylinder(r=r, h=h+2);
       }
}

//overlap: -1 to 1  - how much the circles overlap
module circleflower(r=10, h=10, t=1, circles=3, overlap=0.3) {

  slice=360/circles;
  //calculate the actual size of the smaller circles:
  r=(r-2*t)/(2-overlap);
      
  intersection() {
    // cutting pattern
    for ( angle = [0 : slice : 360] ) {    
      intersection() {
        rotate([0,0,angle]) {
          translate([r-r*overlap,0,0]) {
              cylinder(r=r+t, h=h);
          }
        }
        rotate([0,0,angle-slice]) {
          translate([r-r*overlap,0,0]) {
              cylinder(r=r+t, h=h);
          }
        }
      }            
    }

    // overlaped circles
    for ( angle = [0 : slice : 360] ) {
      rotate([0,0,angle]) {
        translate([r-r*overlap,0,0]) {
          ring(r=r, h=h, t=t);
        }
      }
    }    
  }
}

//circleflower(r=10, h=10, t=1, circles=3, overlap=0.3);


//bwidth 0..1  - band width
//bdepth 0..1  - band depth
module bandedring(r=25, h=5, t=2, bdepth=1, bwidth=0.3) {    
    bwidthnum = h/2 * bwidth;
    bdepthnum = t * bdepth;
    
    difference() {
      ring(r=r, h=h, t=t);
      translate([0,0,bwidthnum]) 
        ring(r=r+t-bdepthnum, 
            h=h-2*bwidthnum, 
            t=t+1);
    }   
}



//lt = line thickness
//offset = 0 to 1 : z-axis rotation of the pattern
module ringpattern(r=10, h=5, t=2, lt=1, circles=3, overlap=0.3, rotation=30, offset=0) {
    
    numflowers = round(2*PI*r/h);
    slice = 360 / numflowers;
    offset = slice*offset;    

    intersection() {
      union() {

        for( angle = [0+offset: slice: 360+offset]) {
    
          rotate([0,0,angle])
          translate([0,-r,h/2])
          rotate([90,0,0])
          rotate([0,0,rotation])
            circleflower(r=h/2, 
                    h=t, 
                    t=lt, 
                    circles=circles, 
                    overlap=overlap);
        }
      }
      cylinder(r=r+t, h=h);
    }
    
}

module celticring(
  r=10,               // ring radius
  w=10,              // ring width
  t=3,                // thickness of the ring
  depth=0.2,         // depth of the pattern
  bwidth=0.3,        // rel. width of the bands
  divergency=0.8,    // up/down shift of the mirrored patterns
  sizecorrection=1.3, // rel. correction of the pattern size
  lt=0.7,             // line thickness for the pattern
  circles=3,          // num circles in the pattern
  overlap=0.2,       // overlap of the circles
  rotation=30,        // rotation of the pattern
  density=1   // double density of the pattern
) {

    patternh=(w-2*bwidth);
    patternhcor=patternh*sizecorrection;
    corshift=(patternhcor-patternh)/2;    

        bandedring(r=r, h=w, t=t, bdepth=depth, 
          bwidth=bwidth);

        if (density>0)
        translate([0,0,-divergency-corshift+bwidth])
        ringpattern(r=r, h=patternhcor, t=t, lt=lt, 
          circles=circles, overlap=overlap, 
          rotation=rotation);
    
        if (density>1)
        translate([0,0,divergency-corshift+bwidth])
        ringpattern(r=r, h=patternhcor, t=t, lt=lt, 
          circles=circles, overlap=overlap, 
          rotation=-rotation, offset=0.5);    

}

celticring(
  r=radius, w=width, t=thickness, depth=depth,
  bwidth=bwidth, divergency=divergency,
  sizecorrection=sizecorrection,
  lt=linethickness, circles=circles, overlap=overlap,
  rotation=rotation, density=density
);
