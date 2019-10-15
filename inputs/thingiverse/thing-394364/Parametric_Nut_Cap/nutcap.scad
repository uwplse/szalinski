
$fn=100;

// Nut diameter (mm)
nut=11.9;

// Nut height (whithout sphere)
h=6.5;

// width
e=1.5;




ri=sqrt(3)/2*nut/2;
rie=sqrt(3)/2*(nut/2+e);

module form() {


translate([0,0,h/2])

difference() {
sphere(r=rie, center=true);
sphere(r=ri, center=true);

translate([0,0,-nut/2])
cube([nut+1, nut+1, nut], center=true);
}


difference() {
cylinder(r=nut/2+e, h=h, $fn=6, center=true);
cylinder(r=nut/2, h=h+2, $fn=6, center=true);
}

}





form();