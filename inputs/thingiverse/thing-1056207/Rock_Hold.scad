//Connor Kmiec
//Rock Wall Hold Project - MY4777 
// Bolt for rock wall assignment
// Inane imperial units inexplicably in use in a free state: 3/8" - 16x2-1/2"
// All measurements below in mm

//Bolt head diamter with clearance for tool
B=25;

// Bolt head height
h=8;

// Bolt overall length
l=69.5;

// diamter
d=11;

$fn=50;

module bolt(){
union(){
		translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
		cylinder(h=l, r=d/2); // bolt shaft
		}
					}
                    
difference(){
union(){
translate([0,0,20])sphere(30, $fn=50);
cylinder(h = 40, r1 = 30, r2 = 30, center = true,$fn=50);
translate([0,0,-15])scale([1,1,0.33])sphere(35, $fn=50);
translate([0,0,5])scale([1,1,0.33])sphere(35, $fn=50);   
translate([0,0,25])scale([1,1,0.33])sphere(34, $fn=50);  
translate([0,0,41])scale([1,1,0.33])sphere(28, $fn=50);     
    
};
translate([0,0,-70])cube([1000,1000,100],center=true);
translate([0,0,-40])bolt();
translate([0,0,135])cylinder(h = 200, r1 = 12.5, r2 = 12.5, center = true,$fn=50);
}
