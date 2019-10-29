limb=20;
head=30;
body=50;

B=25;

// Bolt head height
h=8;

// Bolt overall length
l=69.5;

// diamter
d=11;

$fn=50;

h=100;

module bolt(){
union(){
		translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
		cylinder(h=l, r=d/2); // bolt shaft
		}
					}

module buddy(){
union(){
sphere(r=body, center=true);
    
    translate([0,body+2,0]) sphere(r=head);
    
    translate([-body,20,0]) sphere(r=limb);
    
    translate([-body+10,-40,0]) sphere(r=limb);
    
    translate([body+1,20,0]) sphere(r=limb);
    
    translate([body-10,-40
  ,0]) sphere(r=limb);
}}

difference() {
    buddy();
    translate([0,0,-h/2]) cube(size=[200,200,h], center= true);
    translate([0,0,-30]) bolt();}