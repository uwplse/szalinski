use <naca4.scad>;  // https://www.thingiverse.com/thing:898554

//
// list/vector utility functions
//

//echo("test.subList.forward", subList([0,1,2,3,4], 1, 3) == [1,2,3]);
//echo("test.subList.negativeEnd", subList([0,1,2,3,4], 2, -1) == [2,3,4]);
//echo("test.subList.negativeStartAndEnd", subList([0,1,2,3,4], -1, -2) == [4,3]);
function subList(list,begin=0,end=-1) = [
    let(begin=begin<0?len(list)+begin:begin, end=end<0?len(list)+end:end)
    let(step=begin<end?1:-1)
    for(i=[begin:step:end])
    list[i]
];

//echo("test.sumList", sumList([0,1,2,3]) == 6);
function sumList(l) = len(l) == 0 ? 0 : (l[0] + (l[1] ? sumList(subList(l, 1, -1)) : 0));

//echo("test.reverseList", reverseList([0,1,2]) == [2,1,0]);
function reverseList(l) = [for(i=[len(l)-1:-1:0]) l[i]];


//
// transformations
//

//echo("test.affineTransform.min", affineTransform(0, 10, 0, 100, 0) == 0);
//echo("test.affineTransform.max", affineTransform(0, 10, 0, 100, 10) == 100);
//echo("test.affineTransform.center", affineTransform(0, 10, 0, 100, 5) == 50);
function affineTransform(startMin, startMax, endMin, endMax, value) = 
    let(
        startSize = startMax - startMin,
        endSize = endMax - endMin
    )
    let(factor = (value - startMin)/startSize)
    endMin + endSize * factor;

function rotateVector3Z(v, angle) =
    let(
        s = sin(angle), c = cos(angle),
        m = [
            [c, -s, 0],
            [s, c, 0],
            [0, 0, 1]
        ]
    )
    m * v;


//
// airfoil math functions
//

Pi = 3.14159265359;
function pitchAngleAtRadius(pitch, radius) = atan(pitch/(2*Pi*radius));
function chordLengthForAngleAndHeight(angle, height) = height/sin(angle);


//
// polyhedron utility functions
//
function traingleFacesFromPlanarPointIndices(indices, ccw=false) =
    [for(faceList=[
        for(j=[0:1:floor(len(indices)/2)])
        let(
            a=indices[j],
            b=indices[j+1],
            c=indices[len(indices)-1-j],
            d=indices[len(indices)-2-j]
        )
        [
            ccw ? [a,b,c] : [a,c,b],
            ccw ? [b,d,c] : [b,c,d]
        ]
    ], face=faceList) face];


//
// structures
//

// convenience function for creating homogenous vectors
function airfoilLoftSegment(
    position=0,
    naca=12,
    chord=100,
    offset=[0,0,0],
    angle=0
) = [position, naca, chord, offset, angle];


//
// extrapolation
//

// extrapolate out one new head and tail value and return the new vector (length = len(original) + 2)
function extrapolateHeadAndTail(l) =
    let(j=len(l)-1)
    concat(
        [l[0] - (l[1]-l[0])],
        l,
        [l[j] + (l[j]-l[j-1])]
    );


//
// interpolation
//

function interpolateCubicUnit(aValue, bValue, aTangent, bTangent, t) =
    let(t3=pow(t,3), t2=pow(t,2))
    (2*t3 - 3*t2 + 1)*aValue + (t3 - t2 + t)*aTangent + (-2*t3 + 3*t2)*bValue + (t3 - t2)*bTangent;
function getCardinalSplineTangentAtIndex(positions, valueVectors, i, tension=0) =
    let(
        p1=positions[i-1], p2=positions[i], p3=positions[i+1],
        t1=valueVectors[i-1], t2=valueVectors[i], t3=valueVectors[i+1],
        p = p1 ? [p1, p2] : [p2, p3],
        t = t1 ? [t1, t2] : [t2, t3],
        divisor=t[1] - t[0]
    )
    [for(j=[0:1:len(t[0])-1]) divisor[j] == 0 ? 0 : (1-tension)*( (p[1] - p[0]) / divisor[j] )];
function getFiniteDifferenceSplineTangentAtIndex(positions, valueVectors, i) =
    let(
        pl=extrapolateHeadAndTail(positions),
        tl=extrapolateHeadAndTail(valueVectors),
        k=i+1,
        p1=pl[k-1], p2=pl[k], p3=pl[k+1],
        t1=tl[k-1], t2=tl[k], t3=tl[k+1]
    )
    0.5 * ( (p3-p2)/(t3-t2) + (p2-p1)/(t2-t1) );
function getActiveSegmentIndicesAtT(segments, t) =
    let(
        lowers=[for(i=[0:1:len(segments)-1]) let(s=segments[i], position=s[0]) if(t>=position) i],
        uppers=[for(i=[0:1:len(segments)-1]) let(s=segments[i], position=s[0]) if(t<=position) i],
        lower=lowers[len(lowers)-1],
        upper=uppers[0]
    )
    [lower?lower:0, upper?upper:len(segments)-1];
function interpolateLinearValue(segments, positions, values, t) =
    let(
        activeIndices=getActiveSegmentIndicesAtT(segments, t),
        activePositions=[for(i=activeIndices) positions[i]],
        activeValues=[for(i=activeIndices) values[i]]
    )
    activeValues[0] == activeValues[1] ? activeValues[0] : affineTransform(activePositions[0], activePositions[1], activeValues[0], activeValues[1], t);
function interpolateCubicValue(segments, positions, values, t) =
    let(
        activeIndices=getActiveSegmentIndicesAtT(segments, t),
        activePositions=[for(i=activeIndices) positions[i]],
        activeValues=[for(i=activeIndices) values[i]],
        tangents=[for(i=activeIndices) getFiniteDifferenceSplineTangentAtIndex(positions, values, i)],
        virtualT=affineTransform(activePositions[0], activePositions[1], 0, 1, t)
    )
    activeValues[0] == activeValues[1] ? activeValues[0] : interpolateCubicUnit(activeValues[0], activeValues[1], tangents[0], tangents[1], virtualT);


//
// specific value interpolation
//

function interpolateNaca(segments, t) =
        let(
            positions=[for(s=segments) s[0]],
            values=[for(s=segments) let(naca=s[1]) len(naca)==3?naca:NACA(naca)], // naca
            valueSets=[for(j=[0:1:len(values[0])-1]) [for(i=[0:1:len(values)-1]) [values[i][j]]]]
        )
        [for(valueSet=valueSets) interpolateLinearValue(segments, positions, valueSet, t)[0]];
function interpolateChord(segments, t) =
        let(
            positions=[for(s=segments) s[0]],
            values=[for(s=segments) [s[2]]]  // chord
        )
        interpolateLinearValue(segments, positions, values, t)[0];
function interpolateOffset(segments, t) =
        let(
            positions=[for(s=segments) s[0]],
            values=[for(s=segments) s[3]]  // offset
        )
        interpolateLinearValue(segments, positions, values, t);
function interpolateAngle(segments, t) =
        let(
            positions=[for(s=segments) s[0]],
            values=[for(s=segments) [s[4]]]  // angle
        )
        interpolateLinearValue(segments, positions, values, t)[0];


//
// main module
//

module airfoilLoft(
    segments,
    span=100,
    nacaSampleCount=81,
    open=true,
    step=undef
) {
    step = step == undef ? $fs : step;
    pointSets = [for(z=[0:step:span])
        let(
            t=z/span,
            naca=interpolateNaca(segments, t),
            chord=interpolateChord(segments, t),
            offset=interpolateOffset(segments, t),
            angle=interpolateAngle(segments, t)
        )
        [for(p=airfoil_data(naca=naca, L=chord, N=nacaSampleCount, open=open)) rotateVector3Z([p[0], p[1], z], angle)+offset]
    ];
    points = [for(pointSet=pointSets, point=pointSet) point];
    pointIndices = [for(i=[0:1:len(points)-1]) i];
    pointSetPairs = [for(i=[0:1:len(pointSets)-2]) [pointSets[i], pointSets[i+1]]];
    startCapPointIndices = subList(pointIndices, 0, nacaSampleCount-1);
    endCapPointIndices = subList(pointIndices, -nacaSampleCount, -1);
    faces = concat(
        // endcaps
        traingleFacesFromPlanarPointIndices(startCapPointIndices),
        traingleFacesFromPlanarPointIndices(endCapPointIndices, ccw=true),
        // curve
        [for(faceList=[
            for(j=[0:1:len(pointSetPairs)-1], i=[0:1:nacaSampleCount-2])
            let(
                aOffset=j*nacaSampleCount, bOffset=(j+1)*nacaSampleCount,
                a1=aOffset+i, a2=a1+1,
                b1=bOffset+i, b2=b1+1
            )
            [
                [a1, a2, b2],
                [a1, b2, b1]
            ]
        ], face=faceList) face],
        // trailing edge
        [for(faceList=[
            for(j=[0:1:len(pointSetPairs)-1])
            let(
                aOffset=j*nacaSampleCount, bOffset=(j+1)*nacaSampleCount,
                a1=aOffset+nacaSampleCount-1, a2=aOffset,
                b1=bOffset+nacaSampleCount-1, b2=bOffset
            )
            [
                [a1, a2, b2],
                [a1, b2, b1]
            ]
        ], face=faceList) face]
    );
    polyhedron(points=points, faces=faces, convexity=5);
}

//
// example / testbed
//

pitch=100;
span=100;
height=8;
thickness=5;
segmentCount=50;
segments=[for(i=[0:1:segmentCount-1])
    let(
        position=i/(segmentCount-1),
        radius=affineTransform(0, 1, 0, span, position),
        angle=pitchAngleAtRadius(pitch, radius),
        chord=chordLengthForAngleAndHeight(angle, height),
        naca=[0.05, 0.4, thickness/chord],
        offset=[0,0,0]//rotateVector3Z([-0.5*chord-(i%2)*2,-(i%2)*1,0], -angle)
    )
    airfoilLoftSegment(position=position, naca=naca, chord=chord, offset=offset, angle=-angle)
];
!
rotate([90,0,0])
airfoilLoft(
    segments=segments,
    span=span,
    nacaSampleCount=11,
    step=2*(span/segmentCount)
);
