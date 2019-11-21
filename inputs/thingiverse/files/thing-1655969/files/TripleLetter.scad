monogram = "RX2";
size = 30;

//Word("Calibri");
Union("Calibri");
//Difference("Calibri");
//Intersection("Impact");

module Word(font) {
  LetterBlock(monogram[0], font);
  translate([size,0,0]) LetterBlock(monogram[1], font);
  translate([size*2,0,0]) LetterBlock(monogram[2], font);
}

module Union(font) {
  union() {
    LetterBlock(monogram[0], font);
    rotate([90,0,0]) LetterBlock(monogram[1], font);
    rotate([90, 0, 90]) LetterBlock(monogram[2], font);
  }
}

module Intersection(font) {
  intersection() {
    LetterBlock(monogram[0], font);
    rotate([90,0,0]) LetterBlock(monogram[1], font);
    rotate([90, 0, 90]) LetterBlock(monogram[2], font);
  }
}

module Difference(font) {
  difference() {
    cube([size*.99,size*.99,size*.99], true);
    cube([size*.75,size*.75,size*.75], true);
    LetterBlock(monogram[0], font);
    rotate([90,0,0]) LetterBlock(monogram[1], font);
    rotate([90, 0, 90]) LetterBlock(monogram[2], font);
  }
}

module LetterBlock(letter, font) {
  scale([1.4,1,1]) {
    translate([0,0,-size/2]) {
      linear_extrude(height=size, convexity=4) {
        text(letter, size=size, font=font, halign="center", valign="center");
      }
    }
  }
}
