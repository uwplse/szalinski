/* [Global */
span=150;
spanThickness=6;
plateWidth=40;
plateHeight=40;
holeInterval=20;

/* [Hidden] */

plate(90,3,plateWidth,plateHeight,holeInterval,spanThickness);
translate([0,-span,-span]) rotate([90,0,0]) plate(-90,-1,plateWidth,plateHeight,holeInterval,spanThickness);
brace(span,spanThickness,plateHeight);

module brace(span,spanThickness,plateHeight) {
    myLeng=sqrt((span*span)+(span*span));
    translate([0,-span,-span]) rotate([45,0,0]) cube([spanThickness,myLeng,plateHeight]);
    difference(){
        translate([0,-plateHeight,0]) cube([spanThickness,plateHeight,plateHeight]);
        translate([-1,-plateHeight,(plateHeight/4)+(plateHeight*0.165)]) rotate([45,0,0]) cube([spanThickness+2,plateHeight,plateHeight]);
    }
    difference(){
    translate([0,-(span+plateHeight),-(span)]) cube([spanThickness,plateHeight,plateHeight]);
    translate([-1,-(span+plateHeight),-(span-((plateHeight/4)+(plateHeight*0.165)))]) rotate([45,0,0]) cube([spanThickness+2,plateHeight,plateHeight]);
    }
}
module plate(xRot,yTrans,plateWidth,plateHeight,holeInterval,spanThickness) {
    difference() {
        cube([plateWidth,2,plateHeight]);
        for (a =[0:(plateHeight/20)])
        {echo(a);
        if (a>0) {
        translate([30,yTrans,a*holeInterval-10]) rotate([xRot,0,0]) cylinder(h=4,d1=4,d2=8);
        translate([holeInterval-5,yTrans,a*holeInterval-10]) rotate([xRot,0,0]) cylinder(h=4,d1=4,d2=8);
        };
        };
    }
}
