holeWidth = 13.15;
holeHeight = 0.9;
holeDepth = 5;
surround=2;

difference() {
    cube([holeWidth+surround, holeDepth+surround, holeHeight+surround], center=true);
    translate([0,surround/2+0.01,0])
    cube([holeWidth, holeDepth, holeHeight], center=true);
    translate([0,surround/2+0.01-0.5,0])
    cube([3, holeDepth+1, holeHeight], center=true);
}