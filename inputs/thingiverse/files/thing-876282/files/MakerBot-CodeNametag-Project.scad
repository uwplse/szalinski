// MakerBot Handbook Tutorial
// OpenSCAD nametag with parameters

// Start by modifying the parameters at the beginning of this document.

// The code is very simple and we've included lots of comments.
// Even if you've never read or written code before, you can do this!

// For more advanced exploration, you can experiment with the 
// trigonometric function and the rest of the code below the parameters. 

/////////////////////////////////////////////////////////////////////
// THE PARAMETERS

// TEXT AND FONT
// Use menu Help / Font List to find the available font names
// You can drag and drop names right from the OpenSCAD Font List
// fontsize controls the letter heights

myword = "Caroline";
myfont="Phosphate:style=Inline";
fontsize = 8;

// TOTAL DIMENSIONS
// Adjust these dimensions to fit the size of your word.
// The "length" is left to right, the "width" is top to bottom.
// The "height" will be the height of the top of the tallest wave.

length = 56; 
width = 15;
height = 8;

// BORDER CURVE STYLE
// Now you can style the border of your nametag!
// The "frequency" controls the number of waves.
// A low number of steps is good for a cool chunky look.
// A large number of steps is smoother, but takes longer to compile.
// You probably won't want to change border, inset, or base.

frequency = 1;
steps = 8;
border = 2;
inset = 2;
base = 2;

/////////////////////////////////////////////////////////////////////
// PRINT THE TEXT

// STEP 3. Translate up and to the right past the border.

translate([ border + inset, border + inset, 0 ]){

    // STEP 2. Pull up the text in the z-direction.
    
    linear_extrude( height = 6 ){
    
        // STEP 1. Write the word in the correct font and size.
        
        text(
            text = myword, 
            font = myfont, 
            size = fontsize, 
            spacing = 1
        );
        
    // This closes the parenthesis for "linear_extrude".
    }

// This closes the parenthesis for "translate".  
}

/////////////////////////////////////////////////////////////////////
// THIS TRIGONOMETRIC FUNCTION CONTROLS THE WAVE
// (don't mess with this unless you are a trigonometry master :)

// The first part ensures that the lowest part is above the base.
// The middle part scales the function to a max height of "height".
// The last line is a shifted trig function with variable frequency.
// The "steps-1" allows one extra step contained in the "width".

function f(x) = 
    2*base + 
    0.5*(height - 2*base)*
    ( cos(frequency*x*360/(steps-1)) + 1 );
    
/////////////////////////////////////////////////////////////////////
// MAKE A WAVY SHAPE AND CUT OUT THE INSIDE

// The "difference" command subtracts the second thing from the first.
// We're going to construct a wavy shape and subtract an interior box.

difference(){
    
    // STEP 1: Make a wavy shape out of a series of retangular boxes.
    
    // Make a rectangular box for each number i = 0, 1, ..., steps-1.
    // To get a better idea of what each step is doing,
    // try replacing "steps-1" with something small like "4" or "8".
    // Then make sure it says "[0:steps-1]" again when you're done!
    
    for( i = [0:steps-1] ){
        
        // Move box "i" to the right by "i*(length/steps)" units,
        // so that box "i" begins right where box "i-1" ends.
        // Note that the width of each box is "length/steps".
        
        translate([ i*(length/steps), 0, 0 ])
            
            // This is box "i", a thin rectangular solid.
            // The box height is determined by the function "f".
            // Put a "#" before "cube" to see the full rectangles,
            // and remove it when you're done.
        
            cube([ length/steps, width, f(i) ]);
        
    // This closes the parentheses of the "for" loop.
    }
    
    // STEP 2: Remove a box on the inside to make room for the text.

    // Translate the box past the left and lower borders, and
    // translate it up to just a tiny bit below the top of the base.
    
    translate([ border, border, base-.1 ])
    
        // This is the cube that is to be removed.
        // The length and width take into account the border size.
        // Put a "#" before "cube" to see the box, 
        // and remove it when you're done.
    
        cube([
            length - 2*border,
            width - 2*border,
            height
        ]);
    
 // This closes the parentheses for "difference".
 }

 
 
 
 
 
 