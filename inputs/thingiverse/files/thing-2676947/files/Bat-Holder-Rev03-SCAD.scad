// - Bat Diameter (mm) (default=25.4)
batdia = 25.4; // [20:35]
// - Handle Length (mm) (default=95.25)
handlelength = 95.25; // [70:110]
// - Wall Thickness (mm) (default=6.35)
wallthickness = 6.35; // [6.35:8]

module outerdia (){
cylinder(h=handlelength,r= (batdia/2)+wallthickness, center=true);
}
module innerdia (){
cylinder(h= handlelength,r= batdia/2, center=true);
}
module batslot(){
 translate([0,0,-handlelength/2])
 rotate([0,0,-45])
 cube([(batdia+wallthickness),(batdia+wallthickness),handlelength]);
}  
module rubberstub (){
translate ([0,-(batdia/2)-(wallthickness/2),0])
rotate([107,0,0])
cylinder(h=20,r1=9,r2=11.3);
}
module rubbercb (){
translate ([0,-(batdia/2)-(wallthickness/2),0])
rotate([107,0,0])
cylinder(h=25,r1=6.5,r2=6.5);
}
module bolthole (){
translate ([-15,-(batdia/2)-(wallthickness*2.125),-4])
rotate([0,90,0])
cylinder(h=30,r1=1.5,r2=1.5);
}
union(){
difference (){
    outerdia();
    innerdia();
    batslot();
}
difference (){
rubberstub();
    rubbercb();
    bolthole();
}
}