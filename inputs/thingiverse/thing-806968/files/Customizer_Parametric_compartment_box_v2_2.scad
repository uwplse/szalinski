/* [Global] */


// Whether or not to generate the box
generate_box="yes";//[yes, no]

// Whether or not to generate the lid
generate_lid="yes";//[yes, no]

showlid = generate_lid=="yes"? true : false;

showbox = generate_box=="yes"? true : false;

Type_of_Lid = "Standard";//[Standard, Sliding]

lidtype = Type_of_Lid == "Standard"? 0 : 1;	// 0=Flat lid.  Use "1" for lid that slides off in the x direction


// Size of compartments, X
compx = 30;	


// Size of compartments, Y
compy = 40;	


// Width of wall, Make slightly larger then n*nozzle diameter. i.e. 1.15 for a 0.5 nozzle, should give a 2-pass thick wall
wall = 1.15;


// Number of compartments, X
nox = 4;


// Number of compartments, Y
noy = 2;



// Depth of compartments
deep = 30;	







// Tolerance around lid.  If it's too tight, increase this. If it's too loose, decrease it. 0.15 recommended for sliding lid
tolerance=.05;



// This is how far away from the box to print the lid
lidoffset=3;		


// How far the lid goes down the sides of the box. Only applies to Standard lid
lid_drop=7;
lidheight=lid_drop+wall;

//Adds a divit to sliding lid to make opening easer, no effect on standard lid
Thumb_Divit="yes"; //[yes, no]

includethumbhole = Thumb_Divit =="no"? false : true;


//Add a coin slot above every compartment
Coin_Slot="no"; //[yes, no]

includecoinslot=Coin_Slot == "no"? false: true;


//Size of Coin slot in X direction, default is slot thickness for United States Coins. Reverse X and Y to swap direction of slot
coinx=2.5;	
//Size of Coin slot in Y direction, default is slot width for United States Coins. Reverse X and Y to swap direction of slot
coiny=26;	



/* [Hidden] */

				// Z tolerance can be tweaked separately, to make the top of the sliding lid
				// be flush with the top of the box itself.  Default is zero.  Warning: this also
				// adds wiggle room to the lid.
                //Hidden from customizer, because more likely to mess up the box then help it.
ztolerance=0;

////////////////////
//start of objects
////////////////////

totalheight = deep + (lidtype*wall);
thumbrad = min(20,noy*(compy+wall)/3);

if (showbox) {
difference() {
	cube ( size = [nox * (compx + wall) + wall, noy * (compy + wall) + wall, (totalheight + wall)], center = false);


	for ( ybox = [ 0 : noy - 1])
		{
             for( xbox = [ 0 : nox - 1])
			{
			translate([ xbox * ( compx + wall ) + wall, ybox * ( compy + wall ) + wall, wall])
			cube ( size = [ compx, compy, totalheight+1 ]);
			}
		}
	if (lidtype==1) {
			translate ([0,wall/2,deep+wall]) 
			polyhedron ( points = [   
							[0,0,0], 
							[0,noy*(compy+wall),0], 
							[nox*(compx+wall)+wall/2,0,0], 
							[nox*(compx+wall)+wall/2,noy*(compy+wall),0],
							[0,wall/2,wall], 
							[0,noy*(compy+wall)-wall/2,wall], 
							[nox*(compx+wall)+wall/2,wall/2,wall], 
							[nox*(compx+wall)+wall/2,noy*(compy+wall)-wall/2,wall]
							],
						faces = [ 
							[0,2,1], [1,2,3], [4,5,6], [5,7,6]	,		// top and bottom
							[0,4,2], [4,6,2], [5,3,7], [5,1,3]	,		// angled sides
							[0,1,4], [1,5,4], [2,6,3], [3,6,7]			// trapezoidal ends
							]);
			translate ([0,wall/2,deep+wall-ztolerance])
			cube (size=[nox*(compx+wall)+wall/2,noy*(compy+wall),ztolerance],center=false);
			}

	}
}

if (showlid) {
translate ([0,noy*(compy+wall)+wall+lidoffset,0])
difference () { union () {	// for including coin slot
	if (lidtype==1) { 
		difference () {
		polyhedron ( points = [   
						[0,0,0], 
						[0,noy*(compy+wall)-2*tolerance,0], 
						[nox*(compx+wall)-tolerance+wall/2,0,0], 
						[nox*(compx+wall)-tolerance+wall/2,noy*(compy+wall)-2*tolerance,0],
						[0,wall/2,wall], 
						[0,noy*(compy+wall)-wall/2-2*tolerance,wall], 
						[nox*(compx+wall)-tolerance+wall/2,wall/2,wall], 
						[nox*(compx+wall)-tolerance+wall/2,noy*(compy+wall)-wall/2-2*tolerance,wall]
						],
					faces = [ 
						[0,2,1], [1,2,3], [4,5,6], [5,7,6]	,		// top and bottom
						[0,4,2], [4,6,2], [5,3,7], [5,1,3]	,		// angled sides
						[0,1,4], [1,5,4], [2,6,3], [3,6,7]			// trapezoidal ends
						]);
		// Thumb hole
		if (includethumbhole==true) {
			intersection () {
			translate ([min(8,nox*(compx+wall)/8),(noy*(compy+wall))/2,thumbrad+wall/2]) sphere (r=thumbrad, center=true, $fn=50);
			translate ([min(8,nox*(compx+wall)/8),0,0]) cube (size=[20,(noy*(compy+wall)),20], center=false);
		}
	}

		}
	} else {

	difference() {
	cube ( size = [nox * (compx + wall) + 3 * wall + 2* tolerance, noy * (compy + wall) + 3 * wall + 2*tolerance, lidheight], center = false);

	translate ([wall,wall,wall])
	cube ( size = [nox * (compx + wall) +wall+tolerance, noy * (compy + wall) + wall + tolerance, lidheight+1], center = false);
	}
} // if lidtype
} // union
if (includecoinslot==true) {
	for ( yslot = [ 0 : noy - 1])
		{
             for( xslot = [ 0 : nox - 1])
			{
			translate([ xslot * ( compx + wall ) + (2-lidtype)*wall + (compx-coinx)/2, yslot * ( compy + wall ) + wall*(2-3*lidtype/2) + (compy-coiny)/2, 0])
			cube ( size = [ coinx, coiny, wall ]);
			}
		}
	}
} //difference
} // if showlid



