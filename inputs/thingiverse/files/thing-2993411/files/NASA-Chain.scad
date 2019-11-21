// inspired by https://www.thingiverse.com/thing:2437081/files

/* [Overall Size] */
xcount = 4;
ycount = 4;
plateSize = 15;
plateGap = .5;
platethick = 2;

/* [Ring Parameters] */

ringAxialThick = 1;
ringRadialThick = 1;
ringDiameter = 13;
ringSectionFn = 8;
ringExtrudeFn = 12;

/* [Ring placement] */
// Positive values raise the ring. This can help clear intersections with adjacent plates, or fix the condition where the ring extends vertically below the plate.
ringVerticalOffset = 0;
// lower values position the rings more vertically.
ringTilt = 35;
// positive values postition the rings closer to the center of the plate. This can help clear intersections with adjacent plates.
ringLinkOffset = 1.6;

/* [Plate Bevel] */
// zero for no bevel
bevelAngle = 45;
// height at which the bevel starts. 
bevelHeight = 1;

// calculated constants
ringOverallHeight = (ringDiameter + ringRadialThick*2) * cos(ringTilt) + ringAxialThick*sin(ringTilt);

module ring() {
rotate(ringTilt, [0,1,0])
rotate(90, [0,1,0])    
rotate_extrude($fn=ringExtrudeFn)
translate([ringDiameter/2,0,0])
scale([ringRadialThick,ringAxialThick, 1 ])
circle(1, $fn=ringSectionFn);
}
    
module xRing() {
    translate([plateSize/2,ringDiameter/4-plateGap/2+ringLinkOffset,ringOverallHeight/2+ringVerticalOffset])
     ring();
}

function hypot(a,b)=sqrt(a*a+b*b);

for(x=[0:xcount-1]) for(y=[0:ycount-1]) translate([x*(plateSize+plateGap), y*(plateSize+plateGap), 0]) 
{
    difference() {
        cube([plateSize, plateSize, platethick]);
        if(bevelAngle!=0) 
          for(theta=[0:90:270])
          translate([plateSize/2,plateSize/2, 0]) rotate(theta, [0,0,1]) translate([-plateSize/2,-plateSize/2, 0])
          plateBevel();
    }
    
    for(theta=[0:90:270])
    translate([plateSize/2,plateSize/2, 0]) rotate(theta, [0,0,1]) translate([-plateSize/2,-plateSize/2, 0])
    xRing();

zz = plateSize/2 - ringDiameter/4-plateGap/2+ringLinkOffset;

translate([plateSize/2, plateSize/2,ringOverallHeight/2+ringVerticalOffset+ringDiameter/2*cos(ringTilt)])    
rotate_extrude($fn=ringExtrudeFn)
translate([hypot(zz,ringDiameter/2*sin(ringTilt)),0,0])
circle(
    hypot(ringRadialThick*cos(ringTilt), ringAxialThick*sin(ringTilt)),
    $fn = ringSectionFn
    );
    
}


module plateBevel() {
    rotate(-90, [1,0,0])
    translate([0,0,-plateSize/2])
    linear_extrude(plateSize*2)
    polygon([
    [-platethick*2 * tan(bevelAngle), platethick*2 -bevelHeight],
    [platethick*2 * tan(bevelAngle), -platethick*2 - bevelHeight],
    [-platethick*2 * tan(bevelAngle), -platethick*2 - bevelHeight],
    ]);
}
 
