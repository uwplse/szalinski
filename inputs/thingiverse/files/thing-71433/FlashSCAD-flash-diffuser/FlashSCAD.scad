//FlashSCAD™ Flash Diffuser by Appxela
//
//nissin width=74.6 depth=46.8
//Sigma EF-500 DG Super SA-STTL width=76 depth=44
flashWidth = 76.7;
flashDepth = 44.7;
resolution = 5; //[1:10]

flashHeight = flashDepth*0.75;

ht = flashWidth*1;
wd = flashDepth*0.65;
fn = resolution*2+3;

saddle = 2;

module diffuser() {
	difference() {
		union() {
			//left
			translate( [-wd,0,0] )
				cylinder( h=ht, r1=wd, r2=wd*.75,$fn=fn );
			//right
			translate( [wd,0,0] )
				cylinder( h=ht, r1=wd, r2=wd*.75, $fn=fn );
			//middle
			translate( [0,-wd/4,0] )
				scale( [1,0.7,1] )
					cylinder( h=ht, r1=wd*2, r2=wd*1.75, $fn=fn*2 );
			//top
			translate( [0,-wd/3,ht] )
				rotate( 90,[0,1,0] )
					scale( [1.7,1.5,1.94] )
						sphere( r=wd, $fn=fn*4 );


			}
		//bounce plane

		translate( [-wd*5,wd*2.5,wd*.8] )
			rotate( 45,[1,0,0] )
				cube( [wd*10,wd*10,wd*10] );


	}
}

difference() {

	union() {
	//make it hollow
	//difference() {
		diffuser();
	//	translate( [0,0,1] ) 
	//		scale( 0.95,[1,1,1] )
	//			diffuser();
	//	}
	//	//add flash mounting box
	//	translate( [-(flashWidth+saddle)/2,-(flashDepth+saddle)/1.6,0] )
	//	cube([flashWidth+saddle,flashDepth+saddle,flashHeight+saddle]);

	}

		//hole for the flash unit
		translate( [-flashWidth/2,-flashDepth/1.6,0] )
		cube([flashWidth,flashDepth,flashHeight]);

		//hole for the light to pass through
		//translate( [-(flashWidth-saddle)/2,-(flashDepth-saddle)/1.6,0] )
		//cube([flashWidth-saddle,flashDepth-saddle,flashHeight+saddle]);

}