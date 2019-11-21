// Textadapter

Textgroesse = 5;
text = "YOUR NAME";


module letter(l) {
  linear_extrude(height = 0.45) {
    text(l, size = Textgroesse, halign = "center", valign = "center", $fn = 16);
  }
}

difference() {
  union() {
      color("gray") cube([61.03, 1.5, 9.45], center =(true));
    translate([0, -0.75, 0]) rotate([90, 0, 0]) letter(text);
  }
      rotate([90,0,0])
    translate([28.64,0,0])
    linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
polygon([[0,0],[5.41,-11.25],[5.41,11.25]],paths=[[0,1,2]], convexity=3);
}

