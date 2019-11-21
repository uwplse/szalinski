// MakerBot Handbook Tutorial
// OpenSCAD nametag with parameters
// Modified for Customizer

/////////////////////////////////////////////////////////////////////
// THE PARAMETERS

// preview[view:south, tilt:top]

/* [Text] */

myword = "Mike";
myfont="Black Ops One"; //[Alfa Slab One,Anton,Architects Daughter,Bangers,Black Ops One,Bubblegum Sans,Cherry Cream Soda,Courgette,Damion,Droid Serif,Electrolize,Exo,Fjalla One,Fredoka One,Great Vibes,Josefin Slab,Julius Sans One,Lobster,Luckiest Guy,Marck Script,Montserrat,Nunito,Orbitron,Oswald, Oxygen,Pacifico,Patua One,Passion One,Paytone One,Permanent Marker,Poiret One,Press Start 2P,Quicksand,Righteous,Rock Salt,Rokkitt,Russo One,Satisfy,Shadows Into Light,Sigmar One,Signika,Syncopate,Walter Turncoat]

// size of the letters
fontsize = 8;

// amount the word is extruded
textheight = 7;

// space between characters
myspacing = 1.1;

/* [Dimensions] */

// left to right
length = 38; 

// top to bottom
width = 16;

// to the top of the tallest wave
height = 8;

/* [Wave] */

// number of waves
frequency = 1;

// low is stair-steppy, high is smoother
steps = 8;

// width of the wave border
border = 2;

// distance from border to text
inset = 2;

// thickness of base
base = 2;

/////////////////////////////////////////////////////////////////////
// PRINT THE TEXT

// STEP 3. Translate up and to the right past the border.

translate([ border + inset, border + inset, 0 ]){

    // STEP 2. Pull up the text in the z-direction.
    
    linear_extrude( height = textheight ){
    
        // STEP 1. Write the word in the correct font and size.
        
        text(
            text = myword, 
            font = myfont, 
            size = fontsize, 
            spacing = myspacing
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

 
 
 
 
 
 