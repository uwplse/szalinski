// Funky pick 1.2 - a parametric symmetrical plectrum with optional unicode text/character embossing, Antti Suomela January 2017
// CC-BY-SA-NC - Creative Commons Attribution-NonCommercial-ShareAlike 3.0
// Changes: 
// * 1.1 -> 1.2 fixed an error in plectrum size and emboss height generation, added a further embossing option (both sides), added an emboss height parameter, other slight improvements that shorten the code and make it easier to read
// * 1.0 -> 1.1 embossing now happens only on one side (which is supposed to be the top side when printed)

/* Set thickness, length, and other parameters as you like. */ 
thickness = 0.7;        // plectrum thickness, as expected, default: 0.7 
length = 30;            // from base to tip (hint: keep the plectrum longer than it is wide for best results) default: 30
width = 26;             // speaks for itself, default: 26
taper = 1;              // default: 1mm taper distance from the thick bit to the very edge

/* Use these to emboss (or cut) something to the plectrum. */
text = "\u262e";                            // the text to be engraved into the plectrum, default: "\u262e"
font = "Arial Unicode MS:style=Regular";    // default: "Arial Unicode MS:style=Regular" 
fontsize = 16;                              // font size selection, 0 = "automatic" of sorts, default: 16
emboss = 1;                                 // If emboss is 0, the text is cut into the plectrum, not embossed. If emboss is 1, the text is embossed on one side. If 2, it is embossed on both sides. Note that emboss is better for actual text and cutting may be appropriate for certain unicode characters. Default: 1

emboss_height = 0.25;                       // default: 0.25 (mm)

/* Not commonly changed, but nevertheless changeable variables. Chunk and funk change the shape of the plectrum in a certain way. Experiment! :-) */
chunk = 0.327;         // practical range 0 to 0.345 to avoid going beyond set length and width parameters, experiment! :-) (default: 0.327)
funk = 0.2;            // practical range 0 to 0.3 without going beyond set length and width parameters (default: 0.2)

module main_part(t) {               // this establishes the shape and size of the plectrum, the t parameter is the thickness
    linear_extrude(height = t, convexity = 10, center = true)
    resize(newsize=[length, width, thickness])
    hull() {
        circle(width / 2, $fn = 50);                            // main part
        translate([funk * -length, chunk * width, 0])
            circle(4, $fn = 30);              // base corner #1
        translate([funk * -length, chunk * -width, 0])
            circle(4, $fn = 30);              // base corner #2
        translate([length - width / 2 - 1.5, 0, 0])
            circle(1.5, $fn = 50);                              // tip
    }
}
module taper() {                    // this does the tapering at the edge of the plectrum
    hull() {
            resize(newsize=[length - taper, width - taper, thickness])      
            main_part(thickness);
            main_part(0.01);        
    }
}

module create_text() {              // creates the text in the correct orientation
    rotate(90)
    if (fontsize == 0) { text(text, size = 9 - len(text), font = font, valign = "center", halign = "center", $fn = 70); }
    else { text(text, size = fontsize, font = font, valign = "center", halign = "center", $fn = 70); }
}

module emboss() {                   // embosses or cuts the text into the plectrum
    if (emboss == 0) { 
        linear_extrude(height = thickness * 1.5, convexity = 10, center = true) 
        create_text();
        }
    else if (emboss == 1) {
        translate([0, 0, thickness / 2])
        linear_extrude(height = emboss_height, convexity = 10)  
        create_text();
    }
    else {
        linear_extrude(height = thickness + emboss_height * 2, convexity = 10, center = true)  
        create_text();
    }
}
module all_together_now() {         // here we put it all together
    if (emboss == 0) {
        difference() {    
            taper();
            emboss();
        }   
    }
    else {
       taper();
       emboss();
    }
} 

all_together_now();
