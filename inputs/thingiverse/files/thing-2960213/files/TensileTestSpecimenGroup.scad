/*
====================================================================
=====  Test specimens for determination of tensile properties  =====
=====    according to EN ISO 527-2:1996/2012,                  =====
=====    and ASTM D638-03/14							       =====
=====										                   =====
=====  by Chris Cox, March 2018                                =====
====================================================================

See also ISO 20753 - multipurpose test specimen
Useful Information: http://www.zwick.be/fileadmin/content/testXpo/Vortraege/2014/Vortraege/Zwick_Helmut_Fahrenholz_ISO527_eng.pdf


TODO - see about diagonal supports

TODO - ASTM D638−14 rod samples (make new file)
    can't find matching ISO specification for rods
*/


//CUSTOMIZER VARIABLES

// Sample type
sampleIndex = 1;	// [ 0:ISO 527-2 1A, 1:ISO 527-2 1B, 2:ISO 527-2 1BA, 3:ISO 527-2 1BB, 4:ISO 527-2 5A, 5:ISO 527-2 5B, 6:ASTM D638-14 Type I, 7:ASTM D638-14 Type II, 8:ASTM D638-14 Type III, 9:ASTM D638-14 Type IV 10:ASTM D638-14 Type V ]

// Vertical or Horizontal layout
isVertical = 0;       // [0:Horizontal, 1:Vertical]

// Single specimen or group?
singleSample = 0;       // [0:Group, 1:Single]

// Printer model
printerIndex = 10;	// [ 0:Wanhao D7, 1:Peopoly Moai, 2:FormLabs Form1, 3:FormLabs Form2, 4:XYZ Nobel1, 5:B9 Creator, 6:3DSystems Projet 1200, 7:AnyCubic Photon, 8:Phrozen Make, 9:Uniz Slash, 10:Generic I3 FDM, 11:User Defined ]

// Rotate printer bed 90 degrees, boolean
rotateBed = 0;       // [0:false, 1:true]

// Separation between specimens, in mm
separation = 3;    // [1.0:0.1:50.0] 
// 3 seems smallest reasonable value with supports, 20 seems like practical upper limit

// Include supports for vertical group, boolean
makeSupports = 1;       // [0:false, 1:true]

// Diameter of support rods, in mm
supportDiameter = 0.8;   // [0.2:0.1:10.0]

// Separation of Z support rods, in mm
supportSpacingZ = 8.0;   // [3:1:50]
// 5 probably practical lower limit, 15 seems practical upper limit, want dense on FEP machines

// Diameter of Z support rods, in mm
supportDiameterZ = 1.5;   // [1:0.1:10]

// Use a fence around vertical specimens, boolean
useFence = 0;   // [0:false, 1:true]
// should this be tied to makeSupports?

// thickness of fence, in mm
fenceThickness = 1.5;      // [0.5:0.1:5.0]

// Exterior edge of the bed to avoid, in mm
bedEdgeMargin = 5;   // [0:1:50]

// user defined bed size X, in mm
userBedX = 100; // [ 20: 1 : 1000 ]

// user defined bed size Y, in mm
userBedY = 50; // [ 20: 1 : 1000 ]

// user defined bed size Z, in mm
userBedZ = 180; // [ 100: 1 : 1500 ]

// show more debugging info and geometry, boolean
debugBed = 0;       // [0:false, 1:true]

//CUSTOMIZER VARIABLES END



// ref: https://all3dp.com/1/best-resin-dlp-sla-3d-printer-kit-stereolithography/
// plus maker's webpages

// bed size, name
printerModels = [
//  [ [  X,   Y,   Z], "name" ],
    [ [120,  70, 180], "Wanhao D7" ],       // 0
    [ [130, 130, 180], "Peopoly Moai" ],
    [ [125, 125, 165], "Formlabs Form1" ],
    [ [145, 145, 175], "Formlabs Form2" ],
    [ [125, 125, 190], "XYZ Nobel1" ],
    [ [104,  75, 200], "B9 Creator" ],      // 5
    [ [ 43,  27, 150], "3DSystems Projet 1200" ],
    [ [115,  65, 155], "AnyCubic Photon" ],
    [ [120,  68, 140], "Phrozen Make" ],
    [ [192, 120, 200], "Uniz Slash" ],
    [ [200, 200, 180], "Generic I3 FDM" ],      // 10
    [ [userBedX, userBedY, userBedZ], "User Defined" ],      // 11
];

// define the bed, choose to flip coordinates
bed = (rotateBed == 0) ? printerModels[printerIndex][0] : [ printerModels[printerIndex][0][1], printerModels[printerIndex][0][0], printerModels[printerIndex][0][2] ];

// Fake print bed for debugging
if (debugBed != 0) {
    echo("Rendering bed ", printerModels[printerIndex][1], bed, "rotation ", rotateBed );
    #cube([bed[0],bed[1],0.001], center=true );
    #translate([0,bed[1]/2,bed[2]/2])
       cube([bed[0],0.001,bed[2]], center=true );
}


/*
Notes on circle diameter smoothness
    atan gives the same result as asin for large radii, as adjacent and hypot approach equality

hypot = radius, opposite = facet_len/2
facet_len/2 = radius*sin(360/2N);
facet_len/(2*radius) = sin(180/N);
asin(facet_len/(2*radius)) = 180/N;
N = 180/asin(facet_len/(2*radius));

module circle_segments( radius, facet_len )
{ echo("r = ", radius," N = ", 180/asin(facet_len/(2*radius)) ); }

circle_segments( 76, 1.0 );
circle_segments( 60, 1.0 );
circle_segments( 30, 1.0 );
circle_segments( 24, 1.0 );
circle_segments( 14, 1.0 );
circle_segments( 12, 1.0 );
circle_segments( 8, 1.0 );
circle_segments( 3, 1.0 );
*/

test_specimens = [
//  [ [   l1,    l2,    l3,   L0,     L,   b1,   b2,   h,   r,    r2, $fn ], "name" ],
    [ [ 80.0, 109.3, 170.0, 75.0, 115.0, 10.0, 20.0, 4.0, 24.0,  0.0, 150 ], "ISO 527-2 1A" ],   // EN ISO 527-2:1996-2012 1A
    [ [ 60.0, 108.0, 150.0, 50.0, 115.0, 10.0, 20.0, 4.0, 60.0,  0.0, 375 ], "ISO 527-2 1B" ],   // EN ISO 527-2:1996-2012 1B
    [ [ 30.0,  58.0,  75.0, 25.0,  60.0,  5.0, 10.0, 2.0, 30.0,  0.0, 200 ], "ISO 527-2 1BA" ],  // EN ISO 527-2:1996-2012 1BA
    [ [ 12.0,  23.0,  30.0, 10.0,  24.0,  2.0,  4.0, 2.0, 12.0,  0.0, 100 ], "ISO 527-2 1BB" ],  // EN ISO 527-2:1996-2012 1BB
    [ [ 25.0,  50.0,  75.0, 20.0,  50.0,  4.0, 12.5, 2.0,  8.0, 12.5, 100 ], "ISO 527-2 5A" ],  // EN ISO 527-2:1996-2012 5A
    [ [ 12.0, 20.95,  35.0, 10.0, 20.95,  2.0,  6.0, 1.0,  3.0,  3.0, 100 ], "ISO 527-2 5B" ],  // EN ISO 527-2:1996-2012 5B
 
 // using the given mm measures instead of inches for ASTM samples
    [ [ 57.0, 115.0, 165.0, 50.0, 115.0, 13.0, 19.0, 3.2, 76.0,  0.0, 475 ], "ASTM D638-14 Type I" ],
    [ [ 57.0, 135.0, 183.0, 50.0, 135.0,  6.0, 19.0, 3.2, 76.0,  0.0, 475 ], "ASTM D638-14 Type II" ],
    [ [ 57.0, 115.0, 246.0, 50.0, 115.0, 19.0, 29.0, 3.2, 76.0,  0.0, 475 ], "ASTM D638-14 Type III" ],
 // [ [ 33.0,  65.0, 115.0, 25.0,  65.0,  6.0, 19.0, 3.2, 14.0, 25.0, 150 ], "ASTM D638-14 Type IV" ],  // as given in spec, the curves do not fit
    [ [ 33.0,  76.0, 115.0, 25.0,  76.0,  6.0, 19.0, 3.2, 14.0, 25.0, 150 ], "ASTM D638-14 Type IV" ],  // corrected so curves fit
    [ [ 9.53,  25.4,  63.5, 7.62,  25.4, 3.18, 9.53, 3.2, 12.7,  0.0, 100 ], "ASTM D638-14 Type V" ],
];

// render the desired specimen
echo("Rendering specimen ", test_specimens[sampleIndex][1] );

if (singleSample == 1) {
    test_core (
        l1 = test_specimens[sampleIndex][0][0],
        l2 = test_specimens[sampleIndex][0][1],
        l3 = test_specimens[sampleIndex][0][2],
        L0 = test_specimens[sampleIndex][0][3],
        L  = test_specimens[sampleIndex][0][4],
        b1 = test_specimens[sampleIndex][0][5],
        b2 = test_specimens[sampleIndex][0][6],
        h  = test_specimens[sampleIndex][0][7],
        r  = test_specimens[sampleIndex][0][8],
        r2 = test_specimens[sampleIndex][0][9],
        smoothness=test_specimens[sampleIndex][0][10]
        );
} else if (isVertical == 0) {
    test_group_horizontal (
        l1 = test_specimens[sampleIndex][0][0],
        l2 = test_specimens[sampleIndex][0][1],
        l3 = test_specimens[sampleIndex][0][2],
        L0 = test_specimens[sampleIndex][0][3],
        L  = test_specimens[sampleIndex][0][4],
        b1 = test_specimens[sampleIndex][0][5],
        b2 = test_specimens[sampleIndex][0][6],
        h  = test_specimens[sampleIndex][0][7],
        r  = test_specimens[sampleIndex][0][8],
        r2 = test_specimens[sampleIndex][0][9],
        smoothness=test_specimens[sampleIndex][0][10]
        );
} else {
    test_group_vertical (
        l1 = test_specimens[sampleIndex][0][0],
        l2 = test_specimens[sampleIndex][0][1],
        l3 = test_specimens[sampleIndex][0][2],
        L0 = test_specimens[sampleIndex][0][3],
        L  = test_specimens[sampleIndex][0][4],
        b1 = test_specimens[sampleIndex][0][5],
        b2 = test_specimens[sampleIndex][0][6],
        h  = test_specimens[sampleIndex][0][7],
        r  = test_specimens[sampleIndex][0][8],
        r2 = test_specimens[sampleIndex][0][9],
        smoothness=test_specimens[sampleIndex][0][10]
        );
}


// This creates a group of vertical specimens to fill the bed,
// plus optional support between specimens.
    // TODO - diagonal bracing? hard part is knowing where to end it
module test_group_vertical(l1,l2,l3,L0,L,b1,b2,h,r,r2,smoothness)
{
    // Sanity checks
    if( l3 > bed[2] || h > bed[1] || b2 > bed[0] ) {
        echo("<B>Error: Single specimen will not fit in printer!</B>");
    }
    
    supportDiameter = (supportDiameter > h) ? h : supportDiameter;
    
    if (supportDiameter > separation) {
        echo("<B>Error: Supports won't fit!</B>");
    }

    supportRadius = supportDiameter/2;
    supportRadiusZ = supportDiameterZ/2;
    
    begin_x = -(bed[0]/2) + bedEdgeMargin + (b2/2) + ((useFence)?fenceThickness+separation:0);
    end_x = (bed[0]/2) - bedEdgeMargin - (b2/2) - ((useFence)?fenceThickness+separation:0);
    begin_y = -(bed[1]/2) + bedEdgeMargin + (h/2) + ((useFence)?fenceThickness+separation:0);
    end_y = (bed[1]/2) - bedEdgeMargin - (h/2) - ((useFence)?fenceThickness+separation:0);
    
    xStep = b2 + separation;
    yStep = h + separation;
    
    tempX = floor( (end_x - begin_x + xStep) / xStep );
    tempY = floor( (end_y - begin_y + yStep) / yStep );
    countTotal = tempX * tempY;
    echo("Fit ", countTotal, " specimens as ", tempX, tempY );
    
    for (m = [ begin_x: xStep : end_x ]) {
        for (k = [ begin_y: yStep : end_y ]) {
            translate([m,k,(l3/2)])
              rotate([90,90,0])
                test_core(l1,l2,l3,L0,L,b1,b2,h,r,r2,smoothness);
        }
    }

    // Optional surrounding fence to minimize disturbance with FEP peeling
    // This does make support removal more challenging!
    fence_length_x = tempX*xStep + 2*separation;
    fence_length_y = tempY*yStep + 2*separation;
    fence_start_x = begin_x - (b2/2) - separation - fenceThickness;
    fence_start_y = begin_y - h - separation - fenceThickness;
    fence_end_x = fence_start_x + fence_length_x - fenceThickness;
    fence_end_y = fence_start_y + fence_length_y - fenceThickness;
    if (useFence) {
        color ("Red", 0.20)       // make it transparent so we can see the samples and supports
        difference() {
            union() {
            translate([fence_start_x,fence_start_y,0])
               cube([fenceThickness,fence_length_y,l3] );
            translate([fence_end_x,fence_start_y,0])
               cube([fenceThickness,fence_length_y,l3] );
            translate([fence_start_x,fence_start_y,0])
               cube([fence_length_x,fenceThickness,l3] );
            translate([fence_start_x,fence_end_y,0])
               cube([fence_length_x,fenceThickness,l3] );
            }
            
            // drain/air holes!  very important for SLA printing!
            color("blue") {
                drainWidth = 2;     // wide enough that overexposure won't fill it in, can still drain
                drainHeight = 3;    // high enough that it won't get compressed out in first layers
                drainOverlap = 1;   // to make sure it cuts through
                translate([fence_start_x+fenceThickness,fence_start_y-drainOverlap,0])
                   cube([drainWidth,fenceThickness+2*drainOverlap,drainHeight] );
                translate([fence_end_x-drainWidth,fence_start_y-drainOverlap,0])
                   cube([drainWidth,fenceThickness+2*drainOverlap,drainHeight] );
                translate([fence_start_x+fenceThickness,fence_end_y-drainOverlap,0])
                   cube([drainWidth,fenceThickness+2*drainOverlap,drainHeight] );
                translate([fence_end_x-drainWidth,fence_end_y-drainOverlap,0])
                   cube([drainWidth,fenceThickness+2*drainOverlap,drainHeight] );
            }
        }
    }
    
    if (makeSupports) {
        // x axis supports
        countX = floor( (end_x - begin_x) / xStep );
        supportLenX = (useFence) ? fence_length_x : ((countX) * xStep);
        start_x = (useFence) ? fence_start_x : begin_x;
        
        if (countX > 0)
        difference() {
            for (z = [ 0: supportSpacingZ : l3-supportRadius ]) {
                for (k = [ begin_y: yStep : end_y ]) {
                    translate([start_x,k-(h/2),z])
                      rotate([0,90,0])
                        cylinder( supportLenX, supportRadius, supportRadius, $fn=8 );
                }
            }
        
            // clip below ground
            translate([0,0,-2])
                cube([bed[0]+2,bed[1]+2,4], center=true );
        }
        
        // y axis supports
        countY = floor( (end_y - begin_y) / yStep );
        supportLenY = (useFence) ? fence_length_y : ((countY) * yStep);
        start_y = (useFence) ? fence_start_y : (begin_y-(h/2));
        xSpace = (b2+separation)/2;
        
        if (countY > 0)
        difference() {
            for (z = [ 0: supportSpacingZ : l3-supportRadius ]) {
                for (x = [ begin_x: xStep : (end_x-xStep) ]) {
                    xpos = x + xSpace;
                    translate([xpos,start_y,z])
                      rotate([-90,0,0])
                       cylinder( supportLenY, supportRadius, supportRadius, $fn=8 );
                }
            }
        
            // clip below ground
            translate([0,0,-2])
                cube([bed[0]+2,bed[1]+2,4], center=true );
        }
        
        // z axis supports
        if (separation > 5) {
            countZ = floor( (l3-supportRadius) / supportSpacingZ  );
            supportLenZ = (countZ) * supportSpacingZ + supportRadius;
            baseRadius = min( separation/3, 5 );
            for (x = [ begin_x: xStep : (end_x-xStep) ]) {
                for (y = [ begin_y: yStep : end_y ]) {
                    xpos = x+xSpace;
                    translate([xpos,y-(h/2),0])
                       cylinder( supportLenZ, supportRadiusZ, supportRadiusZ, $fn=8 );
                    translate([xpos,y-(h/2),0])
                       cylinder( 5, baseRadius, supportRadiusZ );
                }
            }
        }   // end if separation
    
    }   // end if makeSupports

}   // end module test_group_vertical



// This creates a group of horizontal specimens to fill the bed, for larger printers
module test_group_horizontal(l1,l2,l3,L0,L,b1,b2,h,r,r2,smoothness)
{
    // Sanity checks
    if( l3 > bed[0] || h > bed[2] || b2 > bed[1] ) {
        echo("<B>Error: Single specimen will not fit in printer!</B>");
    }
    
    begin_x = -(bed[0]/2) + bedEdgeMargin + (l3/2);
    end_x = (bed[0]/2) - bedEdgeMargin - (l3/2);
    begin_y = -(bed[1]/2) + bedEdgeMargin + (b2/2);
    end_y = (bed[1]/2) - bedEdgeMargin - (b2/2);
    
    xStep = l3 + separation;
    yStep = b2 + separation;
    
    tempX = floor( (end_x - begin_x + xStep) / xStep );
    tempY = floor( (end_y - begin_y + yStep) / yStep );
    countTotal = tempX * tempY;
    echo("Fit ", countTotal, " specimens as ", tempX, tempY );
    
    for (m = [ begin_x: xStep : end_x ]) {
        for (k = [ begin_y: yStep : end_y ]) {
            translate([m,k,0])
                test_core(l1,l2,l3,L0,L,b1,b2,h,r,r2,smoothness);
        }
    }
    
    
    // Try to use leftover space to fit a few more rotated samples
    end_x2 = (bed[0]/2) - bedEdgeMargin - (b2/2);
    end_y2 = (bed[1]/2) - bedEdgeMargin - (l3/2);
    leftoverX = begin_x + (tempX-1)*xStep + (l3/2) + separation + (b2/2);
    leftoverY = begin_y - (b2/2) + (l3/2);
    
    tempX2 = floor( (end_x2 - leftoverX + yStep) / yStep );
    tempY2 = floor( (end_y2 - leftoverY + xStep) / xStep );
    countTotal2 = tempX2 * tempY2;
    echo("Fit leftover ", countTotal2, " specimens as ", tempX2, tempY2 );
    
    for (m = [ leftoverX: yStep : end_x2 ]) {
        for (k = [ leftoverY: xStep : end_y2 ]) {
            translate([m,k,0])
                rotate([0,0,90])
                    test_core(l1,l2,l3,L0,L,b1,b2,h,r,r2,smoothness);
        }
    }
    
}   // end module test_group_horizontal


/*
====================================================================
=====  Altered from https://www.thingiverse.com/thing:190386   =====
=====       Author: Jumpmobile, Date: 25.11.2013			   =====
=====                                                          =====
=====  Updated and Extended by Chris Cox, March 2018           =====
====================================================================
*/

// this creates a single test specimen
module test_core(l1,l2,l3,L0,L,b1,b2,h,r,r2,smoothness)
{
    // double check order of values
    if( b1 > b2 || L0 > l1 || l1 > l2 || l2 > L || L > l3 ) {
        echo("<B>Error: Parameters don't work!</B>");
    }

    l4 = (l3-l1) / 2;

    linear_extrude(height=h)
        difference() {
            union() {
                square([l3,b1],center=true);
                
                if (r2 > 0.0) {
                    // r2 does not always guarantee contact with r1, and needs to be modified
                    center1 = [l1/2,r+b1/2];
                    center2 = [l2/2,b2/2-r2];
                    line = center2 - center1;
                    dist = sqrt(line[0]*line[0] + line[1]*line[1]);
                    r2_revised = dist - r;
                    //echo( "r = ", r, " ; r2 = ", r2, " ; r2_revised = ", r2_revised );
                    slope = line / dist;
                    intercept = center1 + slope*r;  // echo( "intercept = ", intercept );
                    //intercept2 = center2 - slope*r2_revised;    echo( "intercept2 = ", intercept2 );
                    
                    // double radius case
                    l5 = (l3 - L) / 2;
                    ww = intercept[0]-l1/2;
                    translate([l1/2+ww/2,0])
                        square([ww,intercept[1]*2],center=true);
                    translate([-l1/2-ww/2,0])
                        square([ww,intercept[1]*2],center=true);
                    w2 = (l3 - l2)/2;
                    p2 = (l3 - w2)/2;
                    translate([p2,0])
                        square([w2,b2],center=true);
                    translate([-p2,0])
                        square([w2,b2],center=true);

  // parameters: L, b2, r2, r2_revised, smoothness, p2, w2, l3
  // could also use mirror operator instead of explicit translates, still needs a sub-function
                    difference() {
                        translate([L/2,b2/2-r2])
                            circle(r=r2_revised, center=true, $fn=smoothness);
                        translate([p2,0])
                            square([w2,r2_revised*4],center=true);
                        translate([0,-r2_revised*4+1])
                            square([l3,r2_revised*4]);
                    }
                    difference() {
                        translate([-L/2,b2/2-r2])
                            circle(r=r2_revised, center=true, $fn=smoothness);
                        translate([-p2,0])
                            square([w2,r2_revised*4],center=true);
                        translate([-l3,-r2_revised*4+1])
                            square([l3,r2_revised*4]);
                    }
                    difference() {
                        translate([L/2,-b2/2+r2])
                            circle(r=r2_revised, center=true, $fn=smoothness);
                        translate([p2,-r2_revised*4])
                            square([w2,r2_revised*4],center=true);
                        translate([0,-1])
                            square([l3,r2_revised*4]);
                    }
                    difference() {
                        translate([-L/2,-b2/2+r2])
                            circle(r=r2_revised, center=true, $fn=smoothness);
                        translate([-p2,-r2_revised*4])
                            square([w2,r2_revised*4],center=true);
                        translate([-l3,-1])
                            square([l3,r2_revised*4]);
                    }
                } else {
                    // much simpler single radius case
                    translate([(l3-l4)/2,0])
                        square([l4,b2],center=true);
                    translate([-(l3-l4)/2,0])
                        square([l4,b2],center=true);
                }
            
            }   // end union

            // this is the same for single or double radius case
            translate([l1/2,-r-b1/2])
                circle(r=r, center=true, $fn=smoothness);
            translate([-l1/2,-r-b1/2])
                circle(r=r, center=true, $fn=smoothness);
            translate([l1/2,r+b1/2])
                circle(r=r,center=true, $fn=smoothness);
            translate([-l1/2,r+b1/2])
                circle(r=r, center=true, $fn=smoothness);

        }   // end difference
 
}   // end test_core

