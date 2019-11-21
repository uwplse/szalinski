// straps only work in tpu, pegs work in tpu or pla
anchor_style = 1; // [0:attached strap, 1:cap with pegs, 2:cap with pegs and attachable strap, 3:strap only, 4: cap without pegs]
shape = 1; // [ 0:square, 1:hexagonal ]
batterytype = 2; // [ 0:other, 1:AAA, 2:AA,  3:C, 4:D ]

// diameter of battery if not from the list above
other_diameter = 14;
// length of battery
other_length = 50.5;


// rows in the matrix
rows = 3;
// columns in the matrix
cols = 3;

/* [extras] */
// gap between batteries
wall = 1; 
// bottom wall
bwall=1;

// extra diameter at the opening of the ring
taper = 0.8;
taperlen = 3;
// width of the portion of the band that fits the battery exactly 
ringwidth = 5;

// extra diameter for the battery; use 0 for tpu, something larger for a loose fit (up to 0.5?)
tolerance = 0.2;  // [-0.5:0.1:0.5]

peg_groove = 2;
peg_len = peg_groove+wall;

peg_groove_height = 2;
peg_width = 3;
peg_height = 5;

strapthickness = 0.8;
// strap with for attached straps, detached strap with is based on peg size
strapwidth = 3;
// extra slack in attached straps
strapslop = 1;


/* [hidden] */
$fn = 60;
eps = 0.01;
tol = 0.1;

// other AAA AA C D 
batdias = [ other_diameter, 10.5, 14.5, 26.2, 34.2 ];
batlens = [ other_length, 44.5, 50.5, 50, 61.5];  
// note: AA is 13.5-14.5

batdia = batdias[batterytype] + tolerance;
batlen = batlens[batterytype] +tolerance;

ringd = batdia;
ringlen = taperlen + ringwidth;
// size of the battery cell including the ring around it
cellstep = ringd+wall-taper/2;
/* // silly spacing
rowstep = (shape==0)? cellstep+wall : cellstep*1.5;
colstep = (shape==0)? cellstep+wall-0.2 : cellstep * 0.74;
*/

// square or hexagonal; adjust to allow cells to overlap without intruding into the ring
rowstep =  cellstep+taper;
colstep = (shape==0)? cellstep+taper : (cellstep) * 0.907;

capwidth = colstep*cols+((shape==0)?taper:(cellstep*(1-0.907)*2)); // last cell is full size
caplength = rowstep * (rows-1);
center_offset = rows/2*rowstep + ((shape==0)? 0 : cellstep/2);


module ring()
{
    difference() {
        cylinder(d=ringd+wall*2, h=ringlen); // outside uniform diameter
        translate([0,0,bwall]) cylinder(d=ringd, h=ringwidth+eps);
        translate([0,0,bwall+ringwidth]) cylinder(d2=ringd+taper, d1=ringd, h=taperlen+eps);
    }
}

module cap() {
    translate([cellstep/2+taper,cellstep/2+taper,0])     // translate edge of first cell to origin
    union() {
        for (col=[0:cols-1]){
            for (row=[0:rows-1+(shape==1 && col%2==1?1:0)]){
                translate([col*colstep ,row*rowstep + shape*(1-col%2)*rowstep*0.5, 0])
                    ring();
            }
        }
    }
}

// attach on the right, attachment point at origin
module peg()
{
    // extend the peg into the ring and then subtract it out (rather than figuring out the tangent)
    difference() {
        translate([-peg_len, -peg_width/2,0]) cube([peg_len+wall+batdia/4, peg_width,  peg_height]);
        // groove
        translate([-peg_groove, -peg_width/2-eps,-eps]) cube([peg_groove, peg_width+eps*2, peg_groove_height+eps]);
        // inside wall
        translate([wall+batdia/2,0,-eps]) cylinder(h=peg_height+eps*2, d=batdia);
    }
    //%cube([0.1,10,10]);  // debug marker
}

if (anchor_style==0) {
    union() {
        straplen = bwall + strapslop + batlen ;
        cap();
        // strap
        translate([capwidth-eps, center_offset-strapwidth/2, 0]) 
            cube([straplen+eps*2, strapwidth, strapthickness]);
        translate([straplen+capwidth,0,0]) cap();
        // make a plate for attaching the strap; hidden if it's odd but make it anyway
        translate([0,center_offset,0]) {
            translate([capwidth-cellstep/2,0,0]) cylinder(d=cellstep,h=bwall);
            translate([straplen+capwidth+cellstep/2,0,0]) cylinder(d=cellstep,h=bwall);
        }
    }
}


if (anchor_style>0 && anchor_style<=2) {
    oddoffset = (cols%2==1)? 0 : rowstep/2;
    union() {
        // pegs on the 4 corners
        for (x=[0:1])
            for (y=[0:1])
                translate([x*capwidth, y*caplength+shape*cellstep/2, 0])  
                    translate([0,rowstep/2,0]) rotate([0,0,x*180]) 
                    translate([0,shape*x*(y%2==1?-1:1)*oddoffset,0]) peg();
        cap();
    }
}

if (anchor_style>=2 && anchor_style<=3) {
    straplen = bwall + batlen ; // don't use strapslop for attached straps
    holesize = peg_height - peg_groove_height+tol*2;
    translate([capwidth+colstep*2,rowstep/2,0]) 
    rotate([0,0,90]) // oops drew it in a non-ideal orientation
    difference() {
        cube([straplen, peg_width+wall*2+tol*2, strapthickness]);
        // stretch these holes over the pegs
        translate([peg_groove_height+tol, wall,-eps]) 
            cube([holesize+tol*2,peg_width+tol*2, strapthickness+tol*2] );
        translate([straplen-peg_height-tol, wall,-eps]) 
            cube([holesize+tol*2,peg_width+tol*2, strapthickness+tol*2] );
        
    }
}

if (anchor_style==4) cap();