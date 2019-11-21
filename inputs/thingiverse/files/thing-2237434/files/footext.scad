//
//  parametric furniture foot extension
//  for leveling furniture on uneven floors
//  but also uneven furniture on even floors
//

extension = 15.0; // amount of extension needed

fsize_x = 44.5; // size of furniture foot
fsize_y = 44.5; // size of furniture foot
holedia = 30.0; // central hole, if desired, can be zero
wall = 2.0; // outer wall (fence) thickness
minwall = 0.0; // minimum outer wall total height (can be zero)
fence = 10.0; // minimum outer wall overlap of original foot 

tol = 0.5; // tolerance

d = 1*0.1;

difference () {
    union () { // add:
        translate([-fsize_x/2, -fsize_y/2, 0]) cube([fsize_x, fsize_y, extension]);
        hull () {
            translate([-fsize_x/2-tol-wall, -fsize_y/2-tol-wall, min(extension-2*wall,extension+fence-minwall)]) cube([fsize_x+2*tol+2*wall, fsize_y+2*tol+2*wall, max(2*wall+fence, minwall)]);
            translate([-fsize_x/2, -fsize_y/2, extension-2*wall-wall]) cube([fsize_x, fsize_y, wall]);
        }    
    }
    union () { //sub:
        // hole for furniture foot:
        translate([-fsize_x/2-tol, -fsize_y/2-tol, extension]) cube([fsize_x+2*tol, fsize_y+2*tol, max(minwall,fence)+d]);
        // any excess "below the surface":
        translate([-fsize_x/2-tol-wall-d, -fsize_y/2-tol-wall-d, -(wall+max(minwall,fence)+d)]) cube([fsize_x+2*tol+2*wall+2*d, fsize_y+2*tol+2*wall+2*d, wall+max(minwall,fence)+d]);
        // central hole:
        translate([0, 0, -(wall+max(minwall,fence)+d)]) cylinder(d=holedia, h=d+wall+max(minwall,fence)+extension+max(minwall,fence)+d, $fn=120);
    }
}
