//Radi de revolució
radi_rev = 20; // [1:40]

//Radi petit cercle que gira
radi_cercle = 10; // [1:20]

costat_cub = 2*(radi_rev + radi_cercle);

intersection(){
	rotate_extrude(convexity = 10, $fn=60)
		translate([radi_rev, 0, 0])
			circle(r = radi_cercle,$fn=60);
	translate([0,0,radi_cercle/2]) 
		cube([costat_cub,costat_cub,radi_cercle],center=true);
}