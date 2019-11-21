//
//  Pegs for robot mower perimeter wire
//
//  Should print as is, no support needed
//  Best material is probably ABS
//
//  Design by Egil Kvaleberg, 20 April 2016
//

peg_length = 110.0;
peg_wall = 2.0;
peg_width = 12.0;
peg_slot = 4.0;
// max degrees of overhang supported by printer/material. 45 is usually safe
max_overhang = 30.0; // degrees
tip_len = peg_width / (2*tan(max_overhang)); // BUG:
d = 1*0.01;

module bar(slant) {
    points = [
      [0,-peg_wall/2,0],
      [peg_length-tip_len,-peg_wall/2,0],
      [peg_length-tip_len,peg_wall/2,0],
      [0,peg_wall/2,0],
      [0,slant-peg_wall/2,peg_width],
      [peg_length-tip_len,slant-peg_wall/2,peg_width],
      [peg_length-tip_len,slant+peg_wall/2,peg_width],
      [0,slant+peg_wall/2,peg_width]];
    faces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left          
    polyhedron(points, faces);
    translate([peg_length-tip_len, 0, 0]) tip(slant);
}
module tip(slant) {
    points = [
      [0,-peg_wall/2,0],
      [tip_len,slant/2-peg_wall/2,peg_width/2],
      [tip_len,slant/2+peg_wall/2,peg_width/2],
      [0,peg_wall/2,0],
      [0,slant-peg_wall/2,peg_width],
      [0,slant+peg_wall/2,peg_width]];
    faces = [
      [0,1,2,3],  // bottom
      [4,1,0],    // front
      [5,2,1,4],  // top
      [5,3,2],    // back
      [5,4,0,3]]; // left  
    polyhedron(points, faces);
}
translate([0, -peg_width/2, 0]) bar(peg_width);
translate([0, peg_width/2, 0])  bar(-peg_width);
translate([0, -peg_width/2, 0]) cube([peg_wall,peg_width,peg_width]);
translate([0, -peg_width/2-peg_wall/2, 0]) cube([2*peg_slot+peg_wall,peg_wall,peg_width]);
intersection() {
    translate([0, -peg_width, -d]) cube([peg_slot+peg_wall,peg_slot+peg_wall,peg_width+2*d]);
    translate([peg_slot+peg_wall, -peg_width/2, 0]) {
        difference() {
            cylinder(r=peg_slot+peg_wall, h=peg_width, $fn=30);
            translate([0,0,-d]) cylinder(r=peg_slot, h=peg_width+2*d, $fn=30);
        }
    }
}
translate([peg_slot+peg_wall, -peg_width/2-peg_slot-peg_wall/2, 0]) tip(0);