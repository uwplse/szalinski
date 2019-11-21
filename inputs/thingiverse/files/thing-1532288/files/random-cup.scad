// Random Number Seed - cup will be the same if generated with the same seed and parameters
Random_Seed=0;  // [0:10000]
// Height
Cup_Height=100; // [20:300]
// Twist
Cup_Twist=175; // [0:1440]
// Min Radius
Min_Radius=34.5; // [20:0.5:150]
// Max Radius
Max_Radius=48; // [20:0.5:150]
// Number of Points
Number_of_Points=34; // [3:150]
// Wall Thickness
Wall_Thickness=2; // [1:0.1:10]
// Cup Taper
Taper=1.2; // [1:0.1:3]
// Make cup from intersection of two opposite twists
Double_Twist="no"; // [yes,no]
//  Do not hollow the cup out for printing in vase mode
Solid="no"; // [yes,no]

maximum=max(Max_Radius,Min_Radius);
minimum=min(Max_Radius,Min_Radius);

function polar_to_cart(angle=0, distance=0) = [distance*sin(angle),distance*cos(angle)];


cup(height=Cup_Height, thickness=Wall_Thickness, twist=Cup_Twist, scale=Taper, solid=Solid)
	random_polygon(Number_of_Points,minimum,maximum);

module random_polygon(num_points=40, min=28, max=35) {
    randoms=rands(min,max,num_points,Random_Seed);
    
    union() {
		for (i=[1:num_points-1]) {
			//echo(randoms[i],(360/num_points)*i);
			polygon([[0,0],	polar_to_cart((360/num_points)*(i-1),randoms[i-1]), polar_to_cart((360/num_points)*i,randoms[i])]);
		}
		polygon([[0,0],	polar_to_cart((360/num_points)*(num_points-1),randoms[num_points-1]), polar_to_cart(0,randoms[0])]);
	}
}

module cup(height=50, thickness=3, twist=90, scale=1.1, solid="no") {
	difference() {
        cup_shape(height,twist, scale)
            children(0);
        if (solid=="no") {
            translate([0,0,0.01])
                cup_shape(height,twist, scale)
                    offset(-thickness)
                        children(0);
        }
     }
    intersection() {
        cup_shape(height,twist, scale)
            children(0);
        cylinder(r=100, height=thickness);
    }
}

module cup_shape(height=50, twist=90, scale) {
    if (Double_Twist=="yes") {
        intersection () {
          linear_extrude(height=height, twist=twist,scale=scale)
              children(0);
          linear_extrude(height=height, twist=-1*twist,scale=scale)
              children(0);
         }
     } else {
         linear_extrude(height=height, twist=twist,scale=scale)
              children(0);
     }
}

