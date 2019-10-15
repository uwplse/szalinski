/*
Github_Avatar_Identicon_3D_Model_Generator.scad by MegaSaturnv
Generate identicons here: http://identicon.net/

To use the module "drawAvatar()" as part of your model, write:

use <Github_Avatar_Identicon_3D_Model_Generator.scad>

at the start of your code. Then drop this file the same directory as your model.
*/

//////////////////////////////////
// Customiser / Parametric code //
//////////////////////////////////

//list/array of strings. String is normally sent as list / array, but customiser requires it to be written like this:
LINE_1 = ".X.X.";
//list/array of strings. String is normally sent as list / array, but customiser requires it to be written like this:
LINE_2 = "XX.XX";
//list/array of strings. String is normally sent as list / array, but customiser requires it to be written like this:
LINE_3 = ".XXX.";
//list/array of strings. String is normally sent as list / array, but customiser requires it to be written like this:
LINE_4 = "..X..";
//list/array of strings. String is normally sent as list / array, but customiser requires it to be written like this:
LINE_5 = "X.X.X";

//Pixel size in mm
PIXEL_SIZE = 2;

//Pixel thickness in mm
PIXEL_THICKNESS = 2;

//Would you like to include a base? true / false
INCLUDE_BASE = true;

//Base thickness in mm
BASE_THICKNESS = 1;

//Base extra size, to create a 'lip' around the github avatar / pixel art
BASE_EXTRA_SIZE = 1;

module drawAvatar(identiconAvatar=" ", pixelSize=1, pixelThickness=1, includeBase=false, baseThickness=1, baseExtraSize=0) {
    for (i = [0 : len(identiconAvatar)-1], j = [0 : len(identiconAvatar[i])-1]) {
        if (!(identiconAvatar[i][j] == " " || identiconAvatar[i][j] == ".")) {
            translate([i*pixelSize, j*pixelSize, 0]) cube([pixelSize, pixelSize, pixelThickness]);
        }
		if (includeBase) {
			translate([i*pixelSize - baseExtraSize, j*pixelSize - baseExtraSize, -baseThickness]) cube([2*baseExtraSize + pixelSize, 2*baseExtraSize + pixelSize, baseThickness]);
		}
    }
}

PIXELS_STRING_LIST = [LINE_1, LINE_2, LINE_3, LINE_4, LINE_5];
drawAvatar(PIXELS_STRING_LIST, PIXEL_SIZE, PIXEL_THICKNESS, INCLUDE_BASE, BASE_THICKNESS, BASE_EXTRA_SIZE);

////////////////////
// Default values //
////////////////////
//drawAvatar(" ", 1, 1, false, 1, 0);

////////////////////
//    Examples    //
////////////////////
//list / array of strings. Any character which isn't a space or . is counted as a pixel
/*
avatar = [
    " X X ",
    "XX XX",
    " XXX ",
    "  X  ",
    "X X X"];
*/
//drawAvatar(avatar, 2, 2, true, 1, 1);
//drawAvatar(avatar, 2, 2, true, 2);
//drawAvatar(avatar, 4, 1);
//drawAvatar(avatar);
