// Customizable circular token holder for board games
// Matthew (Nick) Veldt

// Number of token slots
Number = 3; //[3,4,5]

// Should they all be the same size?
Same_size = "yes"; // [yes,no]

// Height in mm
h = 50;

// Wiggle room
w = 1;

// Diameter of first (and largest) token in mm
d1 = 25;

// Diameter of second token
d2 = 15;

// Diameter of third token
d3 = 15;

// Diameter of fourth token
d4 = 10;

// Diameter of fifth token
d5 = 10;

dArray = [d1,d2,d3,d4,d5];
module base() {
    cylinder(h, r = d1*(0.5+0.2*Number));
    
}

module cylinders() {
    factor = 0.2*Number + 0.1;
    if (Same_size == "yes"){
        for (i = [0:Number -1]) {
            alpha = i *360/Number;
            translate([factor*d1*cos(alpha),factor*d1*sin(alpha),3])
            cylinder(h,(d1/2 + w),(d1/2+w));
        }
    }
    if (Same_size == "no"){
        for (i = [0:Number -1]) {
            alpha = -i *360/Number;
            translate([factor*(1.4*d1-0.4*dArray[i])*cos(alpha),factor*(1.2*d1-0.2*dArray[i])*sin(alpha),3])
            cylinder(h,(dArray[i]/2 + w),(dArray[i]/2+w));
        }
        
    }
    
}
difference(){
    base();
    cylinders();
}
