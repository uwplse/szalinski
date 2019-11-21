// CAN bus connector housing

// the count of connectors
countSubD9 = 12;
//with fastening tabs on both sides
withFasteningTab = "Yes"; //[Yes,No]

// outer height of housing
total_height = 12;
// thickness of the walls of the box (and lid)
wall_thickness = 1.5;
// which part should be printed
part_to_print = "case and lid"; //[case and lid, case, lid]

// the x dimension of a hole. to be changed for other SubD connectors than SubD9
db9x = 20;
// the y dimension of a hole. to be changed for other SubD connectors than SubD9
db9y = 12.5;
// gap between two SuD connectors, relates to the width of the plugs
db9Gap = 5;
            // was 4 but the PCAN dongle is thicker

//-------- here the used functions from other modules, because the cutomizer does not support imports
// holes for screws
module polyhole(h, d) { /* Nophead's polyhole code */
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}
// This module creates the shape that needs to be substracted from a cube to make its corners rounded.
module createMeniscus(h,radius){
    difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
        translate([radius/2+0.1,radius/2+0.1,0]){
            cube([radius+0.2,radius+0.1,h+0.2],center=true);
        }
        cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
    }
}

// Now we just substract the shape we have created in the four corners
module roundCornersCube(x,y,z,r){
    difference(){
        cube([x,y,z], center=true);

        translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
            rotate(0) createMeniscus(z,r); // And substract the meniscus
        }
        translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
            rotate(90) createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
        }
        translate([-x/2+r,-y/2+r]){ // ...
            rotate(180) createMeniscus(z,r);
        }
        translate([x/2-r,-y/2+r]){
            rotate(270) createMeniscus(z,r);
        }
    }
}
//-------- end of functions from other modules

// Generates a standoff for mounting something e.g. a PCB
module standoff(outer_diam, inner_diam, height, hole_depth) {
	difference(){
		cylinder(r=outer_diam/2, h=height, $fn=50);
		translate([0,0, height - hole_depth]) polyhole(hole_depth + 1, inner_diam);
	}
}

// Generates a hollow cylindrical lip, quartered.
module cylindrical_lip(outer_diameter, height, wall_thickness) {
	difference(){
		cylinder(r=outer_diameter/2, h = height);
		//Core it out
		translate([0,0,-0.5])  cylinder(r=(outer_diameter/2) - wall_thickness, h = height+1);
		//Cut it into a quarter.
		//translate([-outer_diameter/2,0,-0.5]) cube([outer_diameter + 1, outer_diameter/2,height + 1]);
		//translate([0, -outer_diameter/2, -0.5]) cube([outer_diameter + 1, outer_diameter/2,height + 1]);
	}
}

db9screws = 25;         // zwischen den Schrauben
db9screwHole = 4;       // war 3
db9Abstand = db9y+db9Gap;    // gesamt mit dem Ausschnitt
db9Rand = 8;            // wo faengt der erste Ausschnitt an

pcbX = (countSubD9) * db9Abstand + db9Rand;  // dimension of enclosed PCB
pcbY = 35;				// Breite des Gehaeuses
pcbZ = 0;               // die Dicke der Platine (haben wir nicht)

module oneSubD9(){
    union(){
        cube([db9y,db9x,3]);
        dy = (db9screws-db9x)/2;
        translate([db9y/2,-dy,0]) cylinder(d=db9screwHole,h=3);
        translate([db9y/2,db9x+dy,0]) cylinder(d=db9screwHole,h=3);
    }
}

fasteningX = 10; // die Breite der Befestigung
module oneFasteningTab(sy,r){
    difference(){
        widthReal = fasteningX+2*r;    // wegen den Rundungen
        translate([-(fasteningX-r)/2,sy/2,wall_thickness/2])
            roundCornersCube(widthReal+r,sy,wall_thickness,r);
        hole_d = 6;
        translate([-fasteningX/2,sy/2,-.1]) cylinder(d=hole_d, h=wall_thickness+.2);
    }
}

screw_hole_dia = 2;  		// Diameter of the screws you want to use
module rounded_cube_case (generate_box = true, generate_lid = false)
{
	distPCBouterBottom =6;	 	// der Abstand der Unterseite der Platine vom Unterboden-Unterseite

	//Screw hole details
	corner_lip_dia = screw_hole_dia * 1.5;
	standoff_dia = screw_hole_dia+3;	// Durchmesser der Schraubenhalter, die Platinenbohrung ist 3mm
	lipHeight = total_height-2*wall_thickness-distPCBouterBottom+.5;	// die .5 sind ausgemessen

	distPCBouterSideX = wall_thickness+1;		// von der Platine seitlich zur Aussenkante, die Platine liegt an den Aussenwaenden an
	distPCBouterSideY = wall_thickness+.5;	    // der zusaetzliche Abstand kommt durch die runden Ecken

	//Case details (these are *outer* diameters of the case)
	sx = pcbX + 2*distPCBouterSideX; 			//X dimension
	sy = pcbY + 2*distPCBouterSideY;			//Y dimension
	r = 2.5;							        //the radius of the curves of the box walls.
	dDeckel=.2;                                 //clearance for the lid

	screw_head_dia = 4.5;		//Diameter of the screw head (for the recess)
	screw_head_depth = 1.0;		//Depth of the recess to hold the screw head

	// where are the screws for the lid?
	y1 = distPCBouterSideY+2+dDeckel;       //position seitlich
    y2 = sy - distPCBouterSideY-2-dDeckel;  //
    x1 = distPCBouterSideX+2+dDeckel;
    x2 = pcbX-dDeckel;
    screw_hole_centres = [
		[x1          , y1, 0]
		, [x1        , y2, 0]
		, [x2        , y1, 0]
		, [x2        , y2, 0]
		, [(x2+x1)/3*2 , y1, 0]
		, [(x2+x1)/3*2 , y2, 0]
		, [(x2+x1)/3 , y1, 0]
		, [(x2+x1)/3 , y2, 0]
	];

	if (generate_lid == true){
		translate([0, sy+10, 0])
		difference(){
			union(){
				//Create the top plate
                translate([sx/2, sy/2, wall_thickness/2]) roundCornersCube(sx,sy,wall_thickness,r);
				//Create the reinforcing lip.
                translate([corner_lip_dia,wall_thickness+dDeckel,wall_thickness])
                    cube([sx-corner_lip_dia * 2,wall_thickness,lipHeight]);
				translate([wall_thickness+dDeckel+.4,corner_lip_dia,wall_thickness])
					cube([wall_thickness,sy-corner_lip_dia*2, lipHeight]);
				translate([sx - wall_thickness*3-dDeckel+.4,corner_lip_dia, wall_thickness])
					cube([wall_thickness,sy-corner_lip_dia*2, lipHeight]);
				translate([corner_lip_dia,sy - wall_thickness*2-dDeckel,wall_thickness])
					cube([sx-corner_lip_dia * 2,wall_thickness,lipHeight]);	// long side

				//fit the reinforcing lip around the corner standoffs
				translate([0,0,wall_thickness]){
                    for (i = screw_hole_centres){
                        translate(i) cylindrical_lip(standoff_dia, lipHeight, .7);
                    }
                }
			}

			//the cutoffs for the SubD9 connectors
            for(lauf=[0:countSubD9-1]){
                translate([lauf*db9Abstand+db9Rand,(pcbY-db9x)/2+2.5,-.1]) oneSubD9();
            }
            //the holes for the screws for fixing the lid
            translate([0,0,-.1]) for(i = screw_hole_centres){
                translate(i) cylinder(d=screw_hole_dia+1,h=corner_lip_dia + wall_thickness+.5);
            }
		}
	}

	if (generate_box == true){
		totalLenght=sx;
        union() {
			if(withFasteningTab=="Yes"){
                oneFasteningTab(sy,r);
                translate([sx+fasteningX-4*r,sy,0]) rotate([0,0,180]) oneFasteningTab(sy,r);
                totalLenght = totalLenght+fasteningX;
            }
            difference() {
				// the outer box
				translate([sx/2, sy/2,total_height/2 ]) roundCornersCube(sx,sy,total_height, r);
				//cut off the 'lid' of the box
				translate([-0.1,-0.1, total_height - wall_thickness])
                    cube([sx+1,sy+1,wall_thickness + 1]);
				//hollow it out
				translate([sx/2, sy/2, total_height/2 + wall_thickness])
                    roundCornersCube(sx - (wall_thickness*2) , sy - (wall_thickness*2) , total_height, r);

                // hier wuerden eventuelle Ausschnitte kommen, haben wir aber nicht
			}

			//put in the pillars for the screws to go into.
			for (i = screw_hole_centres){
				translate([0,0,-0.1]) translate(i)
					standoff(standoff_dia, screw_hole_dia, distPCBouterBottom-pcbZ+wall_thickness,10);
			}
		}
        echo (str("---- the complete housing is ", totalLenght, "mm long ----"));
	}
}

if(part_to_print=="case"){
    rounded_cube_case(true, false);	//generate_case
} else if(part_to_print=="lid"){
    rounded_cube_case(false, true);	//generate_lid
} else {
    rounded_cube_case(true, true);
}
