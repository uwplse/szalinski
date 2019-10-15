$fn=30;

wbthick = 13mm; // thickness of the whiteboard
angle = 13; //Slope = 3mm on 13 mm = 13 degrees
penmax = 20; // Max Thickness pen
width = 20; // width holder
thick = 1.2; // thickness of the holder, more is stronger

cube([thick,width,30]);

pm = penmax / cos(angle); // calculate length needed to fit pen based on angle
tx = sin(angle) * thick; // correct for angle
translate([tx,0,30-thick])
rotate([0,angle*-1,0])
cube([pm, width, thick]);

th = penmax * tan(angle); // translate height to move based on angle and penwidth
tz = 0;
translate([penmax+tx-thick,0,30+th+tx-thick])
rotate([0,13,0])
cube([thick, width, 4]);


  