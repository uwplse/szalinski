$fn=100*1;
//distance-between-axis-in-mm 
dist=15; 


//No sé que carallo quieres hacer


difference() 
{ 
	union() 
	{ 
		difference() 
		{
			cylinder(h = 25, r=8); 
			cylinder(h = 5, r=6);
			cylinder(h = 40, r=3); 
			translate([0,0,21])
			cylinder(h = 4, r=6);  //Esto porque lo metes entre corchetes???
		}
		translate([dist,0,0])
		
		difference()
		{
			cylinder(h = 25, r=6); 
			cylinder(h = 50, r=5); 
			translate([0,-1,0]) 
			cube(size = [25,2,30], center = false);
		} 
		
		difference() 
		{
			translate([-dist/2,0,12.5]) 
			cube(size = [((dist/2)+15),6,25], center = true);
			translate([-dist,0,0]) 
			cylinder(h = 40, r=6); 
			cylinder(h = 50, r=5);
		}
		rotate([90,0,0])
		translate([-(dist/2),12.5,0]) 
		cylinder(h = 17, r=2.5, center = true);
	      rotate([90,0,0]) 
		translate([-(dist/2),12.5,0]) 
		cylinder(h = 17, r=2.5, center = true); 
		difference() 
		{
			union()
			{
				translate([5,1,0])
				cube(size = [5,2,25],center = false);
				translate([5,-3,0]) 
				cube(size = [5,2,25], center = false);
			}
			rotate([90,0,0]) 
			translate([7.5,12.5,0]) 
			cylinder(h = 17, r=1.1, center = true);
		}
	}
}

rotate([90,0,0]) 
translate([(dist/2),12.5,0])
cylinder(h = 30, r=1.5, center = true);





