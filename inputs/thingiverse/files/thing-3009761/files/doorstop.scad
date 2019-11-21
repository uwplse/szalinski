$fn = 200;
innerR = 7;
clearance = 2;
outerWidth = 1.6;
outerR = innerR + clearance + outerWidth;
stopperR = 2;
midHeight = 20;
plateWidth = 6;
screwD = 3.4;
screwTolerance = 0.3;
screwClearance = 2;
springWidth = 1.4;
desiredLength = 75;
springLength = desiredLength/2 - plateWidth - innerR;
screwDistance = 39.5;

linear_extrude(height = midHeight)
    circle(r=innerR);
outerRing();

wallPart(0);
mirror([0,1,0]) wallPart(outerWidth + clearance + springWidth);

module outerRing() {
    linear_extrude(height = midHeight) {
        difference() {
            circle(r=outerR);
            circle(r=outerR - outerWidth);
            polygon(points = [[0, 0], [-outerR, -outerR], [outerR, -outerR]]);
        }
        stopper(45);
        stopper(-45);
    }
}

module wallPart(shift) {
    magicY = outerR * sin(166.5);
    scale([1, 1, 1])
        #linear_extrude(height = midHeight) 
        {
            translate([0, magicY - shift, 0]) {
                spring();
                mirror([1, 0, 0]) spring();
            }
        }
    plateLen = outerR*2.7 + (screwD + screwClearance) * 4;
    plateShift = springLength - shift + plateWidth + magicY + springWidth + outerWidth;
    echo(plateShift);
    translate([
        0, 
        plateShift, 
        midHeight/2
    ])
        plate(plateLen);
}

module stopper(angle) {
    rotate([0, 0, angle])
    translate([0, -(innerR + clearance + outerWidth/2), 0])
    circle(stopperR);
}

module spring() {
    a1 = 110;
    a2 = -140;
    radius = springLength/(sin(a1)-sin(a2));
    translate([radius+0.8, radius, 0]) {
    difference() 
    {
        circle(r=radius);
        circle(r=radius - springWidth);
        polygon(points = [
            [0, 0], 
            [2*radius * cos(a1), 2*radius * sin(a1)], 
            [2*radius, 2*radius], 
            [2*radius, -2*radius],
            [2*radius * cos(a2), 2*radius * sin(a2)]
        ]);
    }
      // attachment
      translate([radius*cos(a1), radius*sin(a1), 0])
        circle(r=outerWidth);
    }
}

module plate(plateLen) {
        difference(){
            // TODO rounded
            cube(size = [plateLen, plateWidth, midHeight], center = true);
            screwHole(1);
            screwHole(-1);
        }
}

module screwHole(sig) {
    translate([
        sig * screwDistance/2, 
        -plateWidth/2-0.1, 
        0
    ])
        rotate([-90, 0, 0])
        screw(screwD + screwTolerance, plateWidth + 1);

}

module screw(diameter, length) {
    cylinder(h = length, d = diameter);
    cylinder(h = diameter , d1 = diameter * 2, d2 = diameter);
}
