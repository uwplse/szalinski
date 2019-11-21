x_size=15;
y_size=22.5;
z_size=2;

//First Letter
first_Letter = J;
//Second Letter
second_letter = 10;
//Third Letter
third_letter = 10;

//plate
color([1,0,0,1]) cube([x_size,y_size,z_size]);

//right rings
color([0,1,0,1]) translate ([2,0,0]) cylinder (h=z_size, r=x_size/2, $fn=50);
color([0,1,0,1]) translate ([x_size-2,0,0]) cylinder (h=z_size, r=x_size/2, $fn=50);

//left rings
color([0,1,0,1]) translate ([2,y_size,0]) cylinder (h=z_size, r=x_size/2, $fn=100);
color([0,1,0,1]) translate ([x_size-2,y_size,0]) cylinder (h=z_size, r=x_size/2, $fn=50);

//key ring
translate ([x_size, y_size/2,0]) {
	difference() {
		color ([0,0,1,1]) cylinder (h=z_size, r=y_size/6, $fn=50);
		color ([0,1,0,1]) cylinder (h=z_size, r=y_size/14, $fn=50);
	}
}

include <bitmap.scad>

// change chars array and char_count
// OpenSCAD has no string or length methods :(
chars = [first_letter,sedond_letter,third_letter];
char_count = 3; //<---- MODIFY!!

// block size 1 will result in 8mm per letter
block_size =1;
// height is the Z height of each letter
height = 1;

union() rotate([0,0,180]){
	translate(v = [-7,-block_size*8*char_count/2+block_size*8/2-11,z_size]) {
		8bit_str(chars, char_count, block_size, height);
	}
}

