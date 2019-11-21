module LetterBlock(letter, size=30) {
    difference() {
        translate([0,0,size/4])
          cube([size,size,size/2], center=true);
        translate([0,0,size/6])
            linear_extrude(height=size, convexity=3)
                text(letter, 
                     size=size*22/30,
                     font="Tahoma",
                     halign="center",
                     valign="center");
    }
}

size=30;
for (i=[0:25])
  translate([(i%5)*(size+3),floor(i/5)*-(size+1),0])
    LetterBlock(chr(i+65), size);
