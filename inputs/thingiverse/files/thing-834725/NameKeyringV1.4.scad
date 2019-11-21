/* [Text & Font] */

// for your keyring
Font_name = "Racing Sans One"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

// for your keyring
Text = "#iamburny";

// of the preview
Rotation = 50; // [0:5:360]

/* [Spacing and Height] */

// between letters adjust the overlap (e.g. 5 letters = 5 comma seperated numbers [5,5,4.8,4.2,4])
spacing = [10,11,11,14,15,15,15,15,15];

// of each letter (e.g. 5 letters = 5 comma seperated numbers [4,3,3.5,3,4])
height = [5,6,4,5,4,3,5,4,6];

/* [ Twist ] */

// angle in degrees
twist = -3; // [-10:0.5:10]

// of twist rotation
center = 60; // [0:1:70]

/* [ Loop Settings ] */

// adjument
Loop_x_position = -125; // [-150:1:50]

// adjument
Loop_y_position = 0; // [-20:1:20]

// to use (default : u)
Loop_character = "o";

// to use (default : Chewy)
Loop_font = "Chewy"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

rotate([0,0,Rotation]) {

    linear_extrude(height = 3, $fn = 100) {
        translate ([-center-Loop_x_position,Loop_y_position,0]) rotate([0,0,-90]) 
        text(size = 20, text = Loop_character, font = Loop_font, halign = "center", valign= "center", $fn = 100);
    }

    for (i = [0 : len(Text) -1]) {
       linear_extrude(height = height[i], twist = twist, $fn = 100) {
            translate ([(spacing[i]*i)-center,0,0])
            text(size = 25, text = Text[i], font = Font_name, halign = "center", valign= "center", $fn = 100);
        } 
    }
}
