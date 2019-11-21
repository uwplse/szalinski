/* Sides */
side1 = "One";
side2 = "Two";
side3 = "Three";
side4 = "Four";
side5 = "Five";
side6 = "Six";

/* Hidden */
font = "Times";
cube_size = 50;
letter_size = 12;
letter_height = 10;

$fn= 50;

t=cube_size/2-letter_height/2;

diceMaker();

module letter(l) {
    linear_extrude(height=letter_height) {
        text(l, halign="center", valign="center", size=letter_size, font=font);
    }
}

module shape(s) {
    import(s, convexity=10);
}

module sideOne(side1) {
    translate([0,0,t]) {letter(side1);}
}

module sideTwo(side2) {
    translate([0,0,-t - letter_height]) mirror([1,0,0]) {letter(side2);}
}

module sideThree(side3) {
    translate([0,-t,0]) rotate([90,0,0]) {letter(side3);}
}

module sideFour(side4) {
    translate([t,0,0]) rotate([90,0,90]) {letter(side4);}
}

module sideFive(side5) {
    translate([0,t,0]) rotate([90,0,180]) {letter(side5);}
}

module sideSix(side6) {
    translate([-t,0,0]) rotate([90,0,-90]) {letter(side6);}
}

module diceMaker() {
    difference() {
        intersection() {
           cube(cube_size, center=true);
           sphere(cube_size/1.3, center=true);
        }
        sideOne(side1);
        sideTwo(side2);
        sideThree(side3);
        sideFour(side4);
        sideFive(side5);
        sideSix(side6);
    };
}