// Select to print individually or combine.
show_Box = 1;   		// Show the box
show_Cover = 1;   		// Show the cover
show_Dcjack = 1;		// Show the dc jack

//=========================== Box section ========================================
if (show_Box == 1) {

translate ([44,0,0])
	difference () {
		union () {
			cube ([88,88,30],center=true);							// Battery box main body
			translate ([-31,+39,11])	
				screwhead ();										// screw head
			translate ([-31,-39,11])	
				screwhead ();										// screw head
			translate ([19,+39,11])	
				screwhead ();										// screw head
			translate ([19,-39,11])	
				screwhead ();										// screw head
			translate ([0,-12,15])	
				rotate ([0,90,0])
					cylinder (d=16,h=88,center=true,$fn=50);		// pillar
			translate ([0,+12,15])	
				rotate ([0,90,0])
					cylinder (d=16,h=88,center=true,$fn=50);		// pillar
			translate ([-34,-34,-10])	
				sphere (d=20,center=true,$fn=50);					// Leg
			translate ([-34,+34,-10])	
				sphere (d=20,center=true,$fn=50);					// Leg
			translate ([+34,-34,-10])	
				sphere (d=20,center=true,$fn=50);					// Leg
			translate ([+34,+34,-10])	
				sphere (d=20,center=true,$fn=50);					// Leg
			hull () {
				translate ([44,-47,-12])
					rotate ([0,90,0])
						cylinder (d=10,h=8,center=true,$fn=50);		// Cover plate
				translate ([44,-47,+12])
					rotate ([0,90,0])
						cylinder (d=10,h=8,center=true,$fn=50);		// Cover plate
				translate ([44,+47,-12])
					rotate ([0,90,0])
						cylinder (d=10,h=8,center=true,$fn=50);		// Cover plate
				translate ([44,+47,+12])
					rotate ([0,90,0])
						cylinder (d=10,h=8,center=true,$fn=50);		// Cover plate
			}
		}
		union () {
			translate ([9,0,0])	
				cube ([100,82,24],center=true);						// Box inside
			translate ([-31,+39,11])	
				screwheadcut ();									// screw head cutout
			translate ([-31,-39,11])	
				screwheadcut ();									// screw head cutout
			translate ([19,+39,11])	
				screwheadcut ();									// screw head cutout
			translate ([19,-39,11])	
				screwheadcut ();									// screw head cutout
			rotate ([0,-90,0])
				cylinder (d=20,h=100,center=false,$fn=50);			// Wire hole
			translate ([96,0,0])	
				cube ([100,86,28],center=true);						// Cover plate extend slot
			translate ([44,+48,0])
				rotate ([0,90,0])
					cylinder (d=4,h=20,center=true,$fn=50);		// Cover plate hole
			translate ([44,-48,0])
				rotate ([0,90,0])
					cylinder (d=4,h=20,center=true,$fn=50);		// Cover plate hole
		}
	}

difference () {
	union () {
		difference () {
			translate ([0,0,-7])
				rotate ([90,0,-90])
					cylinder (d=75,h=24,center=false,$fn=6);		// Switch box main body
			translate ([0,0,-515])
				cube ([1000,1000,1000],center=true);				// Cut away bottom
		}
		translate ([-12,0,-10])	
			sphere (d=20,center=true,$fn=50);						// Leg
		}
	translate ([-12,-20,13])
		rotate ([+60,0,0])
			cylinder (d=20.5,h=56,center=true,$fn=50);				// Switch hole
	translate ([-12,+20,13])
		rotate ([-60,0,0])
			cylinder (d=20.5,h=56,center=true,$fn=50);				// Switch hole
	rotate ([0,-90,0])
		cylinder (d=20,h=12,center=false,$fn=50);					// Wire hole
	translate ([-18,0,8])
		rotate ([0,45,0])
			cylinder (d=6,h=100,center=false,$fn=50);				// Wire hole
}

}

//=========================== Cover section ========================================
if (show_Cover == 1) {

translate ([100,0,0])
	difference () {
		union () {
			hull () {
				translate ([0,-47,-12])
					rotate ([0,90,0])
						cylinder (d=10,h=3,center=true,$fn=50);		// Cover plate
				translate ([0,-47,+12])
					rotate ([0,90,0])
						cylinder (d=10,h=3,center=true,$fn=50);		// Cover plate
				translate ([0,+47,-12])
					rotate ([0,90,0])
						cylinder (d=10,h=3,center=true,$fn=50);		// Cover plate
				translate ([0,+47,+12])
					rotate ([0,90,0])
						cylinder (d=10,h=3,center=true,$fn=50);		// Cover plate
			}
			translate ([-1.9,0,0])	
				cube ([3,85.8,27.8],center=true);					// Cover plate extend slot
		}
		translate ([0,+48,0])
			rotate ([0,90,0])
				cylinder (d=4,h=20,center=true,$fn=50);				// Cover plate hole
		translate ([0,-48,0])
			rotate ([0,90,0])
				cylinder (d=4,h=20,center=true,$fn=50);				// Cover plate hole
	}

}

//=========================== DC jack section ========================================
if (show_Dcjack == 1) {

translate ([-12,50,30]) 
rotate ([120,0,0]) {

	difference () {
		cylinder (d=24,h=4,center=false,$fn=50);
		translate ([0,-2,0])
		cube([9,10,100],center=true);
	}
	difference () {
		cylinder (d=20,h=10,center=false,$fn=50);
		translate ([0,2,0])
		cube([9,18,100],center=true);
	}
}

}

//=========================== Modules ========================================

module screwhead () {
	translate ([0,0,-2])
		cylinder (d=22,h=16,center=true,$fn=50);			// Cap
}

module screwheadcut () {
	translate ([0,0,-2])
		union () {
			cylinder (d=16,h=10,center=true,$fn=50);		// Cap inside
			translate ([0,0,3])
				cylinder (d=5,h=16,center=true,$fn=50);		// Hole
		}
}
