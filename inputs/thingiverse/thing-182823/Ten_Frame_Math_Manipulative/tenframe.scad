// Ten frame generation script
//
// enter size of each cube/space as cubesize
// enter number of cubes/spaces across in framecount
// enter how many rows of the frame as rowcount
//
// Designed by: John Yang
// Thingiverse user: ljyang
// released CC-BY-SA

//	Size of hole
cube_size=20; // [1:30]
// Number of holes in frame
frame_size=5; // [1:20]
// Number of rows in frame
row_count=2; // [1:20]

hidden_wallsize=cube_size*0.2;
hidden_cubeandwall=cube_size + hidden_wallsize;
hidden_totalwidth=row_count*hidden_cubeandwall + hidden_wallsize;
hidden_totallength=frame_size*hidden_cubeandwall + hidden_wallsize;

difference(){
	cube([hidden_totallength,hidden_totalwidth,hidden_cubeandwall]);
	for (i = [0:frame_size-1]){
		for (j = [0:row_count-1]){
			translate([(i*hidden_cubeandwall + hidden_wallsize),(j*hidden_cubeandwall + hidden_wallsize),hidden_wallsize]) cube([cube_size,cube_size,hidden_cubeandwall]);
		}
	}
}