/*
  Through hole tactile switch based on CTS 222A tactile switch
  http://www.mouser.com/ds/2/96/222A-531986.pdf

  Aaron Ciuffo (txoof) 

  23 December 2015

  Released under GPL V3

  TODO: 
    * add vertical and horizontal mount variants
    * add legs

*/

/* [Switch Dimensions] */
switchBase = [6.2, 6.2, 3.3]; // X, Y, Z dimensions of base
switchButtonDia = 3.5; // button diameter
switchButtonZ = 4.3; // total height of button
buttonStandoffZ = 0.5; // standoffs above the height of the base
buttonStandoffX = 4.6; // diameter of standoffs

/* [options] */
// center around the volume of the base, or place at the positive origin
center = false; // [true,false] 

// add "spear" to make locating easier
locate = false; // [true,false]

module tactileSwitch(locate = false, center = false) {
  $fn = 36;
  // center around the volume of the base or move so base sits at origin
  trans = center == false ? [0, 0, switchBase[2]/2] : [0, 0, 0];

  translate(trans) // move the object to the location set above
  union() {
    color("darkslategray")
      cube(switchBase, center = true);
    translate([0, 0, switchBase[2]/2])
      color("darkgray")
      cylinder(r = switchButtonDia/2, h = switchButtonZ, center = true);
    translate([0, 0, buttonStandoffZ/2])
      color("silver")
      cylinder(r = buttonStandoffX/2, h = switchBase[2] + buttonStandoffZ, center = true);
    if(locate) {
      color("red")
      cylinder(h = switchButtonZ* 20, r = .1, center = true);
    }
  }

}

tactileSwitch(locate = locate, center = center);
