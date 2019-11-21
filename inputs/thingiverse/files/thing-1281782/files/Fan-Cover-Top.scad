$fn=100;
ly = .2;

elevation = 38;
height = 20;

d1 = 140;
d2 = d1-d1/3;

thickness = 4*ly;
screwH = height/1.5;
screwRi = 4.3/2;
screwRo = 1.5*screwRi;
D = (140-124.5-screwRi*2)/2;

S1 = [d1/2-screwRo-D,0,0];
S2 = [0,d1/2-screwRo-D,0];
S3 = [-d1/2+screwRo+D,0,0];
S4 = [0,-d1/2+screwRo+D,0];


    difference() {
        union() {
            translate([0,0,elevation]) {
                difference() {
                    translate([0,0,thickness]) cylinder(h=height,r1=d1/2,r2=d2/2,$fn=4);
                    cylinder(h=height,r1=d1/2,r2=d2/2,$fn=4);
                }
            }
            translate(S1) cylinder(h=elevation+screwH,r1=screwRo,r2=screwRo);
            translate(S2) cylinder(h=elevation+screwH,r1=screwRo,r2=screwRo);
            translate(S3) cylinder(h=elevation+screwH,r1=screwRo,r2=screwRo);
            translate(S4) cylinder(h=elevation+screwH,r1=screwRo,r2=screwRo);
        }
        translate(S1) cylinder(h=elevation+screwH,r1=screwRi,r2=screwRi);
        translate(S2) cylinder(h=elevation+screwH,r1=screwRi,r2=screwRi);
        translate(S3) cylinder(h=elevation+screwH,r1=screwRi,r2=screwRi);
        translate(S4) cylinder(h=elevation+screwH,r1=screwRi,r2=screwRi);
    }