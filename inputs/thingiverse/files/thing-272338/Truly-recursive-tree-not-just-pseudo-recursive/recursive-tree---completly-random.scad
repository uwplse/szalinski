// From this seed, your tree will grow! Enter a number.
seed=42;

// Over how many levels should your tree grow? Choose no more than 9 levels, or it will take a lot of time to render...
number_of_levels=6; 

height = rands(10,30,20,seed);
TILTANGLE = rands(20,40,20,seed);
ZANGLE = rands(0,360,20,seed);
HEIGHTFACT = rands(0.6,0.9,20,seed);
height_to_with_bottom = rands(15,30,20,seed);
height_to_with_top = rands(20,40,20,seed);

module tree(level, length){
	color([ 150/255, (80+level*(175/(number_of_levels-1)))/255, 0/255 ]) cylinder(length, length / height_to_with_bottom[0], length / height_to_with_top[0]);
	if (level < number_of_levels-1){
		if (HEIGHTFACT[level+2] < 0.99){branch(level + 1, TILTANGLE[level+1]*HEIGHTFACT[level+4], length, 1, 0, 0);}
		if (HEIGHTFACT[level+2] < 0.99){branch(level + 1, -TILTANGLE[level+2]*HEIGHTFACT[level+3], length*HEIGHTFACT[level+1], 1, 0, 0);}
		if (HEIGHTFACT[level+3] < 0.87){branch(level + 1, TILTANGLE[level+3]*HEIGHTFACT[level+2], length, 0, 1, 0);}
		if (HEIGHTFACT[level+4] < 0.88){branch(level + 1, -TILTANGLE[level+4]*HEIGHTFACT[level+1], length*HEIGHTFACT[level+2], 0, 1, 0);}
	}
}

module branch(level, tilt, branchlength, x, y, z){
	translate(v = [0, 0, branchlength]) {
		rotate(a = tilt, v = [x, y, z]) {
			rotate(a = ZANGLE[level], v = [0, 0, 1]) {
				tree(level, branchlength * HEIGHTFACT[level]);
			}
		}
	}
}

tree (0, height[0]);
