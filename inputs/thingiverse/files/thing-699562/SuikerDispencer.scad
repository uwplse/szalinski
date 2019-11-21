height = 80;
diameter = 22;
thickness = 3;
smooth = 360; // Number of facets of rounding cylinder
slideSpace = 0.1;
endCapThickness = 2;


part = "first"; // [first:Top Only,second:Bottom Only,both:Top and Bottom]
print_part();

module print_part() {
	if (part == "first") {
		top(height, diameter/2, thickness, center = false);
	} else if (part == "second") {
		bottom(height, diameter/2, thickness, center = false);
	} else if (part == "both") {
		tube(height, diameter/2, thickness, center = false);
	} else {
		tube(height, diameter/2, thickness, center = false);
	}
}


// wall is wall thickness
module tube(heightTube, radius, wall, center = false) {

top(heightTube, radius, wall, center = false);
bottom(heightTube, radius, wall, center = false);
}


module top(heightTube, radius, wall, center = false){
union(){
difference() {
    cylinder(h=heightTube, r=radius, center=center, $fn=smooth);
    cylinder(h=heightTube, r=radius-wall, center=center, $fn=smooth);

 translate([-(diameter/2-2), 0, 0])
 cube([diameter-4, wall-1, height]); 

 translate([-(diameter/2)+wall/1.5, wall/2.5, 0])
 cylinder(h=heightTube, r=wall/2.5, center=center, $fn=smooth);

 translate([+(diameter/2)-wall/1.5, wall/2.5, 0])
 cylinder(h=heightTube, r=wall/2.5, center=center, $fn=smooth);

    translate([-(diameter/2), 0, 0])
    cube([diameter, radius, height]); // 1 = spatie tussen 2 delen

  }
union(){
 translate([-(diameter/2)+(wall/1.5+slideSpace), wall/2.5-slideSpace, 0])
 cylinder(h=heightTube, r=wall/2.5-slideSpace, center=center, $fn=smooth);
 translate([-(diameter/2)+(wall/1.67), 0, 0])
 cube([wall/2.5, 1, height]); 
}

union(){
 translate([+(diameter/2)-(wall/1.5+slideSpace), wall/2.5-slideSpace, 0])
 cylinder(h=heightTube, r=wall/2.5-slideSpace, center=center, $fn=smooth);
 translate([+(diameter/2)-(wall), 0, 0])
 cube([wall/2.5, 1, height]); 
}

cylinder(h=endCapThickness, r=radius-wall, center=center, $fn=smooth);

}
}


module bottom(heightTube, radius, wall, center = false){
  
union(){
difference() {
    cylinder(h=heightTube, r=radius, center=center, $fn=smooth);
    cylinder(h=heightTube, r=radius-wall, center=center, $fn=smooth);

 translate([-(diameter/2-2), 0, 0])
 cube([diameter-4, wall-1, height]); 

 translate([-(diameter/2)+wall/1.5, wall/2.5, 0])
 cylinder(h=heightTube, r=wall/2.5, center=center, $fn=smooth);

 translate([+(diameter/2)-wall/1.5, wall/2.5, 0])
 cylinder(h=heightTube, r=wall/2.5, center=center, $fn=smooth);

  translate([-(diameter/2), -radius, 0])
    cube([diameter, radius , height]); // 1 = spatie tussen 2 delen

  }


translate([0, 0, +heightTube-endCapThickness])
cylinder(h=endCapThickness, r=radius-wall, center=center, $fn=smooth);

}

}


 
