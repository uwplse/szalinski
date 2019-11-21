// coin holder http://www.thingiverse.com/thing:212164

// inspired by http://www.thingiverse.com/thing:9116

// preview[view:south east, tilt:top]

use <write/Write.scad>;

/* [General] */

// Part to display
part = 1; //[1:Preview, 2:Body, 3:Plungers, 4:Cover, 5:Plated]

// Chop into coin holder to see how it assembles. Turn this off before printing!
chop = 0; //[0:Whole, 1:Hole]

//Number of coin slots
numSlots = 5; // [1:8]
coin1 = 1; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]
coin2 = 2; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]
coin3 = 3; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]
coin4 = 4; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]
coin5 = 5; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]
coin6 = 6; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]
coin7 = 0; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]
coin8 = 0; // [0:None, 1:US Dollar, 2:US half dollar, 3:US quarter, 4:US dime, 5:US nickle, 6:US penny, 7:euro cent, 8:2 euro cents, 9:5 euro cents, 10:10 euro cents, 11:20 euro cents, 12:50 euro cents, 13:1 euro, 14:2 euros, 15:5 Australian cents, 16:10 Australian cents, 17:20 Australian cents, 18:50 Australian cents, 19:Australian Dollar, 20:Australian $2, 21:CAN $2, 22:CAN $1, 23:CAN 25c, 24:CAN 10c, 25:CAN 5c, 26:CAN 1c]

/* [Cup Holder] */

// width of your cup holder (mm)
cupHolderWidth = 75;
cupHolderR = cupHolderWidth/2;

// depth of your cup holder (mm)
cupHolderDepth = 50;

/* [Spring] */

// Spring outer diameter (mm)
springOD = 10;
springOR = springOD/2;

// Spring inner diameter (mm)
springID = 8;
springIR = springID/2;

echo ("spring ", springOD, springOR, springID, springIR);

// Spring min height (mm)
springHeight = 20;

/* [Tweaks] */

// Scale of text
scale = 2;

// cupHolderFloor (mm)
cupHolderFloor = 5;

// Top lip to hold coins in (mm)
lip = 4;

// Clearance, adjust to suit your printer
clearance = 0.4;

// Wall thickness (mm between coins and the outside of the holder)
wall = 2; // wall thickness

/* [Hidden] */

gap = 0.01; // to make surfaces not perfectly aligned
$fn=64;
coin=[coin1,coin2,coin3,coin4,coin5,coin6,coin7,coin8];
echo("coin ",coin);

// Compute angles for position of each coin slot proportional to coin sizes
/* not ready yet
totalCoinSizes = coinSize[coin[0]]+coinSize[coin[1]]+coinSize[coin[2]]+coinSize[coin[3]]
	+coinSize[coin[4]]+coinSize[coin[5]];
*/

// coin definitions, from WikiPedia and
// Some from http://www.air-tites.com/coin_size_chart.htm
// Some from http://www.usmint.gov/about_the_mint/?action=coin_specifications
// Australian from http://en.wikipedia.org/wiki/Coins_of_the_Australian_dollar (curseddager request)

coinName = ["None", "$1", "50", "25", "10", //US 1-6
	"5", "1",
	"1", "2", "5", "10", //Euro 7-14
	"20", "50", "E", "2E",
	"5", "10", "20", "50", "$1", "$2", //Australian 15-20
	"$2", "$1", "25", "10", "5", "1"]; // Canadian 21-26
coinSize = [0, 26.49, 30.6, 24.3, 17.9,//US 1-6
	21.21, 19,
	16.25, 18.75, 21.25, 19.75,//Euro 7-14
	22.25, 24.25, 23.25, 25.75,
	19.41, 23.6, 28.65, 32, 25, 20.5, //Australian 15-20
	28, 26.5, 23.9, 18, 21.2, 19.1]; // Canadian 21-26
coinHeight = [0, 2, 2.15, 1.75, 1.35, //US 1-6
	1.95, 1.55,
	1.67, 1.67, 1.67, 1.93,//Euro 7-14
	2.14, 2.38, 2.33, 2.20,
	1.3,2,2.5,2.5,3,3.2, //Australian 15-20
	1.6,1.9,1.6,1.3,1.8,1.5]; // Canadian 21-26

// computations

slotHeight = cupHolderDepth-wall;

// modules

module CoinSlot(coin) {
	union() {
		cylinder(r=coinSize[coin]/2+clearance, h=slotHeight+1);
		}
	}

module CoinSlotPlunger(c) {
	difference() {
		union() {
			// cylinder body
			cylinder(r=coinSize[c]/2, h=springHeight-coinHeight[c]);
			// top bevel
			translate([0,0,springHeight-coinHeight[c]-gap])
				cylinder(r1=coinSize[c]/2, r2=coinSize[c]/2-coinHeight[c],
				         h=coinHeight[c]);

			}
		translate([0,0,-1]) cylinder(r=springOR+clearance, h=springHeight-wall);
		translate([0,0,springHeight-.49]) scale([scale,scale,1]) write(coinName[c], center=true);
		}
	}

module coinHolder() {
	echo("start");
	difference() {
		cylinder(r=cupHolderR-clearance,h=cupHolderDepth);
		for (c=[0:numSlots-1]) {
			assign (a=c*360/numSlots) {
				echo("coin",c,"is ",coinName[coin[c]]);
				rotate([0,0,a])
					translate([cupHolderR-coinSize[coin[c]]/2-wall,0,cupHolderFloor]) {
					CoinSlot(coin[c]);
					translate([coinSize[coin[c]]/2,0,
					          cupHolderDepth-cupHolderFloor-coinHeight[coin[c]]+2*clearance])
						cube([coinSize[coin[c]]+2*clearance,
						     coinSize[coin[c]]+2*clearance,
						     1.5*coinHeight[coin[c]]+2*clearance], center=true);
					}
				}
			}
		}
	// add cones to keep the springs centered in the coin slots
	for (c=[0:numSlots-1]) {
		assign (a=c*360/numSlots) {
			echo("coin",c,"is ",coinName[coin[c]]," angle ",a);
			rotate([0,0,a]) translate([cupHolderR-coinSize[coin[c]]/2-wall,0,cupHolderFloor-gap]) {
						cylinder(r1=springIR-clearance,r2=springIR/2-clearance,h=springIR);
				// and show spring
				// difference() {
				// 	cylinder(r=springOR, h=springHeight);
				// 	translate([0,0,-1]) cylinder(r=springIR, h=springHeight+2);
				// 	}
				}
			}
		}
	// key on top
	cylinder(r=cupHolderR/7, h=cupHolderDepth+wall+clearance, $fn=3);
	cylinder(r=cupHolderR/7, h=cupHolderDepth+wall+clearance, $fn=4);
	}

// circle of plungers
module coinPlungers(extra) {
	for (c=[0:numSlots-1]) {
		assign (a=c*360/numSlots) {
			echo("coin",c,"is ",coinName[coin[c]]," angle ",a);
			rotate([0,0,a])
				translate([cupHolderR-coinSize[coin[c]]/2-wall+extra,0,cupHolderDepth-springHeight-cupHolderFloor-2*clearance]) {
					CoinSlotPlunger(coin[c]);
					}
			}
	 	}
	 }

module cover() {
	difference() {
		cylinder(r=cupHolderR, h=wall);

		for (c=[0:numSlots-1]) {
			assign (a=c*360/numSlots) {
				rotate([0,0,a])
					translate([cupHolderR-coinSize[coin[c]]/2-wall-lip,0,-1]) {
					cylinder(r=coinSize[coin[c]]/2-lip+clearance, h=wall+2);
					translate([coinSize[coin[c]]/2+lip,0,
					          (2*coinHeight[coin[c]]+wall+2*clearance)/2])
						cube([coinSize[coin[c]]+2*lip+2*clearance,
						     coinSize[coin[c]]-2*lip+2*clearance,
						     2*coinHeight[coin[c]]+wall+2*clearance], center=true);
					}
				}
			}
		translate([0,0,-1]) cylinder(r=cupHolderR/7+clearance, h=wall+2, $fn=3);
		translate([0,0,-1]) cylinder(r=cupHolderR/7+clearance, h=wall+2, $fn=4);
		}
	}

module assembled() {
	color("blue") coinHolder();
	color("grey") translate([0,0,cupHolderFloor]) coinPlungers(0);
	color("green") translate([0,0,cupHolderDepth+clearance+gap]) cover();
	}

module plated() {
	coinHolder();
	translate([cupHolderWidth+5,0,0]) rotate([180,0,0]) translate([0,0,-cupHolderDepth+cupHolderFloor+clearance*2]) coinPlungers(wall);
	translate([-cupHolderWidth-5,0,0]) cover();
	}

difference() {
	if (part==1) assembled();
	if (part==2) coinHolder();
	if (part==3) rotate([180,0,0]) translate([0,0,-cupHolderDepth+cupHolderFloor+clearance*2]) coinPlungers(wall);
	if (part==4) cover();
	if (part==5) plated();
	if (chop) rotate([0,0,-90]) translate([-cupHolderWidth-wall,0,-1]) cube([2*(cupHolderWidth+wall),cupHolderWidth+wall,cupHolderDepth+wall]);
	}