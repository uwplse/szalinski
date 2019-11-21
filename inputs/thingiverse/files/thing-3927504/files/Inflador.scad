B_ed=13.5;
B_id=5-0.5;
B_h=6.5;
PA_ed=7.6;
PA_id=B_id;
PA_h=3.2;
PB_ed=5;
PB_id=2-0.2;
PB_h1=3;
PB_h2=3;
PB_id2=3;
PB_hole_d=1.7;

module PA() {
    difference() {
        cylinder(d=PA_ed,h=PA_h,$fn=100);
        cylinder(d=PA_id,h=PA_h*2.5,$fn=100,center=true);
    }
}

module B() {
    difference() {
        cylinder(d=B_ed,h=B_h,$fn=100);
        cylinder(d=B_id,h=B_h*2.5,$fn=100,center=true);
    }
}
module PB_hole() {
    cylinder(d=PB_id,h=(PB_h1+PB_h2)*2.5,$fn=100,center=true);
}

module PB_2holes() {
    translate([PB_hole_d,0,0])
    PB_hole();
    translate([-PB_hole_d,0,0])
    PB_hole();
}

module PB_holes() {
    PB_2holes();
    rotate([0,0,90])
    PB_2holes();
}
module PB() {
    difference() {
        union() {
            cylinder(d=PB_ed,h=PB_h1,$fn=100);
            translate([0,0,PB_h1])
            cylinder(d=PB_id2,h=PB_h2,$fn=100);
        }
        PB_holes();
    }
}
PA();
translate([0,0,PA_h])
B();
translate([0,0,PA_h+B_h])
PB();
