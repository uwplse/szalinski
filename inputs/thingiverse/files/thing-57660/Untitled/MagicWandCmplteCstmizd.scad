



////////// Magic Wand //////////////////////
////////////by: Mario The Magician////////////////////
/////////////www.mariothemagician.com/////////////////////


//////////Magic Wand Tips///////////////////////
tip_length = 50; // [15:50] 
///////////////////////////////////////////////

//////////////////Center of Wand/////////////////
wand_center = 230; // [30:230] 
////////////////////////////////////////////////



//Magic Wand tip
translate([0,32.5,0])
rotate([90,0,0]) {
rotate([0,0,22.5]) {

union() {
cylinder(r=6,tip_length,$fn=8); // outer end
translate([0,0,tip_length]) // keeps inner dowel attached while sizing
cylinder(r=3,h=15,$fn=50); // inner end
       
      }
translate([20,-8,0])
union() {
cylinder(r=6,tip_length,$fn=8); // outer end
translate([0,0,tip_length]) // keeps inner dowel attached while sizing
cylinder(r=3,h=15,$fn=50); // inner end
       
      }
  
   }

}


translate([0,50,0])
translate([-115,0,0])
rotate([0,90,0])

difference() {
translate([0,0,10])
cylinder(r=6,wand_center,$fn=8); // Center of Wand
cylinder(r=3.5,h=250,$fn=50); // inner hole

}





