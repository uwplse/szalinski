// @pabile 20180511
// U bracket openscad parametric customizeable customizer

uthick = 5; // bracket thickness
ulength = 15; // thickness of thing to insert inside bracket
uwidth = 25; // width of bracket arm;
udepth = 25; // height of bracket arm
screwhole = 3; // radius
driverhole = 5; // radius 

difference() {
    minkowski(){
        cube (size = [((uthick*2)+ulength)-2,uwidth-2,udepth+uthick-2]);
        sphere(1);
    }

    # translate ([uthick-1,-2,uthick]) {
        cube (size = [ulength,uwidth+1,udepth]);
    }

    // screw hole
    # translate ([0,(uwidth/2)-1,(udepth/2)+(uthick/2)]) {
        rotate (a=[0,90,0]) cylinder (uthick*2,screwhole,screwhole,center=true);
    }
    
    // driver hole
    # translate ([uthick-2,(uwidth/2)-1,(udepth/2)+(uthick/2)]) {
        rotate (a=[0,90,0]) cylinder (ulength*2,driverhole,driverhole,center=false);
    }
}