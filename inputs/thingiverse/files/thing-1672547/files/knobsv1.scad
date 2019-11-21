
k_height=16;
k_dia=24;
s_dia=44;
ntxt=4;
txt=["50","60","70","80"];
ang=[0, 60,120,180];
xang=[-30, 30, 90, 150, 210];

res=12;

module knob(){
    cylinder($fn=5*res,d1=k_dia, d2=k_dia*0.8, h=k_height-2);
}

module top(){
    difference(){
        translate([0,0,k_height-3]){
            rotate_extrude($fn=10*res, convexity = 2)
                translate([k_dia/2.5-1.7, 0, 0])
                    circle($fn=5*res, d = 4);
        }
        cylinder($fn=5*res,h=k_height-2, d=k_dia*1.1);
    }
}

module skirt(){
    difference(){
        translate([0,0,-2]){
            cylinder($fn=5*res,h=2,d=s_dia-2);
            rotate_extrude($fn=5*res, convexity = 2)
                translate([s_dia/2-1, 0, 0])
                    circle($fn=5*res, r = 2);
        }
        translate([0,0,-8.01])cylinder(d=s_dia*1.1,h=6);
    }
}


module dial(ht=1){
    dfont="DejaVu Sans:style=Bold";
    dsize=5.5;
    s1=3;
    s2=5;
    r1 = s_dia/2+1;
    
    rotate([0,0,xang[0]])translate([r1-s2,0,-2])cube([s2,1,2+ht]);
    for(i=[0:ntxt-1]){
        rotate([0,0,ang[i]])
            translate([r1-10,0,0])rotate([0,0,-90])
                linear_extrude(height=ht)
                    text(text=txt[i], font=dfont, size=dsize, halign="center");
        rotate([0,0,ang[i]])translate([r1-s1,0,-2])cube([s1,1,2+ht]);
        rotate([0,0,xang[i+1]])translate([r1-s2,0,-2])cube([s2,1,2+ht]);
    }
}

module hole(){
    translate([0,0,-2])cylinder($fn=2*res,h=k_height-3,d=6);
    translate([0,0,-3.01])cylinder($fn=2*res,h=6,d=13);
    for(i=[0:30:360]){
        rotate([0,0,i]){
            translate([-k_dia/2-1,0,1])rotate([0,10,0])cylinder($fn=2*res,r=k_dia/12,h=k_height-3.5);
        }
    }
}

//*
union(){
    top();

    difference(){
        union(){
            knob(13);
            skirt();
        }
        hole();
    }
    color("white")dial(1);

}
//*/
