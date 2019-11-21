cardWidth=63.5;
cardHeight=88.5;
cardThickness=0.34;

cardPerBox=500;
cardBlockLength=cardThickness*cardPerBox;

spaceAroundCard=0.25;
spaceAroundLid=0.5;

wallthickness=0.96;

fingerCutout=30;

// 1 for base box, 0 for lid
boxOrLid=0;

if (boxOrLid) {
    mainBox();
} else {
    mainLid();
}

module mainBox () {
    difference() {
        Box();
        translate([
            (cardWidth+(spaceAroundCard*2)+(wallthickness*2))/2,
            cardBlockLength+(spaceAroundCard*2)+(wallthickness*3),
            cardHeight+spaceAroundCard+wallthickness
            ]){
            rotate(a=[90,0,0]){
                cylinder(h=(cardBlockLength+(spaceAroundCard*2)+(wallthickness*4)),d=fingerCutout);
            }
        }
    }
}


module Box () {
    difference() {
        cube([
        cardWidth+(spaceAroundCard*2)+(wallthickness*2),
        cardBlockLength+(spaceAroundCard*2)+(wallthickness*2),
        cardHeight+spaceAroundCard+wallthickness
        ]);
        translate([wallthickness,wallthickness,wallthickness]) {
            cube([
            cardWidth+(spaceAroundCard*2),
            cardBlockLength+(spaceAroundCard*2),
            cardHeight+spaceAroundCard+wallthickness
            ]);
        }
    }
}

module mainLid () {
    difference() {
        LidBox();
        translate([
            -spaceAroundLid,
            (cardBlockLength+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*2))/2,
            cardHeight+spaceAroundCard+(wallthickness*2)+(spaceAroundLid)
            ]){
            rotate(a=[0,90,0]){
                cylinder(h=cardWidth+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*4),d=fingerCutout);
            }
        }
    }
}


module LidBox () {
    difference() {
        cube([
        cardWidth+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*2),
        cardBlockLength+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*2),
        cardHeight+spaceAroundCard+(wallthickness*2)+(spaceAroundLid)
        ]);
        translate([wallthickness,wallthickness,wallthickness]) {
            cube([
            cardWidth+(spaceAroundCard*2)+(wallthickness*2)+(spaceAroundLid*2),
            cardBlockLength+(spaceAroundCard*2)+(wallthickness*2)+(spaceAroundLid*2),
            cardHeight+spaceAroundCard+(wallthickness*2)+(spaceAroundLid)
            ]);
        }
    }
}