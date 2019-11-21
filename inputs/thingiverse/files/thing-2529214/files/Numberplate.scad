//cube ([220,220,240]); //My printing space
npString=   "LKP 357";
npWidth=    520;
npHeight=   100;
npThickness=   1.6;
quarterT =   npThickness/4;
npTextH=    70;
npTextO=    (npHeight-npTextH)/2;
maxx=   200;
maxy=   200;
maxz=   220;
npFont= "Liberation Sans";
//npFont= "DejaVu Sans";

color ("White") {
difference() {
    translate ([0,0,0]) cube([npWidth/3,npHeight,npThickness]); //first third
    translate([npTextH,npTextO,3*quarterT])
    linear_extrude(height=quarterT,center=false,convexity=0,twist=0,slices=1, scale=1.0) {text(npString, npTextH, font=npFont);}
    translate ([-0.5,-0.5,1.2]) cube([51,101,1.2]);
    }
difference() {
    translate ([1*npWidth/3,0,0]) cube([npWidth/3,npHeight,npThickness]); //2nd third
    translate([npTextH,npTextO,3*quarterT])
    linear_extrude(height=quarterT,center=false,convexity=0,twist=0,slices=1, scale=1.0) {text(npString, npTextH, font=npFont);}
    translate ([-0.5,-0.5,1.2]) cube([51,101,1.2]);
    }
difference() {
    translate ([2*npWidth/3,0,0]) cube([npWidth/3,npHeight,npThickness]); //3rd third
    translate([npTextH,npTextO,3*quarterT])
    linear_extrude(height=quarterT,center=false,convexity=0,twist=0,slices=1, scale=1.0) {text(npString, npTextH, font=npFont);}
    translate ([-0.5,-0.5,1.2]) cube([51,101,1.2]);
    }
}

translate ([0,0,1.2]){color ("Black") cube([50,100,1.2]);}
translate ([npTextH,npTextO,3*quarterT]) {
    color ("Black")
    linear_extrude(height=3*quarterT,center=false,convexity=0,twist=0,slices=1, scale=1.0) {text(npString, npTextH, font=npFont);}
    }
    