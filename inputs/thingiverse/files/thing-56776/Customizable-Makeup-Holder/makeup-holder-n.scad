
// -------------------------------------------------------------
// Customizable makeup holder.
//
// OpenSCAD script to generate a multi-slot make-up holder.  I
// found myself building roughly the same model multiple times,
// for different dimensions of make-up products for my wife. I 
// realized it was faster to find a way to script the creation
// instead, and wound up generating this. 
// 
// Yes, the formatting of the script is odd; it's set up to fit
// half-screened on an ultra-book, which winds up about ~65 chars
//
// James Long (james@jameslong.org)
// -------------------------------------------------------------

// -------------------------------------------------------------
// Holder specific settings - things you must change for each
// custom model. 
// -------------------------------------------------------------


// Tells customizer to show from the front.
// preview[view:north west, tilt:top diagonal]

// Number of rows in the holder.
HEIGHT_SLOTS = 5; // [1:10]

// Number of columns in the holder.
WIDTH_SLOTS = 2; // [1:10]

// Width of the item to be stored.
DIAMETER = 38;// [15:75]

// Height of the item to be stored. 
ITEM_HEIGHT = 25; // [15:50]

// -------------------------------------------------------------
// Customization - settings that work, by default, but may be
//     customized to your preferences.
// -------------------------------------------------------------

// Width of the walls.
WALLS = 2; // [1:2]

// Width of the vertical backstop.
BACKSTOP_WIDTH=5; // [2:5]

// Size of the nibble to take out of the side walls.
WALL_NIBBLE_HEIGHT=5; // [5:15]

// Height of the nibble to take out of the side walls.
WALL_NIBBLE_RECT_WIDTH=7.5; // [5:15]

// -------------------------------------------------------------
// Internal variables.
// -------------------------------------------------------------

// Internal common variables.
WIDTH = DIAMETER + 1;
HEIGHT = ITEM_HEIGHT + 1;
OVERALL_WIDTH = (WIDTH + WALLS) * WIDTH_SLOTS + WALLS;
OVERALL_HEIGHT = (HEIGHT + WALLS) * HEIGHT_SLOTS + WALLS;
OVERALL_DEPTH = DIAMETER + WALLS;

// Spit out the overall dimensions.
echo(str("Dimensions are ", OVERALL_WIDTH, "x", OVERALL_HEIGHT, "x", OVERALL_DEPTH));

// Overall union to build the object.
union() {
 
   // Build the base - a full diameter rectangle.
   cube([OVERALL_WIDTH, DIAMETER + WALLS, WALLS]); 

   // Generate the rectangular portion of the shelves.
   for (level = [1 : HEIGHT_SLOTS]) {
     translate([0, 0, level * (HEIGHT + WALLS)]) {
       cube([(WIDTH + WALLS) * WIDTH_SLOTS + WALLS,
             DIAMETER/2 + WALLS,
             WALLS]); 
     }

     // The topmost shelf is just the rectangular portion.
     if (level < HEIGHT_SLOTS) {
       // The rest of the slots halve a half-cylinder ledge with
       // a chunk cut out to help you grab items out of it.
       for (x = [0 : WIDTH_SLOTS -1]) {
         translate([WALLS + (x + .5) * (WIDTH + WALLS), WALLS + DIAMETER/2, (HEIGHT + WALLS) * level]) {
           difference() {
             // Generate the cylinder.  This is a little sloppy -
             // rather than generating a half cylinder, we're
             // assuming we can just fuse the back half of the 
             // cylinder with the rectangular shelf 
             cylinder(r=DIAMETER/2, h=WALLS);
             // Offset to the far end of the cylinder, and 
             // subtract a smaller scaled cylinder out of it.
             translate([0, DIAMETER/2, -1]) {
               scale([1,2,1]) cylinder(r=DIAMETER/4, h=WALLS+2);
             }
           }
         }
       } 
     }
   }

   // Generate the vertical backstop walls that span the middle
   // of each slot.
   for (x = [0 : WIDTH_SLOTS - 1]) {
     translate([WALLS + (x) * (WIDTH + WALLS) + WIDTH / 2.0 - BACKSTOP_WIDTH/2.0, 0, 0]) {
       cube([BACKSTOP_WIDTH, WALLS, OVERALL_HEIGHT]); 
     }
   }

   // Diamonds on the backstop, to give added support and keep
   // the wall from getting damaged when removing it from the
   // build plate.
   for (z = [0 : HEIGHT_SLOTS]) {
     for (x = [0 : WIDTH_SLOTS]) {
       // Create the diamond shape at the intersection of the
       // vertical walls and the shelf. 
       intersection() {
         translate([x * (WALLS+WIDTH) + WALLS/2, WALLS/2, z * (WALLS+HEIGHT) + WALLS/2]) {
           rotate(45, [0,1,0]) cube([10, WALLS, 10],center=true);           
         }
         translate([-.01,-.01,-.01]) cube([OVERALL_WIDTH, WALLS+2, OVERALL_HEIGHT]);
       }

       // Add the diamond on the right side of the intersection
       // of the backstop and the shelf.
       intersection() {         
         translate([(WALLS + x * (WALLS+WIDTH) + WIDTH / 2.0 + BACKSTOP_WIDTH / 2), WALLS/2, z * (WALLS+HEIGHT) + WALLS/2]) {
           rotate(45, [0,1,0]) cube([10, WALLS, 10],center=true);           
         }
         translate([-.01,-.01,-.01]) cube([OVERALL_WIDTH, WALLS+2, OVERALL_HEIGHT]);
       }
       // Add the diamond on the left side of the intersection
       // of the backstop and the shelf.
       intersection() {         
         translate([(WALLS + x * (WALLS+WIDTH) + WIDTH / 2.0 - BACKSTOP_WIDTH / 2.0), WALLS/2, z * (WALLS+HEIGHT) + WALLS/2]) {
           rotate(45, [0,1,0]) cube([10, WALLS, 10],center=true);           
         }
         translate([-.01,-.01,-.01]) cube([OVERALL_WIDTH, WALLS+2, OVERALL_HEIGHT]);
       }
     }
   }

   // Generate the vertical walls between the slots.
   difference() {
     // Each of the vertical rectangular solids.
     for (wall = [0 : WIDTH_SLOTS]) {
       translate([wall * (WIDTH + WALLS), 0, 0]) {
         cube([WALLS,
               DIAMETER / 2+WALLS,
               (HEIGHT + WALLS) * HEIGHT_SLOTS + WALLS]);
       }
     } 
     // Subtracting out a finger slot in the sides by subtracting 
     // a cylinder and a rectangular solid from the walls.
     union() { 
       for (level = [0 : HEIGHT_SLOTS]) {
         translate([-1, DIAMETER/2-WALL_NIBBLE_RECT_WIDTH + WALLS, (level+0.5) * (HEIGHT + WALLS)]) {
           rotate(90, [0,1,0]) cylinder(h=OVERALL_WIDTH+2, r=WALL_NIBBLE_HEIGHT/2);
           translate([0, 0, -WALL_NIBBLE_HEIGHT/2]) cube([OVERALL_WIDTH+2,WALL_NIBBLE_RECT_WIDTH+1,WALL_NIBBLE_HEIGHT]);
         }
       }
     }
   }
}