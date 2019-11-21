// Text on barrel
TextOnBarrel="OIL";
// Text position on barrel
TextLocation="Middle"; // [Top, Middle, Bottom]


module ring(dout=32,height=2) {
rotate_extrude(convexity = 10, $fn = 50)
translate([dout/2+0.1, 0, 0])
circle(r = height/2-0.3, $fn = 50);
}


module barrel(hi=35,di=30) {
cylinder(h=hi,d=di,$fn=50);
    translate([0,0,0.5]) {
ring(dout=di-1);
    }
translate([0,0,hi/3]) {
    ring(dout=di-1);
}
translate([0,0,hi*2/3]) {
    ring(dout=di-1);
}
translate([0,0,hi-0.5]) {
    ring(dout=di-1);
}
translate([4,0,hi-1.8]){
cylinder(d=3,h=2,$fn=50);
}
}

module barreltext(txt=TextOnBarrel,deg=14,fsize=3,dia=20) {
    for (v = [0:deg:len(txt)*deg]) {
        rotate([90,0,v]) {;
           translate([0,0,dia]) {
                linear_extrude(height=5) {
                text(txt[v/deg],size=fsize,font="Arial:style=bold",halign="center");
                }
            }
        }
    }

    }

module main() {
    rotate([0,0,-45]) {
difference() {
barrel(hi=23,di=15);
    translate([0,0,-5]) {
    cube([50,50,10],center=true);
    }
}
intersection() {
    if (TextLocation=="Top") {
    translate([0,0,(23*4/5)-1]) {
        barreltext(dia=7,fsize=3,deg=20);
    }
    } else if (TextLocation=="Middle") {
    translate([0,0,23/2-1.5]) {
        barreltext(dia=7,fsize=3,deg=20);
    }
    } else if (TextLocation=="Bottom") {
    translate([0,0,(23/5)-2]) {
        barreltext(dia=7,fsize=3,deg=20);
    }
    }
    cylinder(h=35,d=15.6,$fn=50);
}
}
}

main();