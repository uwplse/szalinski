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

bolt();
