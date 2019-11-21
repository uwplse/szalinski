//This generates a bunch of rods that make a twisted strip

//Resolution of Strip.
number_of_rods = 20;//[20:500]

//Thickness of the wall.
thickness = 4;//[2:0.2:10]

//Height of wall.
length = 100;//[20:200]

//Inner Radius of the strip.
radius = 100;//[20:200]

//Number of twists.
twists = 1;//[0:10]

/* [Hidden] */


for(i=[0:number_of_rods]) {
	value = i/number_of_rods;
	value_1 = (i+1)/ number_of_rods;
	hull() {
		translate([radius*sin(value*360),-radius*cos(value*360),0]) 
		rotate(value*360,[0,0,1]) rotate(value*twists*180,[1,0,0])
			cube([thickness,thickness,length], center=true);
		//
		translate([radius*sin(value_1*360),-radius*cos(value_1*360),0]) 
		rotate(value_1*360,[0,0,1]) rotate(value_1*twists*180,[1,0,0])
			cube([thickness,thickness,length], center=true);
	}
}
//Programmed by Will Webber
// with a thank you to Neon22 for suggeting alterations to use the convex hull