filamentWidth = 1.75;
clipHeight = 6;
clipWidth = 2.5;
tolerance=0.4;

module O (extra) {
    difference() {
        cylinder(d=filamentWidth+clipWidth*2, h=clipHeight, center=true);
        cylinder(d=filamentWidth+tolerance+extra, h=clipHeight+1, center=true);
    }
}
$fn=50;

O(tolerance);
difference() {
    translate([(filamentWidth+clipWidth+tolerance),0,0])
    O(0);
    translate([filamentWidth+clipWidth+tolerance,0,0])
    rotate([0,0,29])
    translate([0,(filamentWidth+clipWidth)/2,0])
    cube([filamentWidth+tolerance,filamentWidth+clipWidth,clipHeight+1],center=true);
}