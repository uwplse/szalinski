$fn = 30;
wTray = 50;
lTray = 80;
hTray = 10;
wall = 1;
dHandle = 4;
lHandle = lTray*.35;

translate([-wTray*.6,0,0]) {
    handle(hTray*1.3);
    breadTray([wTray, lTray, hTray]);
}

translate([wTray*.6,0,0])
waterTray([wTray, lTray, hTray]);

translate([0,lTray*.8,0])
rotate([0,0,90])
waterLid([wTray, lTray, hTray]);





module handle(hHandle) {
    
    hull() {
        translate([0,-lHandle*.5,0])
        cylinder(h=.1, d=dHandle);
        translate([0,-lHandle*.5,hHandle])
        scale([1,.5,.5])
        sphere(d=dHandle);
    }
    
    hull() {
        translate([0,lHandle*.5,0])
        cylinder(h=.1, d=dHandle);
        translate([0,lHandle*.5,hHandle])
        scale([1,.5,.5])
        sphere(d=dHandle);
    }
    
    hull() {
        translate([0,-lHandle*.5,hHandle])
        scale([1,.5,.5])
        sphere(d=dHandle);
        translate([0,lHandle*.5,hHandle])
        scale([1,.5,.5])
        sphere(d=dHandle);
    }
}

module breadTray(v) {
    mv = [v[0], v[1]*.75, v[2]*.5];
    difference() {
        tray(mv);
        translate([0,0,wall])
        tray([mv[0]-wall, mv[1]-wall, mv[2]]);
    }
}


module waterTray(v) {
    difference() {
        tray(v);
        translate([0,0,wall])
        tray([v[0]-wall, v[1]-wall, v[2]]);
    }
    
    handle(v[2]*1.8);
}

module tray(v) {
    
    hull(){
        rrect([v[0]*.8, v[1]*.8, .1]);
        translate([0,0,v[2]])
        rrect([v[0], v[1], .1]);
    }
}

module waterLid(v) {
    dCup = wTray*.14;
    dCupSpace = dCup*1.35;
    
    difference() {
        rrect([v[0], v[1], wall]);
        translate([-wTray*.5+dCup,-lTray*.5+dCup,-.1])
        union() {
            for(j = [0:1]) {
                for(i = [0:7]) {
                    translate([j*dCupSpace,i*dCupSpace,0])
                    cylinder(h=wall*2, d=dCup);
                }
            }
            translate([wTray*.54,0,0])
            for(j = [0:1]) {
                for(i = [0:7]) {
                    translate([j*dCupSpace,i*dCupSpace,0])
                    cylinder(h=wall*2, d=dCup);
                }
            }
            
            
        }
        hull() {
            translate([0,-lHandle*.5,0])
            cylinder(h=wall*2, d=dHandle+2);
            translate([0,lHandle*.5,0])
            cylinder(h=wall*2, d=dHandle+2);
        }
    }
    
}

module rrect(v) {
    diam = v[1] *0.2;
    
    hull() {
    translate([(v[0]-diam)*.5,(v[1]-diam)*.5,0])
    cylinder(h=v[2], d=diam);
    
    translate([-(v[0]-diam)*.5,(v[1]-diam)*.5,0])
    cylinder(h=v[2], d=diam);
    
    translate([(v[0]-diam)*.5,-(v[1]-diam)*.5,0])
    cylinder(h=v[2], d=diam);
    
    translate([-(v[0]-diam)*.5,-(v[1]-diam)*.5,0])
    cylinder(h=v[2], d=diam);
    }
}