/* [Parameters] */
//The "smoothness" of the pores, higher number means smoother pores
resolution = 10; // [5:25]
//Size of the cube
Cube_Size = 15;
//Number of pores in the cube
Pore_Count = 60; // [10:400]
//Diameter of the spheres
Pore_Size = 2;
//Set to "true" to see just the pores, set to "false" otherwise
See_Spheres = "false"; // [false, true]

/* [Hidden] */
$fn = resolution;

difference(){
    if(See_Spheres == "false")
        cube([Cube_Size,Cube_Size,Cube_Size]);

    for(i = [1:Pore_Count]) {
        xDist = rands(0,Cube_Size,1);
        roundedXDist = round(xDist[0]);
        
        yDist = rands(0,Cube_Size,1);
        roundedYDist = round(yDist[0]);
        
        zDist = rands(0,Cube_Size,1);
        roundedZDist = round(zDist[0]);
        
        translate([roundedXDist, roundedYDist, roundedZDist]){
            sphere(d = Pore_Size);
        }
    }
}