$fn=50;

// Height of the cards in mm
Height = 88; //[50:150]

// Width of the cards in mm
Width = 64; //[30:100]

// Number of cards to be contained
Number_of_Cards = 50; //[10:200]

// What type of sleeves
Sleeves = "none"; // ["none","light","premium"]

if (Sleeves == "none") {
	Card_Box(Height, Width, Number_of_Cards * 0.3);
}
if (Sleeves == "light") {
	Card_Box(Height + 2, Width + 2, Number_of_Cards * 0.5);
}
if (Sleeves == "premium") {
	Card_Box(Height + 2, Width + 2, Number_of_Cards * 0.6);
}


module Card_Box(Height,Width,Depth) {
	translate(v=[0, 5, 0])
	union() {
		difference() {
			cube([Height + 5, Width + 5, Depth - 3]);
			translate(v=[2, 2, 2])
			cube([Height + 1, Width + 1, Depth + 5 ]);
			translate(v=[Height / 2, Width + 4, Depth + 2])
			cube([Height / 2, 10, Depth * 2 + 5],center=true);
			translate(v=[-1, Width-2, -1])
			cube([2,8,2]);
			translate(v=[Height + 4, Width-2, -1])
			cube([2,8,2]);
		}
		translate(v=[-2, 2, Depth / 2])
		rotate([0, 90, 0])
		cylinder(h=3,r=2);
		translate(v=[Height + 4, 2, Depth / 2])
		rotate([0, 90, 0])
		cylinder(h=3, r=2);
	}

	translate(v=[0, -Width, 0])
	union() {
		difference() {
			union() {
				cube([Height + 10, Width + 1, Depth]);
				intersection() {
					translate(v=[0,(Depth * Depth) / 64 - 4, Depth / 2])
					rotate([0, 90, 0])
					cylinder(h=Height + 10, r=(Depth * Depth) / 64 + 4);
					translate(v=[0, -8, 0])
					cube([Height + 10, 10, Depth]);
				}
			}
			translate(v=[2, -10, 2])
			cube([Height + 6, Width + 20, Depth + 5]);
			translate(v=[-2, -2, Depth / 2])
			rotate([0, 90, 0])
			cylinder(h=Height + 20, r=3);
			translate(v=[2, -10, -2])
			cube([Height + 6, 10, 5]);
		}
		translate(v=[2, Width + 1, Depth - 1])
		rotate([90,0,0])
		cylinder(h=6, r=1.5);
		translate(v=[Height + 8, Width + 1, Depth - 1])
		rotate([90,0,0])
		cylinder(h=6, r=1.5);
	}
}