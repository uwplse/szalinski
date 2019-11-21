// number of sample slots
N = 25; // [10:1:60]

// thickness of bottom (mm)
TB = 2;  // [1:0.1:4]

// thickness of outer wall (mm)
TW = 3;   // [1:0.5:5]

// radius of edges (mm)
R = 2;  // [0:0.1:3]

// depth of box (mm)
D = 15; // [5:0.5:30]

// width of slot (mm)
WS = 2.5;  // [1:0.1:5]

// length of slot (mm)
LS = 68.5; // [50:0.5:90]

// width of divider (mm)
WD = 1;    // [1:0.5:3]

// length of divider (mm)
LD = 7.5; // [2:0.5:40]

// radius of divider corner
RD = 5; // [0:.5:20]

module end_customizable_parameters() { }
$fn = 50;
eps = 0.001;

difference() {
    hull() {
        
        // lower corners
        translate([R,R,0]) cylinder(r=R+eps,h=TB);
        translate([LS+2*TW-R,R,0]) cylinder(r=R+eps,h=TB);
        translate([R,2*TW-R+N*(WS+WD)-WD,0]) cylinder(r=R+eps,h=TB);
        translate([LS+2*TW-R,2*TW-R+N*(WS+WD)-WD,0]) cylinder(r=R+eps,h=TB);
        
        //upper corners
        translate([R,R,D+TB-R]) sphere(r=R+eps);
        translate([LS+2*TW-R,R,D+TB-R]) sphere(r=R+eps);
        translate([R,2*TW-R+N*(WS+WD)-WD,D+TB-R]) sphere(r=R+eps);
        translate([LS+2*TW-R,2*TW-R+N*(WS+WD)-WD,D+TB-R]) sphere(r=R+eps);
    }
    
    // cut the slots
    for (i = [0:N-1]) {
        translate([TW,TW+i*(WS+WD),TB]) cube([LS,WS,2*D]); 
        }
        
    // eliminate the middle portion of the dividers
    translate([LD+TW,TW,TB]) cube([LS-2*LD,N*(WS+WD)-WD,2*D]);

    // round the corners of the dividers
    if (RD > 0) {
        translate([0,0,TB+D-RD]) difference() {
            translate([LD+TW-RD,TW,0]) cube([LS-2*LD+2*RD,N*(WS+WD)-WD,2*D]);
            translate([LD+TW-RD,TW,0]) rotate([-90,0,0]) cylinder(r=RD,h=N*(WS+WD)-WD);
            translate([LS-LD+TW+RD,TW,0]) rotate([-90,0,0]) cylinder(r=RD,h=N*(WS+WD)-WD);
        }   
    }
}