baseSize = 35;
rounding = 2;

numCords = 6;
cordWidth = 6;
cordSpacing = 10;
cordOuterSpacing = 6;

difference() {
    linear_extrude(height = (numCords * (cordWidth + cordSpacing)) - cordSpacing + (cordOuterSpacing * 2)) {
        translate([rounding, rounding, 0])
        scale(1 - ((rounding * 2) / baseSize))
        offset(rounding, $fn=40) {
            intersection() {
                difference() {
                    translate([0, -baseSize * 0.1, 0]) scale([1, 0.8]) circle(baseSize, $fn=180);

                    circleBase = baseSize / 2.8;
                    translate([circleBase + (baseSize / 10), 0, 0]) {
                        circle(circleBase, $fn=100);
                        intersection() {
                            scale([1.2, 1]) circle(circleBase, $fn=100);
                            translate([0, -circleBase, 0]) square(circleBase * 2);
                        }
                    }
                    /*translate([baseSize * .2, ((baseSize * 0.8) / 5) * 3, 0]) circle(baseSize / 7, $fn=40);*/
                }
                square(baseSize);
            }
        }
    }

    for (space = [cordOuterSpacing:cordWidth + cordSpacing:(numCords * (cordWidth + cordSpacing))]) {
        translate([baseSize / 3, 0, space]) {
            slot = cordWidth;
            cube([baseSize, baseSize, slot]);
            translate([0, 0, slot / 2]) {
                rotate(-90, [1, 0, 0]) {
                    cylinder(h = baseSize, d = slot, $fn=40);
                }
            }
        }
    }
}
