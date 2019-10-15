length=48.8;
width=28;
height=71;
breadth=1.5;
rounding_top=3.5;
hole1_position=2.3;
hole_distance=10.5;
hole_diameter=9.2;

$fn=100;

sheight=height-rounding_top;
module outer() {
    translate([(length-width)/2,0,0]) cylinder(h=sheight, d=width);
    translate([-(length-width)/2,0,0]) cylinder(h=sheight, d=width);
    translate([-(length-width)/2,-width/2,0]) cube([length-width,width,sheight]);
}

module inner() {
    translate([(length-width)/2,0,-0.01]) cylinder(h=sheight+0.02, d=width-2*breadth);
    translate([-(length-width)/2,0,-0.01]) cylinder(h=sheight+0.02, d=width-2*breadth);
    translate([-(length-width)/2,-width/2+breadth,-0.01]) cube([length-width,width-2*breadth,sheight+0.02]);
}

difference() {
    outer();
    inner();
    translate([0,0,hole1_position+hole_diameter/2]) rotate([0,90,0]) cylinder(h=length+0.02, d=hole_diameter,center=true);
    translate([0,0,hole1_position+hole_diameter*1.5+hole_distance]) rotate([0,90,0]) cylinder(h=length+0.02, d=hole_diameter,center=true);
}

intersection() {
    translate([0,0,sheight]) rotate([0,90,0]) scale([rounding_top*2/width,1,1]) cylinder(h=length+0.02, d=width,center=true);
    difference() {
        translate([0,0,rounding_top+0.01]) outer();
        translate([-length/2-0.01,-width/2-0.01,0]) cube([length+0.02,width+0.02,height-rounding_top-0.01]);
    }
}
