M8BoltThick = 6.5;
M8BoltWidth = 15;
M8BoltHoleDiameter = 8.5;
Bearing608zzThick = 8;
Bearing608zzDiameter = 22.5;
M8ThreadDiameter = 12;
XWallThick = 3;
YWallThick = 5;
ZWallThick = 3;

difference() {
    translate([-(XWallThick*2+Bearing608zzDiameter)/2, -(YWallThick*2+Bearing608zzThick)/2, 0]) {
        cube([XWallThick*2+Bearing608zzDiameter, YWallThick*2+Bearing608zzThick, ZWallThick*2 + M8BoltThick + Bearing608zzDiameter*2/3]);
    }
    translate([0,0,-1]) {
        cylinder(r=M8BoltHoleDiameter/2, h=ZWallThick+1.01, $fn=50);
    }
    translate([-M8BoltWidth/2,-M8BoltWidth/2-YWallThick-1,ZWallThick]) {
        cube([M8BoltWidth, M8BoltWidth+YWallThick+1, M8BoltThick]);
    }
    translate([0,0,ZWallThick*2+M8BoltThick+Bearing608zzDiameter/2]) {
        rotate([90,0,0]) {
            cylinder(r=Bearing608zzDiameter/2, h=Bearing608zzThick, $fn=50, center=true);
            cylinder(r=M8ThreadDiameter/2, h=Bearing608zzThick+YWallThick*2+2, $fn=50, center=true);
        }
    }
}