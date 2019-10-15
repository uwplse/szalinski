/*[Standard 1836 Wood Bellypan]*/
// Overall Width:
Width = 32;
// Overall Length:
Length = 24;
/*[Advanced]*/
//Plate Thickness:
Thickness = .5; 
//Hole Spacing
Holepattern = .5;
//Hole Size
Holesize = .201;

/*[Hidden]*/
holes = 0;

module Bellypan() {
    difference() {  
        scale([25.4, 25.4, 25.4]) cube([Length, Width, Thickness], center = true);
      
    }
}

difference() {
    Bellypan();
    for (holes = [0:Holepattern:Length/2-Holepattern]) {
        scale([25.4, 25.4, 25.4]) translate([holes, Width/2-Holepattern, 0]) cylinder (d = Holesize, h = Thickness, center = true);
         scale([25.4, 25.4, 25.4]) translate([-holes, Width/2-Holepattern, 0]) cylinder (d = Holesize, h = Thickness, center = true);
        scale([25.4, 25.4, 25.4]) translate([holes, -Width/2+Holepattern, 0]) cylinder (d = Holesize, h = Thickness, center = true);
        scale([25.4, 25.4, 25.4]) translate([-holes, -Width/2+Holepattern, 0]) cylinder (d = Holesize, h = Thickness, center = true);
    }
    
    for (holes = [0:Holepattern:Width/2-Holepattern]) {
        scale([25.4, 25.4, 25.4]) translate([Length/2-Holepattern, holes, 0]) cylinder (d = Holesize, h = Thickness, center = true);
        scale([25.4, 25.4, 25.4]) translate([-Length/2+Holepattern, holes, 0]) cylinder (d = Holesize, h = Thickness, center = true);
        scale([25.4, 25.4, 25.4]) translate([Length/2-Holepattern, -holes, 0]) cylinder (d = Holesize, h = Thickness, center = true);
         scale([25.4, 25.4, 25.4]) translate([-Length/2+Holepattern, -holes, 0]) cylinder (d = Holesize, h = Thickness, center = true);
}
}