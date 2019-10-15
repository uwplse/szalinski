// Angle & Flat feet

// Side 1 (mm)
L1=25.5; //[1:51]
// Side 2 (mm)
L2=25.5; //[1:51]
// Height of foot (mm)
height=25.5; //[1:51]
// Thickness of steel (mm) - look at gauge tables for conversion 
T=1; //[0.2:3]
// Thickness of print (mm)
wall=3; //[1:5]

tolx=0.25;
module foot(){
    difference(){
        union(){
            translate([-1.5*wall,-1.5*wall,0])cube([L1+3*wall,L2+3*wall,wall]);
            translate([-wall,-wall,0])cube([L1+2*wall,2*wall+T,height+wall]);
            translate([-wall,-wall,0])cube([2*wall+T,L2+2*wall+T,height+wall]); }
        union(){
            translate([0,0,wall])cube([L1,T,height+tolx]);
            translate([0,0,wall])cube([T,L2,height+tolx]); }
        }
}

foot();