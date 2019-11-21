//Configuration:
//Coin diameter (mm)
coinSz = 21.0;
//Coin thickness (mm)
coinTh = 1.6;
//Maximum coins
coins = 20;
//Gap for finger size
finger = 12;
//Mounting hole diameter (mm)
holeSz = 3.4;

//Other configurations:
//reduction for the coin not to fall by itself
iFactor = 0.95;
//Walls thickness
wallTh = 3; //[2:5]

ioRing = coinSz * iFactor;
iiRing = ioRing - wallTh;
height = coins * coinTh + finger;

//---------------------------------------------
//geometrias
//tools
module chaflan(size, tr = [0, 0], rt = 0){
    translate([tr[0], tr[1]])
        rotate(rt - 180)
            difference(){
                square(size);
                translate([size, size])
                    circle(r=size);
            }
}
//---------------------------------------------
//simples
module rSquare(sz, chSz){
    difference(){
        square(sz, true);
        chaflan(chSz, [szB/2, szB/2], 0);
        chaflan(chSz, [-szB/2, szB/2], 90);
        chaflan(chSz, [-szB/2, -szB/2], 180);
        chaflan(chSz, [szB/2, -szB/2], 270);
    }
}

module slice(d, cutAng){
    R = d * sqrt(2)/2;
    intersection(){
        circle(d=d);
        polygon([
            [0, 0],
            [R, 0],
            [R * cos(cutAng * (1/8)), R * sin(cutAng * (1/8))],
            [R * cos(cutAng * (2/8)), R * sin(cutAng * (2/8))],
            [R * cos(cutAng * (3/8)), R * sin(cutAng * (3/8))],
            [R * cos(cutAng * (4/8)), R * sin(cutAng * (4/8))],
            [R * cos(cutAng * (5/8)), R * sin(cutAng * (5/8))],
            [R * cos(cutAng * (6/8)), R * sin(cutAng * (6/8))],
            [R * cos(cutAng * (7/8)), R * sin(cutAng * (7/8))],
            [R * cos(cutAng), R * sin(cutAng)],
        ]);
    }
}

module ring(outer, inner){
    difference(){
        circle(d=outer);
        circle(d=inner);
    }
}

module sliceRing(outer, inner, ang) {
    intersection(){
        ring(outer, inner);
        slice(outer, ang);
    }
}

module uRing (o, i, l) {
    sliceRing(o, i, 180);
    translate([0,-l/2])
        difference() {
            square([o, l], true);
            square([i, l], true);
        }
}

//---------------------------------------------
//base
thSz = 4; //thingy Size
thOff = 2; //thingy offset

module cBase(ht, szB, szCh, holeSz){
    linear_extrude(ht){
        difference(){
            rSquare(szB, szCh);
            //montaje
            circle(d=holeSz);
        }
    }
}
//---------------------------------------------
//main
//datos anillo exterior
oiRing = coinSz + 2.5; //alejado 3 capas
ooRing = oiRing + wallTh;

szB = ooRing;
baseH = 2;
szCh = 5;
color("blue")
cBase(baseH, szB, szCh, holeSz);

gap = coinTh * 1.8;
translate([0, 0, baseH]){
    union(){
        //interior
        color("cyan")
        linear_extrude(finger){
            uRing(ioRing, iiRing, ioRing/3);
        }
        //exterior con hueco para moneda
        linear_extrude(finger + gap){
            sliceRing(ooRing, oiRing, 180);
        }
        //resto del exterior
        translate([0, 0, finger + gap])
        linear_extrude(height - finger - gap){
            ring(ooRing, oiRing);
        }
    }
}