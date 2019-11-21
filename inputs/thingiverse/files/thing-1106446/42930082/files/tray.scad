//////////////////////////////////////////////////////////
//                                                      //
//      Trays for Warmachine / Hordes Figures           //
//      New Version! now with customizer.               //
//                                                      //
//////////////////////////////////////////////////////////

//CUSTOMIZER VARIABLES

/* [Lanes] */

// The overall width is the sum of all lane widths. Consider extra spacing if you have models that hang over the base. I added modification parameters in mm if you want to customize your results. Different printers and slizers can show different results.
// Missing a game system? Just PM me the right shape / size and I'll add it.

// Lane 1 - Type
lane1 = "30mm_Privateer_Press";  // [30mm_Privateer_Press,40mm_Privateer_Press,50mm_Privateer_Press]
// Lane 1 - Width
lane1_space = 40;
// Lane 1 - Horizontal modifier
lane1_hmod = 0.0;
// Lane 1 - Vertical modifier
lane1_vmod = 0.0;

// Lane 2 - Type
lane2 = "40mm_Privateer_Press";  // [30mm_Privateer_Press,40mm_Privateer_Press,50mm_Privateer_Press,none]
// Lane 2 - Width
lane2_space = 50;
// Lane 2 - Horizontal modifier
lane2_hmod = 0.0;
// Lane 2 - Vertical modifier
lane2_vmod = 0.0;

// Lane 3 - Type
lane3 = "50mm_Privateer_Press";  // [30mm_Privateer_Press,40mm_Privateer_Press,50mm_Privateer_Press,none]
// Lane 3 - Width
lane3_space = 60;
// Lane 3 - Horizontal modifier
lane3_hmod = 0.1;
// Lane 3 - Vertical modifier
lane3_vmod = 0.1;

// length
tray_length = 150;
// height
tray_height = 7;

/* [Options] */

// Hexagon cutouts in bottom to save Material. Might be a problem on printers/materials with adheason problems
cutouts     = true; 	// [true, false]

// Block at the end of the tray to stop miniatures
endstop     = 0; 	// [5:thick, 2:thin, 0:none]

// Small Holes on one side to allow joining together multiple elements
jointholes  = "both_sides"; 	// [none, one_sided, both_sides]
jointhole_diameter = 1.8;



//CUSTOMIZER VARIABLES END


//////////////////////////////////////////////////////
//  CUSTOMIZEABLE TRAY                                                   

color("darkgrey") custom_tray();

module custom_tray()
	{
	difference ()
		{
		union()
			{	
			// Lanes		
			custom_lane(lane1, lane1_space, lane1_hmod, lane1_vmod);
			
			if (lane2 != "none") 
				{
				translate([lane1_space,0,0])
					custom_lane(lane2, lane2_space, lane2_hmod, lane2_vmod, 0.1);
				}

			if (lane3 != "none") 
				{
				translate([lane1_space+lane2_space,0,0])
					custom_lane(lane3, lane3_space, lane3_hmod, lane3_vmod, 0.1);
				}

			}		
		
		// Jointholes

        if (jointholes == "both_sides")
            {
            translate([2,10,tray_height/2]) 
                rotate([90,0,0]) 
                cylinder($fn=32,r=jointhole_diameter/2,h=11);
            if (lane2 != "none") 
                {       
                translate([lane1_space,10,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=1,h=11);    
                }
            else
                {
                translate([lane1_space-2,10,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);                    
                }
                
            if (lane3 != "none") 
                {       
                translate([lane1_space+lane2_space,10,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);    
                    
                translate([lane1_space+lane2_space+lane3_space-2,10,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);                   
                }
            if (lane3 == "none" && lane2 != "none") 
                {
                translate([lane1_space+lane2_space-2,10,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);                    
                }            
                
            }
            
        if (jointholes != "none")
            {
            translate([2,tray_length+1,tray_height/2]) 
                rotate([90,0,0]) 
                cylinder($fn=32,r=jointhole_diameter/2,h=11);
            if (lane2 != "none") 
                {       
                translate([lane1_space,tray_length+1,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=1,h=11);    
                }
            else
                {
                translate([lane1_space-2,tray_length+1,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);                    
                }
            if (lane3 != "none") 
                {       
                translate([lane1_space+lane2_space,tray_length+1,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);    
                    
                translate([lane1_space+lane2_space+lane3_space-2,tray_length+1,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);                   
                }
            if (lane3 == "none" && lane2 != "none")
                {
                translate([lane1_space+lane2_space-2,tray_length+1,tray_height/2]) 
                    rotate([90,0,0]) 
                    cylinder($fn=32,r=jointhole_diameter/2,h=11);                    
                }            
                
            }            
            
        }   
	}

module custom_lane(type, space, hmod, vmod, extrasize=0)
	{
	difference()
		{
		translate([-extrasize,0,0])
			cube([space+extrasize, tray_length, tray_height]);
		
		// cutouts for models
			
		if (type == "30mm_Privateer_Press")
			{
            
            // Parameters for cutout    
            d=31;
            d2=27;
            h1=5;    
            
            // Lane Cutout    
			translate([space/2,endstop-0.01,1.5]) 
				cutout(d,d2,h1,tray_length+0.02,vmod,hmod);
            
            // Hexagonal cutouts
			if (cutouts == true) 
                {
				for (i=[0:12:tray_length-20.5]) {
					//center
					
					translate([+space/2,+12+i,-18])
							cylinder($fn=6, r=5, h=20); 
					
					if (i < tray_length-15-10) 
						{
						translate([space/2+10,+18+i,-18]) 
							cylinder($fn=6, r=5, h=20);
						translate([space/2-10,+18+i,-18]) 
							cylinder($fn=6, r=5, h=20);
					
						}
					}            				
				}
			}
		if (type == "40mm_Privateer_Press")
			{
            // Parameters for cutout    
            d=41;
            d2=37;
            h1=5;                
             
            // Lane Cutout    
			translate([space/2,endstop-0.01,1.5]) 
				cutout(d,d2,h1,tray_length+0.02,vmod,hmod);
            
            // Hexagonal cutouts            
			if (cutouts == true) 
                {
				for (j=[0:12:tray_length-20.5]) {
					//center
					
					translate([+space/2,+12+j,-18])
							cylinder($fn=6, r=5, h=20); 
					
					if (j < tray_length-15-10) 
						{
						translate([space/2+10,+18+j,-18]) 
							cylinder($fn=6, r=5, h=20);
						translate([space/2-10,+18+j,-18]) 
							cylinder($fn=6, r=5, h=20);
					
						}
					}            				
				}                
			}
		if (type == "50mm_Privateer_Press")
			{
            // Parameters for cutout    
            d=51;
            d2=47;
            h1=6;           
             
            // Lane Cutout    
			translate([space/2,endstop-0.01,1.5]) 
				cutout(d,d2,h1,tray_length+0.02,vmod,hmod);
            
            // Hexagonal cutouts       
			if (cutouts == true) 
                {
				for (k=[0:12:tray_length-20.5]) {
					//center
					
					translate([+space/2,+12+k,-18])
							cylinder($fn=6, r=5, h=20); 
					
					if (k < tray_length-15-10) 
						{
						translate([space/2+10,+18+k,-18]) 
							cylinder($fn=6, r=5, h=20);
						translate([space/2-10,+18+k,-18]) 
							cylinder($fn=6, r=5, h=20);
					
						}
					
                    translate([+space/2+20,+12+k,-18])
							cylinder($fn=6, r=5, h=20); 
					
                    translate([+space/2-20,+12+k,-18])
							cylinder($fn=6, r=5, h=20); 
					} 					     
                    
				}

			}
		}
	}

//////////////////////////////////////////////////////
//  BASIC MODULES                                        

module cutout(d, d2, h1, length,vmod=0,hmod=0)
    {
    mirror([0,1,0])
    rotate([90,0,0])
    linear_extrude(length)
        polygon(points=[
            [d/2+hmod,0],
            [d/2+hmod,h1-d/2+d2/2+vmod],
            [d2/2+hmod,h1+vmod],
            [d2/2+hmod,h1+5*h1],
            [-d2/2-hmod,h1+5*h1],        
            [-d2/2-hmod,h1+vmod],
            [-d/2-hmod,h1-d/2+d2/2+vmod],
            [-d/2-hmod,0],
            ]);
    }