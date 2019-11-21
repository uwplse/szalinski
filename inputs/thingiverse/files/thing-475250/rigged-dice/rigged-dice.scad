//ridge length (mm)
l=100;
//wall thickness
ep=1;
//trickery  (0-100) : how much will the dice be rigged
f=75;
//face that will likely show up (1-6)
rigged=6;
//cut to view inside (0=no,1=yes)
cut=1;
//dot size (defaults to l/10)
dot=l/10;
//dot spread (dot radius multiplier, keep this about 2 to 3)
ecart=2.5;
//dot depth 
dot_depth=0.1;
//round corners (1=cube,0.5=dotless sphere, sweet spot around 0.8)
arrondi=0.8;

$fa=10;
$fs=0.1;

il=l-ep*2;

roll=[
	[0,0,0], 	//1
	[0,90,0],	//2
	[90,0,0],	//3
	[-90,0,0],	//4
	[0,-90,0],	//5
	[0,180,0]	//6
];

intersection() {  //round corners

difference() {   //punch holes

	difference(){ //cut to see through (if cut=1)

		difference(){ //make the dice hollow
			cube([l,l,l],center=true);
			difference() // f=0 removes sphere, f=100 removes hemisphere
				{sphere(r=il/2,center=true);
				translate([0,0,-(ep+il)*(0.5+(100-f)*0.005)])cube([l,l,l],center=true);
				}
			}
		translate([0,0,-l/1.9]) cube([cut*l/1.9,cut*l/1.9,cut*l*2.1]);
	}
	
	rotate(roll[rigged-1]) { //roll the dice to put rigged face upward
			//--------- dots -----------------
			translate([0,0,l/2-dot_depth])cylinder(h = l,r=dot);  	//1
			
			rotate([0,-90,0])
				translate([0,0,l/2-dot_depth]) {	               //2		
				translate([-dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				}
			
			rotate([-90,0,0])
			translate([0,0,l/2-dot_depth]) {	               //3		
				cylinder(h = l,r=dot);  
				translate([-dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				}
			
			rotate([90,0,0])
			translate([0,0,l/2-dot_depth]) {	               //4
				translate([-dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([-dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				}
			
			rotate([0,90,0])
			translate([0,0,l/2-dot_depth]) {	               //5
				cylinder(h = l,r=dot);  
				translate([-dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([-dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				}
			
			rotate([180,0,0])
			translate([0,0,l/2-dot_depth]) {	               //6
				translate([-dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([-dot*ecart,dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,-dot*ecart,0]) cylinder(h = l,r=dot);  
				translate([dot*ecart,0,0]) cylinder(h = l,r=dot);  
				translate([dot*-ecart,0,0]) cylinder(h = l,r=dot);  
				}
			}
	}

sphere(r=(3*l)/(2*sqrt(3))*arrondi);
}