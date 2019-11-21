//Customizable Shadow Band - to cast a shadow on solar radiation equipment so you can look at global and direct radiation


//Height of band
h=20; 
// radius of band
r=50; 
//Thickness of band
t= 5; 
// Center extension width
w=10; 
//Center extension hole size
e=2;

module shadowband ()
{
difference(){

		union(){
		rotate([0,90,0])cylinder(h = 2*r, r1 = w, r2 = w, center = true, $fn=250);
			difference(){
			cylinder(h = h, r1 = r, r2 = r, center = true, $fn=250);
			cylinder(h = h+2, r1 = r-t, r2 = r-t, center = true, $fn=250);
			translate([-r,0,-h/2-1])cube([2*r+2,r+1,h+2]);
						}
				}
rotate([0,90,0])cylinder(h = 2*r+2, r1 = e, r2 = e, center = true, $fn=250);
rotate([0,90,0])cylinder(h = 2*r-2*t, r1 = w+0.1, r2 = w+0.1, center = true, $fn=250);
			}
}

shadowband ();