// [Dimensions]

// Phone Height
h=156.4;
// Phone Width
w=76.2;
// Phone Tickness
phoneTickness=6;
// Snap Tickness
snapTickness=4.99;

// [Hidden]
tickness=phoneTickness + snapTickness;
topBorder = 1.4;
topHeight = 1.5;
shell = 1.2;
cameraRad = 12;
caseW = w+2*shell;
caseH = h+2*shell;
caseT = tickness+shell;
$fn=40;

module baseShape(t = tickness, bottomRatio=0.95, topRatio=1) {
    d = 10;
    resize([w, h, t])
    hull() {
        translate([d, d, 0])
        cylinder(h=t, r1=d* bottomRatio, r2=d * topRatio);

        translate([d, h-2*d, 0])
        cylinder(h=t, r1=d* bottomRatio, r2=d * topRatio);

        translate([w-2*d, h-2*d, 0])
        cylinder(h=t, r1=d * bottomRatio, r2=d * topRatio);

        translate([w-2*d, d, 0])
        cylinder(h=t, r1=d * bottomRatio, r2=d * topRatio);
    }
}

module phone() {
    hull() {
        baseShape(t=snapTickness, bottomRatio=0.7);
        
        translate([0, 0, snapTickness])
        baseShape(t=phoneTickness, bottomRatio=1);
    }
}

module topBorder() {
    color("#0ABAB5")
    difference() {
        translate([0, 0, caseT])
        resize(newsize=[caseW, caseH, topHeight])
        baseShape(t=topHeight, bottomRatio=1);
        
        translate([topBorder/2, topBorder/2, caseT-1])
        resize(newsize=[caseW-topBorder, caseH-topBorder, 4])
        baseShape(t=4, bottomRatio=1, topRatio=0.75);
    }
}

color("#0ABAB5")
difference() {    
    // Build the basic phone shell bounding box
    union() {
        resize(newsize=[caseW, caseH, caseT]) phone();
        topBorder();
    }
    
    // Cut the phone interior
    translate([shell, shell, shell+0.2]) phone();
    
    // Cut button holes
    translate([caseW-5, 100, snapTickness + shell + 0.2])
    cube([6, 36, phoneTickness+topHeight]);
    
    translate([28, -1, snapTickness + shell + 0.2])
    cube([35, 6, phoneTickness+topHeight]);
    
    // Cut camera hole
    translate([caseW/2, caseH-cameraRad-14, -1])
    cylinder(h = tickness, r1=cameraRad, r2=cameraRad);
};