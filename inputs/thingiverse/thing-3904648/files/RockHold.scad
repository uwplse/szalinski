a=50/2;
b=100/2;
c=200/2;
smooth=100;
//Bulb Rotation Angle
rot_angle=45;
//Number of Bulbs
Number=6;
//Arc Covered by Bulbs
Arc=270;

module bulb(){
    hull(){
        union(){
        cube([a,b,c],center=true);
    translate([0,0,b])sphere(b,$fn=smooth);
}
}
}
module rotated(){hull(){translate([0,-b*2/3,0])rotate([rot_angle,0,0])bulb();
}
}
module Grip(){
    union(){for(i=[1:Number])
        assign(angle=i*Arc/Number)
    {
        rotate(angle,[0,0,1])
        rotated();
    }
}
}
module Mount(){union(){cylinder(h=c*2/3,r=b/1.5,,center=true);
    Grip();
}
}
module base()translate([0,0,-100]){cube([c*10,c*10,200],center = true);
}

module Hold(){
    difference(){
        Mount();
    base();
}
}



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


                    
module final(){
    difference(){
        Hold();
        translate([0,0,-40])
        bolt();
    }
}


final();