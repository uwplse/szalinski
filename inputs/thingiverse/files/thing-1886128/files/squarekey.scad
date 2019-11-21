keywidth = 7.2;
keylength = 7;
holediameter = 15.5;
gripdiameter = 55;
gripheight = 8;
cutout = 3;
skirtheight = 8;
smoothness = 100;
tocorner = sqrt((gripdiameter / 2) * (gripdiameter / 2) * 2);
bottomradius = (tocorner - ((gripdiameter - cutout) / 2)) - 0;

module keyway(keywidth, keylength, holediameter) {
    difference() {
        cylinder((keylength + 2), (holediameter / 2), (holediameter / 2), $fn=smoothness, center=true);
        translate([0, 0, 1.5]) 
            cube([keywidth, keywidth, (keylength + 1)], center=true);
    }
}

module skirt(holediameter, gripdiameter, cutout, skirtheight) {
    translate([0, 0, -((skirtheight / 2) + ((keylength / 2) + 1))])
        cylinder(skirtheight, bottomradius, (holediameter / 2), center=true);
}

module cutout(height, diameter) {
    circleradius = (diameter - cutout) / 2;
    cylinder(height + 1, circleradius, circleradius, $fn=smoothness, center=true);
}

module grip(diameter, height, keylength) {
    translate([0, 0, -((height / 2) + ((keylength / 2) + 1) + skirtheight)])
        difference() {
            cube([diameter, diameter, height], center=true);
            translate([(diameter / 2), (diameter / 2), 0])
                cutout(height, diameter);
            translate([-(diameter / 2), (diameter / 2), 0])
                cutout(height, diameter);
            translate([(diameter / 2), -(diameter / 2), 0])
                cutout(height, diameter);
            translate([-(diameter / 2), -(diameter / 2), 0])
                cutout(height, diameter);
        }
}

difference() {
    union() {
        keyway(keywidth, keylength, holediameter);
        difference() {
            hull() {
                skirt(holediameter, gripdiameter, cutout, skirtheight);
                grip(gripdiameter, gripheight, keylength);
            }
            translate([(gripdiameter / 2), (gripdiameter / 2), 0])
                cutout(200, gripdiameter);
            translate([-(gripdiameter / 2), (gripdiameter / 2), 0])
                cutout(200, gripdiameter);
            translate([(gripdiameter / 2), -(gripdiameter / 2), 0])
                cutout(200, gripdiameter);
            translate([-(gripdiameter / 2), -(gripdiameter / 2), 0])
                cutout(200, gripdiameter);
        }
    }
    translate([0, 0, -((gripheight / 2) + ((keylength / 2) + 1) + skirtheight + (gripheight/3) + (gripheight/2))])
        resize(newsize=[((bottomradius*2)*0.8),((bottomradius*2)*0.8),((gripheight+skirtheight)*2)]) sphere(r=(gripheight+skirtheight), $fn=100);
}