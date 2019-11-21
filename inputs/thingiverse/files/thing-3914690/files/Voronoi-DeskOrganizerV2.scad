
use <KeibelsVoronoiToolboxV2.1.scad>;

$fn=30;
$fa=20;
dim=[260,260,5];//  dx= x-edge,dy=y-edge dz=hight of cube
seed=7;
n=20;
x = rands(-dim.x/2, dim.x/2, n, seed);      
y = rands(-dim.y/2, dim.y/2, n, seed + 1);  
z = rands(0, 30, n, seed + 2);  
points = [ for (i = [0 : n - 1]) [x[i], y[i], z[i]] ];
//        echo(points);


3D_VoronoizeFromGivenPointsAKL(
                points,         // Pass the points to the function
                L = 200,        // Largest diagonal Length of the resulting structure
                thickness = 2, // Thickness of the gaps between the voronoi cells 
                round = 3,      // Roundings of the areal-gaps between the voronoi cells 
                showDots=false, // Show the dots or not (for debugging)
                renderit=true)
                    union(){
						cylinder(130,50,90);
						cylinder(35,100,130);
					}

// outside big cone
d2=[60,60,130];//  dx= x-edge,dy=y-edge dz=hight of cube
s2=7;
n2=80;
x2 = rands(0, 360, n2, s2);      
y2 = rands(-20, 20, n2, s2 + 1);  
z2 = rands(20, d2.z, n2, s2 + 2);  
p2 = [ for (i = [0 : n2 - 1]) [
                  sin(x2[i])*(d2.x+y2[i]),
                  cos(x2[i])*(d2.x+y2[i]), z2[i]] ];

3D_VoronoizeFromGivenPointsAKL(
                p2,         // Pass the points to the function
                L = 200,        // Largest diagonal Length of the resulting structure
                thickness = 5, // Thickness of the gaps between the voronoi cells 
                round = 0,      // Roundings of the areal-gaps between the voronoi cells 
                showDots=true, // Show the dots or not (for debugging)
                renderit=true)	difference(){
					cylinder(130,50,90);
					cylinder(130,46,86);
				};
				
// outside lower wider cone
difference(){
	cylinder(35,100,130);
	translate([0,0,2])cylinder(35,96,126);
}
intersection(){ 
 difference(){
	cylinder(130,50,90);
	cylinder(130,46,86);
  }
 translate([0,0,125]) cylinder(6,100,100);
 };
 