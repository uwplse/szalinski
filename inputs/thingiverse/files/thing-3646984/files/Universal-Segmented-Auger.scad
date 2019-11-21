//*-----------*
//| Variables |
//*-----------*

$fn = 200;
segment_height=150;
shaftOD = 20;// Must be less than flightOD
shaftID = 10; //0 for solid. Must be less than shaftOD
flightOD = 200;
flight_width = 10; //fight "width" also controls overall flight thickness.
pitch_mod=0;    //max pitch=shaftOD/2 - flight_width/2; this is barely touching the shaft

pinhole_diameter=4;
pincap_width=5;

//*------*
//| Main |
//*------*
augerpiece();
//translate([0,0,segment_height/2]) rotate([0,0,180]) augerpiece();
//translate([0,0,segment_height]) augerpiece();


module augerpiece() {
	difference() {
		union() {
			linear_extrude(height=segment_height, center=false,twist=360) 
                //makes the 'flight'
                union(){    
                    translate([0,-flight_width/2+pitch_mod,0])
                        square([flightOD/2-flight_width/2,flight_width]);
                    translate([flightOD/2-flight_width/2,pitch_mod,0])
                        circle(d=flight_width);
                }
            //makes the shaft
			cylinder(d=shaftOD,h=segment_height); 
		}
        //makes the unit a half section
		translate([0,-125,-1]) cube([250,250,250]);    
        
        // make insides hollow        
		translate([0,0,-1])cylinder(d=shaftID,h=segment_height+2);
        
        //top hole
		translate([0,0,segment_height*.75]) rotate([0,-90,0]) cylinder(d=pinhole_diameter,h=shaftOD);  
        
        //bottom hole
		translate([0,0,segment_height*.25]) rotate([0,-90,0]) cylinder(d=pinhole_diameter,h=shaftOD);
        //top hex recess. Cannot exceed wall thickness OR (OD-ID)/2
        translate([-shaftOD/2-0,0,segment_height*.75]) rotate([0,90,0]) cylinder(d=pinhole_diameter+2,h=2, $fn=6); 
        //bottom hex recess. Cannot exceed wall thickness OR (OD-ID)/2
        translate([-shaftOD/2-0,0,segment_height*.25]) rotate([0,90,0]) cylinder(d=pincap_width+2,h=2, $fn=6);   
	}

}



//*----------------------*
//| Improvements to make |
//*----------------------*
/*
1.Add hole size and type selector, possibly use snap pins also
2.Selection for solid vs hollow and shaft size selctor
3.Add end connectors option as well, place as to not interfere with the pin holes
4.Add option for "end" pieces where the difference cube is translated so the flights carry to the top/bottom
    a. Basicaly use the difference cube on the opposite half, and stop the twist at 90+ degrees AND half the extrusion height (half of segment height
5. Add option for reverse twist. 
    a. Using mirror? Twist is always "left hand"
*/
 