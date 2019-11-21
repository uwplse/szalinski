//Design by Chris Thomson, May 2015

//First line of text (Species)
text_top = "HOLLY";
//Second line of text (Variety)
text_bottom = "BLUE ANGEL - F";
//Total length of label, from the tip
length = 200; // [10:200]

color("Red",0.5) translate([2,14,2]) linear_extrude(height = 0.5) {
    text(text_top); 
}
color("Blue",0.5) difference() {
    cube(size = [length-30,26,2], center = false);
    translate([2,2,1])  {
         linear_extrude(height = 8) {
            text(text_bottom);
        };
    }
}

translate([length-30,0,0]) linear_extrude(height=2) 
    polygon(points=[[0,0],[0,26],[30,13]],paths=[ [0,1,2] ]);