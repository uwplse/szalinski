/*******************************************************
 PVC plug
v1.0 by Cpayn3d  Sept 2017  
*******************************************************/

// preview[view:south, tilt:top]

/* [Plug Neck] */
// - diameter of the plug neck
PlugDiam = 26; //[6:100]

// - plug Smoothness
PlugFacets = 60; //[25:100]

// - neck Height
PlugHeight = 10; //[6:50]

// - neck wall thickness
PlugWall = 2; //[1:10]  

//--------------------------------

// - diameter of the shoulder
PlugShDiam = 35; //[6:140]  

// - shoulder smoothness
ShFacets = 60; //[25:80]

// - shoulder height
PlugShHeight = 3;    //[1:10]   

// - diameter of drain hole
DrainHoleDiam = 0;  //[0:50]


partlayout(); 


module partlayout() {      
difference() {
// primary body
union() {
    
cylinder(h=PlugShHeight, r=PlugShDiam /2, $fn=ShFacets); // plug shoulder 
translate([0, 0, PlugShHeight]) cylinder(h=PlugHeight, r=PlugDiam /2, $fn=PlugFacets); // plug neck 

} // end union    
 
    

// diff section
union() {
translate([0, 0, PlugShHeight+0.5]) cylinder(h=PlugHeight +1, r=(PlugDiam-PlugWall) /2, $fn=PlugFacets); // plug inner cutout 

translate([0, 0, -1]) cylinder(h=PlugShHeight +2, r=(DrainHoleDiam) /2, $fn=ShFacets); // drain hole 
 
  }  // end diff union
 } // end diff
} // end module - parts layout
  
  