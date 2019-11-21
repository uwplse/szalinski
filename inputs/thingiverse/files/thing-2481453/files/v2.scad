
//Number of bits in x-direction [>0]
nx=12;
//Number of bits in y-direction [>0]
ny=2;
//Spacing in x-direction [mm]. Values below 0 will connect the hexagonal shapes.
spx=-1;
//Spacing in y-direction [mm]. Values below 0 will connect.
spy=4;
//Depth of the hexagon shape for the bit [>1mm]. I advise >=6mm.
bhh=7;
//Thickness of the connecting bottom layer [>1mm]
bh=1.5;
//Skirt into the negative x-axis (west) [>0mm] (for fixing, holding down or labelling)
xb1=6;
//Skirt into the positive x-axis (east) [>0mm]
xb2=6;
//Skirt into the negative y-axis (south) [>0mm]
yb1=0;
//Skirt into the positive y-axis (north) [>0mm]
yb2=0;
//Thickness of the walls for the bitholders [0.3-3mm]. Also consider your nozzle-/print-width.
wt=2.5;
//Tightness. [0-100%], 0 is very loose, 100% is very tight!
tn=45;
//Circular magnet hole depth [0-(bh) mm]. Read more in this Things description. If you don't want to add magnets, set to zero.
mht=0;
//Magnet hole diameter [0-6mm]. Don't forget to add a little print tolerance!If you don't want to add magnets, set to zero.
mhd=0;

wallthickness=min(max(wt,0.3), 3);
ex=max(nx,1);
ey=max(ny,1);
bitholderdepth=max(bhh,1);
baseheight=max(bh,1);
yborder1=max(yb1,0);
yborder2=max(yb2,0);
xborder1=max(xb1,0);
xborder2=max(xb2,0);
innerbitradius=6.25+1.35;
sx = max(spx,-1)+innerbitradius+0.9+0.1;
sy = max(spy,-0.85)+innerbitradius+0.1;
tns=max(min(tn,100),0);
magt=max(min(mht, bh), 0);
magd=max(min(mhd, 6), 0);


difference() {
    union() {
        //Baseplate
        translate([-xborder1,-yborder1,0]) {
            minkowski() {
                cube([max((ex-1)*sx+xborder1+xborder2,0.01), max((ey-1)*sy+yborder1+yborder2,0.01), baseheight/2]);
                cylinder(d=7.6+wallthickness, h=baseheight/2, $fn=100);
            }
        }
        //Add the actual hexagonal bit holders
        difference() {
            for (x = [0:1:ex-1]) {
                for (y = [0:1:ey-1]) {
                    translate([x*sx,y*sy, baseheight]) {
                        bit(h=bitholderdepth, r=innerbitradius+wallthickness);
                    }
                }
            }
            
            for (x = [0:1:ex-1]) {
                for (y = [0:1:ey-1]) {
                    translate([x*sx,y*sy, baseheight]) {
                        bit(h=bitholderdepth+0.5, r=innerbitradius);
                    }
                }
            }
        }

        //Add squeezers to set a nice friction point.
        squeezer=0.05+((tns/100)*0.1);
        for (x = [0:1:ex-1]) {
            for (y = [0:1:ey-1]) {
                for (i=[30,210,-30,150]) {
                    translate([x*sx,y*sy, baseheight]) {
                        rotate(i) {
                            translate([3.35-squeezer,0,bitholderdepth/2]) {
                                cube([squeezer,2,0.3], center=true);
                            }
                        }
                    }
                }
            }
        }
    }

    //Connections between holders
    if (spy<0) {
        p=4;
        for (x = [0:1:ex-1]) {
            translate([-p/2+x*sx, 0, baseheight]) {
                cube([p, (ey-1)*(innerbitradius-0.75), bitholderdepth+0.5]);
            }
        }
    }
    
    if (spx<0) {
        for (y = [0:1:ey-1]) {
            s=0;
            translate([0, -s/2+y*sy-wallthickness/2, baseheight]) {
                cube([(ex-1)*innerbitradius, s+wallthickness, bitholderdepth+0.5]);
            }
        }
    }
    
    //Holes for magnets
    if (magt != 0 && magd != 0) {
        for (x = [0:1:ex-1]) {
            for (y = [0:1:ey-1]) {
                if (magt==bh) {
                    translate([x*sx,y*sy, magt/2]) {
                        cylinder(d=magd, h=magt+0.2, center=true, $fn=100);
                    }
                } else {
                    translate([x*sx,y*sy, magt/2-0.05]) {
                        cylinder(d=magd, h=magt+0.1, center=true, $fn=100);
                    }
                }
            }
        }
    }
}

module bit(r,h) {
    translate([0,0,h/2]) {
        cylinder(d=r, $fn=6, h=h, center=true);
    }
}