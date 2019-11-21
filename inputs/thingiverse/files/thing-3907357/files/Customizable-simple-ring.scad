//enter your ring size in mm found in any online conversion chart
RingSize = 17.7;
OD = RingSize + 2;
module ring(){
    difference (){
    cylinder(3,d = OD);
    translate([0,0,-0.5]){    cylinder(4,d = RingSize);
    }
    }
}
ring();
