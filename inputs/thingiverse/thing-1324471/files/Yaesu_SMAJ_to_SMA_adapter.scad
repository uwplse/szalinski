// Yaesu SMAJ to SMA antenna adapter sleeve
// author: fiveangle@gmail.com
// date: 2016feb07
// ver: 1.0
// known issues: none.

// adjust to increase/decrease polygon count at expense of processing time (above 100 is probably useless)
$fn = 200; //

smaSize = 8;
smaSides = 6;
sleeveOuterDiamAntenna = 14.1;
sleeveOuterDiamBase = 14.1;
sleeveHeight = 22.2;
extrusionSquish = 0.14;


module sleeve(){
	cylinder(r1=sleeveOuterDiamBase/2, r2=sleeveOuterDiamAntenna/2, h=sleeveHeight);
}
module sma(d=smaSize,h=sleeveHeight){
    radius = 0.5*smaSize;
	translate([0,0,0]) cylinder(r=((radius+extrusionSquish)*1.15425), h=sleeveHeight, $fn=smaSides);
}


difference(){
	sleeve();
	sma();
}