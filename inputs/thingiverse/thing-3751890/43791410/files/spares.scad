//**************************************
// Spares for Torqeedo 1103 outboard motor
// The two key parts are the battery lock pin
// and the deadman key
//
// July 2019
// Dan Freedman dan@done-that.com

// both sets are here in one file 
//********************************************************
// Battery or deadman key for Torqeedo 1103 outboard motor
// select part to make set by setting to 1
    make_key = 1;
    make_pin = 0;
    
    
    // radious of battery pin
    radius  = 4.7;
    //lenght of pin
    lenghtrod = 225;
    //pin  base (head)
    headw   = 11.2;
    headl   = 35.4;
    headd   =   20;
    //lockinh key
    keyw    = 6.8;
    keyl    =   12.8;
    keyd    =   20;
    keyoffset = 9.85;
    // slot at end of pin
    slot_size = [20,3.5,14];
    slot_loc  = [0,4.8,212];
    //pin rope hole location
    hole_loc  = [0,14,6];
    half_key_thick = 3.37;
    //magnet dia
    mag_size   = 8.;
    //magnet thickness
    mag_height = 3.0;
    // deadmankey rope size
    rope_size = 4.0 ; //mm thick
    //magnet center
    mag_hole_depth = half_key_thick-(mag_height/2);
    mag_offset =[0,0,mag_hole_depth];
    
    
//******************************************************
//Battery lock down pin componets
// Basic pin
module key()
    {
        union() {
            cube( [headw,headl,headd],center=false);
            translate([5.5,(headw-radius),0]) cylinder( lenghtrod,radius,radius);
            translate([2.5,19,0]) cube( [keyw,keyl,keyd+headd],center=false);
        }      
 
    }   
// Hole for tie rope
module hole()
    {  
     translate (hole_loc) {
        rotate ([0,90,0])
            cylinder (12,3,3);
     }
 }
 
// Cut slot for end of pin
 module slot()
    {
     translate (slot_loc) {
        cube (slot_size,center=false);
     }
    }
//*****************************************************
// deadman key componets
module deadmankey()
    {
        // frame for deadman key
        hull () {
           cylinder ( half_key_thick,15,15);
           translate( [-30,-9,0]) cube ([24.3,20,half_key_thick]);
        }
                  
    }
    // hole for mag for deadman key
 module mag_hole()
    {
        translate (mag_offset)cylinder ( mag_height/2,mag_size,mag_size);
    }   
    // slot for rope deadman key
module rope_slot() 
        {
           // using 4mm rope  
           slot_depth =  half_key_thick - (rope_size/2);
           translate ( [-26,-11,slot_depth]) cube([rope_size/2,29,3]);
        }


//********************************************************
// Main Execution step        
if (make_key==1) {
    // assemble the deadman key blocks
        difference() { 
            deadmankey();
            mag_hole();
            rope_slot();
        }
    }      
        
 
if (make_pin==1) {
    // assemble the battery lock pin
        difference() { 
            key();
            hole();
            slot();    
        }                    
}           
   