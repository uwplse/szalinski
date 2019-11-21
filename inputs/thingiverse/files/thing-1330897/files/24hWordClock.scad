X_SIZE=150.0;               //X-Size of the box
Y_SIZE=150.0;               //Y-Size of the box
Z_SIZE=50;                  //Height of the box
X_CHAR_SPACE=7.62;      // Space between the characters (LEDs) in X direction.
Y_CHAR_SPACE=8.5725;    // Space between the characters (LEDs) in Y direction.
FONT_SIZE=5.0;              // Approx size of the characters.
WALL_THICKNESS = 4.0;   // Thickness of the walls
SPACER_HEIGHT = 20;     // Height of the spacer box above the frontplate
CORNER_RADIUS = 5.0;    // Radius of the corners from the box.

//Text to be printed. It must have 18 characters and 16 lines. "#" will be replaced with random characters (A..Z)
Text=[
    "ES#IST#VIERTELEINS",
    "DREINERSECHSIEBEN#",
    "ELFÜNFNEUNVIERACHT",
    "NULLZWEI#ZWÖLFZEHN",
    "UND#ZWANZIGVIERZIG",
    "DREISSIGFÜNFZIGUHR",
    "MINUTEN#VORBISNACH",
    "UNDHALBDREIVIERTEL",
    "SIEBENEUNULLZWEINE",
    "FÜNFSECHSACHTVIER#",
    "DREINSUND#ELF#ZEHN",
    "ZWANZIG###DREISSIG",
    "VIERZIGZWÖLFÜNFZIG",
    "MINUTENUHR#FRÜHVOR",
    "ABENDSMITTERNACHTS",
    "MORGENS....MITTAGS"
];

// Font to be used. It must be a stencil font!
Font = "Taurus Mono Stencil:style=Bold";

// Internal stuff and program.
rows = len(Text);
cols = len(Text[0]);
x_offset = (X_SIZE - (cols - 1 ) * X_CHAR_SPACE) / 2.0;
y_offset = (Y_SIZE - (rows - 1) * Y_CHAR_SPACE ) / 2.0;
thickness = WALL_THICKNESS;
SpacerHeight = SPACER_HEIGHT;
CornerRadius_2 = CORNER_RADIUS / 2.0;

/*
 * This module creates a flat frontplate. This can be exported to a dxf-file.
 */
module FrontPlate(){
    difference(){
        square([X_SIZE,Y_SIZE]);
        union(){
            for (ypos = [0:1:rows-1]){
                for (xpos = [0:1:cols-1]){
                    translate([x_offset + xpos*X_CHAR_SPACE, Y_SIZE - y_offset - ypos*Y_CHAR_SPACE,0]){
                        Ersatz = rands(65,90,1);
                        Zeichen = len(search("#", Text[ypos][xpos]))==0 ? Text[ypos][xpos] : chr(Ersatz);
                        text(Zeichen,
                            size= FONT_SIZE,
                            font= Font,
                            halign = "center",
                            valign = "center",
                            $fn=10);
                    };
                };
            };
        };
    };
};

/*
 * Creates a 3D Frontplate with WALL_THICKNESS. It's used to create the box.
 */
module FrontPlate3D(){
    linear_extrude(thickness){
        union(){
            for (ypos = [0:1:rows-1]){
                for (xpos = [0:1:cols-1]){
                    translate([x_offset + xpos*X_CHAR_SPACE, Y_SIZE - y_offset - ypos*Y_CHAR_SPACE, 0]){
                        Ersatz = rands(65,90,1);
                        Zeichen = len(search("#", Text[ypos][xpos]))==0 ? Text[ypos][xpos] : chr(Ersatz);
                        text(Zeichen,
                            size= FONT_SIZE,
                            font= Font,
                            halign = "center",
                            valign = "center",
                            $fn=16);
                    };
                };
            };
        };
    };
};

/*
 * This creates the spacerbox. Can be exported to a dxf-file.
 */
module LedSpacer(){
    difference(){
        square([X_SIZE,Y_SIZE]);
        union(){
            for (ypos = [0:1:rows-1]){
                for (xpos = [0:1:cols-1]){
                    translate([x_offset + xpos*X_CHAR_SPACE, Y_SIZE - y_offset - ypos*Y_CHAR_SPACE,0]){
                            square(size=[X_CHAR_SPACE-thickness/2,Y_CHAR_SPACE-thickness/2],center = true);
                    };
                };
            };
        }
    };
};

/*
 * 3D Led-Spacer with the height of SPACER_HEIGHT.
 */
module LedSpacer3D(){
    union(){
        for (ypos = [0:1:rows-1]){
            for (xpos = [0:1:cols-1]){
                translate([x_offset + xpos*X_CHAR_SPACE, Y_SIZE - y_offset - ypos*Y_CHAR_SPACE,SpacerHeight/2]){
                        cube(size=[X_CHAR_SPACE-thickness/2,Y_CHAR_SPACE-thickness/2, SpacerHeight],center = true);
                };
            };
        };
    }
}
module Space3D(){
    $fn=32;
    radius = CORNER_RADIUS - thickness ;
    translate([radius + thickness, radius + thickness, 0]){
        minkowski(){
            cube([X_SIZE - 2.0 * thickness - 2.0 * radius, Y_SIZE - 2.0 * thickness -  2.0 * radius , (Z_SIZE - (thickness + SpacerHeight)) / 2.0] );
            cylinder(r=radius, (Z_SIZE - (thickness + SpacerHeight)) / 2.0);
        };
    };
}
module BackPlate3D(){
    $fn=32;
    radius = CORNER_RADIUS - thickness / 2.0;
    translate([radius + thickness / 2.0, radius + thickness / 2.0, 0]){
        minkowski(){
            cube([X_SIZE - thickness - 2.0 * radius, Y_SIZE - thickness -  2.0 * radius , thickness / 2.0]);
            cylinder(r=radius, thickness / 2.0);
        };
    };
};

module CutOut(){
    union(){
        // cut out the frontplate
        translate([0,0,Z_SIZE - thickness])
        {
            FrontPlate3D();
        };
        //cut out the spacer
        translate([0,0,Z_SIZE - thickness - SpacerHeight]){
            LedSpacer3D();
        }
        // Space in box
        Space3D();
        // cut out for a backplate.
        BackPlate3D();
    };
    
}

/*
 * "main" of the box. creates the box for the 24h-WordClock.
 */
module main(){
    $fn=32;
        
    difference(){
        translate([CORNER_RADIUS, CORNER_RADIUS, 0]){
            minkowski(){
                cube([X_SIZE -  2 * CORNER_RADIUS, Y_SIZE - 2 * CORNER_RADIUS, Z_SIZE / 2.0]);
                cylinder(r=CORNER_RADIUS, Z_SIZE / 2.0);
            }
        };
        CutOut();
    };
};

main();
//BackPlate();
//CutOut();
//Space3D();



/*
union(){
    linear_extrude(height = thickness){
        translate([X_SIZE,0,0]){
            mirror([1,0,0]){
                FrontPlate();
            };
        };
    };
    translate(0,0,thickness){
        linear_extrude(height = SpacerHeight){
            LedSpacer();
        };
    };
};
*/
