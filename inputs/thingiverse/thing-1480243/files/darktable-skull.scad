// darktable keyfob by Kees Guequierre
// Orginal design by Johannes Hanika

unitsize=5;
thickness=3;
holeradius=2;

$fs = 0.01;

difference () {
    union (){
        translate([0,0,thickness/2]) cube([4*unitsize,6*unitsize,thickness],center=true);
        // cheeks
        translate([0,unitsize,thickness/2]) cube([6*unitsize,2*unitsize,thickness],center=true);
        // ringlet
        translate([0,unitsize*3+holeradius,0]) cylinder(h=2*(thickness/3),r=holeradius+1,center=false);
    }
    union(){
        // left eye
        translate([-1.5*unitsize,1.5*unitsize,thickness/2+2*(thickness/3)]) cube([unitsize*0.98,unitsize*0.98,thickness],center=true);
        // right eye
        translate([1.5*unitsize,1.5*unitsize,thickness/2+2*(thickness/3)]) cube([unitsize*0.98,unitsize*0.98,thickness],center=true);
        // mouth
        translate([0,-1.5*unitsize,thickness/2+2*(thickness/3)]) cube([unitsize*4+.2,unitsize,thickness],center=true);
        // ringlet hole
        translate([0,unitsize*3+holeradius,-0.1]) cylinder(h=thickness,r=holeradius,center=false);
    }
}
