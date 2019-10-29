//Guitar Tuner Drill Atachment 
tunerWidth = 20;
tunerHeight = 9;
tunerDepth = 20;
pocketWall = 2;
rodDiameter = 6.75;
rodSmoothSectionLength = 12.5;
rodHexSectionLength = 12.5;

difference() {
    cube([tunerWidth+pocketWall*2, tunerDepth+pocketWall, tunerHeight+pocketWall*2], center=true);
    translate([0, pocketWall, 0]) cube([tunerWidth, tunerDepth, tunerHeight], center=true);
}
rotate([90, 0, 0]) translate([0, 0, (tunerDepth+pocketWall)/2]) {
    cylinder(h = rodSmoothSectionLength, d = rodDiameter, $fn=50);
    translate([0, 0, rodSmoothSectionLength]) cylinder(h = rodHexSectionLength, d = rodDiameter, $fn=6);
}