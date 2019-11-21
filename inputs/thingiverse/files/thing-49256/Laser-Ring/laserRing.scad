
fingerWidth = 18; 
// your button cell's diameter.  (LR44 is 11.5)
batteryWidth = 11.5;  
// your button cell's height.  
batteryHeight = 5.6; 	
// need about 5 volts to work a laser, usually 3 batteries should do it.
batteryCount = 3; 		
// laser module's diameter
laserWidth = 7.08; 	
// laser modules length
laserHeight = 14;		
// how thick the walls are
thickness= 2.5;

batterySlot  = batteryHeight *batteryCount;
ringLength = (batterySlot) +( laserHeight+ thickness*2 );

translate([0,0,ringLength ] ) rotate([180, 0, 0]) laserRing();

module laserRing(){

	
	difference(){
		linear_extrude(height = ringLength) {
			face();
		}
		
		//battery slot
		translate([fingerWidth/2 + batteryWidth/2 +thickness  ,0,thickness]){
			cylinder(r = batteryWidth/2,  h = batterySlot  );
		
		}
		translate([fingerWidth/2 +batteryWidth/2 + thickness*2   ,0,thickness+ batterySlot/2]){
				cube([batteryWidth/2, batteryWidth*2, batterySlot], center=true);
			
		}
		//Laser Slot
		translate([fingerWidth/2 + batteryWidth/4 +thickness*1.5,0 ,thickness*2 +batterySlot  ]){
			cylinder(r=laserWidth/2, h =laserHeight );			
		}
		translate([fingerWidth/2 + batteryWidth/4 +thickness*1.5  ,0,thickness+batterySlot ]){
			cylinder(r=laserWidth/2-1, h =laserHeight +thickness);			
		}
		
		//
		translate([-(ringLength * .6)/2 - fingerWidth/2, 50, 0] ) rotate([90, 0, 0])
		cylinder(r = ringLength * .8, h = 100);
		
	}
	//support
	translate([fingerWidth/2 +batteryWidth/2 + thickness*2+ .8, 0, thickness+ batterySlot/2])
		cube([.9, batteryWidth/2 +thickness*2+.9, batterySlot], center = true) ;
}

module face(){

	difference(){
		hull(){	
			circle(r = fingerWidth/2 + thickness)  ;
			
			translate([ fingerWidth/2 + thickness/2, -(batteryWidth )/2, 0])
			square([batteryWidth/2 +thickness*2, (batteryWidth )]);
		}
		circle(r = fingerWidth/2);	
		translate([-fingerWidth/2, 0, 0]){
			square([fingerWidth,fingerWidth*.25], center = true);
		}
		
	}

}