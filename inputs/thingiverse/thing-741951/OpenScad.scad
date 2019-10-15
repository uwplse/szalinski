/* [Global] */

// Which one would you like to see?
part = "both"; // [first:Cube Only,second:Cylinder Only,both:Cube and Cylinder]

/* [Cube] */

cube_size = 10; // [1:100]

/* [Cylinder] */

cylinder_size = 10; // [1:100]

/* [Hidden] */

secret = 42;
preview_tab = "";

print_part();

module print_part() {
	if (part == "first") {
		mycube();
	} else if (part == "second") {
		mycylinder();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

module both() {
	translate([-cube_size, 0, 0]) mycube();
	translate([cube_size, 0, 0]) mycylinder();
}

module mycube() {
	highlight("Cube") translate([0, 0, cube_size/2]) cube(cube_size, center=true);
}

module mycylinder() {
	highlight("Cylinder") cylinder(r=cube_size/2, h=cylinder_size);
}

module highlight(this_tab) {
  if (preview_tab == this_tab) {
    color("red") child(0);
  } else {
    child(0);
  }
}