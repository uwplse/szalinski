// ********************************************************
// Edsal Shelf Feet by jcantalupo
// remix by Peter Holzwarth
// ********************************************************

// Length of each leg of the L
L = 40;   // [5:150]

// Thickness of the leg slot
T = 2;    // [1:40]

// Number of feet to print
count= 4; // [1:8]

// Thickness of Bottom
B = 2;    // [2:10]

// Total Height of the foot
H = 10;   // [4:40]

// Thickness of the feet
th=3; // [2:10]

W = T+2*th;
s = L + W - T;

for (a=[1:count]) {
    translate([(a-1)*W*1.2,(a-1)*W*1.2,0]) shelfFoot();
}

module shelfFoot() {
    c= sqrt(2*th*th);
    echo (c);
    difference() {
        union() {
            cube([s,W,H]);
            cube([W,s,H]);
            translate([th+T,th+T,0]) linear_extrude(height = H) 
                polygon( points=[[0,0],[0,2*c],[2*c,0]] );
        }
        translate([(W-T)/2,(s-L)/2,B]) cube([L,T,H-B+0.01]);
        translate([(s-L)/2,(W-T)/2,B]) cube([T,L,H-B+0.01]);
        translate([th+T-0.01,th+T-0.01,B]) linear_extrude(height = H+0.01) 
            polygon( points=[[0,0],[0,c],[c,0]] );
    }
}


// translate([(W-T)/2,(s-L)/2,B]) cube([L,T,10]);