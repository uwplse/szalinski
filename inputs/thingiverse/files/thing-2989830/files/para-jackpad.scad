//Begin of user adjustable parameters...

//These parameters are defaulted for the... 
//Harbor Freight 1.5 ton jack.
//Adjust for your jack accordingly.
jackpad_bot_dia=83.5;
jackpad_top_dia=105;
jackpad_bot_height=6.3;

//This is the thickness of the top cylinder.
//If you are adding slots make sure this is "thicker"
//than the slot(s) height(s)
//For no slots I set this to 9
jackpad_top_height=15;

//set these to zero if you want just a flat top
//set channel_1 width/height for a single slot
//set channel_2 width/height for a cross slot
channel_1_width=8;
channel_1_height=8;
channel_2_width=8;
channel_2_height=8;

//End of user adjusted parameters...


jackpad_bot_rad=jackpad_bot_dia / 2.0;
jackpad_top_rad=jackpad_top_dia / 2.0;
    
difference(){    
union(){
	translate([0,0,(jackpad_top_height/2.0)]) {
        cylinder (h = jackpad_top_height, r=jackpad_top_rad, center = true, $fn=200);
        }
	translate([0,0,-(jackpad_bot_height/2.0)]) {
        cylinder (h = jackpad_bot_height, r=jackpad_bot_rad, center = true, $fn=200);
        }
     }  

union(){        
    translate([0,0,(((jackpad_top_height/2.0)-(channel_1_height/2.0))+(jackpad_top_height/2.0))]) {
        cube ([channel_1_height,(jackpad_top_dia+10),channel_1_height], center = true);
        }   
    translate([0,0,(((jackpad_top_height/2.0)-(channel_1_height/2.0))+(jackpad_top_height/2.0))]) {
        cube ([(jackpad_top_dia+10),channel_2_width,channel_2_height], center = true);
        }  
     }  
}