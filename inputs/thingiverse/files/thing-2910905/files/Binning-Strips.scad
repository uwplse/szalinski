//    |<-A->|
//     _____       _______
//    |     |<-C->|     ||
//    |     |     |     |B
//    |     |     |     ||
// ---       -----       ---

// Width of divider in mm
A = 6.4;
// Depth of divider in mm
B = 4;
// Distance between dividers (material thickness) in mm
C = 6.4; // Distance between dividers (material thickness)
 
// Total height of binning strip in mm
H = 25;
// Thickness of 'Tape' holding diviers together in mm
T = 0.4;
// Total number of dividers
N = 16;
// Cutoff angle
P = 30;

//    __________|a| 
//    |   /     \ |
//    b  /       \|
//    |_/         \
//      |         |
//      |         |
//      |         |
// -----           ------          

// rise of divider chamfer in mm
b = 2;
// run of divider chamfer slope in mm
a = 1;

// generate the tape
translate([0,0,-T]) cube([(N)*(A+C)-C,H,T]);

//generate the dividers
for(i=[0:1:N-1])
    translate([i*(A+C),0,0]) divider_element(H, A, B, b, a, P);

// module to make the divider shape
module divider_element(height, width, depth, rise, run, angle){
    difference(){
        translate ([0,height,0]) rotate([90,0,0]) linear_extrude(height, center = false, convexity = 10, twist = 0){
            polygon([[0,0],[0,depth-rise],[run,depth],[width-run,depth],[width,depth-rise],[width,0],[0,0]]);
        }
        // cutoff the top
        rotate([angle,0,0]) cube([width,height,depth]);    
    }
}

