// battery type
batterytype = 14; // [ 0:other, 14:AA, 10.5:AAA, 26.2:C, 34.2:D ]
// note: AA is 13.5-14.5
// diameter of battery if not from the list above
other_diameter = 14;

// gap between batteries
wall = 1; 
// rows in the matrix
rows = 3;
// columns in the matrix
cols = 3;
// square matrix or hexagonal 
shape = 1; // [ 0:square, 1:hexagonal ]

// extra diameter at the opening of the ring
taper = 0.8;
taperlen = 3;
ringwidth = 5;

/* [hidden] */
$fn = 60;
eps = 0.01;
ringd = batterytype==0 ? other_diameter : batterytype;
ringlen = taperlen*2 + ringwidth;

cellstep = ringd+wall-taper/2;
/*
rowstep = (shape==0)? cellstep+wall : cellstep*1.5;
colstep = (shape==0)? cellstep+wall-0.2 : cellstep * 0.74;
*/
rowstep =  cellstep+wall;
colstep = (shape==0)? cellstep+wall-0.2 : cellstep * 0.907;


module ring()
{
    difference() {
        cylinder(d=ringd+wall*2, h=ringlen); // outside uniform diameter
        translate([0,0,-eps]) cylinder(d1=ringd+taper, d2=ringd, h=taperlen+eps*2);
        translate([0,0,taperlen]) cylinder(d=ringd, h=ringwidth+eps);
        translate([0,0,taperlen+ringwidth]) cylinder(d2=ringd+taper, d1=ringd, h=taperlen+eps);
    }
}

union() {
    for (col=[1:cols]){
        for (row=[1:rows+(shape==1 && col%2==0?1:0)]){
            translate([col*colstep ,row*rowstep + shape*(col%2)*rowstep*0.5, 0]) ring();
        }
    }
}
