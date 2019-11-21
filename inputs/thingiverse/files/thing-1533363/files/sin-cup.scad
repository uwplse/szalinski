// Height
Cup_Height=70; // [20:300]
// Twist
Cup_Twist=90; // [0:1440]
// Min Radius
Min_Radius=27; // [20:0.5:150]
// Max Radius
Max_Radius=30; // [20:0.5:150]
// Number of Points
Number_of_Points=50; // [3:150]
// Wall Thickness
Wall_Thickness=3; // [1:0.1:10]
// Bottom Thickness
Bottom_Thickness=4; // [1:0.1:10]
// How far up the bottom of the cup should be recessed
Bottom_Recess=2; // [0:0.1:4]
// Cup Taper
Taper=1.2; // [1:0.1:6]
// Make cup from intersection of two opposite twists
Double_Twist="no"; // [yes,no]
//  Do not hollow the cup out for printing in vase mode
Solid="no"; // [yes,no]
//  How many times to repeat the sin function
Repeat=10;
// Render mode
mode="normal"; // [normal, cross_section, inside]

maximum=max(Max_Radius,Min_Radius);
minimum=min(Max_Radius,Min_Radius);

function polar_to_cart(angle=0, distance=0) = [distance*sin(angle),distance*cos(angle)];

function scaled_sin(angle=0, minimum=20, maximum=25) = ((maximum-minimum)*((sin(angle)+1)/2)+minimum);

function point(x=0, minimum=20, maximum=25) = polar_to_cart((360/Number_of_Points)*(x),scaled_sin(Repeat*360*(x/Number_of_Points),minimum,maximum));

if (mode=="cross_section")
    difference() {
        cup(height=Cup_Height, thickness=Wall_Thickness, bottom_thickness=4, recess=Bottom_Recess, twist=Cup_Twist, taper=Taper, solid=Solid)
            cup_polygon(Number_of_Points,minimum,maximum);
        translate([0,-Max_Radius*Taper,-0.25])
            cube([Max_Radius*Taper,Max_Radius*Taper*2,Cup_Height+0.5]);
    }
    else if (mode=="inside")
        cup_inside(height=Cup_Height, thickness=Wall_Thickness, bottom_thickness=4, recess=Bottom_Recess, twist=Cup_Twist, taper=Taper, solid=Solid)
            cup_polygon(Number_of_Points,minimum,maximum);
    else
        cup(height=Cup_Height, thickness=Wall_Thickness, bottom_thickness=4, recess=Bottom_Recess, twist=Cup_Twist, taper=Taper, solid=Solid)
            cup_polygon(Number_of_Points,minimum,maximum);

module cup_polygon(num_points=40, min=28, max=35) {
    
    union() {
		for (i=[1:num_points-1]) {
			//echo(sin(i));
			polygon([[0,0],point((i-1),minimum,maximum), point(i,minimum,maximum)]);
		}
        polygon([[0,0],point(num_points-1,minimum,maximum),point(0,minimum,maximum)]);
	}
}

module cup_inside(height=50, thickness=3, bottom_thickness=4, recess=0, twist=90, taper=1.1, solid="no") {
    if (solid=="no") {
        difference() {
            cup_shape(height, twist, taper)
                offset(r=-thickness)
                    children(0);
            cylinder(r=Max_Radius*taper+1, h=bottom_thickness+recess);
        }
    }
}

module cup_recess(height=50, thickness=3, recess=0, twist=90) {
    cup_shape(recess, (twist*(recess/height)), 1-4*recess/height)
        offset(r=-thickness)
            children(0);
}

module cup(height=50, thickness=3, bottom_thickness=4, recess=0, twist=90, taper=1.1, solid="no") {
	difference() {
        cup_shape(height,twist, taper)
            children(0);
        translate([0,0,0.01])
            cup_inside(height, thickness, bottom_thickness, recess, twist, taper, solid)
                children(0);
        translate([0,0,-0.01])
            cup_recess(height, thickness, recess, twist)
                children(0);
     }
}

module cup_shape(height=50, twist=90, taper) {
    if (Double_Twist=="yes") {
        intersection () {
          linear_extrude(height=height, twist=twist,scale=taper)
              children(0);
          linear_extrude(height=height, twist=-1*twist,scale=taper)
              children(0);
         }
     } else {
         linear_extrude(height=height, twist=twist,scale=taper)
              children(0);
     }
}


