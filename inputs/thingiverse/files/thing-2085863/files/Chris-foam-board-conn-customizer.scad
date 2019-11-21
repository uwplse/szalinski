/*************************************************/
/* Foam board connectors Customizer Version v2   */
/* Two different sizes:                          */ 
/*   - Foam to Foamfor plywood                   */
/*   - Foam to plywood table top ( 7/16" )       */
/* By Cpayne3d - 2015/2019                       */
/* Creative commons - Non-Commercial Share Alike */
/*************************************************/

plywood_thick = 11 +0;         // plywood/tabletop thickness value ( 11mm = 7/16" )
foam_thick = 4.9 +0;           // foam board thickness value       ( 4.9mm = common foam board)

/* [Settings] */
// Width of Red side (def 5)
Red_Side_Width = 5;    //[3:20]   

// Width of Green side (def 5)
Green_Side_Width = 5;    //[3:20]   

// Customize the thickness (def 10)
Connector_Thickness = 10; //[2:25]

// Customize offset lengths (def 0)
Connector_Length_Offset = 0; //[0:5]

//rotate([0, 270, 0])
  custom_connector();


module custom_connector() {
armwid = 3;
translate([Red_Side_Width + armwid*2, 1, 0])     
difference() {
translate([0, 1, 1])
   union() {
       
//translate([0, 0, -(Red_Side_Width +7)])
translate([-(Red_Side_Width + armwid * 1.5 ), -0.25, 0])
color("Red") 
  minkowski() { 
   cube([Red_Side_Width + armwid*2, 25 + Connector_Length_Offset, Connector_Thickness]); // red cube
     rotate([0, 90, 0]) cylinder(h=1, r=1, $fn=20); 
    }

translate([0.5, -1, 0]) 
 color("Green")  minkowski() { 
   cube([25 + Connector_Length_Offset, Green_Side_Width +armwid*2, Connector_Thickness]); // green cube
   rotate([0, 90, 90]) cylinder(h=1, r=1, $fn=20); 
    }

 } // //end union


union() {
// translate([3.5, 3, -2]) 
 translate([-(Red_Side_Width + armwid/2.5), 3, -2]) 
  color("Red") cube([Red_Side_Width, 25 + Connector_Length_Offset, Connector_Thickness +armwid*2]);  // trim red core

 translate([armwid, armwid, -1]) cube([25 + Connector_Length_Offset, Green_Side_Width, Connector_Thickness +armwid*2]); // trim green core
 }  // end union

} // end difference

} // end module