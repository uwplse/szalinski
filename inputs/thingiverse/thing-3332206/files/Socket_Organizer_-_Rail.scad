// ----------------------------------------------------------------
// Customizable Socket Organizers: Rail (Rectangular Cross Section)
// ----------------------------------------------------------------
//
// Zemba Craftworks
// youtube.com/zembacraftworks
// thingiverse.com/zembacraftworks/about

// This is a configurable, 3D printable insert designed to
// slide onto a metal or wooden bar to create socket set
// organizers. Dimensions can be adjusted for sockets of
// all sizes and to slide onto bars/holders of any size.

// Date Created:  2018-07-30
// Last Modified: 2018-12-19

// Critical Dimensions
// -------------------
// Adjust these dimensions and verify them with a test print
// before printing holders for all of your sockets! You want a
// snug fit but not so tight that anything gets stuck. These
// values will vary depending on your sockets, the rail you're
// using, and the calibration of your printer.

d  = 9.7;           // Socket Drive Width (mm)
                    // (9.7 = approximately 3/8 in * 25.4 mm/in)

dh = 12;            // Socket Drive Height (mm)
                    // May or may not be limited by the design
                    // of your sockets
                    
rx = 3.4;           // Rail Cross-Section Height (mm)
                    // (3.4 = approximately 1/8 in * 25.4 mm/in)
                    
ry = 13;            // Rail Cross-Section Width (mm)
                    // (13 = approximately 1/2 in * 25.4 mm/in)
                    
// Other Dimensions 
// ----------------
// These dimensions are not as critical to the fit, but can be
// adjusted to suit your preferences.

dw = 2;             // Drive Wall Thickness (mm)
                    // Set to d/2 to make the drive post solid
ds = 5.5;           // Drive Stand Width (mm)
                    // (region between clamp and flange)
ct = 3;             // Wall Thickness of Rail Clamp (mm)
ch = d;             // Height of Rail Clamp (mm)
                    // (generally ch = d)                    
cg = 4;             // Bottom Gap of Rail Clamp (mm)
                    // (adds some flex when attaching to rail)
fa = 6;             // Flange Height above Rail Clamp (mm)
fc = 3;             // Flange Chamfer Width (mm)
fw = ry+2*ct;       // Flange Width (mm)
                    // (fw = ry+2*ct = flush with clamp)
ft = 1.5*ct;        // Flange Thickness (mm)

// Nub Dimensions (Optional)
// ------------------
// This imitates the spring-loaded bearing on the socket wrench which
// mates to the internal notch or side hole of the socket. However,
// you may have better success without it. Depending on your print
// it may snap off or deform easily when inserting into the socket.

enableNub = false;  // Enable Nub for Socket
nw = 3;             // Nub Width (mm)
nt = 0.5;           // Nub Height (mm)
nh = 5.5;           // Nub Distance from Flange (mm)
nr = 0.49;          // Radius of Curved Nub Edge (must be <= nt)
fn1 = 20;           // Number of Facets for Nub Curvature 

// Tolerance Value
// ---------------
// When shapes are subtracted through difference() in
// OpenSCAD, there is ambiguity if any faces of the two shapes
// occupy the same space. Adding a small value 't' to make
// the subtracted shape slightly larger prevents this.

t = 0.1;

difference(){
// Create Socket Organizer:
union(){
    
    // Rail Clamp
    difference(){
        // Rail Clamp Full Area
        translate([-(rx+2*ct)/2, -(ry+2*ct)/2, 0]){
            cube([rx + 2*ct, ry + 2*ct, ch]);    }    
        // Rail Cross Section
        translate([-rx/2, -ry/2, -t/2]){
            cube([rx, ry, ch+t]);    }    
        // Rail Clamp Gap
        translate([rx/2-t/2, -cg/2, -t/2]){
            cube([ct+t, cg, ch+t]);}}

    // Socket Drive
    difference(){    
        // Socket Drive Exterior
        translate([-dh-rx/2-ct-fa-ft,-d/2,0]){
            cube([dh,d,d]);}
        // Socket Drive Interior
        translate([-dh-rx/2-ct-fa-ft-t/2,-(d-2*dw)/2,dw]){
            cube([dh+t,d-2*dw,d-2*dw]);}}

    // Socket Drive Flange
    translate([-rx/2-ct-ft-fa,-fw/2,0]){
        cube([ft,fw,d]);    }

    // Socket Drive Support
    translate([-rx/2-ct-fa,-ds/2,0]){
        cube([fa,ds,d]);}

    // Create Nub (Optional)
    // (+0.0001 ensures cube is not height 0 when nt = nr)
    if (enableNub){
        translate([nr-nw-rx/2-ct-fa-ft-nh,nr-nw/2,nr-nt+d]){
            difference(){
                minkowski(){
                    sphere(r=nr,$fn=fn1);
                    cube([nw-2*nr,nw-2*nr,2*nt-2*nr+0.0001]);}
                translate([-nr,-nr,-nr]){
                    cube([nw,nw,nt]);}}}}

    // Chamfers
    translate([-rx/2-ct-fa,ds/2,0]){
        chamfer(fc,d,t);}
    translate([-rx/2-ct,ds/2,0]){
        rotate([0,0,90]){    
            chamfer(fc,d,t);}}
    translate([-rx/2-ct-fa,-ds/2,0]){
        rotate([0,0,-90]){    
            chamfer(fc,d,t);}}
    translate([-rx/2-ct,-ds/2,0]){
        rotate([0,0,-180]){    
            chamfer(fc,d,t);}}
}
}

// Chamfer Module
// Creates an interior chamfered edge w x w x h
module chamfer(w,h,t){
    hyp = sqrt(pow(w,2)+pow(w,2)); // Hypotenuse Distance
    difference(){
    cube([w,w,h]);
    translate([w,0,-t/2]){
        rotate([0,0,45]){
            cube([hyp,hyp,h+t]);}}}}