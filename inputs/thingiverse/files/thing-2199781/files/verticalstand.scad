// Width
th_x = 80;
// Height
th_z = 50;
// Deep
th_y = 20;
// Central width
th_mid = 40;
// Wall thickness
th_thick = 5;
// Elevation
th_elev = 10;
// Text
txt = "thingiverse";
// Text size
txt_size = 6;
    
thing();

module thing()
{   
    
    r_cyl2 = th_mid/2;
    r_cyl1 = (th_x-(2*th_thick)-th_mid)/2;
    
    difference() {
        cube(size=[th_x,th_y,th_z]);    

        // Central
        rotate(a=[90,0,0])
        translate([th_x/2,th_elev+r_cyl2,-th_y-5]) {
            cylinder(h=th_y+10,r=r_cyl2);
            translate([-r_cyl2,0,0])
                cube(size=[r_cyl2*2,th_z,th_y+10]);
        }

        // Side
        rotate(a=[90,0,0])
        translate([0,th_thick+r_cyl1,-th_y-5]) {
            cylinder(h=th_y+10,r=r_cyl1);
            translate([-r_cyl1,0,0])
                cube(size=[r_cyl1*2,th_z,th_y+10]);
        }
   
        rotate(a=[90,0,0])
        translate([th_x,th_thick+r_cyl1,-th_y-5]) {
            cylinder(h=th_y+10,r=r_cyl1);
            translate([-r_cyl1,0,0])
                cube(size=[r_cyl1*2,th_z,th_y+10]);
        }
    }
    
    color("Green")
    rotate(a=[90,0,0])
    translate([th_x/2, th_elev/3, 1]) {
        linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
        text(txt, size=txt_size, halign="center", font = "Open Sans");
    }
}