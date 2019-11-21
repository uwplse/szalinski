// From this seed, your tree will grow! Enter a number.
seed=42;

number_of_levels=6; // [1:8]


height = rands(10,30,20,seed);
TILTANGLE = rands(20,40,20,seed);
ZANGLE = rands(0,360,20,seed);
HEIGHTFACT = rands(0.6,0.9,20,seed);
height_to_with_bottom = rands(15,30,20,seed);
height_to_with_top = rands(20,40,20,seed);

tree (0, height[0]);

module tree(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch1(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch1(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch1(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch1(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}

/////////////
// Level 1 //
/////////////


module tree1(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch2(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch2(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch2(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch2(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch1(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree1(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}

/////////////
// Level 2 //
/////////////


module tree2(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch3(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch3(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch3(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch3(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch2(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree2(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}


/////////////
// Level 3 //
/////////////


module tree3(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch4(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch4(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch4(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch4(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch3(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree3(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}


/////////////
// Level 4 //
/////////////


module tree4(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch5(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch5(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch5(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch5(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch4(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree4(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}


/////////////
// Level 5 //
/////////////


module tree5(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch6(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch6(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch6(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch6(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch5(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree5(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}


/////////////
// Level 6 //
/////////////


module tree6(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch7(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch7(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch7(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch7(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch6(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree6(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}


/////////////
// Level 7 //
/////////////


module tree7(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch8(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch8(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch8(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch8(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch7(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree7(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}


/////////////
// Level 8 //
/////////////


module tree8(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch9(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch9(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch9(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch9(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch8(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree8(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}

/////////////
// Level 9 //
/////////////


module tree9(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch9(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch9(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch9(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch9(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch9(level, tilt, branchlength, x, y, z){
	//color("LawnGreen") cylinder(h = branchlength, r1 = branchlength / 18.0, r2= branchlength / 20.0);
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree9(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}