// radius,
rad = 15;
// wall thickness
sp = 3;
// character (lettera alfabeto)
char = "R";
// delta X (letter placement in mm)
deltaX = -2.8;
// delta X
deltaY = 0;

dia = rad*2;

module lettera(char){
intersection(){
    sphere(rad+1.5);
    translate([-rad*1.2/2+deltaX,0,-rad*1.5/2+deltaY
    ])rotate ([90,0,0]) linear_extrude(20) text(char, size=rad*1.5);
    }
}

module sphere_w_letter(){
difference(){
    union(){
    sphere(rad);
    cylinder(rad*1.25,rad*0.4,rad*0.4);
   lettera(char);
    }
        sphere(rad-sp);
        cylinder(rad*2*1.25,rad*0.4-sp/2,rad*0.4-sp/2);
        translate ([-dia/2,0,-dia/2]) cube([dia,dia,2*dia]);
}
}

module sphere_wth_letter(){
difference(){
    union(){
    sphere(rad);
    cylinder(rad*1.25,rad*0.4,rad*0.4);
    }
        sphere(rad-sp);
        cylinder(rad*2*1.25,rad*0.4-sp/2,rad*0.4-sp/2);
        translate ([-dia/2,0,-dia/2]) cube([dia,dia,2*dia]);
}
}

rotate ([-90,0,0])sphere_w_letter();
translate([dia+4,0,0])rotate ([-90,0,0])sphere_wth_letter();
