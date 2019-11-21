use <MCAD/regular_shapes.scad>

// Please input a numerical seed value for repeatable randomization
seed = 555555;

/* [Hidden] */
r0 = rr(0,0);
r6 = rr(0,1);
sc = rands(13,20,1,seed+7)[0];
podScaleX = rands(0.1,3,1,seed+8)[0];
podScaleY = rands(0.1,3,1,seed+9)[0];
podShape = rands(3,18,1,seed+10)[0];
podLength = rands(3*sc,5.5*sc,1,seed+11)[0];
podRadius = rands(sc/6,sc/2,1,seed+12)[0];
pylonDiameter = podRadius/2;
podOffsetR = rands(10,30,1,seed+13)[0];
podOffsetY = rands(0,sc*4,1,seed+14)[0];
podCount = round(rands(0,8,1,seed+15)[0]);
podRotate0 = (rands(0,1,1,seed+16)[0] < 0.5 ? -90 : 90);
podRotate1 = (podCount == 1 ? podRotate0 : rands(0,180,1,seed+17)[0]);
podRotate2 = 180 - podRotate1;
podRotate3 = (rands(0,1,1,seed+18)[0] < 0.5 ? -1 : 1);
podRotate4 = round(rands(0,2,1,seed+19)[0])*90;
podOffsetAngles = [0,90,rands(-75,75,1,seed+20)[0],rands(-75,0,1,seed+21)[0],rands(15,75,1,seed+44)[0],90,0,90,22.5];
podOffsetA = podOffsetAngles[podCount];
podOffsetX = (podCount == 1 ? 0 : podOffsetR * cos(podOffsetA));
podOffsetZ = podOffsetR * sin(podOffsetA);
podOffsetZ3 = podOffsetR * (podOffsetZ > 0 ? -1 : 1);

function rr(rm,delta) = rands(rm < 2 ? 2 : rm,10,1,seed+delta)[0];

module tail(tailShape, radius, height, seedDelta, faces) {
    tailRemoval = radius * 2;
    if (tailShape != 2) { // tailShape == 2 means flat tail
        difference() {
            union() {
                if (tailShape == 0) {
                    sphere(radius,$fn=faces);
                } else if (tailShape == 1) {
                    translate([0,0,-height]) cylinder(h=height,r1=0,r2=radius,$fn=faces);
                }
            }
            translate([0,0,tailRemoval]) cube([tailRemoval,tailRemoval,tailRemoval], center=true);
        }
    }
}

module nose(noseShape, pos, radius, height, seedDelta, faces, allowDiscs) {
    discSquash1 = rands(0.25,0.75,1,seed+23+seedDelta)[0];
    discSquash2 = rands(1.33,4,1,seed+24+seedDelta)[0];
    noseRemoval = radius * discSquash2 * 2;
    revisedNoseShape = (noseShape == 2 ? (r6 > 6 ? 0 : 2) : noseShape);
    if (revisedNoseShape != 2) { // revisedNoseShape == 2 means flat nose
        difference() {
            union() {
                if (revisedNoseShape == 0) {
                    translate([0,0,pos]) sphere(radius,$fn=faces);
                } else if (revisedNoseShape == 1) {
                    translate([0,0,pos]) cylinder(h=height,r1=radius,r2=0,$fn=faces);
                }
                
                // discs
                if (allowDiscs) {
                    if (rands(0,1,1,seed+25+seedDelta)[0] < 0.25) {
                        translate([0,0,pos]) scale([1,discSquash1,discSquash2]) sphere(radius,$fn=faces);
                    }
                    if (rands(0,1,1,seed+26+seedDelta)[0] < 0.25) {
                        translate([0,0,pos]) scale([discSquash1,1,discSquash2]) sphere(radius,$fn=faces);
                    }
                    if (rands(0,1,1,seed+27+seedDelta)[0] < 0.25) {
                        rotate([0,0,45]) translate([0,0,pos]) scale([discSquash1,1,discSquash2]) sphere(radius,$fn=faces);
                        rotate([0,0,-45]) translate([0,0,pos]) scale([discSquash1,1,discSquash2]) sphere(radius,$fn=faces);
                    }
                }
            }
            translate([0,0,pos -(noseRemoval/1.99)]) cube([noseRemoval,noseRemoval,noseRemoval], center=true);
        }
    }
}

module fuselage() {
    union() {
        rotate([90,0,0]) {
            union() {
                rotate_extrude($fn=72) polygon( points=[[0,0],[r0,0],[rr(r0,2),1*sc],[rr(r0,3),2*sc],[rr(r0,4),3*sc],[rr(r0,5),4*sc],[rr(r0,6),5*sc], [r6,6*sc],[0,6*sc]] );
                nose(round(rands(0,2,1,seed+22)[0]), 6*sc, r6, sc, 0, 72, true);
            }
        }
        if (rands(0,1,1,seed+46)[0] < 0.5) {
            engineSpheres();
        }
    }
}

module podAndPylon(x, y, z, zDiff, r, seedDelta) {
    union() {
        translate([x, y, z]) {
            rotate([90,0,0]) {
                rotate([0,0,r]) {
                    scale([podScaleX,podScaleY,1]) {
                        union() {
                            linear_extrude(height=podLength) circle(r=podRadius, $fn=podShape);
                            nose(round(rands(0,2,1,seed+22+seedDelta)[0]), podLength, podRadius, sc, seedDelta, podShape, false);
                            tail(round(rands(0,2,1,seed+28+seedDelta)[0]), podRadius, sc, seedDelta, podShape);
                        }
                    }
                }
            }
        }
        hull() {
            translate([0,-(podLength/2),0]) cube([pylonDiameter,pylonDiameter,pylonDiameter],center=true);
            translate([x,y-(podLength/2)-podRadius,z]) cube([pylonDiameter,pylonDiameter,pylonDiameter],center=true);
        }
    }
}

module pods() {
    if (podCount > 4) {
        startRotation = podOffsetA;
        incrementRotation = 360 / podCount;
        endRotation = startRotation + 360;
        for (a = [startRotation:incrementRotation:endRotation]) {
            podAndPylon(podOffsetR * cos(a), podOffsetY, podOffsetR * sin(a), 0, (podRotate4 - a) * podRotate3, 1000);
        }
    }
    if (podCount == 4) {
        podAndPylon(podOffsetX, podOffsetY, -podOffsetZ, 0, 180+podRotate2, 1000);
        podAndPylon(-podOffsetX, podOffsetY, -podOffsetZ, 0, 180+podRotate1, 1000);
    }
    if (podCount == 3) {
        podAndPylon(0, podOffsetY, podOffsetZ3, (podOffsetZ3<0?podRadius:-podRadius), podRotate0, 1000);
    }
    if (podCount < 5) {
        podAndPylon(podOffsetX, podOffsetY, podOffsetZ, 0, podRotate1, 1000);
    }
    if (podCount == 2 || podCount == 3 || podCount == 4) {
        podAndPylon(-podOffsetX, podOffsetY, podOffsetZ, 0, podRotate2, 1000);
    }
}

module rotateAroundPoint(angle, point) {
    translate(point) rotate(angle) translate(-point) children();
}

module engine(x,z,r) {
    type = round(rands(0,1,1,seed+45)[0]);
    if (type == 0) {
        translate([x,0,z]) sphere(r, $fn=72);
    } else {
        translate([x,0,z]) rotate([-90,0,0]) cylinder(r1 = r/2, r2 = r, h = sc / 4, $fn=72);
    }
}

module engineSpheres() {
    if (r0 > 5) {
        sphereRad = r0 / 5;
        engine(0, 0, sphereRad);
        sphereRingRad1 = sphereRad * 2;
        sphereRingRad2 = sphereRad * 4;
        sphereCount1 = round((sphereRingRad1 * 2 * 3.141592653589793238) / (sphereRad * 2));
        sphereCount2 = round((sphereRingRad2 * 2 * 3.141592653589793238) / (sphereRad * 2));
        for (sph1 = [1:1:sphereCount1]) {
            angle1 = (sph1 - 1) * (360 / sphereCount1);
            engine(sphereRingRad1 * cos(angle1), sphereRingRad1 * sin(angle1), sphereRad);
        }
        for (sph2 = [1:1:sphereCount2]) {
            angle2 = (sph2 - 1) * (360 / sphereCount2);
            engine(sphereRingRad2 * cos(angle2), sphereRingRad2 * sin(angle2), sphereRad);
        }
    }
}

module axialRing(radius, offset) {
    translate([0,-offset,0]) rotate([90,0,0]) oval_torus(radius, thickness=[4,2], $fn=72);
    spokeCount = round(rands(1,8,1,seed+37)[0]);
    for (spoke = [0:(360/spokeCount):360]) {
        translate([0,-offset,0]) {
            rotate([0,spoke,0]) {
                cylinder(r1=2,r2=0.5,h=radius,$fn=36);
            }
        }
    }
}

module axialRings() {
    count = round(rands(0,3,1,seed+36)[0]);
    offset = rands(sc*0.5,sc*5.5,1,seed+38)[0];
    radius = rands(r6*2,r6*4,1,seed+39)[0];
    axialRing(radius,offset);
    if (count > 0) {
        for (ar = [1:1:count]) {
            radiusMultiplier = rands(0.75,1.25,1,seed+40+ar)[0];
            axialRing(radius * radiusMultiplier,offset + (ar*2));
            axialRing(radius * radiusMultiplier,offset - (ar*2));
        }
    }
}

module quantumRing(rotationAngle, rotationPoint, vOffset, hOffset) {
    translate([0, sc*hOffset, vOffset]) rotateAroundPoint(rotationAngle, rotationPoint) oval_torus(sc, thickness=[4,2], $fn=72);
}

module quantumRings() {
    count = round(rands(0,4,1,seed+29)[0]);
    quantumRing([0,0,0],[0,0,0],0,0.67);
    if (count > 0) {
        for (q = [1:1:count]) {
            quantumRing([10*q,0,0],[0,-sc,0],(r6/10)*q,0.67);
            quantumRing([-10*q,0,0],[0,-sc,0],(-r6/10)*q,0.67);
        }
    }
}

module fedDisc() {
    neck = r0 > 2 ? r0 : 2;
    discOffset = rands(0,sc*7,1,seed+48)[0];
    discHeight = rands(-sc*1.25,sc*1.25,1,seed+49)[0];
    maxBase = (discOffset + sc) < (sc * 5.75) ? (discOffset + sc) : (sc * 5.75);
    minBase = (discOffset - sc) > (sc * 0.25) ? (discOffset - sc) : (sc * 0.25);
    discBase = rands(minBase,maxBase,1,seed+50)[0];
    discRad = rands(sc/2, sc*2, 1, seed+46)[0];
    discRatio = rands(0.5,1,1,seed+47)[0];
    translate([0,-discOffset,discHeight]) rotate_extrude($fn=72) polygon( points=[[0,0],[discRatio*discRad,0],[discRad,2.5],[discRad,5],[discRatio*discRad,7.5],[0,7.5]] );
    hull() {
        translate([0,-discBase,0]) cube([neck,sc * 0.25,0.1],center=true);
        translate([0,-discOffset,discHeight < 0 ? discHeight + 3.75 : discHeight + 3.75]) cube([neck,discRad/3,0.1],center=true);
    }
}

module stand(offset, height) {
    translate([0,-offset,-height]) {
        //base
        union() {
            linear_extrude(height=5, scale=0.8) hexagon(36.662); // 2.5" flat-to-flat
            translate([0,0,5]) linear_extrude(height=5, scale=0.5) hexagon(29.3296);
        }

        //neck
        union() {
            translate([0,0,10]) cylinder(r1=3.9,r2=1.95,h=(height-10),$fn=36);
            translate([0,0,2]) cylinder(r1=3.9,r2=3.9,h=8,$fn=36);
        }
    }
}

// spacecraft
union() {
    engineBell = (rands(0,1,1,seed+46)[0] < 0.5) && (r0 > 5) && (round(rands(0,1,1,seed+45)[0]) == 1);
    if (rands(0,1,1,seed+30)[0] < 0.5 && !engineBell) {
        quantumRings();
        scale([1+rands(0,0.4,1,seed+35)[0],1,0.4 + rands(0,0.6,1,seed+32)[0]]) fuselage();
    } else {
        scale([0.75 + rands(0,0.5,1,seed+34)[0],1,0.75 + rands(0,0.5,1,seed+33)[0]]) fuselage();
    }
    if (rands(0,1,1,seed+31)[0] < 0.5) {
        if (podCount > 0) {
            pods();
            stand(1.75 * sc, 45);
        } else {
            stand(3 * sc, 45);
        }
    } else {
        stand(3 * sc, 45);
    }
    if (rands(0,1,1,seed+40)[0] < 0.5) {
        axialRings();
    }
    if (rands(0,1,1,seed+51)[0] < 0.5) {
        fedDisc();
    }
}
