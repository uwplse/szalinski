/*
  cardSizes

  TicketToRide
  43.44 x 67.51 x 0.25

  Dominion
  58.95 x 90.83 x 0.3

  Catan
  54.2 x 80.2 x 0.3
    
  Power Grid Money
  45 x  90 x 0.1
    
  Power Grid Plants
  70 x 70 x 0.25
*/

//item = "tray"; // [tray,lid,divider]
// if using sleeves, this will be the sleeve width
cardWidth = 59;
// additional space around the card, 2 is 1mm at each end
xySpace = 2;
// this can be tailored based on your printer. A figure of zero essentially means that the points at the end of the interlocking system should exactly touch, so we need to push them together to create a lock. A more accurate printer should permit this figure to get close to the precise figure of -2.
interlockClearance = -1.2;
// another locking clearance parameter, this time for the top/bottom interlock. a typical feature of 3D printing is that the bottom layer is a touch larger than the rest in order to create good bed adhesion, in this case, removing a small sliver from the locking mechanism helps top/bottom stacking to happen cleanly without giving rise to bending trays. You'll tailor this based on your experience with your own printer.
topBottomInterlockClearance = 0.7;
// Text to put on nameplate
label="MERCHANT";



module lock(length,rX,rY,rZ,bcR) {
     translate([0,0,(0.25*10+2.5+1.1)/2])
	  difference() {
	  rotate([rX,rY,rZ])
	       difference() {
	       cube([2,length-interlockClearance,0.25*10+2.5+1.1],center=true);
	       translate([0,(length-interlockClearance)/2,0])
		    rotate([0,0,45])
		    cube([2,length-interlockClearance,0.25*10+2.5+1.2],center=true);
	  };
	  translate([0,0,-(0.25*10+2.5+1.1)/2])
	       rotate([rX,rY,rZ])
	       rotate([0,bcR,0])
	       cube([2,length+0.1-interlockClearance,0.25*10+2.5+1.2],center=true);
     }
}


endLength = cardWidth+xySpace+4;

module nameplate2() {
    length = endLength/2-14;
	centerSupport=20;
	endCubeLength=(endLength-centerSupport)/2;

    rotate([-90,0,0]) {
		difference() {
			cube([endLength,4,6.6],center=true);
			translate([(endCubeLength+centerSupport)/2,1.25,-0.5]) {
				cube([endCubeLength,2.5,5.6],center=true);
			}
			translate([-(endCubeLength+centerSupport)/2,1.25,-0.5]) {
				cube([endCubeLength,2.5,5.6],center=true);
			}
		}
		translate([-(length/4 - endLength/2 - interlockClearance/2),
				1.0,-3.8]) 
			lock(length/2,0,180,90,45);
		translate([(length/4 - endLength/2 - interlockClearance/2),
			1.0,-3.8])
			lock(length/2,0,0,270,-45);

		font1="Liberation Sans";
		translate([0,-1,-0.1]) {
			rotate([90,0,0]){
				linear_extrude(height=2.2){
					text(label,halign="center",valign="center",font=font1,size=5,direction="ltr",spacing=1);
				}
			}
		}
	}
}

	
					
	
nameplate2();
