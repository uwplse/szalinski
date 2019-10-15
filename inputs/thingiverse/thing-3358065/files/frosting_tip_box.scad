//
// With this script you can generate a icing tip box
// and lid for a custom number of tips. The lid can either be a simple lid, 
// or aa logo lid. A logo lid will require some work within your slicer to add the 
// logo, but the box and the lid base can be generated from this script.
//
// To customize the size, change the number of rows or columns to meet you needs
//
// If you want a logo lid set the inset_logo_lid to true, otherwise leave it false
//
// When you are ready, set the make_box variable to true to make the box then 
// set it to false to make the lid.
//
/////////////////
//  Making a Logo/Name Lid
/////////////////
// I have use Cura, so the instructions for a logo lid below are for that software.
// 
// 1) Get a logo in jpg format. If you don't have one you could make a lid
//    with someone's name either by using a graphics editing program or by writing
//    their name in a word processor and using screen capture software like the 
//    Windows snipping tool to cut it out. 
// 2) After opening Cure, make sure you can stack object in Cura by turning off the
//    Automatic drop model to the build plate setting which can be found by going to 
//    Preference -> Configure Cura then unchecking the option in the General section.
// 3) Open the blank lid you generated
// 4) In the same project, open your logo and make sure the size will fit on the lid 
//    by setting the Width and depth walues correctly, you can check the size of the
//    lid blank by clicking on it then selecting resize. Once the size is correct set
//    The height of the logo to 8 and base to 0.
// 5) Select the logo and move it into place by clicking the move icon and setting
//    x=0,y=0,z=2
// 6) If you want it multi-color, then prior to exporting the gcode, enable pausing 
//    from the menu by clicking Extensions -> Post Processing -> Modify G-code. Click 
//    the Add a script drop down and select Pause at height. The Pause height should 
//    be 2.3 and set the Standby Temperature to 185 to make removing the old filament
//    easier. 
//  
// You should be nore ready to eport you G-code.
////////////////////////////////////////////////
// Values you can change to customize the box //
////////////////////////////////////////////////
// Change the rows and columns values for your box
rows=4;
columns=4;

inset_logo_lid=true; // Set to true for a logo inset lid, otherwise it is just a 
                      // standard inset lid
logo_height=8; // This value can be changed based on your need. I use an 8mm logo
               // with a 2mm base so the logo can be used as a handle to remove the 
               // lid.

make_box=false; // Change to false to make the lid or logo lid base
                     

///////////////////////////////
// End Values you can change //
///////////////////////////////
lid_height=2;
box_width=rows*22 + 26;
box_length=columns*22 + 26;
// if using a logo lid add space for logo
box_height=(inset_logo_lid)?48:40;
rim_height=(inset_logo_lid)?box_height-lid_height-logo_height:box_height-lid_height;
    
wall_width=3;

//////////
// Main
//////////
if (make_box) {
    Box(box_width,box_height,wall_width,rim_height);

    for (row=[1:rows]) {
      for (column=[1:rows]) {
        TipHolder(2+ 22*row,2+ 22*column,3);
      }
  }
} else {
    // generate lid
    Lid(box_width,box_length,lid_height,inset_logo_lid);
}

//////////////
// End Main
//////////////


/////////////
// modules
/////////////
module Box(bw,bh,ww,rh) {
   difference() {
     translate([0, 0, 0])
       cube([bw,bw, bh], center = false);
    
    translate([2*ww,2*ww,ww])
      cube([bw-4*ww,bw-4*ww, bh], center = false);

    translate([ww,ww,rh])
      cube([bw-2*ww,bw-2*ww, bh], center = false);
}   
    
}
module TipHolder(x=0,y=0,z=0) {
   cone_base=14;
   cone_height=cone_base*1.95;

   difference () {
     translate([x,y,z])
       cylinder(h=cone_height, r1=cone_base/2, r2=0);
    
     translate([x-7,y-7,cone_height*.7+z])
       cube([cone_base,cone_base,cone_height*.3]);
   }
   translate([x,y,cone_height*.7+z])
     sphere(r=((cone_base/2)*(cone_height * .3)/cone_height),$fn=20); 
    
}

module Lid(bw,bl,lh,inset_logo_lid) {
    difference() {
      translate([0, 0, 0])
        cube([bw-7.5,bl-7.5, lh], center = false); 
      if (!inset_logo_lid) {
        translate([(bw-7.5)/2, (bl-7.5)/2-15, 0])
          cylinder(r = 10, h=4, center = true);           
        
        translate([(bw-7.5)/2, (bl-7.5)/2 + 15, 0])
          cylinder(r = 10, h=4, center = true);           
        }
    }
}
