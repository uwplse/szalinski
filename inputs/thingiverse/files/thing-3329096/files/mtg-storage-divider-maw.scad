/* 
Divider for MTG storage card collection with edition code. Cool tip use multicolor print from .75
 */

/* [Divider] */
// Width of the divider.
width = 63; // card width
// Height of the divider.
height = 88; //card height
// Thickness of the divider. Also acts as the diameter of all the rounded edges.
depth = .6;
//Text and font
 text = "LRW";
 font = "Liberation Sans";
 text2 = ""; //[Mana symbol from https://andrewgioia.github.io/Mana/index.html or Keyrune from https://andrewgioia.github.io/Keyrune/index.html]
 //for help just copy paste this:  
 font2 = "mana"; //[Keyrune, mana]
//tab position
 side = "both"; // [left,right,both(optional)]

module divider(width,depth,height){
    translate([0, 0, depth]) {
    rotate([-90,0,0]) {
    union() {
        difference() {
cube([width,depth,height], false);
        rotate([0,-45,0]) {
        cube([2,depth+2,5], true);
        }
        translate([width, 0, 0]) {
        rotate([0,45,0]) {
        cube([2,depth+2,5], true);
        }
        }
    }
     if (side == "left" || side == "both"){
        translate([0,0,height]){
           cube([width/3,depth,10]);
        }
   translate([1, 0, height+2]) {
       rotate([90,0,0]) {
     linear_extrude(0.3) {
       text(text = str(text), font = font, size = 6);
     }
    }
   }
}
 }
 if (side == "right" || side == "both"){
        translate([width-(width/3),0,height]){
           cube([width/3,depth,10]);
        }
   translate([width-(width/3)+6, 0, height+1]) {
       rotate([90,0,0]) {
     linear_extrude(0.3) {
       text(text = str(text2), font = font2, size = 7);
     }
    }
   }
}
 }

}
}
divider(width,depth,height);