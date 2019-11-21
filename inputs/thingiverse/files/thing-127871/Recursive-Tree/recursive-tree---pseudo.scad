height = 20;
number_of_levels=6; // [1:8]
TILTANGLE = 30;
ZANGLE = 120;
HEIGHTFACT = 0.75;
height_to_with_bottom = 18;
height_to_with_top = 20;

tree (0, height);

module tree(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch1(level + 1, TILTANGLE, height, 1, 0, 0);
		branch1(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch1(level + 1, TILTANGLE, height, 0, 1, 0);
		branch1(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}

module branch(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree(level, height * HEIGHTFACT);
			}
		}
	}
}

/////////////
// Level 1 //
/////////////

module branch1(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree1(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree1(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch2(level + 1, TILTANGLE, height, 1, 0, 0);
		branch2(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch2(level + 1, TILTANGLE, height, 0, 1, 0);
		branch2(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}

/////////////
// Level 2 //
/////////////

module branch2(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree2(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree2(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch3(level + 1, TILTANGLE, height, 1, 0, 0);
		branch3(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch3(level + 1, TILTANGLE, height, 0, 1, 0);
		branch3(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}

/////////////
// Level 3 //
/////////////

module branch3(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree3(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree3(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch4(level + 1, TILTANGLE, height, 1, 0, 0);
		branch4(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch4(level + 1, TILTANGLE, height, 0, 1, 0);
		branch4(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}



/////////////
// Level 4 //
/////////////

module branch4(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree4(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree4(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch5(level + 1, TILTANGLE, height, 1, 0, 0);
		branch5(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch5(level + 1, TILTANGLE, height, 0, 1, 0);
		branch5(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}


/////////////
// Level 5 //
/////////////

module branch5(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree5(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree5(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch6(level + 1, TILTANGLE, height, 1, 0, 0);
		branch6(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch6(level + 1, TILTANGLE, height, 0, 1, 0);
		branch6(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}


/////////////
// Level 6 //
/////////////

module branch6(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree6(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree6(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch7(level + 1, TILTANGLE, height, 1, 0, 0);
		branch7(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch7(level + 1, TILTANGLE, height, 0, 1, 0);
		branch7(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}


/////////////
// Level 7 //
/////////////

module branch7(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree7(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree7(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch8(level + 1, TILTANGLE, height, 1, 0, 0);
		branch8(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch8(level + 1, TILTANGLE, height, 0, 1, 0);
		branch8(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}


/////////////
// Level 8 //
/////////////

module branch8(level, tilt, height, x, y, z){
	//color("LawnGreen") cylinder(h = height, r1 = height / height_to_with_bottom, r2= height / height_to_with_top);
	translate(v = [0, 0, height]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE, v = [0, 0, 1]) {
				tree8(level, height * HEIGHTFACT);
			}
		}
	}
}

module tree7(level, height){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(height, height / height_to_with_bottom, height / height_to_with_top);
	if (level < number_of_levels-1){
		branch8(level + 1, TILTANGLE, height, 1, 0, 0);
		branch8(level + 1, -TILTANGLE, height, 1, 0, 0);
		branch8(level + 1, TILTANGLE, height, 0, 1, 0);
		branch8(level + 1, -TILTANGLE, height, 0, 1, 0);
	}
}
