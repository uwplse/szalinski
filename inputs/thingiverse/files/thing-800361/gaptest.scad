// preview[view:south, tilt:top diagonal]

// Extra space around the test (mm)
margin=2; // [0:10]

// Thickness of the bottom plate (mm)
base_thickness=0.4;

// Distance between the two towers (i.e. the distance to be tested) (mm)
distance=20; // [1:150]

// Width of the two towers (mm)
tower_width=4; // [1:10]

// Depth of the two towers (mm)
tower_depth=7; // [1:20]

// Height of the two towers (mm)
tower_height=9; // [0:100]

text_height = 1*1;

total_width = margin + tower_width + distance + tower_width + margin;
total_depth = margin + tower_depth + margin;

translate([0,0,-base_thickness]) cube([total_width,total_depth,base_thickness]);
translate([margin,margin,0]) cube([tower_width,tower_depth,tower_height]);
translate([margin+tower_width+distance,margin,0]) cube([tower_width,tower_depth,tower_height]);

linear_extrude(text_height) translate([total_width/2,margin,0]) resize([distance,tower_depth,0]) text(str("<",distance,"mm>"),halign="center");

