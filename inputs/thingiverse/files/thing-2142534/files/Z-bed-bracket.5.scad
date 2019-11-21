// This is, essentially, a complete re-do of this item on thingiverse:
// https://www.thingiverse.com/thing:1808029
//
// Bill Kearney, 2017
// NOT for commercial reproduction or use

// How much should the bed be raised? Use calipers to measure your glass thickness. Note: 1/8" = 3.175mm, 3/8" = 9.525mm
ADDED_BED_HEIGHT = 4; // [0.8, 1, 2, 3, 3.125, 3.175, 4, 5, 6, 9.525]

// How wide you want the spacer to be?  7mm is about the max.
SPACER_WIDTH = 5; // [5,6,7]

// How deep should the top hook be? 
TOP_HOOK_DEPTH = 2.0; // [2.0, 3.0, 4.0]
// How deep should the bottom hook be? 
BOTTOM_HOOK_DEPTH = 3.0; // [2.0, 3.0, 4.0]

// How far forward should the top hook extend? 
TOP_HOOK_LENGTH = 5.0; // [3.0, 4.0, 5.0]
// How far forward should the bottom hook extend? 
BOTTOM_HOOK_LENGTH = 8.0; // [5.0, 6.0, 7.0, 8.0]

// Add insertion levers on the back?  These let you insert and remove from the machine without taking it apart.
INCLUDE_LEVERS = 1; // [0,1]
// How far back should the levers extend? 
LEVER_LENGTH = 36;

// Add a flag showing the added height?  1=Show the size flag 0=Leave it off
INCLUDE_FLAG = 1; // [0,1]  

// Add a small pin to help hold the bracket in place?  1=Add a pin 0=No pin
INCLUDE_CATCH = 1; // [0,1]  
// Distance from back of gantry to indent for catch pin
CATCH_GAP = 5.5;
// Size of catch
CATCH_THICKNESS = 1;
// Width of catch
CATCH_WIDTH = 2;
// Depth of catch
CATCH_HEIGHT = 2;

// Vertical size of gantry bracket
GANTRY_HEIGHT = 35.19;
// Horizontal (front-back) size of gantry bracket
GANTRY_DEPTH = 29.5;

// Thickness of bottom lever
BOTTOM_THICKNESS = 3;
// Thickness of top lever
TOP_THICKNESS = 3;
// Thickness of upright post
UPRIGHT_THICKNESS = 2.5;

// How tall to make the added bed height number
FLAG_CHARACTER_SIZE = 8;  
// How far to make the number stand out from the flag
FLAG_EXTRUSION = 3;
// How tall to make the flag
FLAG_HEIGHT = 12; 
// How thick to make the flag
FLAG_THICKNESS = 1; 

// What font to use for the number?
FONT_NAME="Basic Sans Serif 7:style=Regular"; // ["Arial:style=Black","Arial:style=Narrow Bold","Basic Sans Serif 7:style=Regular","Candara","Chewy","Comic Sans MS","Liberation Sans"

//FONT_NAME="Arial:style=Black";
//FONT_NAME="Arial:style=Narrow Bold";
//FONT_NAME="Comic Sans MS";
//FONT_NAME="Liberation Sans";

module letter(l,s,x) {  // raised lettering 
    rotate([90,0,0])
    linear_extrude(height = x) {
        text(l, size = s, halign = "center", font = FONT_NAME, valign = "center", $fn = 32);
    }
}

module prism(l, w, h){  // tips on ends of brackets
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module make_bracket() {  // main routine to create the bracket
    rotate([-90,0,-90]){  // turned over onto the side to facilitate importing for 3D printing
        translate([0,0,0])
        cube([GANTRY_DEPTH,SPACER_WIDTH,ADDED_BED_HEIGHT], center=false);
        
        translate([-UPRIGHT_THICKNESS,0,0])
        cube([UPRIGHT_THICKNESS,SPACER_WIDTH,ADDED_BED_HEIGHT+GANTRY_HEIGHT+TOP_THICKNESS], center=false);
        
        translate([0,0,ADDED_BED_HEIGHT+GANTRY_HEIGHT])
        cube([GANTRY_DEPTH,SPACER_WIDTH,TOP_THICKNESS], center=false);

        // bottom hook
        translate([GANTRY_DEPTH+BOTTOM_HOOK_LENGTH,0,0])
        rotate([0,0,90])
        prism(SPACER_WIDTH,BOTTOM_HOOK_LENGTH,ADDED_BED_HEIGHT+BOTTOM_HOOK_DEPTH);
        
        // top hook
        translate([GANTRY_DEPTH+TOP_HOOK_LENGTH,SPACER_WIDTH,ADDED_BED_HEIGHT+GANTRY_HEIGHT+TOP_THICKNESS])
        rotate([0,180,90])
        prism(SPACER_WIDTH,TOP_HOOK_LENGTH,TOP_THICKNESS+TOP_HOOK_DEPTH);
        
        // I should note that my son, Will, got to file his first-ever bug report.
        // He asked me to try all kinds of crazy numbers for the various pieces.
        // During that process it was revealed I was using the wrong variable to calculate the top hook.
        // SQA to the rescue!
        
        if (INCLUDE_LEVERS){
            translate([-LEVER_LENGTH-UPRIGHT_THICKNESS,0,0])
            cube([LEVER_LENGTH,SPACER_WIDTH,BOTTOM_THICKNESS], center=false);

            translate([-LEVER_LENGTH-UPRIGHT_THICKNESS,0,ADDED_BED_HEIGHT+GANTRY_HEIGHT])
            cube([LEVER_LENGTH,SPACER_WIDTH,TOP_THICKNESS], center=false);
        }
        
        if (INCLUDE_FLAG){
            if (INCLUDE_LEVERS) {
                HEIGHT_LEN = len(str(ADDED_BED_HEIGHT));
                
                // so what is this clever bit of ? logic?  
                FLAG_WIDTH = HEIGHT_LEN > 1 ? FLAG_CHARACTER_SIZE * HEIGHT_LEN : FLAG_CHARACTER_SIZE * 2;
                // It's to work around openSCAD way of handling variable scopes
                // can't use an if{} scope because any changes would only work inside that scope
                // this way the FLAG_WIDTH can be changed on the fly
                                
                translate([-LEVER_LENGTH-UPRIGHT_THICKNESS+1,SPACER_WIDTH-FLAG_THICKNESS,ADDED_BED_HEIGHT+GANTRY_HEIGHT-FLAG_HEIGHT])
                difference() {
                    union() {
                        cube(size=[FLAG_WIDTH,FLAG_THICKNESS,FLAG_HEIGHT], center = false);
                        translate([FLAG_WIDTH/2,FLAG_THICKNESS,FLAG_HEIGHT/2]) letter(str(ADDED_BED_HEIGHT),FLAG_CHARACTER_SIZE,FLAG_EXTRUSION);
                    }
                }
                
            // I should probably refactor the flag code here into a function... some day...
            
            } else {
                HEIGHT_LEN = len(str(ADDED_BED_HEIGHT));
                
                FLAG_WIDTH = HEIGHT_LEN > 1 ? FLAG_CHARACTER_SIZE * HEIGHT_LEN : FLAG_CHARACTER_SIZE * 2;
                translate([-FLAG_HEIGHT-UPRIGHT_THICKNESS,SPACER_WIDTH-FLAG_THICKNESS,((ADDED_BED_HEIGHT+GANTRY_HEIGHT+TOP_THICKNESS)/2+(FLAG_WIDTH/2))])
                rotate([0,90,0])  //turn it to fit closer to the upright
                difference() {
                    union() {
                        cube(size=[FLAG_WIDTH,FLAG_THICKNESS,FLAG_HEIGHT], center = false);
                        translate([FLAG_WIDTH/2,FLAG_THICKNESS,FLAG_HEIGHT/2]) letter(str(ADDED_BED_HEIGHT),FLAG_CHARACTER_SIZE,FLAG_EXTRUSION);
                    }
                }
                
            }
        }
        if (INCLUDE_CATCH){
            translate([CATCH_GAP,SPACER_WIDTH-CATCH_WIDTH,ADDED_BED_HEIGHT+GANTRY_HEIGHT-CATCH_HEIGHT])
            cube(size=[CATCH_THICKNESS,CATCH_WIDTH,CATCH_HEIGHT], center = false);
        }
    }  // end of rotate{} scope to orient toward the bed for 3D printing
}

make_bracket();