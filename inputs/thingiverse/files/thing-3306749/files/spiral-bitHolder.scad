/**
 * Remix of hex bit holder by Fitzterra
 * https://www.thingiverse.com/thing:1686330
 *
 * This remix evolved until it is now almost completely, but not entirely, unlike the original, and
 * has the following features:
 *  - Stepped spiral layout of bits
 *  - Cutouts showing bit size are an artefact of the spiral drawing technique, and go all the way down to the bottom of the bit.
 *  - Hex or round holes
 *  - Extended base for stability
 *  - Just for fun, the base and centre platform are hexagonal
 *
 * To do (but probably won't ever get done. Remix it!)):
 *  - Make the outer surface a smooth curve, (and a circular base to match)
 *  - Make the top surface smooth instead of a staircase
 *  - Allow users to optionally add outer sides to the holes
 *  - Parameterize base size
 *  - Fillet corners
 *
 * Author: FrankV <drifter.frank@gmail.com>  - Dec 2018
 **/

// Number of bits, not including centre
numBits =13;
// Height of the footer
foot = 1.5;
// Height of side above bottom of bit
height = 16;
// Shape of hole
holeShape = "hex"; // ["hex", "round"]

/* [ Advanced ] */
// Clearance to allow for printer errors, etc.
clearance = 0.2;
// Gap between hole edges from one round of the spiral to the next
radialGap = 1.9;
// Gap between hole edges for adjacent bits (adjust so that gaps between outer bits align with inner bits)
circumGap = 1.2;
// Hex size (1/4" + clearance) or hole diameter
hexSize = 25.4/4 + 2*clearance;
// inner diameter = diameter of step drill
innerDiam = 13;
// Footer step (adjust so that bottom of cutout is above outer step)
footStep = 0.4;


// Calculate location of each bit in polar coordinates.
// numBits+2 points
// Bit 0 is the centre, which is not counted in numBits
// numBits+1 is needed to calculate the outside edge of the last step in the spiral
// 12.5 is a fudge factor, sin(60)
// Radius to centre of each each bit
rad = [0, for (b = [1: numBits+1]) innerDiam/2+radialGap+hexSize/2+ b * (hexSize+circumGap*2)/12.5];
// Angle between two adjacent bits to give constant distance between bits... decreases with increasing radius
delta = [0, for (b = [1: numBits+1]) atan2(hexSize/sin(60)+circumGap*2, rad[b])];
// Angle to each bit ... (rad, angle) = Polar coordinates of bit position
angle = [0, for (b = [1: numBits+1]) sum(b, delta)];

// Calculate points around the spiral at the outside of each bit. These points are used to build the 
// staircase spiral. These points are midway between this bit and the next bit, and at the outside edge of the bit.
// A step is made up of a triangle from the centre to these midpoints
spiral = [  
    // The first bit is at (rad[1], angle[1]), so add the preceding "midway" point
    [cos(angle[1]+(angle[1]-angle[2])/2)*(rad[1]+hexSize/2), sin(angle[1]+(angle[1]-angle[2])/2)*(rad[1]+hexSize/2)],
    for (b = [1: numBits])
        // Generate a point midway between this bit and the succeeding bit
            [cos((angle[b]+angle[b+1])/2)*((rad[b]+rad[b+1])/2+hexSize/2), sin((angle[b]+angle[b+1])/2)*((rad[b]+rad[b+1])/2+hexSize/2)]
  ];
    
bitHolder();
linear_extrude(foot) circle(r=rad[numBits]+hexSize+radialGap*2, $fn=6);
   
module bitHolder() {
    difference() {
        union() {
            // Spiral staircase
            for (i = [1: numBits]) {
                baseHeight = foot+(numBits-i) * footStep;
                // One step which surrounds the hex cutout, and has edges coincident with adjacent steps
                linear_extrude(baseHeight + height) polygon([spiral[i-1], spiral[i], [0,0]]);
            }
            // Central platform is at the same height as first bit
            cylinder(d = innerDiam+radialGap*2+clearance*2, h = foot+(numBits-1) * footStep + height, $fn=6);
        }
        
        // Central hole
        translate([0, 0, foot+numBits * footStep + (height+0.1)/2])
            hole();
        for (i = [1: numBits]) {
            baseHeight = foot+(numBits-i) * footStep;
            rotate(angle[i]) {
                translate([rad[i], 0, baseHeight +(height+0.1)/2]) 
                    hole();
            }
       }
    }
}
            

// The hole cutout... 
module hole() {
    if (holeShape == "hex") {
        // It is important that a flat of the hex will be parallel to the YZ plane. Using $fn=6 doesn't work
        for (i =[0:60:120]) {
             // 0.5773 measured in OnShape.com as the right ratio of diameter to flat size
            rotate(i)  cube([hexSize, hexSize*0.5773, height+0.1], center=true);
        }
    } else {
        cylinder(d = hexSize, h = height+0.1, center = true);
    }
}

 // add all array elements 0 to n (recursive)
 function sum(n, array) = ( n==0 ? 0 : array[n] + sum(n-1, array) );
