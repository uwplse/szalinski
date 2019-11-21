// Sink Strainer - Drain Catch  (for Thingiverse Customizer)
// By Urban Reininger   around 2015-06-15
// Twitter: UrbanAtWork
// Thingiverse: http://www.thingiverse.com/UrbanAtWork/
//
// Original OpenSCAD file by Thingiverse user: HarlanDMii

use <utils/build_plate.scad>

build_plate(0);

// I am currently editing this document so if it doesn't work that is why... (Monday Afternoon)
Notice="This files is being worked on";
//Drain Diameter (bathtub 38, bathroom sink 28.5) - I don't think this works right...
diameter=83; //

// Like a "brim", A 0.2mm helper disk will be added to the bottom to help plate adhesion. It's easy to break off. 
HelperDisk = "yes"; // [yes,no]

// Choose from a hole in the center, or a type of handle post 
CenterOption = "Simple"; // [Hole,Ball,Simple (good for meshmixing),Fluted]

//

module mainBasket(){
    scale(diameter/36.25,[1,1,1]){
difference(){	// main drain basket
	union(){   
		intersection(){
		color ("green") cylinder(r1=35/2,r2=37/2,h=10,$fn=100);
		translate([0,0,12])
		color ("lime") sphere(19,$fn=100);
		}
		translate([0,0,10])
		cylinder(r1=37/2,r2=39/2,h=1.5,$fn=100);	
	} //end of union
                
	translate([0,0,20])                     //center main sphere
	color ("orange") sphere(35.5/2,$fn=200);
        
       difference(){                            // Urban Moved this outside of the for loop
	for (r=[0:40:359]){                     // this are the holes rotating around
		rotate(r)
	hull(){
           		translate([5,0,-8])
			rotate([0,90,0])
			cylinder(r1=.9,r2=3.75,h=28/2,$fn=45);
			translate([5,0,5])
			rotate([0,90,0])
			cylinder(r1=.9,r2=6.75,h=28/2,$fn=45);
		} //end of hull
	} //end of for loop
                translate([0,0,10])                                       //Urban moved this
		color ("silver") cylinder(r1=18.5,r2=19.5,h=1.5,$fn=45); // and Urban moved this too  
	} //end of difference cutting out holes
        
	if (CenterOption=="Hole"){
            difference(){
           color ("plum") cylinder(r=3.5,h=10,center=true,$fn=60);	 // Center hole
            }
        }//end of center hole. Should this be here???     
        
      }       // end of main difference
   } // end of main scale
}       // end module main basket

module postHourGlass(){
    scale(diameter/36.25, [1,1,1]){
    translate([0,0,8]) scale([2,2,2.5])
        difference(){
            translate([0,0,0])
            color ("beige") cylinder(r=2,h=5,center=true,$fn=60);
            rotate_extrude(convexity = 10, $fn = 100)
            translate([3, 0, 0])
            circle(r = 2.4, $fn = 100);
        }
    }//end scale of post
} // end postHourGlass

  if(HelperDisk=="yes"){
	color ("green") cylinder(r=diameter/2.3,h=0.2,center=true,$fn=60);	 // Helper Disk on Bottom for easier printing adhesion.
    }    
//==============   
//Center Posts  ===================================
//==============    

module postTaper(){
 hull(){
    translate([0,0,5])
    color ("plum") cylinder(r=1.5,h=5,center=true,$fn=60);	 // Center hole
    translate([0,0,15])
    color ("LightBlue") cylinder(r=3,h=5,center=true,$fn=60);
    translate([0,0,10])
    color ("beige") cylinder(r=2,h=5,center=true,$fn=60);
 } 
} // end postTaper

module postStraight(){
    union(){
     mainBasket();
     scale(diameter/36.25, [1,1,1]){
     translate([0,0,10])
    color ("plum") cylinder(r=1.5,h=15,center=true,$fn=60);
     }
    } // end postStraight
}
module ring(){
rotate_extrude(convexity = 8, $fn = 100)
translate([5, 0, 0])
circle(r = 1, $fn = 100);
}

module postBall(){   //Ball Handle
translate([0,0,15])
   color ("orange") sphere(4,$fn=50);
}

if (CenterOption=="Fluted"){
    postHourGlass();
} 

if (CenterOption=="Ball"){
    postBall();
    }
    
if (CenterOption=="Simple"){
        postStraight();
  }

//if (CenterOption=="Hole,Ball,Simple,Fluted"){ }
 

 