// radius
rad = 15;
//wall thickness
sp = 3;

dia = rad*2;

difference(){
    union(){
    sphere(rad);
    cylinder(rad*1.25,rad*0.4,rad*0.4);
    }
        sphere(rad-sp);
        cylinder(rad*2*1.25,rad*0.4-sp/2,rad*0.4-sp/2);
        translate ([-dia/2,-dia/2,-dia]) cube([dia,dia,dia]);
}

translate ([dia+5,0,0])
difference(){
    sphere(rad);
        sphere(rad-sp);
        translate ([-dia/2,-dia/2,-dia]) cube([dia,dia,dia]);
}

