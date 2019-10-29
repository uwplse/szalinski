include <threads.scad>
$fn=50;

dia_outer = 31;
dia_inner = 29;
h_body = 14;

difference () {
    cylinder (d=dia_outer, h=h_body);
    
    translate([0,0,-0.75])
    intersection() {
        metric_thread (diameter=dia_inner, pitch=3, thread_size=4, length=h_body, internal=true, n_starts=1);
        //translate([0,0,1])
        cylinder(d=28,h=h_body);
    }
        
        
    cylinder(d=3, h=h_body+1);
    
    // grip
    for(ii=[0:15:360]) {
        rotate([0,0,ii])
        translate([dia_outer/2+0.5,0,-1])
        cylinder(d=2, h=h_body+2);
    }
    
    // temp cross section
    *translate([0,0,-1])
    cube([50,50,50]);
}


//difference() {
//    cylinder(d=32, h=20);
//    translate([0,0,-0.5])
//    cylinder(d=28, h=19);
//}