/*[holder plate]*/
//stick distance mm
hsd=34.6;
//stick length mm
hsl=25; 
//stick radius mm
hsr=1.8; 

/*[holder ring]*/
//width mm (min 10)
rw=16; 
//heigth mm
rh=12; 
//thickness mm
t=2; 
//elements of the arc
$fn=40;

rotate([90,0,0]) {
    //holder ring
    translate([-rw/2-t,rw/2,hsd/2]) {
        difference() {
            //outside
            union() {
                translate([0,-rw/4,0])
                cube([rw+2*t,(rw+2*t)/2,rh],center=true);
                cylinder(rh,rw/2+t,rw/2+t,center=true);
            }
            //cutout
            union() {
                translate([0,-rw/2,0])
                cube([rw,rw,rh*2],center=true);
                cylinder(rh*2,rw/2,rw/2,center=true);
            }
        }
    }

    //holder plate
    translate([-(rw+2*t),-hsr*2,0]) {
        cube([rw+2*t,hsr*2,hsd]);
    }
    //holder sticks
    translate([0,-hsr,0]) {
        rotate([270,0,90]) {
            cylinder(hsl+rw+t,hsr,hsr);
            translate([0,-hsd,0]) {
                cylinder(hsl+rw+t,hsr,hsr);
            }
        }
    }
    
}