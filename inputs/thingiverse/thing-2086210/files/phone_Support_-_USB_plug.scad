// USB plug width
uW = 10.3;

// USB plug depth
uD = 7.3;

// Separation from phone back
uS = 2.4;


/* [ Hidden ] */
fH= 3;

wF = 23.3;
dF = 11.3;
hF = 4.8;


difference() {
translate ([-wF/2, 0, 0])
cube([wF, dF, hF]);
translate([-uW/2, uS, -1])
cube ([uW, uD, hF+2]);
translate([-fH/2, -1, -1])
cube([fH, uS+2, hF+2]);
}



