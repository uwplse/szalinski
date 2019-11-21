//////////  FLESHLIGHT MOLD GENERATOR by Castomized
//////////  more projects at www.castomized.com

//////////  HOW DOES IT WORK?

//  Adjusts the parameters of the FLESHLIGHT BODY
//  Adjusts the parameters of the INNER SHAPE
//  Adjusts the parameters of the MOLD
//  Make sure the inner shape not come out from the fleshlight body!
//  After any change press F5 to see the changes
//  When you're satisfied with the result press F6 and export the model as STL (it might take a while)


////////////////////VIEW

view = "MODEL";              // Write MODEL in the design phase and MOLD A or MOLD B before press F6 to export the molds as STL


////////////////////PARAMETERS

//////////FLESHLIGHT BODY

inner_hole = 10;            // Minimum size of the central hole

outer_diameter = 60;        // Outer diameter of the sextoy

length = 100;               // Lenght of the sextoy

smooth = 15;                // Top and bottom chamfer

resolution = 30;            // More ressolution more rendering time (a value of 100 may take up to 2 hours)            


//////////INNER SHAPE

branch_numbers = 6;         // Number of slots

branch_length = 16;         // Lenght of slots

rotation = 260;             // Angle of rotation

softness = 3;               // Rounding of the slots

taper = 0.6;                // Shrinkage of one end


//////////MOLD

thickness = 2;              // Wall thickness

casting_hole = 8;           // Size of the hole for casting


////////////////////CODE

//////////CAUTION, modify this section only if you know what you are doing!!!

$fn = resolution;

module hole() {

    linear_extrude(height = length*1.1, center = true, twist = rotation, slices = resolution, scale = taper) {

        offset(r = -softness)
        offset(r = softness)

        union () {
               
            for(i = [1 : branch_numbers/2])
                
            rotate ([0,0,i*360/branch_numbers]) 

            offset(r = softness)
            offset(r = -softness)
                
            square(size = [branch_length*2, inner_hole/1.5], center = true);

        }   

    }

}


module fleshlight_body() {
 
    difference () {
    
        minkowski() {   
            
        cylinder (d = outer_diameter-smooth, h = length-smooth, center = true);

        sphere ( d = smooth);    

        }
       
       hole (); 
   
    } 
    
}


module moldA() {
  
    difference () {    
        
        cylinder (d = outer_diameter+thickness*2, h = (length/2)+thickness);
          
        fleshlight_body(); 
        
        translate ([casting_hole/2+branch_length*taper+thickness*2*taper,0,length/3])
       
        cylinder (d = casting_hole, h = casting_hole*3); 
        
        cylinder (d = inner_hole*1.05, h = inner_hole, center = true);
        
        translate ([0,-outer_diameter/2-thickness,0])

        cube([thickness,thickness,thickness*4],true);
      
    }  
    
}


module moldB() {

    union () {
        
        difference () {    
          
            translate ([0,0,-length/2-thickness])
                
            cylinder (d = outer_diameter+thickness*2, h = (length/2)+thickness);
                      
            fleshlight_body();
             
            translate ([0,-outer_diameter/2-thickness,0])

            cube([thickness,thickness,thickness*4],true);   
          
        }

        cylinder (d = inner_hole, h = inner_hole, center = true);

    }
    
}


////////////////////RENDER

if (view == "MODEL") { 
    
    translate ([-outer_diameter,0,length/2])
    rotate ([180,0,0])
    fleshlight_body();
        
    translate ([outer_diameter,0,length/2])
    hole();
        
    rotate ([0,180,0])
    translate ([0,-outer_diameter,-(length/2)-thickness])
    rotate ([0,0,180])
    moldA();

    translate ([0,outer_diameter,(length/2)+thickness])
    moldB();

}


if (view == "MOLD A") {
 
    rotate ([0,180,0])
    translate ([0,0,-(length/2)-thickness])
    moldA();    

}


if (view == "MOLD B") {
 
    translate ([0,0,(length/2)+thickness])
    moldB();  

}

// This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 
// 3.0 Italy License. To view a copy of this license, 
// visit http://creativecommons.org/licenses/by-nc-nd/3.0/it/ or send a letter to 
// Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

