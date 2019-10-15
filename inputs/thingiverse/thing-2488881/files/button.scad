//CUSTOMIZER VARIABLES

//	Radius of button
rbut = 9;

//	Distance between holes
dholes = 6;

//	Radius of holes
rhole=1.5;

//	Height of button
hbut=2;

//CUSTOMIZER VARIABLES END

difference() {
    cylinder(h=hbut, r1=rbut, r2=rbut, $fn=50);
    union() {
        translate([-dholes/2,0,0])
            cylinder(h=hbut*2, r1=rhole, r2=rhole, $fn=30);
        translate([dholes/2,0,0])
            cylinder(h=hbut*2, r1=rhole, r2=rhole, $fn=30);
    }
}