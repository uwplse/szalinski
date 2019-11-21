
//number of cubes of each side
dimensions=36; //[1:1:100]

//the chance for a cube to occur
chance_of_cubes=0.5; //[0:0.01:1]

module random_cube ()
{
	for(i=[0:dimensions]) {
		for(j=[0:dimensions]) {
			for(k=[0:dimensions]) {
				translate( [i, j, k] ){
					if(rands(0,1,1)[0]>=chance_of_cubes){
						color([i/dimensions,j/dimensions,k/dimensions,1]){
							cube( size = [1, 1,1] );
						}
					}
				}
			}
		}
	}
}
random_cube();