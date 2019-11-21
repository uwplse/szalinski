$fn=72;

eyeletRingDiameterOffset = 0.2;
eyeletRingTopWidth = 4;
eyeletRingBottomWidth = 7;
eyeletRingHeight= 2;

eyeletDiameter = 14;
outerTopWidth = 7;
outerBottomWidth = 4;
baseHeigth = 1.5;

hookRingWidth=2;
hookRingHeight=2.8;

hookTopWidth = 0.5;
hookMiddleWidth=2.4;
hookTopHeight = 0.0;
hookMiddleHeight = 0.6;

numberOfSplits = 3;
hookSplitWidth = 1;


eyelet();

module eyelet() {
		translate([eyeletDiameter+max(outerBottomWidth,outerTopWidth)+max(eyeletRingTopWidth,eyeletRingBottomWidth)+2,0,0]) {

		difference() {


			cylinder(h=eyeletRingHeight,r1=eyeletDiameter/2+hookRingWidth+eyeletRingBottomWidth,r2=eyeletDiameter/2+hookRingWidth+eyeletRingTopWidth);
					translate([0,0,-0.1]) {
						cylinder(h=eyeletRingHeight+0.2,r=eyeletDiameter/2+hookRingWidth+eyeletRingDiameterOffset);
					}
			}
		}



		//-------------------BASE
		difference() {

		cylinder(h=baseHeigth,r1=eyeletDiameter/2+outerBottomWidth,r2=eyeletDiameter/2+outerTopWidth);

			translate([0,0,-0.1]) {
				cylinder(h=baseHeigth+0.2,r=eyeletDiameter/2);
			}
		}

		difference() {
		//-------------------HOOK RING

			union() {
				translate([0,0,baseHeigth]) {
				difference() {
				cylinder(h=hookRingHeight,r=eyeletDiameter/2+hookRingWidth);

				translate([0,0,-0.1]) {
					cylinder(h=hookRingHeight+0.2,r=eyeletDiameter/2);
				}}
				}


				//-------------------HOOK

				translate([0,0,baseHeigth+hookRingHeight]) {

				difference() {
					union() {
						cylinder(h=hookMiddleHeight,r1=eyeletDiameter/2+hookRingWidth,r2=eyeletDiameter/2+hookMiddleWidth);
						translate([0,0,hookMiddleHeight]) {
						cylinder(h=hookTopHeight,r1=eyeletDiameter/2+hookMiddleWidth,r2=eyeletDiameter/2+hookTopWidth);

						}
					}
					translate([0,0,-0.1]) {
						cylinder(h=hookMiddleHeight+hookTopHeight+0.2,r=eyeletDiameter/2);
					}
				}

				}
			}


		// HOOK SPLITS

			for(pos=[0:1:numberOfSplits]) {

				rotate([0,0,(180 / numberOfSplits)*pos]) {
					translate([0,0,baseHeigth+30]) {
					cube([500,hookSplitWidth,60],true);
					}
				}
			}
		}
}

