$fn=50;

OAH=16;
OAD=14.75;
ScrewRecessR=2.6;
ScrewRecessMinD=11.8;
ScrewRecessH=4.7;
HSpacing=2.6;
HSpacing2=1.5;
ORingNotchMinD=10.9;
CapH=2;
CapD=18;

difference(){
    cylinder(h=OAH,d=OAD);

    translate([0,0,HSpacing+ScrewRecessH/2])
        rotate_extrude()
            translate([ScrewRecessMinD/2+ScrewRecessR,0,])
                circle(ScrewRecessR);
    translate([0,0,HSpacing+ScrewRecessH+HSpacing2])
        difference(){
        cylinder(h=HSpacing,d=OAD);
        cylinder(h=HSpacing,d=ORingNotchMinD);
    }
}
translate([0,0,OAH])
    cylinder(h=CapH,d=CapD);