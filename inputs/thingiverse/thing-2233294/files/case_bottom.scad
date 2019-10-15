$fn = 50;

// global variables
xboard = 175;               // base board X
yboard = 65.5;              // base board Y
zcase = 50;                 // height of case
xyspace = 1;                // space between board edge and inner wall
tplate  = 3;                // bottom plate thickness
twall = 2;                  // side wall thickness
hscrew = 3;                 // board elevation from base plate
dscrew = 3.2;               // diameter of mounting screws, 3.2mm for M3 close fit
dshead = 5;                 // screw head diameter
zshead = 2;                 // depth of screw head


// screw locations
x0 = (51 + 226)/2;
y0 = (73.5 + 139)/2;
xc1 =   223 - x0; yc1 = y0 - 136;
xc2 =    85 - x0; yc2 = y0 - 76.5;
xc3 =    54 - x0; yc3 = y0 - 136;
xc4 =   223 - x0; yc4 = y0 - 76.5;



difference () {
    union() {
        // bottom plate
        difference () {
            roundedcube(xboard + 2*twall + 2*xyspace,yboard + 2*twall + 2*xyspace,zcase,5);
            // main inner cavity
            translate ([0,0,tplate]) roundedcube(xboard+ 2*xyspace,yboard+ 2*xyspace,zcase,5);
        }
        // screw mounting pillars
        translate ([0,0,tplate]) screwpillar(xc1, yc1);
        translate ([0,0,tplate]) screwpillar(xc2, yc2);
        translate ([0,0,tplate]) screwpillar(xc3, yc3);
        translate ([0,0,tplate]) screwpillar(xc4, yc4);
    }
    // M3 screw hole openings
    translate ([xc1,yc1,0]) cylinder(d=dscrew, h=100, center=true);
    translate ([xc2,yc2,0]) cylinder(d=dscrew, h=100, center=true);
    translate ([xc3,yc3,0]) cylinder(d=dscrew, h=100, center=true);
    translate ([xc4,yc4,0]) cylinder(d=dscrew, h=100, center=true);
    
    // screw head diameter
    translate ([xc1,yc1,(tplate - zshead)/2]) cylinder(d=dshead, h= tplate - 2, center=true);
    translate ([xc2,yc2,(tplate - zshead)/2]) cylinder(d=dshead, h= tplate - 2, center=true);
    translate ([xc3,yc3,(tplate - zshead)/2]) cylinder(d=dshead, h= tplate - 2, center=true);
    translate ([xc4,yc4,(tplate - zshead)/2]) cylinder(d=dshead, h= tplate - 2, center=true);
    
    // module slots opening from:
    // x : 68 to 218
    translate ([68 - x0,-yboard/2-5,tplate + hscrew]) cube ([218-68,10,100]);
    
    // data USB and power connectors
    translate ([-xboard/2-10, y0 - 110, tplate + hscrew]) cube([20,110-75,14]);
    
    // RPi power out USB connector
    translate ([94 - x0 - 7.5/2, yboard/2 - 5,tplate + hscrew]) cube([7.5,10,15]);
}


// need to carve out screw holes, and space for screw heads

module roundedcube(xdim ,ydim ,zdim,rdim){
    translate ([-xdim/2,-ydim/2,0]) hull(){
        translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);

        translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    }
}

module screwpillar(x=0, y=0){
    translate ([x,y,hscrew/2]) difference () {
        cylinder (d = dscrew + 2.5, h = hscrew, center=true);

    }
}
