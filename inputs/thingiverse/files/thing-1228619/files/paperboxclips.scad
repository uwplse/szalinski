
paperthick=6.5;
clipsize=80;
clipshortside=10;
clipthick=2;

module shield (shortSideLength, longSideLength, shieldThick) {
    /*
        z
        ^
        |       4________3
        |       /        \
        |      /         /2
        |     /         /
        |  5 /         /
        |    \________/
        |     0      1
       -+-----------------> y
        |

                __
        length( 05 ) : shortSideLength.
             __  __
        dist(05, 23) : longSideLength.
	
    */
    polyhedron(
        points = [ [0,shortSideLength,0], 
                   [0,(longSideLength/2+shortSideLength*sqrt(3)/2)*2.0/sqrt(3),0], 
                   [0,(longSideLength/2+shortSideLength*sqrt(3)/2)*2.0/sqrt(3)+((longSideLength/2+shortSideLength*sqrt(3)/2)*2/sqrt(3)-shortSideLength)/2,((longSideLength/2+shortSideLength*sqrt(3)/2)*2/sqrt(3)-shortSideLength)*sqrt(3)/2],
                   [0,(longSideLength/2+shortSideLength*sqrt(3)/2)*2.0/sqrt(3)+((longSideLength/2+shortSideLength*sqrt(3)/2)*2/sqrt(3)-shortSideLength)/2-shortSideLength/2,(longSideLength/2+shortSideLength*sqrt(3)/2)], 
                   [0,(longSideLength/2+shortSideLength*sqrt(3)/2)/sqrt(3), (longSideLength/2+shortSideLength*sqrt(3)/2)], 
                   [0,shortSideLength/2,shortSideLength*sqrt(3)/2],
               
                   [shieldThick,shortSideLength,0], 
                   [shieldThick,(longSideLength/2+shortSideLength*sqrt(3)/2)*2.0/sqrt(3),0], 
                   [shieldThick,(longSideLength/2+shortSideLength*sqrt(3)/2)*2.0/sqrt(3)+((longSideLength/2+shortSideLength*sqrt(3)/2)*2/sqrt(3)-shortSideLength)/2,((longSideLength/2+shortSideLength*sqrt(3)/2)*2/sqrt(3)-shortSideLength)*sqrt(3)/2],
                   [shieldThick,(longSideLength/2+shortSideLength*sqrt(3)/2)*2.0/sqrt(3)+((longSideLength/2+shortSideLength*sqrt(3)/2)*2/sqrt(3)-shortSideLength)/2-shortSideLength/2,(longSideLength/2+shortSideLength*sqrt(3)/2)], 
                   [shieldThick,(longSideLength/2+shortSideLength*sqrt(3)/2)/sqrt(3), (longSideLength/2+shortSideLength*sqrt(3)/2)], 
                   [shieldThick,shortSideLength/2,shortSideLength*sqrt(3)/2],
        ],
        faces = [ [0,1,2], [0,2,3], [0,3,4], [0,4,5],
                  [6,8,7], [6,9,8], [6,10,9], [6,11,10],
                  [0,7, 1], [0,6, 7],
                  [1,8, 2], [1,7, 8],
                  [2,9, 3], [2,8, 9],
                  [3,10,4], [3,9, 10],
                  [4,11,5], [4,10,11],
                  [5,6, 0], [5,11,6]
        ]
    );
}

module bumper1 (length) {
    polyhedron(
        points = [ [0,length,0], 
                [0,length/2,length*sqrt(3)/2],
                [0,length-1/sqrt(3)*2,0], 
                [0,length/2-1/2,length*sqrt(3)/2-1*sqrt(3)/2],
                [-1,length,0], 
                [-1,length/2,length*sqrt(3)/2],
        ],
        faces = [ [0,3,1], [0,2,3],
                 [5,1,3],
                 [0,4,2],
                 [4,0,1], [4,1,5],
                 [2,4,3], [4,5,3]
        ]
    );
}

module bumper2(length) {

    polyhedron(
        points = [ [0,-length/2,-length*sqrt(3)/2],
                [0,-length,0], 
                [0,-length/2+1/2,-length*sqrt(3)/2+1*sqrt(3)/2],
                [0,-length+1,0],
                [-1,-length/2-sqrt(3)/2,-length*sqrt(3)/2+sqrt(3)],
                [-1,-length,0]
        ],
        faces = [ [0,1,3], [0,3,2],
                 [1,5,3],
                 [4,0,2],
                 [4,1,0], [4,5,1],
                 [2,3,4], [4,3,5]
        ]
    );
}

bShortSide = 0.75 * clipshortside + 0.25 * (clipsize/2+clipshortside*sqrt(3)/2)/sqrt(3)*2;
bTooth1Side = 0.5 * clipshortside + 0.5 * (clipsize/2+clipshortside*sqrt(3)/2)/sqrt(3)*2;
bTooth2Side = 0.25 * clipshortside + 0.75 * (clipsize/2+clipshortside*sqrt(3)/2)/sqrt(3)*2;

union() {

    shield(clipshortside, clipsize, clipthick);

    shield((clipshortside/2*sqrt(3)+clipsize/2)/sqrt(3)*2-clipthick/sqrt(3),clipthick,paperthick+clipthick);
    
    translate ([clipthick + paperthick,0,0]) {
        shield(bShortSide, clipsize+clipshortside*sqrt(3)-bShortSide*sqrt(3), clipthick);
        bumper1(bTooth1Side);
        bumper1(bTooth2Side);
        translate([0,(clipsize/2+clipshortside*sqrt(3)/2)*2.0/sqrt(3)+((clipsize/2+clipshortside*sqrt(3)/2)*2/sqrt(3))/2,((clipsize/2+clipshortside*sqrt(3)/2))]) {
            bumper2(bTooth1Side);
            bumper2(bTooth2Side);
        }
    }
}

