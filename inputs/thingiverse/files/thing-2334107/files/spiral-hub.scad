// by Martin Muehlhaeuser Twitter: @mediaing
// rev2: fixed missing path in vane profile
// rev3: exported root fillet parameter
// rev4: added bearing seat

/* [main parameters] */
// Maximum diameter of the hub in units. Make this 5-10% bigger than the largest spool bore for ideal tension.
maxDia = 58;
// Diameter of the center bore in units.

centerBoreDia = 8.3;
// Height by which the center ring is raised above the vanes in units.
centerExtrusion = 1; //[0:10]

/* [vanes] */
// Number of vanes.
vaneCount = 6;
// Vane width in X times extrusion width.
vaneWidth =  4;//[3:5]
// Height of the vanes in units.
vaneHeight = 6;
// The angle the vane extends to. To large and there is no room for compression of the spring left.
maxVaneAngle = 115;//[90:150]
// Fillet radius between the back of the vane and the hub. As x times vaneWidth.
filletRadiusScale = 1.4; //[1.0:0.1:4.0]

/* [rim] */
// Width of the rim 
rimWidth = 4; //[3:7]
// Rim height in X times layerHeight.
rimHeight = 4;//[2:6]
// Width of the rim segment in degrees.
rimAngularWidth = 50;//[30:90]

/* [bearing seat] */
addSeat = "no"; //[yes, no]
// Width of the seat ring in units.
seatWidth = 2;
// Height of the seat ring in X times layerHeight.
seatHeight = 4; //[2:6]

/* [printer Parameters] */
extrusionWidth = 0.4;
layerHeight = 0.3;
// circular resolution in segments per 360 Degrees.
resolution = 360;

/* [Hidden] */
rVane = ((maxDia - centerBoreDia) / 4);
rRim = rVane + rimWidth;
rimFilletRadius = rimWidth/2.5;
_vaneWidth = extrusionWidth * vaneWidth;
_rimHeight = layerHeight * rimHeight;
_seatHeight = layerHeight * seatHeight;

// rotate and instacnce children
module rotateCopy(deltaAngle = 4)
{
    children();
    rotate(deltaAngle, [0,0,1]) children();
}

// calculates a point on the circle at the specified angle and adds an offset length
function pointOnCircleOffset(radius=1, angle=0, circumferenceOffset=0) = (
     let(offsetAngle = (circumferenceOffset * 180 / ((radius-circumferenceOffset) * PI) ) )
     [sin(angle+offsetAngle) * (radius), cos(angle+offsetAngle) * (radius)]
);

// calculate a point on a circle
function pointOnCircle(radius=1, center=[0,0], angle) = (
     [sin(angle) * (radius) + center[0], cos(angle) * (radius) + center[1]]
);

// offset angle by length on circumference with given radius
function offsetAngle(baseAngle=0, radius=1, circumferenceOffset=0) = 
    (baseAngle + (circumferenceOffset * 180 / ((radius-circumferenceOffset) * PI)));

function ring(d1=1, d2=2, step=0.8) = concat (
    [[0, d2/2]],
    [for (a=[0:step:360]) pointOnCircle(d2/2, [0,0], a)],
    [[0, d2/2]],
    [[0, d1/2]],
    [for (a=[0:step:360]) pointOnCircle(d1/2, [0,0], a)],
    [[0, d1/2]]
);
    
// calculate position of the root fillet between vane and hub
function calcFilletCenter(a=5, b=12.5, c=17.5, fr=1) = (
    let(h = sqrt(-pow(a,4) + 2 * pow(a,2)*pow(b,2) + 2*pow(a,2)*pow(c,2)
                 - pow(b,4) + 2*pow(b,2)*pow(c,2) - pow(c,4)) / (2*c) )
    [-sqrt(pow(b,2) - pow(h,2)), h]
);

// create the vane profile
function vaneProfile(radius=1.0, maxAngle=120, width=5, step=0.8) = (
    let(maxVaneAngle = offsetAngle(maxAngle, radius-width/2, -width/2))
    let(roundoverCenter = pointOnCircleOffset(radius-width/2, maxAngle, -width/2))
    let(filletRadius = width*filletRadiusScale)
    let(filletCenter =
            calcFilletCenter(a=(centerBoreDia/2) + width + filletRadius,
            b=radius+filletRadius,
            c=radius + (centerBoreDia/2)),
            fr=filletRadius )
    let(maxFilletAngle = acos(filletCenter[1]/((centerBoreDia/2) + width +filletRadius)) )
    let(minFilletAngle = acos(filletCenter[1]/(radius+filletRadius)) )
    concat(
        [[-radius+width, 0], [-radius, 0]],
        [for (a=[90:-step:90-asin(filletCenter[1]/((centerBoreDia/2) + width +filletRadius))])
                                     pointOnCircle(centerBoreDia/2, [-radius-centerBoreDia/2,0], a) ],
        [for (a=[180+maxFilletAngle:-step:180-minFilletAngle])
                                     pointOnCircle(filletRadius, filletCenter, a)], // root fillet
        [for (a=[-90+asin(filletCenter[1]/(radius+filletRadius)):step:maxVaneAngle])
                                     pointOnCircle(radius, [0,0], a) ], // outer circle
        [for (a=[maxAngle:step:maxAngle+180]) pointOnCircle(width/2, roundoverCenter, a)], // radius
        [for (a=[maxVaneAngle:-step:-90]) pointOnCircle(radius-width, [0,0], a)] // inner circle
    )
);
 
// create the rim segmennt profile        
function rimProfile(radius=1.0, minAngle=80, maxAngle=120, rimWidth=45, vaneWidth=1, filletRadius=1, step=0.5) = (
    let(outerMinAngle = offsetAngle(minAngle, radius, filletRadius) )
    let(outerMaxAngle = offsetAngle(maxAngle, radius, -filletRadius) )
    let(innerFilletCenter = pointOnCircleOffset(radius-rimWidth+filletRadius, minAngle, -filletRadius))
    let(upperOuterFilletCenter = pointOnCircleOffset(radius-filletRadius, minAngle, filletRadius))
    let(lowerOuterFilletCenter = pointOnCircleOffset(radius-filletRadius, maxAngle, -filletRadius))

    concat(
        [pointOnCircleOffset(radius-rimWidth-vaneWidth/2, minAngle, -filletRadius) ],
        [for (a=[minAngle+180:-step:minAngle+90]) pointOnCircle(filletRadius, innerFilletCenter, a) ],
        [for (a=[minAngle-90:step:minAngle]) pointOnCircle(filletRadius, upperOuterFilletCenter, a) ],
        [for (a=[outerMinAngle:step:outerMaxAngle]) pointOnCircle(radius, [0,0], a) ],
        [for (a=[maxAngle:step:maxAngle+90]) pointOnCircle(filletRadius, lowerOuterFilletCenter, a) ],
        [pointOnCircle(radius-rimWidth-vaneWidth/2, [0,0], maxAngle )],
        [for (a=[outerMaxAngle:-step:outerMinAngle]) pointOnCircle(radius-rimWidth-vaneWidth/2, [0,0], a) ]
    )
);

module hub() {
    union() {
        difference() {
           cylinder(   h = vaneHeight + centerExtrusion,
                       d1 = centerBoreDia + _vaneWidth*2, d2 = centerBoreDia + _vaneWidth*2,
                      center = false, $fn = resolution);
           cylinder(   h = vaneHeight*4 + centerExtrusion,
                       d1 = centerBoreDia, d2 = centerBoreDia,
                       center = true, $fn = resolution);
        }
        if(addSeat == "yes") {
            linear_extrude(height=_seatHeight, center=false, $fn = resolution)
                polygon(points = ring(d1=centerBoreDia, d2=centerBoreDia-2*seatWidth, step=360/resolution));
        }
        for(i=[1:1:vaneCount]) {
            rotateCopy(i*(360/vaneCount))
            
                translate([rVane + centerBoreDia/2, 0,0]) {
                        
                    linear_extrude(height=vaneHeight, center=false, $fn = resolution)
                        polygon(points = vaneProfile(radius = rVane,
                                                     maxAngle=maxVaneAngle,
                                                     width=_vaneWidth,
                                                     step=360/resolution));
                        
                    linear_extrude(height=_rimHeight, center=false, $fn = resolution)
                        polygon(points = rimProfile(
                                                radius = rRim,
                                                minAngle=maxVaneAngle-rimAngularWidth,
                                                maxAngle=maxVaneAngle,
                                                rimWidth=rimWidth,
                                                _vaneWidth=_vaneWidth,
                                                filletRadius=rimFilletRadius,
                                                step=360/resolution
                                        )
                        );
                }
           }
    }
}

hub();
