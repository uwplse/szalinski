vaseRadius = 15; //[5:20]
vaseWallThickness = 2; //[0.1:5]
vaseSides = 6; //[3:10]
slices = 50; //[5:200]
angleShiftPerSlide = 5; //[0.1:20]
radiusIncrease = 10; //[0:20]
heightPerSlice = 1;
heightOffset = 0.1; 
sliceIncrease = radiusIncrease / slices;
echo(sliceIncrease);

linear_extrude(height = heightPerSlice, center = true, convexity = 10, twist = 0)
circle(vaseRadius, $fn=vaseSides);

for (a = [1:slices]) {
    translate([0,0,(1*a)]) 
    rotate([0,0,angleShiftPerSlide*a])
    difference() {
        linear_extrude(height = heightPerSlice + heightOffset, center = true, convexity = 10, twist = 0)
        circle(vaseRadius + (sliceIncrease * a), $fn=vaseSides);
        linear_extrude(height = heightPerSlice + heightOffset + heightOffset, center = true, convexity = 10, twist = 0)
        circle(vaseRadius - vaseWallThickness + (sliceIncrease * a), $fn=vaseSides);
    }
}
