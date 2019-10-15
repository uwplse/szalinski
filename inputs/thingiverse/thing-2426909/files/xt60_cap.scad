width = 6.5;
length1 = 12;
lengthTotal = 14.4;
widthTop = 2;

innerHeight = 9.5;
innerHeight1 = 8.3;

bottom = 1.2;
skirt = 1.2;
walls = 1.2;

xOffsetGuide = 6.25;
guideLength = 1.2;
guideWidth = 1.5;

/* [Hidden] */
outerHeight = bottom + innerHeight;
outerWidth = width + walls * 2;
ratio = outerWidth / width;

outerWidthTop = widthTop * ratio;

outerLength1 = length1 + walls;

outerBottomLength1 = outerLength1 + skirt;
outerBottomWidth = outerWidth + skirt * 2;
outerBottomWidthTop = outerWidthTop * ratio;

hull() {
    translate([-skirt, -skirt, 0])
        cube([outerBottomWidth, outerBottomLength1, bottom]);

    translate([(outerWidth - outerBottomWidthTop) / 2, lengthTotal + walls * 2 + skirt - 0.1, 0])
        cube([outerBottomWidthTop, 0.1, bottom]);
}

translate([0, 0, bottom]) {
    difference() {
        hull() {
            cube([outerWidth, outerLength1, innerHeight]);
        
            translate([(outerWidth - outerWidthTop) / 2, lengthTotal + walls * 2 - 0.1, 0])
                cube([outerWidthTop, 0.1, innerHeight]);
        }
        
        translate([walls, walls, bottom + innerHeight - innerHeight1]) {
            hull() {
                cube([width, length1, innerHeight]);
        
                translate([(width - widthTop) / 2, lengthTotal - 0.1, 0])
                    cube([widthTop, 0.1, innerHeight]);
            }
        }
        
        translate([walls, walls + xOffsetGuide - guideWidth / 2, 0])
            cube([width -walls, guideWidth * 2, innerHeight]);
    }
    
    translate([walls + width - guideLength, walls + xOffsetGuide, 0]) {
        cube([guideLength, guideWidth, innerHeight]);
    }
}