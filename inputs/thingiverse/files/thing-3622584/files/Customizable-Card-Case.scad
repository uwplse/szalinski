
/* Scaling card (or anything, really) box  */

// standard 52-card deck is default

/*
 *
 * Future improvements
 * - Something to hold it together. Maybe an indentation on one case and a nub
 *   on the other
 * - Abiliity to automatically generate 1mm false cards as part of the STL to act
 *   as spacers (and make box automatically size to account for them)
 * - Automatic embossing of text to note what's stored
 *   
 */

/* [Two Part Box] */

// Width of cards (shorter side) (mm)
cardWidth = 64; // [1:300]

// Length of cards (longer side) (mm)
cardLength = 88; // [1:300]

// Thickness of deck (don't squeeze too tight) (mm)
deckThickness = 16; // [1:300]

// Thickness of box walls
boxThickness = 1; // [1:10]

// Margin between boxes (mm) - too low and they won't go together or come apart, so be careful
innerMargin = 0.5; // mm of "space" between boxes when together

// ignore variable values
cornerRadius = boxThickness * 1.6;
lowerBoxLength = cardLength * 1;
upperBoxLength = cardLength * 0.8;
deckWiggle = 1; // mm of extra space inside box
distanceBetweenModels = 10; // spacing between models in STL

difference() 
{ 
  outerWidth = cardWidth + boxThickness*2 + deckWiggle;
  outerLength = lowerBoxLength + deckWiggle;
  outerDepth = deckThickness + boxThickness*2 + deckWiggle;
  
  innerWidth = cardWidth + deckWiggle;
  innerLength = lowerBoxLength + deckWiggle;
  innerDepth = deckThickness + deckWiggle;
  
  roundedRect([outerWidth, outerDepth, outerLength], cornerRadius); 
  translate([boxThickness, boxThickness, boxThickness]) {
    rect([innerWidth, innerDepth, innerLength]);
  }
} 

yoffset = deckThickness + boxThickness * 2 + distanceBetweenModels;

// move the new center to the right for the new model
translate([0, yoffset]) { 
  difference() {
    
    innerWidth = cardWidth + boxThickness * 2 + deckWiggle + innerMargin;
    innerLength = lowerBoxLength + deckWiggle + innerMargin;
    innerDepth = deckThickness + boxThickness * 2 + deckWiggle + innerMargin;
    
    outerWidth = innerWidth + boxThickness * 2;
    outerLength = upperBoxLength;
    outerDepth = innerDepth + boxThickness * 2;
    
    roundedRect([outerWidth, outerDepth, outerLength], cornerRadius);
    translate([boxThickness, boxThickness, boxThickness]) {
      rect([innerWidth, innerDepth, innerLength]);
    }
  }
}

module roundedRect(size, radius, center)  // more elegant version 
 linear_extrude(height = size.z, center = center) 
  offset(radius) offset(-radius) 
   square([size.x, size.y], center = center); 

module rect(size, center)
  linear_extrude(height = size.z, center = center)
    square([size.x, size.y], center = center);
