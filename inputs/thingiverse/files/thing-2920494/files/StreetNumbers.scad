part = "one"; // [one:1, two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, zero:0, all:0-9, custom:Custom Letter]

// set part to "Custom Letter" first
customLetter = "a";

// custom font name
customFontName = "Ubuntu:style=Bold";
customFontSize = 180; // [50:5:300]
// letter height
customHeight = 20; // [5:50]

customFirstHole = "no"; // [yes, no]
firstHoleX = 0; // [-50:0.5:50]
firstHoleY = 10; // [0:0.5:180]

customSecondHole = "no"; // [yes, no]
secondHoleX = 0; // [-50:0.5:50]
secondHoleY = 69; // [0:0.5:180]

customThirdHole = "no"; // [yes, no]
thirdHoleX = 0; // [-50:0.5:50]
thirdHoleY = 10; // [0:0.5:180]

spacerHeight = 8; // [0:50]
// needs to be lower than customHeight
spacerInset = 8; // [0:50]

screwDiameter = 4; // [2:6]
screwHeadDiameter = 10; // [5:15]

$fn=100;

printPart();

module printPart() {
    if (customFontName != "Ubuntu:style=Bold") {
        customFirstHole = "yes";
        customSecondHole = "yes";
        customThirdHole = "yes";
    }
    if (spacerInset > customHeight) {
        spacerInset = 0;
    }
    if (part == "one") {
        printOne();
    }
    else if (part == "two") {
        printTwo();
    }
    else if (part == "three") {
        printThree();
    }
    else if (part == "four") {
        printFour();
    }
    else if (part == "five") {
        printFive();
    }
    else if (part == "six") {
        printSix();
    }
    else if (part == "seven") {
        printSeven();
    }
    else if (part == "eight") {
        printEight();
    }
    else if (part == "nine") {
        printNine();
    }
    else if (part == "zero") {
        printZero();
    }
    else if (part == "custom") {
        printCustom();
    }
    else {
        printAll();
    }
}

module printOne() {
    assembleNumber("1", makeFirstHole(customFirstHole, [-14, 50, 0]), makeSecondHole(customSecondHole, [-14, 120, 0]), makeThirdHole(customThirdHole, [-14, 50, 0]));
}

module printTwo() {
    assembleNumber("2", makeFirstHole(customFirstHole, [5, 13, 0]), makeSecondHole(customSecondHole, [5, 164, 0]), makeThirdHole(customThirdHole, [5, 13, 0]));
}

module printThree() {
    assembleNumber("3", makeFirstHole(customFirstHole, [5, 10, 0]), makeSecondHole(customSecondHole, [5, 164, 0]), makeThirdHole(customThirdHole, [5, 10, 0]));
}

module printFour() {
    assembleNumber("4", makeFirstHole(customFirstHole, [-29, 54, 0]), makeSecondHole(customSecondHole, [-29, 156, 0]), makeThirdHole(customThirdHole, [46, 54, 0]));
}

module printFive() {
    assembleNumber("5", makeFirstHole(customFirstHole, [0, 10, 0]), makeSecondHole(customSecondHole, [0, 160, 0]), makeThirdHole(customThirdHole, [0, 10, 0]));
}

module printSix() {
    assembleNumber("6", makeFirstHole(customFirstHole, [0, 9, 0]), makeSecondHole(customSecondHole, [0, 96, 0]), makeThirdHole(customThirdHole, [0, 9, 0]));
}

module printSeven() {
    assembleNumber("7", makeFirstHole(customFirstHole, [5, 50, 0]), makeSecondHole(customSecondHole, [5, 160, 0]), makeThirdHole(customThirdHole, [5, 50, 0]));
}

module printEight() {
    assembleNumber("8", makeFirstHole(customFirstHole, [0, 9, 0]), makeSecondHole(customSecondHole, [0, 165, 0]), makeThirdHole(customThirdHole, [0, 9, 0]));
}

module printNine() {
    assembleNumber("9", makeFirstHole(customFirstHole, [0, 20, 0]), makeSecondHole(customSecondHole, [0, 164, 0]), makeThirdHole(customThirdHole, [0, 20, 0]));
}

module printZero() {
    assembleNumber("0", makeFirstHole(customFirstHole, [0, 10, 0]), makeSecondHole(customSecondHole, [0, 164, 0]), makeThirdHole(customThirdHole, [0, 10, 0]));
}

module printAll() {
    translate([0, 0, 0])
        printOne();
    translate([-100, 0, 0])
        printTwo();
    translate([-230, 0, 0])
        printThree();
    translate([-360, 0, 0])
        printFour();
    translate([-490, 0, 0])
        printFive();
    translate([-620, 0, 0])
        printSix();
    translate([-750, 0, 0])
        printSeven();
    translate([-880, 0, 0])
        printEight();
    translate([-1010, 0, 0])
        printNine();
    translate([-1140, 0, 0])
        printZero();
}

module printCustom() {
    customFirstHole = "yes";
    customSecondHole = "yes";
    customThirdHole = "yes";
    assembleNumber(customLetter[0], makeFirstHole(customFirstHole, [0, 50, 0]), makeSecondHole(customSecondHole, [0, 120, 0]), makeThirdHole(customThirdHole, [0, 50, 0]));
}

function makeFirstHole(custom, defaultOffset=[0, 0, 0]) = (custom == "yes") ? [firstHoleX, firstHoleY, 0] : defaultOffset;
function makeSecondHole(custom, defaultOffset=[0, 0, 0]) = (custom == "yes") ? [secondHoleX, secondHoleY, 0] : defaultOffset;
function makeThirdHole(custom, defaultOffset=[0, 0, 0]) = (custom == "yes") ? [thirdHoleX, thirdHoleY, 0] : defaultOffset;

module assembleNumberOld(num, firstHoleOffset=[0, 0, 0], secondHoleOffset=[0, 0, 0], thirdHoleOffset=[0, 0, 0]) {
    translate([0, 0, customHeight])
        rotate([0, 180, 0])
            union() {
                difference() {
                    makeNumber(num);
                    translate(firstHoleOffset)
                        drillhole();
                    translate(secondHoleOffset)
                        drillhole();
                    translate(thirdHoleOffset)
                        drillhole();
                }
            translate(firstHoleOffset)
                spacer();
            translate(secondHoleOffset)
                spacer();
            translate(thirdHoleOffset)
                spacer();
        }
}

module assembleNumber(num, firstHoleOffset=[0, 0, 0], secondHoleOffset=[0, 0, 0], thirdHoleOffset=[0, 0, 0]) {
    union() {
        difference() {
            makeNumber(num);
            translate(firstHoleOffset)
                drillhole();
            translate(secondHoleOffset)
                drillhole();
            translate(thirdHoleOffset)
                drillhole();
        }
        translate(firstHoleOffset)
            spacer();
        translate(secondHoleOffset)
            spacer();
        translate(thirdHoleOffset)
            spacer();
    }
}

module makeNumber(num) {
    linear_extrude(customHeight)
        rotate([0, 180, 0])
            text(num, size=customFontSize, font=customFontName, halign="center");
}


module drillhole() {
    translate([0, 0, -0.01])
        cylinder(h=customHeight+1, d=screwHeadDiameter);
}
    
module spacer() {
    screwheadHeight = (screwHeadDiameter - screwDiameter) / 2 + 1;
    translate([0, 0, spacerInset])
        difference() {
            cylinder(h=customHeight - spacerInset + spacerHeight, d=screwHeadDiameter);
            translate([0, 0, -0.01])
                cylinder(h=customHeight + spacerHeight + 1, d=screwDiameter);
            translate([0, 0, -0.01])
                cylinder(h=screwheadHeight, d1=screwHeadDiameter, d2=screwDiameter);
        }
}
