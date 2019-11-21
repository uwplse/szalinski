// plate will be horizontal part against desk
// walls will be vertical part where the Mac Mini (or book or whatever sits)
// length will run along the channel

length = 10;

wallHeight = 31;
wallThickness = 3;
channelWidth = 30.5;

plateWidth = 51;
plateThickness = 3;

roundRadius = 1.5;

module baseProfile(wallHeight, 
                   wallThickness,
                   channelWidth,
                   plateWidth,
                   plateThickness) {
    outline = [
        [0, 0],
        [0, plateThickness],
        [channelWidth/2, plateThickness],
        [channelWidth/2, wallHeight],
        [channelWidth/2 + wallThickness, wallHeight],
        [channelWidth/2 + wallThickness, plateThickness],
        [plateWidth/2, plateThickness],
        [plateWidth/2, 0]
    ];
    polygon(outline);
    mirror([1, 0, 0]){ polygon(outline); }
}

module base(wallHeight, 
            wallThickness,
            channelWidth,
            plateWidth,
            plateThickness) {
    translate([plateWidth/2, length, 0])
    rotate([90, 0, 0]){
        linear_extrude(length){
            baseProfile(
                wallHeight,
                wallThickness,
                channelWidth,
                plateWidth,
            plateThickness);
        }
    }
}

module roundedBase(wallHeight, 
                   wallThickness,
                   channelWidth,
                   plateWidth,
                   plateThickness,
                   roundRadius) {
    translate([roundRadius, roundRadius, roundRadius])
    minkowski(){
        base(wallHeight - 2 * roundRadius, 
             wallThickness - 2 * roundRadius,
             channelWidth + 2 * roundRadius,
             plateWidth - 2 * roundRadius,
             plateThickness - 2 * roundRadius);
        sphere(roundRadius);
    }
}

$fn = 60;
roundedBase(wallHeight, 
            wallThickness,
            channelWidth,
            plateWidth,
            plateThickness,
            roundRadius-0.1);
