// Side length of cube
size=35;
tolerance=.4;
// Controls the fineness of the cube
slices=1000;
// How much the spiral should twist. Values < 180 will not hold together!
twist=240;
// How much to initially rotate the spiral
offset=-60;
part="single"; // [cube:Assembled Cube,single:Single Piece]

/* [Hidden] */
t=twist;
o=offset;
tol=tolerance;


rotate([-45,0,0])
	rotate([0, -atan(1/sqrt(2)), 0])
		difference(){
			rotate([45, atan(1/sqrt(2)), 0])
				cube(size, center=true);
	
			linear_extrude(
				height=size*sqrt(3),
				twist=t,
				convexity=10,
				center=true,
				slices=slices
			){
				for(i=[0:360/3:359])
					rotate(i+o+t/2)
						translate([-tol/2, 0, 0])
							square([tol, 100*size]);
				if(part=="single")
					for(i=[0,360/3])
						rotate(i)
							polygon([
								[0, 0],
								[0, -100*size],
								100*size*[sin(60),cos(60)]
							]);
			}
}