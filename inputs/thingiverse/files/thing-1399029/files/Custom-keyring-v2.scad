/* [Text & Font] */

// for your keyring
Font_name = "Racing Sans One"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

// for your keyring
Text = "Noémi";

// of the preview
Rotation = 50; // [0:5:360]

/* [Spacing and Height] */

letter_1_height = 6; // [-20:1:20]
letter_1_space = 12; // [-20:1:20]
letter_1_y = 0; // [-20:1:20]
letter_1_rotation = 0; // [-45:1:45]

letter_2_height = 5; // [-20:1:20]
letter_2_space = 12; // [-20:1:20]
letter_2_y = 0; // [-20:1:20]
letter_2_rotation = 0; // [-45:1:45]

letter_3_height = 4; // [-20:1:20]
letter_3_space = 13; // [-20:1:20]
letter_3_y = 0; // [-20:1:20]
letter_3_rotation = 0; // [-45:1:45]

letter_4_height = 6; // [-20:1:20]
letter_4_space = 13; // [-20:1:20]
letter_4_y = 4; // [-20:1:20]
letter_4_rotation = 0; // [-45:1:45]

letter_5_height = 4; // [-20:1:20]
letter_5_space = 10; // [-20:1:20]
letter_5_y = 0; // [-20:1:20]
letter_5_rotation = 0; // [-45:1:45]

letter_6_height = 5; // [-20:1:20]
letter_6_space = 10; // [-20:1:20]
letter_6_y = 0; // [-20:1:20]
letter_6_rotation = 0; // [-45:1:45]

/* [ Twist ] */

// angle in degrees
twist = -5; // [-10:0.5:10]

// of twist rotation
center = 20; // [0:1:70]

/* [ Loop Settings ] */

// adjument
Loop_x_position = 12; // [-150:1:50]

// adjument
Loop_y_position = 0; // [-20:1:20]

Loop_rotation = 90; // [0:5:360]

Loop_size = 20; // [10:1:30]

// to use (default : u)
Loop_character = "o";

// to use (default : Chewy)
Loop_font = "Chewy"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

/* [Hidden */

// between letters adjust the overlap (e.g. 5 letters = 5 comma seperated numbers [5,5,4.8,4.2,4])
spacing = [0,letter_1_space,letter_2_space,letter_3_space,letter_4_space,letter_5_space,letter_6_space];

// of each letter (e.g. 5 letters = 5 comma seperated numbers [4,3,3.5,3,4])
height = [letter_1_height,letter_2_height,letter_3_height,letter_4_height,letter_5_height,letter_6_height];
yoffset = [letter_1_y,letter_2_y,letter_3_y,letter_4_y,letter_5_y,letter_6_y];
letter_rotation = [letter_1_rotation,letter_2_rotation,letter_3_rotation,letter_4_rotation,letter_5_rotation,letter_6_rotation];

rotate([0,0,Rotation]) {

    linear_extrude(height = 3, $fn = 100) {
        translate ([-center-Loop_x_position,Loop_y_position,0]) rotate([0,0,Loop_rotation]) 
        text(size = Loop_size, text = Loop_character, font = Loop_font, halign = "center", valign= "center", $fn = 100);
    }

    for (i = [0 : len(Text) -1]) {
       linear_extrude(height = height[i], twist = twist, $fn = 100) {
            translate ([(spacing[i]*i)-center,yoffset[i],0]) rotate([0,0,letter_rotation[i]]) 
            text(size = 25, text = Text[i], font = Font_name, halign = "center", valign= "center", $fn = 100);
        } 
    }
}

