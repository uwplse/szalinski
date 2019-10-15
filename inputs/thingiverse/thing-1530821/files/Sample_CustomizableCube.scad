//What size do you want?
/* [Cube] */

cube_size_small = 10; // [1:100]

mycubeSmall(cube_size_small);
            
module mycubeSmall(cube_size) {
	translate([0, 0, cube_size/2]) cube(cube_size, center=true);
}
