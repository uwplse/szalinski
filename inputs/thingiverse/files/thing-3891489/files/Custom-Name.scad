/*[User Defined Variables]*/

//String to be printed
name = "Your Name here";

//Size of the letters (in mm)
letterSize = 5;

//X Tolerance (in mm)
widthTolerance = -20;

//Y Tolerance (in mm)
lengthTolerance = 5;

//Height (in mm)
height = 5;

//How far the letter extrude goes for the string(MAX SIZE IS THE HEIGHT)
letterExtrude = 4; 

// Computation
stringLength = len(name);
width = (stringLength * (letterSize)) + widthTolerance;
length = letterSize + lengthTolerance;
difference() {
    translate([0,0,height/2]) cube([width,length,height], center=true);
    translate([0,0,height - letterExtrude]) {
        // convexity is needed for correct preview
        // since characters can be highly concave
        linear_extrude(height, convexity=4)
            text(name, 
                 letterSize,
                 font="Bitstream Vera Sans",
                 halign="center",
                 valign="center");
    }
}