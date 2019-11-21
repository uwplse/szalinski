// separator for 5-star chef food dehydrator
// the separator creates a spacer suitable for inserting filament rolls - for drying!
// by Andrew Davie (andrew@taswegian.com)


$fn=128;

//;  1        |hijk| 
//;  2        |hijk|      internal lip
//;  3 |abcdefghij|
//;  4 |abcdefghi|
//;  5 |abcdefgh|        slope v
//;  6 |abcdefg|
//;  7 |abcdefg|
//;  8 |abcdefg|         main body
//;  9 |abcdef|
//; 10 |abcde|
//; 11 |abcd|            slope^
//; 12 |abcd|            external lip
//; 13
//;  1        |hijk| 
//;  2        |hijk| 
//;  3 |abcdefghij|
//;  4 |abcdefghi|
//;  5 |abcdefgh|
//;  6 |abcdefg|

LEEWAY = 1.5;                   // gap @f
ICING = 0;                          // increase to thicken body
OUTER_DIAMETER = 241;               //@a
OUTER_INTERNAL_LIP = 234.5;         //@h
LIP_THICK = OUTER_DIAMETER - OUTER_INTERNAL_LIP - LEEWAY;       //@hijk OR abcd
TOTAL_THICKNESS = OUTER_DIAMETER - (OUTER_INTERNAL_LIP) + LIP_THICK + ICING;        //@abcdefghijk
BODY_THICKNESS = TOTAL_THICKNESS - 2;
LIP_HEIGHT = 15;      //@ 1-2
TOPLIP_HEIGHT = 10;
LIP_GAP = 0.4;         //@13
TOTAL_HEIGHT = 70;           //@1-12
SLOPE_HEIGHT = 10;
BODY_HEIGHT=TOTAL_HEIGHT - (2* (LIP_HEIGHT+LIP_GAP) );  // @6-8
INNER_DIAMETER = OUTER_DIAMETER-TOTAL_THICKNESS;

    difference(){

        // create total thickness object
        cylinder(d=OUTER_DIAMETER,h=TOTAL_HEIGHT);

        translate([0,0,-1]) {

            // cut out the interior
            cylinder(d=OUTER_DIAMETER - TOTAL_THICKNESS,h=TOTAL_HEIGHT+2);

            // carve out the bottom lip + gap
            cylinder(d=OUTER_INTERNAL_LIP+LEEWAY,h=LIP_HEIGHT+LIP_GAP+1);

            // carve out the mid-section body
            cylinder(d=OUTER_DIAMETER-BODY_THICKNESS,h=BODY_HEIGHT+1);

        }


        // carve out the upslope (@10--@8)
        translate([0,0,LIP_HEIGHT+LIP_GAP])
            cylinder(d1=OUTER_INTERNAL_LIP+LEEWAY,d2=OUTER_DIAMETER-BODY_THICKNESS,h=SLOPE_HEIGHT);

        // carve out upslope2
        translate([0,0,BODY_HEIGHT])
            cylinder(d1=OUTER_DIAMETER-BODY_THICKNESS,d2=OUTER_DIAMETER-TOTAL_THICKNESS,h=SLOPE_HEIGHT);


        // create upper lip
        translate([0,0,TOTAL_HEIGHT-TOPLIP_HEIGHT-LIP_GAP])
        difference(){
            cylinder(d=OUTER_DIAMETER+1,h=TOPLIP_HEIGHT+LIP_GAP+1);
            translate([0,0,-1])
                cylinder(d=OUTER_INTERNAL_LIP-LIP_GAP,h=TOPLIP_HEIGHT+LIP_GAP+2);
        }
    }
