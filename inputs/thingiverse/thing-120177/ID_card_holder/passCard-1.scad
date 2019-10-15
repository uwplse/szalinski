use <write.scad>

cardMarginPer = 0.5;
cardMarginH = 0.5;
cardWidth = 87 + cardMarginPer;
cardLength = 55.5 + cardMarginPer;
cardHight  = 0.76 + cardMarginH;

wall = 1.6;

cardHolderW = wall + cardWidth;
cardHolderL = wall + cardLength;
cardHolderH = wall + cardHight;

myText = "CLONE WARS";

holderL = 15;

numSpheres = 8;
diam = 15;
cylinderRad = 1.6;


module card ( w, l, h )
{
	cube ( [w, l, h] );
}

module d1CardStrap ()
{
	difference ()
	{
		translate ( [cardHolderW, 0, 0] )
		{
			card ( holderL, cardHolderL, wall );
			translate ( [0.6,cardHolderL-9,wall] )
				rotate ([0,0,-90])
					write(myText,h=6,t=0.6, font="orbitron.dxf");
		}
		//	cutting angles of strap
		translate ( [cardHolderW+holderL, 0, 0] )
		{
			rotate ([0,0,180])
			{
				cylinder ( r=holderL+wall, h=10, $fn=3, center=true );
			}
		}
		translate ( [cardHolderW+holderL, cardHolderL, 0] )
		{
			rotate ([0,0,180])
			{
				cylinder ( r=holderL+wall, h=10, $fn=3, center=true );
			}
		}
	
		// Strap hole
		translate ( [(cardHolderW+(holderL/2)+1.4), cardHolderL/2-5, -1] )
		{
			card (3, 10, 10);
			translate ([1.5,0,-1])
				cylinder ( r=1.5, h=10, $fn=10 );
			translate ([1.5,10,-1])
				cylinder ( r=1.5, h=10, $fn=10 );
			translate ([1.5,5,-5])
				cylinder ( r=3, h=10, , $fn=20 );

		}
	}	
}	

module topStops ()
{
	translate ( [ 20, 0, cardHolderH ] )
	{
		union ()
		{
			card ( cardHolderW - 40, 2*wall,  wall );
			// Round the ends
			translate ( [0, wall, 0] )
				cylinder ( r=wall, h=wall, $fn=10 );
			translate ( [cardHolderW - 40, wall, 0] )
				cylinder ( r=wall, h=wall, $fn=10 );
		}
	}
	translate ( [ 20, cardHolderL-(2*wall), cardHolderH] )
	{
		union ()
		{
			card ( cardHolderW - 40, 2*wall,  wall );
			// Round the ends
			translate ( [0, wall, 0] )
				cylinder ( r=wall, h=wall, $fn=10 );
			translate ( [cardHolderW-40, wall, 0] )
				cylinder ( r=wall, h=wall, $fn=10 );
		}
	}

}

module d1CardHolder ()
{
	union() {
	difference ()
	{
		difference ()
		{
			card (cardHolderW, cardHolderL, cardHolderH);
			translate ( [5, 8, -wall] )
				card ( cardHolderW - 40, 2*wall, 4*wall );
				
			translate ( [5, cardHolderL - 2*wall - 8, -wall] )
				card ( cardHolderW - 40, 2*wall, 4*wall );

			translate ([wall,wall,wall])
				card (cardHolderW, cardHolderL-2*wall, cardHolderH);
		}
		translate ([0, (cardHolderL)/2, 0])
			cylinder (  h=10, r = 8, center=true);
	}

	translate ( [10, 15, wall] )
		card ( cardHolderW - 60, 0.5, 0.3 );

	translate ( [10, cardHolderL - 2*wall -15, wall] )
		card ( cardHolderW - 60, 0.5, 0.3 );


//	// Top overhang
	topStops();
	d1CardStrap();
	}
}

d1CardHolder();
translate ([wall, wall, wall])
{
	*#card ( 86, 54, 0.8 );
}
