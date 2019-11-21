/* [Basic Settings] */
Start=180;  // [180:220]
Step=5; // [1:10]
End=220; // [190:260]
Tower_Distance=30; // [20:60]
Base_Thickness=2; // [1:5]

/* [Advanced] */
NOTCH_SIZE=1; // [1:3]

/* [Hidden] */
CUBE_SIZE=10;
FONT_SIZE=4;
FONT_X=CUBE_SIZE / 2;
FONT_Z=NOTCH_SIZE + (CUBE_SIZE - NOTCH_SIZE) / 2;

module TempCube(temp) {
    difference() {
        cube(CUBE_SIZE);

        translate([0, 0, 0]) {
            cube([CUBE_SIZE, NOTCH_SIZE, NOTCH_SIZE]);
        }
        translate([0, 0, 0]) {
            cube([NOTCH_SIZE, CUBE_SIZE, NOTCH_SIZE]);
        }
        translate([0, CUBE_SIZE - NOTCH_SIZE, 0]) {
            cube([CUBE_SIZE, NOTCH_SIZE, NOTCH_SIZE]);
        }
        translate([CUBE_SIZE - NOTCH_SIZE, 0, 0]) {
            cube([NOTCH_SIZE, CUBE_SIZE, NOTCH_SIZE]);
        }

        translate([FONT_X, 0.5, FONT_Z]) rotate([90, 0, 0]) linear_extrude(1) text(temp, FONT_SIZE, halign="center", valign="center");
    }
}

module TempStack() {
    m_start = Start > End ? Start : End;
    m_end = End < Start ? End : Start;
    m_step = -1 * Step;

    for(i = [m_start : m_step : m_end]) {
        o = (i - m_start) / m_step;
        translate([
            0,
            0,
            o * CUBE_SIZE
        ]) {
            TempCube(str(i));
        }
    }
}

module Base() {
    cube([
        CUBE_SIZE * 2 + Tower_Distance,
        CUBE_SIZE * 2,
        Base_Thickness
    ]);
}

module CalibrationTowers() {
    translate([CUBE_SIZE / 2, CUBE_SIZE / 2, Base_Thickness]) TempStack();

    translate([CUBE_SIZE / 2 + Tower_Distance, CUBE_SIZE / 2, Base_Thickness]) TempStack();

    Base();
}

CalibrationTowers();
