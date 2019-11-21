// deviation to test
jitter=0.2; //[0.2, 0.1, 0.05]
// 0 for both, 1 for left, 2 for right
extruder=0; // [0, 1, 2]
//layerHeight you want to print with
layerHeight=0.3;


module pie_slice(r=3.0,a=30) {
  intersection() {
    circle(r=r);
    square(r);
    rotate(a-90) square(r);
  }
}

module tick(point,rot,pos) {
    rotate(pos)
    rotate(rot)
    difference() {
        pie_slice(r=point,a=15);
        pie_slice(r=point-tickWidth,a=15);
    }
}

module jitterSpine (c,j) {
    difference() {
        union() {
            rotate(-20+c)
            pie_slice(r=30+4*jitter,a=5);
            rotate(15+c)
            pie_slice(r=30+4*jitter,a=5);
        }
        circle(8);
    }
        
    for (i=[0:4]) {
        tick (i+middle+i*tickWidth*2+i*j,-15,c);
        tick (i+middle+i*tickWidth*2+i*j,0,c);
    }
    if (extruder==1 || extruder==0) {
        tick (4+middle+4*tickWidth*2+4*jitter,-15,c);
        tick (4+middle+4*tickWidth*2+4*jitter,0,c);        
    }
};

$fn=160;
middle=10;
tickWidth=2;

if (extruder==1 || extruder==0) {
    linear_extrude(layerHeight) {
        difference() {
            union() {
                jitterSpine(0,0);
                jitterSpine(90,0);
                jitterSpine(180,0);
                jitterSpine(270,0);
                circle(middle-tickWidth);
                difference() {
                    difference() {
                        circle(32);
                        circle(30);
                    }
                }
                difference() {
                    square(32);
                    pie_slice(r=30,a=90);
                }
            }

        }
    }
}
translate([0,0,layerHeight])
linear_extrude(layerHeight) {
    if (extruder==2 || extruder==0) {
        jitterSpine(0,jitter);
        jitterSpine(90,jitter);
        jitterSpine(180,jitter);
        jitterSpine(270,jitter);
        translate([1,-3.5,0])
        text("+",font="Lobster", size=12, halign="right", valign="center");
        translate([6,1,0])
        text("-",font="Lobster", size=15, halign="right", valign="center");
        translate([30.5,28,0])
        text(str(jitter),font="Lobster", size=5, halign="right", valign="center");
    }
}