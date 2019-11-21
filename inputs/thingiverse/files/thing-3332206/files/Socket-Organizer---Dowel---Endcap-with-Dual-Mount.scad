// ----------------------------------------------------------------
// Customizable Socket Organizers: Circular End Cap with Dual Mount
// ----------------------------------------------------------------
//
// Zemba Craftworks
// youtube.com/zembacraftworks
// thingiverse.com/zembacraftworks/about

// This is a configurable, 3D printable insert designed to
// slide onto a metal or wooden bar to create socket set
// organizers. Dimensions can be adjusted for sockets of
// all sizes and to slide onto bars/holders of any size.

// Date Created:  2019-01-03
// Last Modified: 2019-01-03

// Critical Dimensions
// -------------------
// Adjust these dimensions and verify them with a test print
// before printing holders for all of your sockets! You want a
// snug fit but not so tight that anything gets stuck. These
// values will vary depending on your sockets, the rail you're
// using, and the calibration of your printer.


rr = 4.8;           // Dowel Radius (mm)
                    // (4.8 = approximately 3/8 in * 25.4 mm/in / 2)
fn1 = 60;           // Number of Facets for Curvature 

ct = 3;             // Wall Thickness of End Cap (mm)
ch = 8;             // Height of End Cap (mm)
       
hd1 = 3;            // Mounting Hole Diameter (Through-hole)
hd2 = 6;            // Mounting Hole Diameter (Counterbore)

hz = 1;             // Mounting Hole Offset Distance
hx = 2;             // Mounting Hole Counterbore Depth

f1 = 4;             // Flange Thickness
f2 = 5;             // Flange Width (Extra)
f3 = 5;             // Flange Fillet

// Tolerance Value
// ---------------
// When shapes are subtracted through difference() in
// OpenSCAD, there is ambiguity if any faces of the two shapes
// occupy the same space. Adding a small value 't' to make
// the subtracted shape slightly larger prevents this.

t = 0.1;

// Create End Cap

    // Dowel Clamp
    difference(){ 
        union(){

            // Main Dowel Clamp
            cylinder(r=rr+ct,h=ch,$fn=fn1);

            // Main Dowel Cap
            translate([0,0,-ct])
                cylinder(r=rr+ct,h=ct,$fn=fn1);

            // Corner Volume
            translate([0,-rr-ct,-ct ])
                cube([(rr+ct),2*(rr+ct),ch+ct]);

            // Mounting Flange
            translate([rr+ct-f1,-rr-ct-f2,-ct])
                cube([f1,2*rr+2*ct+2*f2,ch+ct]);
            translate([rr+ct-f1,rr+ct+f2,(ct+ch)/2-ct])
                rotate([0,90,0])
                cylinder(r=(ct+ch)/2,h=f1,$fn=fn1);
            translate([rr+ct-f1,-rr-ct-f2,(ct+ch)/2-ct])
                rotate([0,90,0])
                cylinder(r=(ct+ch)/2,h=f1,$fn=fn1);

            // (Optional) Square Edges on Flange
            // Top (+z)
            //translate([rr+ct-f1,-rr-ct-f2-(ch+ct)/2,-ct+(ch+ct)/2])
            //    cube([f1,2*rr+2*ct+2*f2+ch+ct,(ch+ct)/2]);
            // Bottom (-z)
            //translate([rr+ct-f1,-rr-ct-f2-(ch+ct)/2,-ct])
            //    cube([f1,2*rr+2*ct+2*f2+ch+ct,(ch+ct)/2]);

            // Flange Fillet 1
            difference(){
            translate([rr+ct-f1-f3,rr+ct,-ct])
                cube([f3,f3,ct+ch]);
            union(){
            translate([rr+ct-f1-f3-f3/2,rr+ct+f3/2,-ct-t/2])
                cube([1.5*f3+t,f3+t,ct+ch+t]);
            translate([rr+ct-f1-f3-f3/2,rr+ct-t/2,-ct-t/2])
                cube([f3+t,1.5*f3+t,ct+ch+t]);
            translate([rr+ct-f1-f3/2,rr+ct+f3/2,-ct-t/2])
                cylinder(r=f3/2,h=ct+ch+t,$fn=fn1);}} 
           
            // Flange Fillet 2
            difference(){
            translate([rr+ct-f1-f3,-rr-ct-f3,-ct])
                cube([f3,f3,ct+ch]);
            union(){
            translate([rr+ct-f1-f3-f3/2,-rr-ct-f3-f3/2,-ct-t/2])
                cube([1.5*f3+t,f3+t,ct+ch+t]);
            translate([rr+ct-f1-f3-f3/2,-rr-ct-f3-f3/2,-ct-t/2])
                cube([f3+t,1.5*f3+t,ct+ch+t]);
            translate([rr+ct-f1-f3/2,-rr-ct-f3/2,-ct-t/2])
                cylinder(r=f3/2,h=ct+ch+t,$fn=fn1);}}
        }

        union(){  
            // Dowel Volume
            translate([0,0,t/2])
            cylinder(r=rr,h=ch+t,$fn=fn1);

            // Mounting Holes
            translate([rr+ct-f1,rr+ct+f2+hz,ch-(ch+ct)/2])
            rotate([0,90,0])
            cylinder(r=hd1/2,h=f1+t,$fn=fn1);

            translate([rr+ct-f1,-(rr+ct+f2+hz),ch-(ch+ct)/2])
            rotate([0,90,0])
            cylinder(r=hd1/2,h=f1+t,$fn=fn1);

            // Mounting Hole Counterbore
            translate([rr+ct-f1-t,rr+ct+f2+hz,ch-(ch+ct)/2])
            rotate([0,90,0])
            cylinder(r=hd2/2,h=hx+t,$fn=fn1);

            translate([rr+ct-f1-t,-(rr+ct+f2+hz),ch-(ch+ct)/2])
            rotate([0,90,0])
            cylinder(r=hd2/2,h=hx+t,$fn=fn1);
        }
    }
