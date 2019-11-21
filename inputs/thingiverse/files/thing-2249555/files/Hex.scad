foamHeight=7;
width=25.4/sin(60);
base=4;
difference() {
    cylinder(d=width, h=foamHeight+base, $fn=6, center=false);
    translate([-1*(width/4),-1*(width/4),base]) cube([width/2,width/2,width/2], center=false);
}