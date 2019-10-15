/* [General] */
// (outer Radius of the rod)
rodRadius = 4.4;//
// (inner Radius of the filament roll)
rollRadius = 27;
// (Height of the spool adapter)
height = 10;
// (Number of bars)
numberOfBars = 6;
/* [Misc] */
// (Width of the bars)
barWidth = 2;
// (Thickness of the inner ring)
innerRingThickness = 2.6;
// (Thickness of the outer ring)
outerRingThickness = 2.5;
// (Width of the guard)
guardWidth = 3;
// (height of the guard)
guardHeight = 2;

print_part();

module print_part() {
    union() {
        // bars with inner ring
        union() {
            // bars
            allBars();
            // inner ring:
            innerRing();
        }
        // top guard with outer Ring
        union() {
            // top guard
            topGuard();
            // outer ring:
            outerRing();
        }
    }
}
module innerRing()
{ 
    difference() {
        cylinder(r=rodRadius+innerRingThickness,h=height,$fa=1, $fs=0.5); // and go 1 mm above
        translate([0,0,-1]) // start 1 mm below the surface
            cylinder(r=rodRadius,h=height+1+1,$fa=1, $fs=0.5);
    }
}
module outerRing()
{
    difference() {
        cylinder(r=rollRadius,h=height,$fa=1, $fs=0.5); // and go 1 mm above
        translate([0,0,-1]) // start 1 mm below the surface
            cylinder(r=rollRadius-outerRingThickness,h=height+1+1,$fa=1, $fs=0.5);
    }
}
module topGuard()
{
    difference() {
        cylinder(r=rollRadius+guardWidth,h=guardHeight,$fa=1, $fs=0.5); // and go 1 mm above
        translate([0,0,-1]) // start 1 mm below the surface
            cylinder(r=rollRadius-1,h=guardHeight+1+1,$fa=1, $fs=0.5);
    }
}
module bar()
{
  translate([(rodRadius+innerRingThickness-1),(-(barWidth/2)),0])
    cube([rollRadius-outerRingThickness-(rodRadius+innerRingThickness)+2,barWidth,height]);
}
module allBars()
{
    for (r=[0:(360/numberOfBars):359])
        rotate([0,0,r])
            bar();
}
