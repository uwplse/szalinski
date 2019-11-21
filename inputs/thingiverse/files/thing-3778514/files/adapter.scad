/* [Global] */
wallThickness = 2;

/* [Hose] */
// What is the minimal inside diameter of a external hose you would like to connect?
yourHoseMinInsideDia = 34.3;
// What is the maximal inside diameter of a external hose you would like to connect?
yourHoseMaxInsideDia = 35.3;
// How high should the hose adapter end be? Keep in mind that the steeper the angle the more will your hose fall out. It seems reasonable to give at least 10mm for each 1mm of taper.
hoseAdapterHeight = 40;
/* [Internal] */
// Height of the middle part between hose taper and Festool locking mechanism. Unless you have wastly different port and hose diameters, you can probably keep it fairly small (10mm).
taperBetweenPartsHeight = 10; 
/* [Festool] */
// I've successfully tested 25mm with the Cleantec port on Festool Domino DF500, which is branded as DF27.
festoolPortOutsideDia = 27.72;
// TODO 25mm was too small !!! test sample 1 against the domino

module hoseAdapter(taperHeight, outsideDiaBot, outsideDiaTop) {
    insideDiaBot = outsideDiaBot - 2*wallThickness;
    insideDiaTop = outsideDiaTop - 2*wallThickness;

    rotate_extrude(angle = 360)
    polygon([
        [insideDiaBot/2, 0],
        [outsideDiaBot/2, 0],
        [outsideDiaTop/2, taperHeight],
        [insideDiaTop/2, taperHeight],
    ]);
}

module festoolCleantecPort(insideDia) {
    festoolHeight = 15;

    // festool part
    rotate_extrude(angle = 360)
    polygon([
        [insideDia/2, 0],
        [insideDia/2+2, 0],
        [insideDia/2+2, festoolHeight],
        [insideDia/2, festoolHeight],
    ]);

    // festool lock
    lockHeight = 8;
    lockWallHeight = 5;
    lockAngleFill = 360/6 - 10;
    lockAngleSpace = (360 - 3*lockAngleFill)/3;
    lockinWallAngle = 3;

    for(angleOffset=[0:lockAngleFill+lockAngleSpace:360])
        group() {
            // depth stop / yank barrier
            rotate(angleOffset)
            translate([0, 0, festoolHeight-lockHeight])
            rotate_extrude(angle = lockAngleFill)
            translate([-insideDia/2, 0, 0])
            square(size=[2,lockHeight]);

            // over-rotation stop
            rotate(angleOffset)
            translate([0, 0, festoolHeight-lockHeight-lockWallHeight])
            rotate_extrude(angle = 10)
            translate([-insideDia/2, 0, 0])
            square(size=[2,lockWallHeight]);

            // rotation lockin minor wall
            rotate(angleOffset-lockinWallAngle+lockAngleFill)
            translate([0, 0, festoolHeight-lockHeight-lockWallHeight])
            rotate_extrude(angle = lockinWallAngle)
            translate([-insideDia/2, 0, 0])
            square(size=[0.5,lockWallHeight]);
        }
}

hoseAdapter(taperHeight = hoseAdapterHeight, outsideDiaBot = yourHoseMinInsideDia, outsideDiaTop = yourHoseMaxInsideDia);
translate([0, 0, hoseAdapterHeight])
    hoseAdapter(taperHeight = taperBetweenPartsHeight, outsideDiaBot = yourHoseMaxInsideDia, outsideDiaTop = festoolPortOutsideDia + 2*wallThickness);
translate([0, 0, hoseAdapterHeight + taperBetweenPartsHeight])
    festoolCleantecPort(insideDia = festoolPortOutsideDia);
