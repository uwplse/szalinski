// IKEA to BRIO track connector

// Height of the piece. Multiplied by one so that it doesn't appear in Customizer
height = 11*1;

// Radius of the fixed end of the connector (with nods). Multiplied by one so that it doesn't appear in Customizer
fixedrad = 6*1;

// Radius of the male end of the connector. Multiplied by one so that it doesn't appear in Customizer
malerad = 5.5*1;

// Length of the connector
stud_length = 22;

// Thickness of the stud. Multiplied by one so that it doesn't appear in Customizer
studthickness = 6*1;

// Radius of the fixing nods. Multiplied by one so that it doesn't appear in Customizer
nodrad = 1*1;

// How far the fixing nods are recessed within the fixed end of the connector. The greater the value, the less they will protude.
nod_recess = 0.2;

// How the nods are distributed. Multiplied by one so that it doesn't appear in Customizer
nodangle = 40*1;

// The resolution of the curved surfaces. Multiplied by one so that it doesn't appear in Customizer
curveresolution = 50*1;

cylinder(h=height,r=fixedrad,$fn=curveresolution);
translate([stud_length,0,0]) cylinder(h=height,r=malerad,$fn=curveresolution);
translate([0,-studthickness/2,0]) cube(size=[stud_length,studthickness,height]);

// Draw the nods to grip the fixed size

nodposrad = fixedrad-nod_recess;

translate([nodposrad*sin(nodangle),nodposrad*cos(nodangle),0]) 
cylinder(h=height,r=nodrad,$fn=curveresolution);

translate([nodposrad*sin(180-nodangle),nodposrad*cos(180-nodangle),0]) 
cylinder(h=height,r=nodrad,$fn=curveresolution);

translate([nodposrad*sin(nodangle+180),nodposrad*cos(nodangle+180),0]) 
cylinder(h=height,r=nodrad,$fn=curveresolution);

translate([nodposrad*sin(-nodangle),nodposrad*cos(-nodangle),0]) 
cylinder(h=height,r=nodrad,$fn=curveresolution);