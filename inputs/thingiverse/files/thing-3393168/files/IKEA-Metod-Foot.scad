//Rendering quality
$fn=128;//[fine:128,coarse:64]

/* [Global] */
//in millimeters without the pins
height=15;

/* [Hidden] */
width=85;
depth=55;

translate([0,0,-height/2])
roundedcube(width,depth,height,10);

translate([32,16,0])
cylinder(h=8,r1=4.8,r2=4.8,center=false);
translate([32,16,8])
cylinder(h=2,r1=4.8,r2=2.8,center=false);

translate([32,-16,0])
cylinder(h=8,r1=4.8,r2=4.8,center=false);
translate([32,-16,8])
cylinder(h=2,r1=4.8,r2=2.8,center=false);

translate([-32,16,0])
cylinder(h=8,r1=4.8,r2=4.8,center=false);
translate([-32,16,8])
cylinder(h=2,r1=4.8,r2=2.8,center=false);

translate([-32,-16,0])
cylinder(h=8,r1=4.8,r2=4.8,center=false);
translate([-32,-16,8])
cylinder(h=2,r1=4.8,r2=2.8,center=false);

module roundedcube(xdim, ydim, zdim, rdim){
    hull(){
    translate([rdim-width/2,rdim-depth/2,-height/2])
        cylinder(r=rdim,h=zdim);
    translate([xdim-rdim-width/2,rdim-depth/2,-height/2])
        cylinder(r=rdim,h=zdim);
    translate([rdim-width/2,ydim-rdim-depth/2,-height/2])
        cylinder(r=rdim,h=zdim);
    translate([xdim-rdim-width/2,ydim-rdim-depth/2,-height/2])
        cylinder(r=rdim,h=zdim);
}
}