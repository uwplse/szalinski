/* [Dimensions] */
// Width
width = 25;

// Height
height = 30;

// Plate thickness
thickness = 2;

/* [Texts configuration] */
name1 = "Name1";
name2 = "Name2";

// Text Size
textSize = 4; // [0:20]

// Text font (choose from Google Fonts)
font = "Arial";

// Text angle
textAng = 60; // [0:180]

// Horizontal translation
horzTrans = -1; // [-20:20]

// Vertical translation
vertTrans = 1; // [-20:20]

/* [Drills configuration] */
// Drill diameter
drillDiam = 4;

// Drill position angle
angDrill = 0; // [0:180]

// Drill separation ratio
sepDrill = 9; // [0:10]


/* [Hidden] */
$fn=60;
cut=[[-width/2,-height/2], [-width/6,-height/3], [-width/6.5,-height/5],[-width/7,-height/12],[0, 0],[width/7,height/12],[width/6.5,height/5], [width/2,height/2], [width/2+1, height/2+1], [width/2+1, -height/2-1], [-width/2-1, -height/2-1]];



a = atan((width/6.5)/(height/5));
b = textAng-a;
ra = height/5 / sin(a);


left_part();
translate([1, -1, 0]) right_part();

module left_part() {
    difference() {
        scale([width, height, thickness]) cylinder(d=1, h=1);
        translate([0, 0, -0.1]) cut();
        rotate([0, 0, angDrill]) drill();
    }
    textName(name1);
    
}

module textName(name) {
    translate([0, 0, 2]) linear_extrude(height=2) rotate([0, 0, textAng]) translate([horzTrans, sin(b)*ra+vertTrans, 0]) text(name, size=textSize, valign="center", halign="center", font = font);
}

module right_part() {
    difference(){
        intersection() {
        scale([width, height, thickness]) cylinder(d=1, h=1);
        translate([0, 0, -0.1]) cut();
    }
    rotate([0, 0, angDrill+180]) drill();
    }
    rotate([0, 0, 180]) textName(name2);
    
    
}

module cut() {
    linear_extrude(height=thickness+1) polygon(points=cut);
}

module drill() {
    translate([0, height/2*sepDrill/10-drillDiam/2, -0.1]) cylinder(d=drillDiam, h=thickness+1);
}
