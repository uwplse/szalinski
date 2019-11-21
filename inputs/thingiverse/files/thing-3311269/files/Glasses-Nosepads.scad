//Parametric nose pads for glasses
//Adjust as needed, then print and hot glue!

//Quantity
quantity = 2;

// Legnth of pad, (mm)
pad_length = 12.0;
// Width of pad (mm)
pad_width = 8.0;
// Thickness of pad (mm)
pad_thickness = 2.0;

// Length of tad
tab_length = 4.0;
// Width of tab
tab_width = 2.0;
// Height of tab
tab_height = 2.0;

//Roundness (lower is faster to preview)
$fn=120;

translate([-3/4*(pad_width*(quantity-1)),0])
for(i=[0:quantity-1]){
     translate([6*i*tab_width,0]){
	  union(){
	       /* Create tab */
	       translate([0, 0, pad_thickness])
		    linear_extrude(tab_height)
		    square([tab_width, tab_length], center=true);
	       
	       /* Create Pad */
	       scale([pad_width/10, pad_length/10]){
		    translate([0,0,pad_thickness/2])
			 rotate_extrude()
			 translate([(10-pad_thickness)/2, 0])
			 circle(pad_thickness/2);
		    linear_extrude(pad_thickness)
			 circle(5-pad_thickness/2);
	       }
	  }
     }
}
