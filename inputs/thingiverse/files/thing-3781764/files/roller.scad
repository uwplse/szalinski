// hair roller of unusual size
// fastest print if select shell of 2x perimeter width
dia=80;
len=120;
shell=1.6;
ss=1-shell*2/dia;
holedia=15;
nholes=10;
nstar=360/nholes;
nrows=5;
// make larger to hide ridges more
$fn=128;

module can() {
    difference() {
        translate([0,0,0]) cylinder(d=dia, h=len, center=false);
        translate([0,0,-2]) scale([ss,ss,1.2]) cylinder(d=dia, h=len, center=false);
        // holes - iterate a star of cylinders
        for (i=[1:nrows])  {
            translate([0,0,20*i]) 
            if (i%2) {
                rotate([0,90,0]) for (c=[1:nholes]) {
                    rotate([c*nstar,0,0])cylinder(d=holedia,h=dia, $fn=20);
                }
            } else {
                rotate([90,90,0]) for (c=[1:nholes]) {
                    rotate([c*nstar,0,0])cylinder(d=holedia,h=dia, $fn=20);
                }
            }
        }
    }
}

translate([0,0,0]) can();
