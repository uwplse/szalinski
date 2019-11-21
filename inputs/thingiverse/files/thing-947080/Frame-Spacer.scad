frame_width = 28; // Width of frame if looked from the size (normally 25mm or 28mm)
frame_wood_thickness = 10; // Width of frame if looked from the front (normally 8 to 10mm)
spacer_height = 5; // Overall height of spacer (5mm worked good) 
spacer_overhang = 2; // Length of "holding clip" to securly attach the spacer at the inner side of the frame
material_thickness = 1.5; // Thickness of spacer (the thicker the stronger (but less flexibel))
beespace = 8; // Normally 8mm (for a frame that has a width of 28mm) -> Change accordingly if you use other frame widths or different beespaces
nipple_thickness = 4; // Witdh of spacer nipple if looked from the front (3-4 mm have been useful)

/* [Hidden] */
//production_variance = 0.1; //not used so far
padding = 0.1; //do not change (used to eliminate zero space surfaces)
$fa=0.5;
$fs=0.5;

module framespacer (){

difference (){
    cube ([frame_width+(2*material_thickness), spacer_height, frame_wood_thickness+(2*material_thickness)]);
    
    translate ([material_thickness,-padding,material_thickness]) cube([frame_width,spacer_height+(2*padding),frame_wood_thickness]);
    translate ([material_thickness+spacer_overhang,-padding,material_thickness+frame_wood_thickness-padding]) cube([frame_width-(2*spacer_overhang),spacer_height+(2*padding),2*material_thickness]);
  }
   union () {
    translate ([frame_width+(2*material_thickness), 0, (((2*material_thickness)+frame_wood_thickness)/2)-(nipple_thickness/2)]) cube([beespace-material_thickness,spacer_height,nipple_thickness]);
    }

}

framespacer();



