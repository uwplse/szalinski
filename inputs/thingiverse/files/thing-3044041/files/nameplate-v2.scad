// Name Plaque

$fa=5; $fs=0.5;

// Compiler warnings for unknown variables ha and r2a

// Border Width
border = 4;  

// Overall Width
w = 170;

// Overall Height
h = 20;

// Thickness (half thickness, actually)
tt = 2;     

// Text scaling factor
textScaling = 1.2; 

// Screw hole diameter 
hd = 4;    

// Enter the text here
name = "Your Name Here";

holes = true;

// countersink = true;  // To Do:  make countersunk holes optional

//////////////////////////////////////////////////////////////////
    
// Precalculate stuff for countersunk holes
pi = 3.1416*1;
r1a = hd/2;
ha = 2.02 * tt;
r2a = hd;
r1a = r2a - ha * cos(60/180*pi);
holePos = 0.5*w-3*hd;

//////////////////////////////////    

// Build the model

difference() {
    union() {
        
        // The main body and the border
        difference() {
            cube([w, h, 2*tt], center=true);
            translate([0, 0, tt]) {
                cube([w-1*border, h-1*border, 2*tt], center=true);
            }
        }
    
        // The lettering
        translate([0, 0, 0]) {
            scale(textScaling, textScaling, 1) {
                linear_extrude(1*tt) {
                    text(name, font = "Liberation Sans:style=Bold Italic", halign="center", valign="center");
                            
                }
            }
        }
        
        if (holes == true) {
        // Hole Bosses
        translate([-holePos, 0, 0]) {
            cylinder(r=hd*1.35, h=2*tt, center=true);
        }
        translate([holePos, 0, 0]) {
            cylinder(r=hd*1.35, h=2*tt, center=true);
        }
    }
    }
    
    // Holes to remove
    if (holes == true) {
    union() {
       translate([-holePos, 0, 0]) {
            cylinder(r=hd*0.5, h=tt*3, center=true);
            cylinder(r1=r1a, r2=r2a, h=ha, center=true); 
        }   
        translate([holePos, 0, 0]) {
            cylinder(r=hd*0.5, h=tt*3, center=true);
            cylinder(r1=r1a, r2=r2a, h=ha, center=true); 
        }
    }
}
}


