// The word visible when looking at the object from the front
first_word = "LOVE";
// The word visible when looking at the object from the side
second_word = "HATE";

// The font to use (use standard font names)
font = "Helvetica";

// How much to thicken the font
boldness = 0.5; // [0:2]

module Word(word) {
    resize([size,0], auto=1) 
      linear_extrude(height = size, convexity = 10, center=true)
        offset(boldness) 
          text(word, size=10, halign="center", valign="center", font = font);
}


$fn=64;
size = max(len(first_word), len(second_word)) * 10;

intersection() {
    rotate([90, 0, 90]) Word(first_word);
    rotate([90, 0, 0]) Word(second_word);
}
