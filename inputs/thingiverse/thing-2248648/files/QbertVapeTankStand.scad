n = 3;

holeDiameter = 8;
holeDepth = 5;
boxLength = 30;
boxHeightFactor = .5;

module makeBox (boxHeight) {
    difference() {
        cube([boxLength,boxLength,boxHeight]);
        translate([boxLength*.5,boxLength*.5,boxHeight])
        cylinder(h=holeDepth*2,d=holeDiameter,center=true);
    }
}

rotate(180,0,0)
for (i=[0:n-1]) {
    for (j=[0:i]) {
        translate([(i-j)*boxLength,(j)*boxLength,0])
        makeBox((n-i)*boxLength*boxHeightFactor);
    }
}