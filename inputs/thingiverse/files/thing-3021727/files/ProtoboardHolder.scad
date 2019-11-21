protoboardWidth = 60;
protoboardHeight = 40;
postHeight = 50;
postCornerOffset = 2;
postRadius = 1;
baseHeight = 2;


cube(size = [protoboardWidth, protoboardHeight, baseHeight]);
translate([postCornerOffset, postCornerOffset])
    cylinder(postHeight, postRadius, postRadius);
translate([protoboardWidth-postCornerOffset, postCornerOffset])
    cylinder(postHeight, postRadius, postRadius);
translate([protoboardWidth-postCornerOffset, protoboardHeight-postCornerOffset])
    cylinder(postHeight, postRadius, postRadius);
translate([postCornerOffset, protoboardHeight-postCornerOffset])
    cylinder(postHeight, postRadius, postRadius);