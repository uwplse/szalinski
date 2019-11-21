/*
    Author: Sunny Fugate, Email: sunny.fugate@gmail.com, Date: 9 Oct 2017
    Contributors: 
    Licensing GPL V3 (http://www.gnu.org/licenses/quick-guide-gplv3.html).

    Script for microscopy parts.
*/


slide_l=76;
slide_w=25;

smooth=64;

module samplebox(depth=2,length=25,width=20) {
    difference() {
        cube([slide_l,slide_w,depth],center=true);
        cube([length,width,depth],center=true);
    }
}

module liquidbox(depth=5,diameter=slide_w-10) {
    r=diameter/2;
    difference() {
        union() {
        //cylinder(h=depth, r1=r, r2=r, center=false, $fn=smooth);
        cylinder(h=depth,r1=slide_w/2,center=false,$fn=smooth);
        }
        cylinder(h=depth, r1=r-1, r2=r-1, center=false, $fn=smooth);

    }

    
}


/* Main or start function basicaly do it */
render (convexity = 1) {
    translate([60,0,0]) liquidbox(depth=2);
    
    translate([60,30,0]) liquidbox(depth=4);
    
    translate([60,60,0]) liquidbox(depth=6);
    
    translate([60,90,0]) liquidbox(depth=8);
    translate([60,120,0]) liquidbox(depth=10);
  

    translate([0,0,0.5]) samplebox(depth=1);
    translate([0,30,1]) samplebox(depth=2);
    translate([0,60,1.5]) samplebox(depth=3);
    translate([0,90,2]) samplebox(depth=4);
    translate([0,120,2.5]) samplebox(depth=5);

}
