/* [Main Dimensions] */
// Upper Diameter (mm)
UPPER_DIA = 21;
// Lower Diameter (mm)
LOWER_DIA = 40;
// Upper Length (mm)
UPPER_LENGTH = 30;
// Lower Length (mm)
LOWER_LENGTH = 30;

/* [Tooth Options] */
// Number of teeth
N_TEETH = 2;
// Depth of teeth
TOOTH_DEPTH = 1;

/* [Various] */
$fn = 60;
THICKNESS = 2;
CHAMFER_LENGTH = 10;

tooth_offset = UPPER_LENGTH / 4;
tooth_length = (UPPER_LENGTH - CHAMFER_LENGTH - tooth_offset) / N_TEETH;
tooth_outer_dia = UPPER_DIA + 2*TOOTH_DEPTH;

difference () {
    // Outer solid
    union () {
        // Lower part
        cylinder(d = LOWER_DIA, h = LOWER_LENGTH);

        // Chamfer
        translate([0 ,0, LOWER_LENGTH])
            cylinder(d1 = LOWER_DIA, d2 = UPPER_DIA, h = CHAMFER_LENGTH);

        // Upper part
        translate([0, 0, LOWER_LENGTH])
            cylinder(d = UPPER_DIA, h = UPPER_LENGTH);

        // Teeth
        if (N_TEETH > 0) {
            for (i = [0 : N_TEETH - 1]) {
                translate([0, 0, LOWER_LENGTH + CHAMFER_LENGTH + tooth_offset + i*tooth_length])
                    cylinder(d1 = tooth_outer_dia, d2 = UPPER_DIA, h = tooth_length);
            }
        }
    }

    // Hollow out
    cylinder(d = LOWER_DIA - 2*THICKNESS, h = LOWER_LENGTH);
    translate([0, 0, LOWER_LENGTH])
        cylinder(d1 = LOWER_DIA - 2*THICKNESS, d2 = UPPER_DIA - 2*THICKNESS, h = CHAMFER_LENGTH);
    translate([0, 0, LOWER_LENGTH])
        cylinder(d = UPPER_DIA - 2*THICKNESS, h = UPPER_LENGTH);
}
