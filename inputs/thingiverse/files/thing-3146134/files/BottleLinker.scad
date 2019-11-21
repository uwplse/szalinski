// Bottle linker for PET bottles etc
// Specify bottle hole diameter, pattern spacing and height
// It is possible to make a stack with gaps to print multiple linkers at once. Recommended print settings: 100 perimeters (is stronger, prints faster and makes separation easier).
// Vincent Groenhuis
// Oct 9, 2018

// Diameter of bottles
BottleDiameter = 87;

// Distance between heartlines of bottles (BottleDiameter+3 is fine)
PatternSpacing = 90;

// Number of bottles to link together (1-7)
NumberOfBottles = 3;

// Height of bottle linker
Height = 3;

// Number of linkers in stack to print at once
PrintCount = 1;

// Gap between stacked linkers, use 0.2 mm to print without support
PrintGap = 0.2;

// Number of polygon segments in a circle
$fn = 100;


///////////// Construction //////////////


for (i=[0:PrintCount-1]) {
    translate([0,0,i*(Height+PrintGap)]) {
        linker(b=BottleDiameter, p=PatternSpacing, h=Height, n=NumberOfBottles);
    }
}


///////////// Functions /////////////////

module linker(b,p,h,n) {
    ring(b=b,p=p,h=h);
    satelliteRings(b=b,p=p,h=h,n=n);
    reinforcements(b=b,p=p,h=h,n=n);
}

module reinforcements(b,p,h,n) {
    if (n>=2) {
        rotate([0,0,-60])triangle(b=b,p=p,h=h);
        rotate([0,0,60*(n-2)])triangle(b=b,p=p,h=h);
    }
    if (n>=3) {
        for (i=[0:n-3]) {
            rotate([0,0,60*i])translate([p/2,sqrt(3)*p/2,0])rotate([0,0,-60])triangle(b=b,p=p,h=h);
        }
    }
}

// Triangle between three rings
module triangle(b,p,h) {
    intersection(){
        union(){
            ring(b=b, p=p, h=h);
            satelliteRings(b=b,p=p,h=h,n=3);
        }
        translate([0,0,-1])linear_extrude(height=h+2)polygon([[0,0],[p,0],[p/2,sqrt(3)*p/2]]);
    }    
}

module satelliteRings(b,p,h,n) {
    if (n>=2) {
        for (i=[0:n-2]) {
            x = p*cos(60*i);
            y = p*sin(60*i);
            translate([x,y,0])ring(b=b,p=p,h=h);    
        }
    }
}

// b=bottle size, p=pattern spacing, h=height
module ring(b,p,h) {
    difference(){
        translate([0,0,0])cylinder(d=p*2-b,h=h);
        translate([0,0,-1])cylinder(d=b,h=h+2);
    }
}
