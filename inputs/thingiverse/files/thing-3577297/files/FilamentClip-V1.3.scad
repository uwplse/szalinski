/* Filament Clip Creator for THE BEST Filament Clip
   by Lyl3

Able to create clips for 1.75 mm filament or 2.85 mm filament

This code is published at:
https://www.thingiverse.com/thing:3577297

V1.1 Enabled the Cura nozzle adjustment
V1.2 Added fillets at the bottom of the channels
V1.3 Fixed bug that was setting the height of the fillets in the straight channel based on the width of the grab channel instead of the width of the straight channel.
*/

$fn = 50 + 0;          
fudge = 0.0001 + 0;

/* [Parameters] */

//Enter the length of the clip (mm). The default length of 18 mm provides very good grabbing power. A shorter length increases the grabbing power but puts more stress on the filament.
clipLength = 18.0;           // [14:0.5:25]

// Enter the height of the channels (mm). The default height of 3.25 mm provides secure channels with minimal material. Increasing the height may provide an even lower risk of the filamant popping out but will use more material.
channel_height = 3.25;       // [3:0.05:6.5]

// Enter the thickness of the base (mm). The default of 0.8 mm is strong enough to hold together when clipping the filament. A thicker base will be even stronger but will use more material.
baseThickness = 0.8;         // [0.8:0.1:2]

//Enter the width of the walls (mm). The default of 0.8 mm is strong enough to hold together when clipping the filament. Thicker walls will be even stronger but will use more material.
wall_width = 0.8;             // [0.8:0.4:2.0]
wallWidth = (wall_width/0.4*0.4051); // For some reason Cura 3.6 treats a 0.4 mm nozzle as a 0.4051 mm nozzle, so the width needs to be adjusted for it to slice well. Slic3r doesn't care either way so this adjustment does no harm.

// Enter the width of the straight channel (mm). The default width of 2.0 is suitable for 1.75 mm filament and provides enough slack that the filament won't be forcing the wall apart. Don't reduce this below the default unless you have a very accurate printer.
straightChannelWidth = 2.0; // [1.8:0.05:3.5]

// Enter the width of the curved-path "grab" channel that contains the nubs (mm). The default width of 3.5 mm is suitable for 1.75 mm filament and provides enough space for the arced filament bent by the nubs. 
grabChannelWidth = 3.5;      // [2:0.1:6]

// Enter the top radius of the nubs in the curved-path "grab" channel (mm). The default radius of 1.75 mm is suitable for 1.75 mm filament and provides just enough space to push the filament into the channel if the width of the channel is left at the default value. Don't set this less than the bottom radius.
nubTopRadius = 1.75;         // [1:0.05:3]

// Enter the bottom radius of the nubs in the curved-path "grab" channel (mm). The default radius of 1.5 mm is suitable for 1.75 mm filament and provides enough of a bend in the filament to provide a good grip if the width of the channel is left at the default value. Don't set this greater than the top radius.
nubBottomRadius = 1.5;       // [1:0.05:3]

clipHeight = channel_height + baseThickness;
grabChannelSpace = grabChannelWidth - nubBottomRadius;

/*
Build the curved-path "grab" channel
*/

// The base
cube([clipLength,grabChannelWidth+2*wallWidth,baseThickness]);

// The walls
color ("green") cube([clipLength,wallWidth,clipHeight]);
color ("red") translate ([0,grabChannelWidth+wallWidth,0]) cube([clipLength,wallWidth,clipHeight]);

// The fillets
color ("purple") difference () {
translate([0,wallWidth,baseThickness])cube([clipLength,grabChannelSpace/2,grabChannelSpace/2]);
translate([0,grabChannelSpace/2+wallWidth,grabChannelSpace/2+baseThickness]) rotate([0,90,0]) cylinder(h=clipLength, d=grabChannelSpace);
}

color ("purple") difference () {
translate([0,grabChannelWidth+wallWidth-grabChannelSpace/2,baseThickness])cube([clipLength,grabChannelSpace/2,grabChannelSpace/2]);
translate([0,grabChannelWidth+wallWidth-grabChannelSpace/2,grabChannelSpace/2+baseThickness]) rotate([0,90,0]) cylinder(h=clipLength, d=grabChannelSpace);
}

// The nubs in the grab channel
color ("green") translate ([clipLength/2,wallWidth,0]) intersection () {
    translate ([0,0,baseThickness]) cylinder(h=clipHeight-baseThickness,r1=nubBottomRadius,r2=nubTopRadius);
    translate([-25,0,0]) cube (50);
}

color ("red") translate ([0,grabChannelWidth+wallWidth,0]) intersection () {
    translate ([0,0,baseThickness]) cylinder(h=clipHeight-baseThickness,r1=nubBottomRadius,r2=nubTopRadius);
    translate([0,-50,0]) cube (50);
}

color ("red") translate ([clipLength,grabChannelWidth+wallWidth,0]) intersection () {
    translate ([0,0,baseThickness]) cylinder(h=clipHeight-baseThickness,r1=nubBottomRadius,r2=nubTopRadius);
    translate([-50,-50,0]) cube (50);
}

/*
Build the straight channel
*/

// The base
translate ([0,-straightChannelWidth-wallWidth,0])
  cube([clipLength,straightChannelWidth+2*wallWidth,baseThickness]);

// The wall
color ("blue") translate ([0,-straightChannelWidth-wallWidth,0])
  cube([clipLength,wallWidth,clipHeight]);

// The fillets
color ("purple") difference () {
translate([0,-straightChannelWidth,baseThickness])cube([clipLength,straightChannelWidth,straightChannelWidth/2]);
translate([0,-straightChannelWidth/2,straightChannelWidth/2+baseThickness]) rotate([0,90,0]) cylinder(h=clipLength, d=straightChannelWidth);
}
