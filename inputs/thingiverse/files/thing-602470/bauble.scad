//AJC customisable bauble
//http://www.thingiverse.com/thing:602470
//inspired by http://www.thingiverse.com/thing:189704

//Number of loops
loops = 5; //[2:10]
//Twists
twist = 3; //[0:10]
//Diameter of bauble
size = 55; //[10:200]
//Thickness of shell (loops are twice this wide)
thickness = 3; //[1:10]
//Double or single twist
double_helix = true; //[true, false]
//Turn on or off loop for hanging
do_loop = true; //[true, false]

module spirals(twist=twist) {
    twistA = twist*360/(loops*2);
    linear_extrude(height=size, center=true, convexity=4, twist=twistA, slices=size)
        for (i = [1:loops]) {
            rotate(i*360/loops, [0,0,1])
                translate([-thickness,-1,0])
                    square([thickness*2,size/2+2], center=false);
        }
}
union() {
    intersection() {
        difference() {
            union() {
                    spirals(twist);
                if (double_helix == true) {
                    spirals(-twist);
                }
            }
            sphere(r=size/2-thickness, center=true);
        }
        sphere(r=size/2, center=true);
        translate([0,0,thickness/2])
            cube(size, center=true);
    }
    //Loop
    if (do_loop == true) {
        translate([0,0,size/2+2])
            rotate([90,0,0])
                rotate_extrude($fn=20)
                    translate([3,0,0])
                        circle(r = 1);    
    }
}