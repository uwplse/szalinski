diameter=21;
thickness=2;
width=10;
screwTab=8;
screwHole=4;
$fn=50;


difference(){
    translate([diameter/2,diameter/2+thickness+screwTab,0])cylinderBlock(diameter+thickness*2,width);
    translate([diameter/2, diameter/2+thickness+screwTab,0])cylinderBlock(d=diameter, h=width);
    translate([-thickness,screwTab,0])cube([thickness, diameter+thickness*2, width]);
}
screwTab(screwTab, width, thickness, screwHole);
translate([0,screwTab+diameter+thickness*2,0])screwTab(screwTab, width, thickness, screwHole);

module cylinderBlock(d, h){
    hull(){
        cylinder(d=d, h=h);
        translate([-d/2,-d/2,0])cube([d/2,d,h]);
    }
}

module screwTab(w,h,t,d){
    difference(){
        cube([t, w, h]);
        translate([0,w/2,h/2])rotate([0,90,0])cylinder(d=d,h=t*2);
    }
}