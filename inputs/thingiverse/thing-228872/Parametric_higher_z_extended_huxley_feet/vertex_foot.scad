//------------------------------------------------------------
// Huxley vertex feet for higher z and more clearance 
//
// http://www.thingiverse.com/wardwouts
// 
//
//------------------------------------------------------------
// Inspired by:
// http://www.thingiverse.com/thing:19160 -- eMaker Huxley Higher Z (burtyb)
// http://www.thingiverse.com/thing:28045 -- eMaker Huxley Extended Vertex Parts (Snille)

// Length measured between the bottom feet (207 is default for emaker huxley)
baserodlength=207;
// Length measure between top vertex and feet (207 is default for emaker huxley)
siderodlength=280;

partstyle = "top"; // [top,bottom]

// size of the M6 holes
M6 = 6.5;
// thickness of the part
thickness = 14;
// distance between tear and hole
teardist = 2*1;
// 80 for pretty curves; 16 for quick ones
FN=80*1;

// distance between the original holes (you probably do not want to change this)
distance = 38;

zaxisliftrod = sqrt(pow(siderodlength,2) - pow((baserodlength/2),2));

echo ("===========================================");
echo ("Lengths measured between the parts");
echo (str("Base rod length: ", baserodlength));
echo (str("Side rod length: ", siderodlength));
echo ("===========================================");
echo ("Shopping list (approximate size):");
echo (str("2 x ", baserodlength + 50 ,"mm M6 threaded bar for the base rods"));
echo (str("4 x ", siderodlength + 50 ,"mm M6 threaded bar for the side rods"));
echo (str("2 x ", round(zaxisliftrod + 72) ,"mm x 6mm smooth bar for the z-axis"));
echo (str("2 x ", round(zaxisliftrod + 22) ,"mm M5 threaded bar smooth bar for the z-axis"));
echo ("===========================================");

toprodangle = asin( (baserodlength/2) / siderodlength )  ;
//echo ("Top rod angle: ", toprodangle);
bottomrodangle = acos((baserodlength/2) / siderodlength ) ;
//echo ("Bottom rod angle: ", bottomrodangle);


// http://www.hhofstede.nl/modules/soscastoa.htm

barlength = (distance / 2) / cos(30) ;
//echo("Length of a single bar piece: ", barlength);

module bar(){
	// bar is een balkje met afgeronde uiteinden en 2 gaten
	// + een tear op teardist van een van de gaten
	difference(){
		union(){
			cylinder(h=thickness, r=thickness/2, $fn=FN);
			translate([0,-thickness/2,0]){
				cube([barlength,thickness,thickness]);
			}
			translate([barlength,0,0]){
				cylinder(h=thickness, r=thickness/2, $fn=FN);
			}
		}
		union(){
			translate([0,0,-thickness/2]){
				cylinder(h=thickness*2, r=M6/2, $fn=FN);
			}
			translate([barlength,0,0]){
				translate([0,0,-thickness/2]){
					cylinder(h=thickness*2, r=M6/2, $fn=FN);
				}
			}
				translate([teardist+M6,-thickness,thickness/2]){
					rotate([0,0,90]){
						tear(thickness*2, M6/2);
					}
				}
		}
	}
}

module foot(){
	// draw a foot which is just a bunch of cubes
	// side 1
	translate([-14,3,0]){ cube([16,2,thickness]); }
	// side 2
	translate([-14,-5,0]){ cube([16,2,thickness]); }
	// bottom
	translate([-16,-6,0]){ cube([2,12,thickness]); }
	//top
	translate([-8,-4,0]){ cube([4,8,thickness]); }
}

module mainbody(){
	// in dit deel is de standaard hoek van het onderdeel altijd 120 graden
	// dit omdat het standaard frame altijd hoeken van 60 graden heeft
	// omdat de afstand tussen de 2 standaard gaten altijd de contante
	// 'distance' afstand is roteer ik 30 graden (90 - 60)
	// en wandel ik 'distance' die richting in vervolgens teken ik een bar
	// 90 + 120 - 60 = 150
	// (30 + 150 = 180 dus zo wordt ie omgekeerd)
	// dit allemaal niet erg parametrisch, want het moet gewoon
	// in het basis frame passen
	bar();
	footextend();
	rotate([0,0,-30]){
		translate([distance, 0,0 ]){
			rotate([0,0,150]){
				bar();
				extend();
			}
		}
	}
}

module extend(){
	// we staan al goed voor de hoek van 60, dus alleen verschil
	// verder roteren
	if ( partstyle == "bottom" ){
		rotate([0,0,60-bottomrodangle]){
			translate([-barlength,0,0]){
				bar();
			}
		}
	}
	if ( partstyle == "top") {
		rotate([0,0,30-toprodangle]){
			translate([-barlength,0,0]){
				bar();
			}
		}
	}
}

module footextend(){
	if ( partstyle == "top") {
			rotate([0,0,-30+toprodangle]){
			translate([-barlength,0,0]){
				bar();
			}
		}
	}
	if ( partstyle == "bottom" ){
		foot();
	}
}

module tear(height,radius){
	rotate([90,0,90]){
		cylinder(h=height,r=radius,$fn=FN);
		rotate([0,0,45]){
			cube([radius, radius, height]);
		}
	}
}

mainbody();
