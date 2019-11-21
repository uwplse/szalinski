/* [Global] */
// Number of Collet Places in a row
rows=2; // [1:50]
// Number of Collet Places in a column
columns=5; // [1:50]
// Type of Collet, currently ER only
collettype="ER"; //["ER"]
// Size of the collet (for ER collets)
colletsizeER=16; // [8:ER8, 11:ER11, 16:ER16, 20:ER20, 25:ER25, 32:ER32, 40:ER40, 50:ER50]
// Specify If box bottom should be open, or not
openbottom="yes"; // [yes, no]
// Create Top Cover?
topcover="yes"; // [yes, no]
//Smoothness of cones in STL
smooth=50; // [10:rough, 50:medium, 100:fine]
/////////////////////////////////////////////////////////////////
/* [Hidden] */
//Static Things
/*er8=[8,10.9,13.6]; //Diameter, Lenght of Long cone, total lenght of collet
er11=[11,13.5,18];
er16=[16,20.8,27.5];
er20=[20,23.9,31.5];
er25=[25,25.9,34];
er32=[32,30.9,40];
er40=[40,34.9,46];
er50=[50,46,60];
//Collet Specs taken from http://www.rego-fix.com/fileadmin/user_upload/Bilder_Zeichnungen_PDF/home/Produkte/Technische_Infos/REGO-FIX_ER_Dimensions_ER_Collets.pdf
// Another source of sizes http://www.takayama-shoji.co.jp/rego/pdf/13_technical_information.pdf
*/

module draw_er_collet(diameter, longcone, colletlenght, openbottom, clamprange) {
	for (xpos=[1:rows], ypos = [1:columns]) {
		if (openbottom=="no") {
			translate([xpos*(diameter+2.999), ypos*(diameter+2.999), longcone/2+1.5]) difference () {
				if (openbottom=="no") {
					translate ([0,0,-1]) cube(size = [diameter+3,diameter+3,longcone+1], center = true); 	
				} else {
					cube(size = [diameter+3,diameter+3,longcone], center = true); 	
				} //endif
					cylinder(h = longcone, r1 = (diameter-2*longcone*tan(8))/2+clamprange, r2 = diameter/2+clamprange, center = true, $fn=smooth );
			} // enddifference
		} else {
			translate([xpos*(diameter+2.999), ypos*(diameter+2.999), longcone/2]) difference () {
				if (openbottom=="no") {
					translate ([0,0,-1]) cube(size = [diameter+3,diameter+3,longcone+1], center = true); 	
				} else {
					cube(size = [diameter+3,diameter+3,longcone], center = true); 	
				}
					cylinder(h = longcone+0.001, r1 = (diameter-2*longcone*tan(8))/2+clamprange, r2 = diameter/2+clamprange, center = true, $fn=smooth );			
			}// enddifference
		} //endif
		if (topcover=="yes") {
			if (openbottom=="no") {
				translate([-xpos*(diameter+2.999), ypos*(diameter+2.999), (colletlenght-longcone)/2+1.5]) difference () {
					if (openbottom=="no") {
						translate ([0,0,-1]) cube(size = [diameter+3,diameter+3,colletlenght-longcone+2], center = true); 	
					} else {
						cube(size = [diameter+3,diameter+3,colletlenght-longcone], center = true); 	
					}
					cylinder(h = colletlenght-longcone+1, r1 = (diameter-2*longcone*tan(8))/2+2+clamprange, r2 = diameter/2+clamprange, center = true, $fn=smooth );
				}//enddifference
			}else {
				translate([-xpos*(diameter+2.999), ypos*(diameter+2.999), (colletlenght-longcone)/2]) difference () {
					if (openbottom=="no") {
						translate ([0,0,-1]) cube(size = [diameter+3,diameter+3,colletlenght-longcone+1], center = true); 	
					} else {
						cube(size = [diameter+3,diameter+3,colletlenght-longcone], center = true); 	
					}
					cylinder(h = colletlenght-longcone+0.001, r1 = (diameter-2*longcone*tan(8))/2+2+clamprange, r2 = diameter/2+clamprange, center = true, $fn=smooth );
				}//enddifference
			}//endif
		}//endif
	} //endfor
} //endmodule

module set_collet_parameters (type, size) {
	if (type=="ER") {
		if (size==8) { //Collet Diameter; Lenght of Long cone; total lenght of collet;the collet is bigger this size, when it is open (in radius)
			draw_er_collet (8,10.9,13.6,openbottom,0.3); 
		}
		if (size==11) {
			draw_er_collet (11,13.5,18,openbottom,0.5); 
		}
		if (size==16) {
			draw_er_collet (16,20.8,27.5,openbottom,0.8); 
		}
		if (size==20) {
			draw_er_collet (20,23.9,31.5,openbottom,1); 
		}
		if (size==25) {
			draw_er_collet (25,25.9,34,openbottom,1); 
		}
		if (size==32) {
			draw_er_collet (32,30.9,40,openbottom,1); 
		}
		if (size==40) {
			draw_er_collet (40,34.9,46,openbottom,1); 
		}
		if (size==50) {
			draw_er_collet (50,46,60,openbottom,1); 
		}
	}

}

if (collettype=="ER") {
	set_collet_parameters(collettype,colletsizeER);
}
