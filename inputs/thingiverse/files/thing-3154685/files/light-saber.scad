//Code written by FBlanc Oct. 2018

// Pen diameter (mm) at the cap begining
Diameter_top = 12.5;

// Pen diameter (mm) at pen bottom
Diameter_bottom = 12.5;

// Pen length (mm): from bottom to cap begining
Length = 84;

/* [Hidden] */
$fn=60;
//$fa = 0.5;
//$fs = 0.5;

union() {
    difference() {
            scale(v = [Diameter_bottom / 20, Diameter_bottom / 20, Length / 105])
                light_saber();
            translate([0,0,-0.001])
                 cylinder(h=Length + 0.002, d1 = Diameter_bottom, d2 = Diameter_top);
    }
    l_tick = 5;
    translate([Diameter_bottom / 2,l_tick / 2,0.1*Length ])
        rotate(a=90,v=[1,0,0])
            cylinder(h=l_tick,d=1.5);
    translate([Diameter_bottom / 2,l_tick / 2,0.92*Length ])
        rotate(a=90,v=[1,0,0])
            cylinder(h=l_tick,d=1.5);
}

module light_saber()
{
    union() {
        difference() {
            difference() {
                union() {
                    cylinder(d=25,h=105);
                    for (angle = [0:60:360])
                        rotate(a = angle, v = [0,0,1])
                            handle_line();
                    translate([0,0,100])
                        cylinder(d=28,h=25);
                }
                translate([0,0,100])
                    rotate_extrude() {
                        translate([14.7,0])
                            circle(r=2.5);
                    }
                translate([0,0,95])
                    rotate_extrude() {
                        translate([14,0])
                            circle(r=2.5);
                    }
                translate([0,0,45])
                    rotate_extrude() {
                        translate([14,0])
                            circle(r=2.5);
                    }
                translate([0,0,50])
                    rotate_extrude() {
                        translate([14,0])
                            circle(r=2.5);
                    }
                translate([0,0,55])
                    rotate_extrude() {
                        translate([14,0])
                            circle(r=2.5);
                    }
             }
             union(){
                 translate([0,0,105])
                    cylinder(d = 24, h = 50);
                 translate([0,0,172])
                    rotate(a = 30, v = [0,1,0])
                        cube(size=[100,100,100],center = true);
             }
         }
         translate([12,0,73])
            knob_1();
         translate([0,0,60])
            rotate(a = 55, v = [0,0,1])
                translate([3,-5,0])
                    rotate(a = 10, v = [0,1,0])
                        cube([10,10,15]);
     } 

}

module knob_1()
{
    union() {
         translate([-3,-3,0])
            cube(size=[6,6,30]);
         for (i = [7.5:7.5:29])
            translate([3,0,i])
                sphere(d=4);
         translate([0,-3,0])
            rotate(a = 90, v = [-1,0,0])
            linear_extrude(height = 6) {polygon([[0,0],[0,3],[3,0]]);}
     
    } 
}

module handle_line()
{
    translate([-4,11,0])
        cube(size=[8,2,40]);
}