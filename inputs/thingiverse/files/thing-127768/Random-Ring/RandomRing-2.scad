// Ring size in mm
inner_diameter = 19;

// Ring height
height = 8;

// Ring thickness
thickness = 2;

// Seed, enter any number you like
seed = 42;

/* [Advanced] */
// The mesh resolution
mesh_resolution=50; // [20:120]

/* [Hidden] */
// preview[view:south, tilt:top]
$fn=mesh_resolution; // mesh resolution

rand_hole_count = rands(5,32,1,seed);
randangle = rands(0,360/rand_hole_count[0],100,seed);
randholedia = rands(0,height-2,100,seed);
randholeposfactor = rands(0,100,100,seed); 

echo (rand_hole_count[0]);
echo (randangle[0]+randangle[1]+randangle[2]+randangle[3]+randangle[4]+randangle[5]+randangle[6]+randangle[7]+randangle[8]+randangle[9]+randangle[10]);

difference() {
	difference() {
		union() {
			cylinder(h = height, r = (inner_diameter+thickness*2)/2);
			cylinder(h = 1, r = (inner_diameter+thickness*2)/2+0.5);
			translate ([0,0,height-1])cylinder(h = 1, r = (inner_diameter+thickness*2)/2+0.5);
				}
		translate ([0,0,-1]) cylinder(h = height+2, r = inner_diameter/2);
	}
	for(i=[0:rand_hole_count[0]])  {
	//sum_of_angles(randangle,i,0);
	echo(rand_hole_count[0]);
	echo("durchgang", i);
	echo("sum angles=", sum_of_angles(randangle,i,0)); 
		translate ([0,0,1+(randholedia[i]/2)+((height-2-randholedia[i])*randholeposfactor[i]/100)]){
			rotate(a=[90,0,sum_of_angles(randangle,i,0)*2]) {
			cylinder(h = 18, r = randholedia[i]/2);
			}
		}
	}
}
echo("sum angles=", sum_of_angles(randangle,20,0)); // is 20+30=50

function sum_of_angles(v,i,s=0) = (i==s ? v[i] : v[i] + sum_of_angles(v,i-1,s));





