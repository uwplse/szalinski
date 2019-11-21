// Customizable_Ammo_and_bullet_models.scad
// Last update: May 26, 2017
//  Changelog: Fixed 357 Magnum not working in customizer. Added 44 Mag.
// Albert Phan
// This scad library makes models of entire cartridges or just bullets.
// You can use it to make dummy rounds or dummy bullets or use as models in other openscad projects.
// Dimensions for ammo can be found from wikipedia.
// Dimensions are in mm.
// Github: https://github.com/AlbertPhan/Openscad-Ammo-and-Bullet-Library/tree/master






// Customizable stuff

// Choose the cartridge
cartridge = "357 Mag";	// [50 BMG, 338 Lapua Mag, 30-06 Springfield, 308 Winchester, 303 British, 7.62x39mm, 223 Remington, 45 APC, 40 S&W, 44 Mag, 357 Mag, 9mm]
// Type of bullet
bulletType = "roundflat";		// [ballnose, pistolroundnose, rifleroundnose, roundflat,semiwadcutter, wadcutter, pistolhollowpoint, riflehollowpoint]
// boatTail if making bullet only
boatTail = false;				// [true, false]
// Make the cartridge or just the bullet
part = "cartridge";					// [cartridge, bullet]

/* [Hidden] */
$fn = 100;
// End Customizable stuff

if(part == "cartridge")
{
		makeCartridge(cartridge, bulletType, boatTail, bulletOnly = false);
}
else if(part == "bullet")
{
	// make only bullet
	makeCartridge(cartridge, bulletType, boatTail, true);
}

	
//makeCartridge creates a cartridge based on the cartridge you pass to it. It can also make the bullet only if specified.
module makeCartridge(cartridge, bulletType, boatTail, bulletOnly)
{
	if (cartridge == "50 BMG")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(12.98, 138.43-100.203, bulletType, boatTail);
		} 
		else 
		{
			makeCustomCartridge(
			cartridgeType 				= "rifle",	// [rifle,pistol] 
			rimThickness				= 2.108,		// R
			rimDiameter					= 20.422,	// R1
			extractorGrooveDiameter		= 17.272, 		// E1
			extractorGrooveThickness 	= 3.277,		// e
			extractorTaperHeight 		= 7.385,		// E if no groove then use R rimThickness
			baseDiameter 				= 20.422,	// P1
			shoulderDiameter 			= 20.422, 	// P2
			neckDiameter				= 14.224,		// H1
			shoulderBaseHeight 			= 76.352,	// L1
			neckBaseHeight 				= 84.100,	// L2
			caseLength 					= 100.203,	// L3
			overallLength				= 138.43,	// L6
			bulletDiameter				= 12.98,		// G1
			bulletType = bulletType);		
		}

	}	
	else if (cartridge == "338 Lapua Mag")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(8.61, 93.50-69.20, bulletType, boatTail);
		} 
		else 
		{
			makeCustomCartridge(
			cartridgeType 				= "rifle",	// [rifle,pistol] 
			rimThickness				= 1.52,		// R
			rimDiameter					= 14.93,	// R1
			extractorGrooveDiameter		= 13.24, 		// E1
			extractorGrooveThickness 	= 0.90,		// e
			extractorTaperHeight 		= 3.12,		// E if no groove then use R rimThickness
			baseDiameter 				= 14.91,	// P1
			shoulderDiameter 			= 13.82, 	// P2
			neckDiameter				= 9.41,		// H1
			shoulderBaseHeight 			= 54.90,	// L1
			neckBaseHeight 				= 60.89,	// L2
			caseLength 					= 69.20,	// L3
			overallLength				= 93.50,	// L6
			bulletDiameter				= 8.61,		// G1
			bulletType = bulletType);		
		}

	}
	else if (cartridge == "30-06 Springfield")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(7.85, 84.84-63.35, bulletType, boatTail);
		} 
		else 
		{
			makeCustomCartridge(
			cartridgeType 				= "rifle",	// [rifle,pistol] 
			rimThickness				= 1.24,		// R
			rimDiameter					= 12.01,	// R1
			extractorGrooveDiameter		= 10.39, 		// E1
			extractorGrooveThickness 	= 0.84,		// e
			extractorTaperHeight 		= 3.16,		// E if no groove then use R rimThickness
			baseDiameter 				= 11.96,	// P1
			shoulderDiameter 			= 11.2, 	// P2
			neckDiameter				= 8.63,		// H1
			shoulderBaseHeight 			= 49.49,	// L1
			neckBaseHeight 				= 53.56,	// L2
			caseLength 					= 63.35,	// L3
			overallLength				= 84.84,	// L6
			bulletDiameter				= 7.85,		// G1
			bulletType = bulletType);		
		}

	}
	
	else if (cartridge == "7.62x39mm")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(7.92, 56.00-38.70, bulletType, boatTail);
		} 
		else 
		{
			makeCustomCartridge(
			cartridgeType 				= "rifle",	// [rifle,pistol] 
			rimThickness				= 1.50,		// R
			rimDiameter					= 11.35,	// R1
			extractorGrooveDiameter		= 9.56, 		// E1
			extractorGrooveThickness 	= 1.00,		// e
			extractorTaperHeight 		= 3.20,		// E if no groove then use R rimThickness
			baseDiameter 				= 11.35,	// P1
			shoulderDiameter 			= 10.07, 	// P2
			neckDiameter				= 8.60,		// H1
			shoulderBaseHeight 			= 30.50,	// L1
			neckBaseHeight 				= 33.00,	// L2
			caseLength 					= 38.70,	// L3
			overallLength				= 56.00,	// L6
			bulletDiameter				= 7.92,		// G1
			bulletType = bulletType);		
		}

	}
	else if (cartridge == "223 Remington")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(5.70, 57.40-44.70, bulletType, boatTail);
		} 
		else 
		{
			makeCustomCartridge(
			cartridgeType 				= "rifle",	// [rifle,pistol] 
			rimThickness				= 1.14,		// R
			rimDiameter					= 9.60,	// R1
			extractorGrooveDiameter		= 8.43, 		// E1
			extractorGrooveThickness 	= 0.76,		// e
			extractorTaperHeight 		= 3.13,		// E if no groove then use R rimThickness
			baseDiameter 				= 9.58,	// P1
			shoulderDiameter 			= 9.0, 	// P2
			neckDiameter				= 6.43,		// H1
			shoulderBaseHeight 			= 36.52,	// L1
			neckBaseHeight 				= 39.55,	// L2
			caseLength 					= 44.70,	// L3
			overallLength				= 57.40,	// L6
			bulletDiameter				= 5.70,		// G1
			bulletType = bulletType);		
		}

	}
	else if (cartridge == "308 Winchester")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(7.85, 71.12-51.18, bulletType, boatTail);
		} 
		else 
		{
			makeCustomCartridge(
			cartridgeType 				= "rifle",	// [rifle,pistol] 
			rimThickness				= 1.37,		// R
			rimDiameter					= 12.01,	// R1
			extractorGrooveDiameter		= 10.39, 		// E1
			extractorGrooveThickness 	= 1.40,		// e
			extractorTaperHeight 		= 3.85,		// E if no groove then use R rimThickness
			baseDiameter 				= 11.96,	// P1
			shoulderDiameter 			= 11.53, 	// P2
			neckDiameter				= 8.72,		// H1
			shoulderBaseHeight 			= 39.62,	// L1
			neckBaseHeight 				= 43.48,	// L2
			caseLength 					= 51.18,	// L3
			overallLength				= 71.12,	// L6
			bulletDiameter				= 7.85,		// G1
			bulletType = bulletType);
		}

	}
	else if (cartridge == "303 British")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				// makeCustomBullet(bulletDiameter, bulletHeight, bulletType = "rifleroundnose", boatTail = false)
				makeCustomBullet(7.92, 78.11-56.44, bulletType, boatTail); 
		} 
		else 
		{
			makeCustomCartridge(
			cartridgeType 				= "rifle",	// [rifle,pistol] 
			rimThickness				= 1.63,		// R
			rimDiameter					= 13.72,	// R1
			extractorGrooveDiameter		= 0, 		// E1
			extractorGrooveThickness 	= 0,		// e
			extractorTaperHeight 		= 1.63,		// E if no groove then use R rimThickness
			baseDiameter 				= 11.68,	// P1
			shoulderDiameter 			= 10.18, 	// P2
			neckDiameter				= 8.64,		// H1
			shoulderBaseHeight 			= 45.47,	// L1
			neckBaseHeight 				= 48.01,	// L2
			caseLength 					= 56.44,	// L3
			overallLength				= 78.11,	// L6
			bulletDiameter				= 7.92,		// G1
			bulletType = bulletType);
		}	

	}
	else if (cartridge == "45 APC")
	{
		if(bulletOnly == true)
		{
			// TODO: bullet only here
			color("chocolate")
				makeCustomBullet(11.48, 32.39-22.81, bulletType, boatTail);
		}
		else
		{
						makeCustomCartridge(
			cartridgeType 				= "pistol",	// [rifle,pistol] 
			rimThickness				= 1.24,		// R
			rimDiameter					= 12.19,	// R1
			extractorGrooveDiameter		= 10.16, 	// E1
			extractorGrooveThickness 	= 0.89,		// e
			extractorTaperHeight 		= 4.11,		// E if no groove then use R rimThickness
			baseDiameter 				= 12.09,		// P1
			shoulderDiameter 			= 0, 		// P2
			neckDiameter				= 0,		// H1
			shoulderBaseHeight 			= 0,		// L1
			neckBaseHeight 				= 0,		// L2
			caseLength 					= 22.81,	// L3
			overallLength				= 32.39,	// L6
			bulletDiameter				= 11.48,		// G1
			bulletType = bulletType);				
		}
	}
	else if (cartridge == "44 Mag")
	{
		if(bulletOnly == true)
		{
			// TODO: bullet only here
			color("chocolate")
				makeCustomBullet(10.972, 40.89-32.64, bulletType, boatTail);
		}
		else
		{
						makeCustomCartridge(
			cartridgeType 				= "pistol",	// [rifle,pistol] 
			rimThickness				= 1.52,		// R
			rimDiameter					= 13.05,	// R1
			extractorGrooveDiameter		= 0, 	// E1
			extractorGrooveThickness 	= 0,		// e
			extractorTaperHeight 		= 1.52,		// E if no groove then use R rimThickness
			baseDiameter 				= 11.61,		// P1
			shoulderDiameter 			= 0, 		// P2
			neckDiameter				= 0,		// H1
			shoulderBaseHeight 			= 0,		// L1
			neckBaseHeight 				= 0,		// L2
			caseLength 					= 32.64,	// L3
			overallLength				= 40.89,	// L6
			bulletDiameter				= 10.972,		// G1
			bulletType = bulletType);				
		}
	}
	else if (cartridge == "9mm")
	{
		if(bulletOnly == true)
		{
			// TODO: bullet only here
			color("chocolate")
				makeCustomBullet(9.03, 29.69-19.15, bulletType, boatTail);
		}
		else
		{
						makeCustomCartridge(
			cartridgeType 				= "pistol",	// [rifle,pistol] 
			rimThickness				= 1.27,		// R
			rimDiameter					= 9.96,		// R1
			extractorGrooveDiameter		= 8.79, 	// E1
			extractorGrooveThickness 	= 0.90,		// e
			extractorTaperHeight 		= 2.98,		// E if no groove then use R rimThickness
			baseDiameter 				= 9.93,		// P1
			shoulderDiameter 			= 0, 		// P2
			neckDiameter				= 0,		// H1
			shoulderBaseHeight 			= 0,		// L1
			neckBaseHeight 				= 0,		// L2
			caseLength 					= 19.15,	// L3
			overallLength				= 29.69,	// L6
			bulletDiameter				= 9.03,		// G1
			bulletType = bulletType);				
		}
	}
	else if (cartridge == "357 Mag")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(9.03, 29.69-19.15, bulletType, boatTail);
		}
		else
		{
			makeCustomCartridge(
			cartridgeType 				= "pistol",	// [rifle,pistol] 
			rimThickness				= 1.5,		// R
			rimDiameter					= 11.2,		// R1
			extractorGrooveDiameter		= 0, 		// E1
			extractorGrooveThickness 	= 0,		// e
			extractorTaperHeight 		= 0,		// E
			baseDiameter 				= 9.6,		// P1
			shoulderDiameter 			= 0, 		// P2
			neckDiameter				= 0,		// H1
			shoulderBaseHeight 			= 0,		// L1
			neckBaseHeight 				= 0,		// L2
			caseLength 					= 33,		// L3
			overallLength				= 40,		// L6
			bulletDiameter				= 9.1,		// G1
			bulletType = bulletType);				
		}
	}
	else if (cartridge == "40 S&W")
	{
		if(bulletOnly == true)
		{
			color("chocolate")
				makeCustomBullet(10.17, 28.83-21.59, bulletType, boatTail);
		}
		else
		{
			makeCustomCartridge(
			cartridgeType 				= "pistol",	// [rifle,pistol] 
			rimThickness				= 1.40,		// R
			rimDiameter					= 10.77,		// R1
			extractorGrooveDiameter		= 8.81, 		// E1
			extractorGrooveThickness 	= 1.14,		// e
			extractorTaperHeight 		= 3.50,		// E
			baseDiameter 				= 10.77,		// P1
			shoulderDiameter 			= 0, 		// P2
			neckDiameter				= 0,		// H1
			shoulderBaseHeight 			= 0,		// L1
			neckBaseHeight 				= 0,		// L2
			caseLength 					= 21.59,		// L3
			overallLength				= 28.83,		// L6
			bulletDiameter				= 10.17,		// G1
			bulletType = bulletType);				
		}
	}
	
}
		
// makeCustomCartridge creates a cartridge based on the dimensions of the cartridge you pass to it.
module makeCustomCartridge(
// From wikipedia images of cartridges dimensions
cartridgeType,	// rifle or pistol (bottle neck or straight case)
rimThickness, 	// R
rimDiameter,	// R1
extractorGrooveDiameter,	// E1
extractorGrooveThickness,	// e
extractorTaperHeight, 		// E
baseDiameter, 			// P1
shoulderDiameter, 		// P2
neckDiameter,			// H1
shoulderBaseHeight, 	// L1
neckBaseHeight, 		// L2
caseLength, 			// L3
overallLength, 			// L6
bulletDiameter,			// G1
bulletType = "ballnose")			// ballnose, pistolroundnose rifleroundnose, pointed, roundflat,semiwadcutter, wadcutter, pistolhollowpoint, riflehollowpoint
{

	// Sanity check for overall length
	//%cylinder(d = rimDiameter, h = overallLength);
	
	// Rim
	cylinder(d = rimDiameter, h = rimThickness); 
	translate([0,0,rimThickness])
	{
		// Extractor Groove
		cylinder(d = extractorGrooveDiameter, h = extractorGrooveThickness);
		translate([0,0,extractorGrooveThickness])
		{
			// Extractor Groove taper
			cylinder(d1 = extractorGrooveDiameter, d2 = baseDiameter, h = extractorTaperHeight - (rimThickness + extractorGrooveThickness)); 
			translate([0,0,extractorTaperHeight - (rimThickness + extractorGrooveThickness)])
			{
				if(cartridgeType == "rifle")
				{
					// Rifle Case 
					cylinder(d1 = baseDiameter, d2 = shoulderDiameter, h = shoulderBaseHeight - extractorTaperHeight);
					translate([0,0,shoulderBaseHeight - extractorTaperHeight])
					{
						// Shoulder
						cylinder(d1 = shoulderDiameter, d2 = neckDiameter, h = neckBaseHeight - shoulderBaseHeight);
						translate([0,0,neckBaseHeight - shoulderBaseHeight])
						{
							// Neck
							cylinder(d = neckDiameter, h = caseLength - neckBaseHeight);
							translate([0,0,caseLength - neckBaseHeight])
								color("chocolate")
									// bullet is inserted one bulletDiameter into case
									translate([0,0,-bulletDiameter])
										makeCustomBullet(bulletDiameter, overallLength - caseLength, bulletType);
						}
					}
				}
				else
				{
					// Pistol Case 
					cylinder(d = baseDiameter, h = caseLength - extractorTaperHeight);
					translate([0,0,caseLength - extractorTaperHeight])
						color("chocolate")
							// bullet is inserted one bulletDiameter into case
							translate([0,0,-bulletDiameter])
								makeCustomBullet(bulletDiameter, overallLength - caseLength, bulletType);
				}
			}
		}
	}
}

// makeCustomBullet creates a custom bullet given bullet diameter, height, type, and whether there is a boattail or not.
module makeCustomBullet(bulletDiameter, bulletHeight, bulletType = "rifleroundnose", boatTail = false)
{
	// Puts bullet at [0,0,0]
	translate([0,0,bulletDiameter])
		{
		boatTailLength = bulletDiameter*(1-tan(10));
		
		// Bullettype
		if (bulletType == "rifleroundnose")
		{
			makeRoundnose(4);	
		}
		else if (bulletType == "pistolroundnose")
		{
			makeRoundnose(1.5);
			
		}
		else if (bulletType == "ballnose")
		{
			makeRoundnose(1);
			
		}
		else if (bulletType == "roundflat")
		{
			difference()
			{
				makeRoundnose(2);
				translate([0,0, bulletHeight - bulletDiameter * 0.2])
					cylinder(d = bulletDiameter, h = bulletDiameter);
			}
			
		}
		else if(bulletType == "wadcutter")
		{
			cylinder(d = bulletDiameter, h = bulletHeight);
			
		}
		else if(bulletType == "semiwadcutter")
		{
			cylinder(d = bulletDiameter, h = bulletHeight - bulletHeight* 0.7);
			translate([0,0,(bulletHeight) * 0.1])
				cylinder(d1 = bulletDiameter * 0.9, d2 = bulletDiameter * 0.8, h = bulletHeight * 0.9);
		}
		else if(bulletType == "pistolhollowpoint")
		{
			hollowPointOgive = 2;
			hollowPointDepth = 3;
			difference()
			{
				union()
					{
					translate([0,0, hollowPointOgive])
						makeRoundnose(1.5);
					cylinder(d = bulletDiameter, h = hollowPointOgive);
					}
				// hollowpoint cutout
				translate([0,0, bulletHeight-hollowPointDepth])
					cylinder(d1 = bulletDiameter * 0.1, d2 = bulletDiameter * 0.6, h = hollowPointDepth + 0.1);
				// flatten bullet tip
				translate([0,0, bulletHeight]) 
					cylinder(d = bulletDiameter, h = bulletHeight);
			}
		}
		else if(bulletType == "riflehollowpoint")
		{
			hollowPointOgive = 2;
			hollowPointDepth = 3;
			difference()
			{
				union()
					{
					translate([0,0, hollowPointOgive])
						makeRoundnose(4);
					cylinder(d = bulletDiameter, h = hollowPointOgive);
					}
				// hollowpoint cutout
				translate([0,0, bulletHeight-hollowPointDepth])
					cylinder(d1 = bulletDiameter * 0.1, d2 = bulletDiameter * 0.4, h = hollowPointDepth + 0.1);
				// flatten bullet tip
				translate([0,0, bulletHeight]) 
					cylinder(d = bulletDiameter, h = bulletHeight);
			}
		}
		// Add bottom length of bullet (going inside cartridge)
		// When making bullet only, this will make a proper length bullet to be seated into an empty casing
		
		// Make boattail or just cylinder
		if(boatTail)
		{
			boatTailLength = bulletDiameter * (1 - tan(10));
			rotate([180,0,0])
			{
				cylinder(d = bulletDiameter, h = bulletDiameter * tan(10));
				translate([0,0,bulletDiameter * tan(10)])
					cylinder(d1 = bulletDiameter, d2 = bulletDiameter * 0.8, h = boatTailLength);
				
			}
		}
		else
		{
			rotate([180,0,0])
				cylinder(d = bulletDiameter, h = bulletDiameter);
		}
	}
	
	// Creates basic bullet shape, cylinder and roundnose
	module makeRoundnose(bulletOgiveScale)
	{
		// Sanity check for bullet overall length
		//%cylinder(d = bulletDiameter, h = bulletHeight);
		
		cylinder(d = bulletDiameter, h = bulletHeight - bulletDiameter * bulletOgiveScale/2);
		
		translate([0,0, bulletHeight - bulletDiameter * bulletOgiveScale/2])
		{
				// Round nose of bullet
				difference()
				{	
					scale([1,1,bulletOgiveScale])
						sphere(d = bulletDiameter);	
					// remove bottom of sphere
					rotate([0,180, 0]) 
						cylinder(d = bulletDiameter*1.01, h = bulletOgiveScale * bulletDiameter);
				}
		}		
	}
	
}