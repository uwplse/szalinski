//Word Cube Generator
//Inspired by Word Cubes by MrKindergarten
//http://www.thingiverse.com/thing:1554507


/*[Word 1]*/
W1_L1 = "B";
W1_L2 = "o";
W1_L3 = "x";
/*[Word 2]*/
W2_L1 = "Z";
W2_L2 = "i";
W2_L3 = "p";
/*[Word 3]*/
W3_L1 = "T";
W3_L2 = "e";
W3_L3 = "n";
/*[Word 4]*/
W4_L1 = "H";
W4_L2 = "u";
W4_L3 = "T";
/*[Cube Features]*/
size = 25.4;
gap = 2;

/*[Text Features]*/
font = "arial";
//percentage
fontSize = .50;
//percentage
depth = .02;//[.01:.01:.25]
union(){
  difference(){
    cube([size*3+gap*2,size,size], center = true);
    translate([-size/2-gap/2,0,0])
      cube([gap,size+1,size+1], center = true);
    translate([size/2+gap/2,0,0])
      cube([gap,size+1,size+1], center = true);
    rotate([0,90,0])
        cylinder(r = size/4+1, h = size+gap*2, center = true);
    //Word 1
    rotate([0,0,0])
    {
      translate([-size*(fontSize/2+1)-gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W1_L1), font = font, size = size*fontSize);
      translate([-size*(fontSize/2),-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W1_L2), font = font, size = size*fontSize);
      translate([size*(fontSize/2+.5)+gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W1_L3), font = font, size = size*fontSize);
    }
    //Word 2
    rotate([90,0,0])
    {
      translate([-size*(fontSize/2+1)-gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W2_L1), font = font, size = size*fontSize);
      translate([-size*(fontSize/2),-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W2_L2), font = font, size = size*fontSize);
      translate([size*(fontSize/2+.5)+gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W2_L3), font = font, size = size*fontSize);
    }
    //Word 3
    rotate([180,0,0])
    {
      translate([-size*(fontSize/2+1)-gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W3_L1), font = font, size = size*fontSize);
      translate([-size*(fontSize/2),-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W3_L2), font = font, size = size*fontSize);
      translate([size*(fontSize/2+.5)+gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W3_L3), font = font, size = size*fontSize);
    }
    //Word 4
    rotate([270,0,0])
    {
      translate([-size*(fontSize/2+1)-gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W4_L1), font = font, size = size*fontSize);
      translate([-size*(fontSize/2),-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W4_L2), font = font, size = size*fontSize);
      translate([size*(fontSize/2+.5)+gap,-size*fontSize/2,size/2+.01-size*depth])
        linear_extrude(size*depth)
          text(text = str(W4_L3), font = font, size = size*fontSize);
    }
  }
  rotate([0,90,0])
    translate([0,0,-size/2-gap])
      cylinder(r = size/4, h = size+gap*2);
}