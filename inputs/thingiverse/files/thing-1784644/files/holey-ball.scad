spherediam=10;
cylinderdiam=4;
cylinderdpth=15;
sides=150;

difference(){
    sphere( d=spherediam,$fn=sides);
    translate([0,0,0-(spherediam/2)])#cylinder( d=cylinderdiam,h=cylinderdpth,$fn=sides);

}

