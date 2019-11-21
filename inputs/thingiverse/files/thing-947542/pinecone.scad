
/* [leaf] */
// (Total leaves that make up a pinecone) :
totalLeafs = 150; // [10:400]

// (Average length of each leaf) :
leafBaseLength = 60; // [10:200]

// (Average thichkness of each leaf) :
leafThickness = 5; // [2:10]

// (Shape of leaf) :
leafSides = 4; // [3:6]

// (Spikiness of leaf) :
leafSpikiness = 8; // [0:20]

// (Upwards angle of leaf for printability) :
leafGrade = 30;  // [0:80]

/* [pinecone] */

// (Overall height of pinecone) :
pineConeHeight = 120; // [10:300]

// (Spiraling angle between leaf (Phi = 137.5, Lucas = 100.0) ) :
angleBetweenLeafs = 137.5;

// layer
module layer(segments) {

    union () {

        // Overall height of pinecone
        pineConeBase = leafBaseLength*0.15;
        cylinder(h = pineConeHeight, r1 = pineConeBase, r2 = 2, $fn=leafSides);
        cylinder(h = pineConeHeight*0.1, r1 = (pineConeBase+4), r2 = 0, $fn=leafSides);

        for ( i = [0 : segments] ) {

            seedNormal = (i/(segments-1));
            inverseSeedNormal = ((1-seedNormal) >.3) ? ((1-seedNormal)) : (.3);
            sinusoidalNormal = sin(seedNormal*90);
            inverseSinusoidalNormal = 1-sinusoidalNormal;

            baseTaper = .1;
            bottomLeafScalar = (seedNormal<baseTaper) ? (( seedNormal/baseTaper)*0.75+0.25 ) : 1;

            sizeScalar = bottomLeafScalar*inverseSeedNormal*leafThickness;
            
            leafWidth = 3*sizeScalar;
            leafHeight = 2*sizeScalar;

            leafBaseLengthCalculated = bottomLeafScalar*(leafBaseLength - (seedNormal*leafBaseLength));
            leafOffsetFromCenter = 0;
            leafTipLengthCalculated = leafSpikiness*inverseSeedNormal;
            leafHeightOffset = sinusoidalNormal*-pineConeHeight;

            rotate([0,0,0])
            rotate([0,90,0])
            rotate([i*angleBetweenLeafs ,0,0])
            translate([leafHeightOffset-5,0,0])
            leaf(
                width = leafWidth, 
                height = leafHeight, 
                baseLength = leafBaseLengthCalculated,
                tipLength = leafTipLengthCalculated,
                offsetFromCenter = leafOffsetFromCenter,
                seedNormal = seedNormal
            );
        }
    }
}

// leaf
module leaf(width, height, baseLength, tipLength, offsetFromCenter, seedNormal) {
    tip = tipLength;
    base = baseLength;
    rotate([0,-leafGrade,0]) // upwards angle for printing
    rotate([0,0,0]) // upwards angle for printing
    union () {
    
        // leaf base
        translate([0,0,offsetFromCenter])
        scale([height,width,1])
        cylinder(h = base, r1 = 0.5, r2 = 1, $fn=leafSides);
        
        // leaf tip
        translate([0,0,offsetFromCenter+base])
        scale([height,width,1])
        cylinder(h = tipLength, r1 = 1, r2 = 0, $fn=leafSides);
    
    }
}

scale([1,1,1])
layer( totalLeafs );
