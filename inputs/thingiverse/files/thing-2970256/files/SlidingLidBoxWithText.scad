Render_Box=1; // [1:Yes,0:No]
Render_Lid=1; // [1:Yes,0:No]

Compartment_Size_X = 50;	// Size of compartments, X
Compartment_Size_Y = 25;	// Size of compartments, Y
Wall = 2;		// Width of Wall
Number_of_Compartments_X = 2;		// Number of compartments, X
Number_of_Compartments_Y = 2;		// Number of compartments, Y
Depth = 15;		// Depth of compartments

// Tolerance around lid.  If it's too tight, increase this. If it's too loose, decrease it.
Tolerance=.13;

Rounded_outside = 1; // [1:Yes,0:No]
Rounded_outside_all = 0; // [1:Yes,0:No]
Rounded_inside = 1; // [1:Yes,0:No]

Lid_Type=1;	// [1:Sliding,0:Flat]
Lid_Height=5;

Include_Thumbhole=1; // [1:Yes,0:No]
Include_Coinslot=0; // [1:Yes,0:No]

Coinslot_X=20;	// US coinage (penny, nickel, quarter dime) in X direction
Coinslot_Y=2.5;	// swap values for slot in Y direction

Font_Size = 8; // [4:1:30]
Font_Size_Lid = 12; // [4:1:30]
Label = "Text Here";

/* [Hidden] */
ztolerance=0;
				// Z tolerance can be tweaked separately, to make the top of the sliding lid
				// be flush with the top of the box itself.  Default is zero.  Warning: this also
				// adds wiggle room to the lid, so !
lidoffset=3;		// This is how far away from the box to print the lid

// Font
font = "Arial:style=Bold";

totalheight = Depth + (Lid_Type*Wall);
thumbrad = min(20,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)/3);

if (Render_Box==1) {
difference() {
    
     if (Rounded_outside==1) {
         if (Rounded_outside_all==1) {
	   roundedcube ( size = [Number_of_Compartments_X * (Compartment_Size_X + Wall) + Wall, Number_of_Compartments_Y * (Compartment_Size_Y + Wall) + Wall, (totalheight + Wall)], center = false, radius = Wall, apply_to = "all", $fn=25);
             }
         if (Rounded_outside_all==0) { 
             roundedcube ( size = [Number_of_Compartments_X * (Compartment_Size_X + Wall) + Wall, Number_of_Compartments_Y * (Compartment_Size_Y + Wall) + Wall, (totalheight + Wall)], center = false, radius = Wall, apply_to = "z", $fn=25);
         }
     }
     
     if (Rounded_outside==0) {
	   cube ( size = [Number_of_Compartments_X * (Compartment_Size_X + Wall) + Wall, Number_of_Compartments_Y * (Compartment_Size_Y + Wall) + Wall, (totalheight + Wall)], center = false);
     }

         // Cut out text
   translate([(Compartment_Size_X*Number_of_Compartments_X+Wall*(Number_of_Compartments_X))/2+Wall,Compartment_Size_Y*Number_of_Compartments_Y+Wall*(Number_of_Compartments_Y+1)-0.5,Depth/2+Font_Size/2-Wall]) {
    rotate([90,0,180]) {
      linear_extrude(height = 1.1) {
        text(text = str(Label), font = font, size = Font_Size, valign = "center", halign = "center");
      }
    }
    }
    
    translate([(Compartment_Size_X*Number_of_Compartments_X+Wall*(Number_of_Compartments_X))/2+Wall,0.5,Depth/2+Font_Size/2-Wall]) {
    rotate([90,0,0]) {
      linear_extrude(height = 1.1) {
        text(text = str(Label), font = font, size = Font_Size, valign = "center", halign = "center");
      }
    }
    }
    
    translate([0.5,(Compartment_Size_Y*Number_of_Compartments_Y+Wall*(Number_of_Compartments_Y))/2+Wall,Depth/2+Font_Size/2-Wall]) {
    rotate([90,0,-90]) {
      linear_extrude(height = 1.1) {
        text(text = str(Label), font = font, size = Font_Size, valign = "center", halign = "center");
      }
    }
    }
    
    translate([(Compartment_Size_X*Number_of_Compartments_X+Wall*(Number_of_Compartments_X))+Wall,(Compartment_Size_Y*Number_of_Compartments_Y+Wall*(Number_of_Compartments_Y))/2,Depth/2+Font_Size/2-Wall]) {
    rotate([90,0,90]) {
      linear_extrude(height = 1.1) {
        text(text = str(Label), font = font, size = Font_Size, valign = "center", halign = "center");
      }
    }
    }



	for ( ybox = [ 0 : Number_of_Compartments_Y - 1])
		{
             for( xbox = [ 0 : Number_of_Compartments_X - 1])
			{
			
			
            if (Rounded_inside==0) {
              translate([ xbox * ( Compartment_Size_X + Wall ) + Wall, ybox * ( Compartment_Size_Y + Wall ) + Wall, Wall])
              cube ( size = [ Compartment_Size_X, Compartment_Size_Y, totalheight+1 ]);
            }
            
            if (Rounded_inside==1) {
              translate([ xbox * ( Compartment_Size_X + Wall ) + Wall, ybox * ( Compartment_Size_Y + Wall ) + Wall, Wall])
              roundedcube ( size = [ Compartment_Size_X, Compartment_Size_Y, totalheight+10 ], center = false, radius = Wall*2, apply_to = "all", $fn=25);
			}
            
            }
		}
        
  
        
        
	if (Lid_Type==1) {
			translate ([0,Wall/2,Depth+Wall]) 
			polyhedron ( points = [   
							[0,0,0], 
							[0,Number_of_Compartments_Y*(Compartment_Size_Y+Wall),0], 
							[Number_of_Compartments_X*(Compartment_Size_X+Wall)+Wall/2,0,0], 
							[Number_of_Compartments_X*(Compartment_Size_X+Wall)+Wall/2,Number_of_Compartments_Y*(Compartment_Size_Y+Wall),0],
							[0,Wall/2,Wall], 
							[0,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)-Wall/2,Wall], 
							[Number_of_Compartments_X*(Compartment_Size_X+Wall)+Wall/2,Wall/2,Wall], 
							[Number_of_Compartments_X*(Compartment_Size_X+Wall)+Wall/2,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)-Wall/2,Wall]
							],
						triangles = [ 
							[0,2,1], [1,2,3], [4,5,6], [5,7,6]	,		// top and bottom
							[0,4,2], [4,6,2], [5,3,7], [5,1,3]	,		// angled sides
							[0,1,4], [1,5,4], [2,6,3], [3,6,7]			// trapezoidal ends
							]);
			translate ([0,Wall/2,Depth+Wall-ztolerance])
			cube (size=[Number_of_Compartments_X*(Compartment_Size_X+Wall)+Wall/2,Number_of_Compartments_Y*(Compartment_Size_Y+Wall),ztolerance],center=false);
			}

	}
}

if (Render_Lid==1) {
translate ([0,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)+Wall+lidoffset,0])
difference () { union () {	// for including coin slot
	if (Lid_Type==1) { 
		difference () {
		polyhedron ( points = [   
						[0,0,0], 
						[0,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)-2*Tolerance,0], 
						[Number_of_Compartments_X*(Compartment_Size_X+Wall)-Tolerance+Wall/2,0,0], 
						[Number_of_Compartments_X*(Compartment_Size_X+Wall)-Tolerance+Wall/2,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)-2*Tolerance,0],
						[0,Wall/2,Wall], 
						[0,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)-Wall/2-2*Tolerance,Wall], 
						[Number_of_Compartments_X*(Compartment_Size_X+Wall)-Tolerance+Wall/2,Wall/2,Wall], 
						[Number_of_Compartments_X*(Compartment_Size_X+Wall)-Tolerance+Wall/2,Number_of_Compartments_Y*(Compartment_Size_Y+Wall)-Wall/2-2*Tolerance,Wall]
						],
					triangles = [ 
						[0,2,1], [1,2,3], [4,5,6], [5,7,6]	,		// top and bottom
						[0,4,2], [4,6,2], [5,3,7], [5,1,3]	,		// angled sides
						[0,1,4], [1,5,4], [2,6,3], [3,6,7]			// trapezoidal ends
						]);
            
            
            //Cut out text
             translate([(Number_of_Compartments_X*(Compartment_Size_X+Wall)-Tolerance+Wall/2)/2,(Number_of_Compartments_Y*(Compartment_Size_Y+Wall)-2*Tolerance)/2,Wall-0.5]) {
    rotate([0,0,0]) {
      linear_extrude(height = 1.1) {
        text(text = str(Label), font = font, size = Font_Size_Lid, valign = "center", halign = "center");
      }
    }
    }
            
            
            // Thumb hole
		if (Include_Thumbhole==1) {
			intersection () {
			translate ([min(8,Number_of_Compartments_X*(Compartment_Size_X+Wall)/8),(Number_of_Compartments_Y*(Compartment_Size_Y+Wall))/2,thumbrad+Wall/2]) sphere (r=thumbrad, center=true, $fn=60);
			translate ([min(8,Number_of_Compartments_X*(Compartment_Size_X+Wall)/8),0,0]) cube (size=[20,(Number_of_Compartments_Y*(Compartment_Size_Y+Wall)),20], center=false);
		}
	}

		}
	} else {

	difference() {
        
     if (Rounded_outside==1) {
        if (Rounded_outside_all==1) {
	roundedcube ( size = [Number_of_Compartments_X * (Compartment_Size_X + Wall) + 3 * Wall + 2* Tolerance, Number_of_Compartments_Y * (Compartment_Size_Y + Wall) + 3 * Wall + 2*Tolerance, Lid_Height], center = false, radius = Wall, apply_to = "all", $fn=25);
            }
            
            if (Rounded_outside_all==0) {
	roundedcube ( size = [Number_of_Compartments_X * (Compartment_Size_X + Wall) + 3 * Wall + 2* Tolerance, Number_of_Compartments_Y * (Compartment_Size_Y + Wall) + 3 * Wall + 2*Tolerance, Lid_Height], center = false, radius = Wall, apply_to = "z", $fn=25);
                
            }
            }

    if (Rounded_outside==0) {
        cube ( size = [Number_of_Compartments_X * (Compartment_Size_X + Wall) + 3 * Wall + 2* Tolerance, Number_of_Compartments_Y * (Compartment_Size_Y + Wall) + 3 * Wall + 2*Tolerance, Lid_Height], center = false);
        
    }    

     translate ([Wall,Wall,Wall])
	cube ( size = [Number_of_Compartments_X * (Compartment_Size_X + Wall) +Wall+Tolerance, Number_of_Compartments_Y * (Compartment_Size_Y + Wall) + Wall + Tolerance, Lid_Height+1], center = false);
	
	}
} // if Lid_Type
} // union
if (Include_Coinslot==1) {
	for ( yslot = [ 0 : Number_of_Compartments_Y - 1])
		{
             for( xslot = [ 0 : Number_of_Compartments_X - 1])
			{
			translate([ xslot * ( Compartment_Size_X + Wall ) + (2-Lid_Type)*Wall + (Compartment_Size_X-Coinslot_X)/2, yslot * ( Compartment_Size_Y + Wall ) + Wall*(2-3*Lid_Type/2) + (Compartment_Size_Y-Coinslot_Y)/2, 0])
			cube ( size = [ Coinslot_X, Coinslot_Y, Wall ]);
			}
		}
	}
} //difference
} // if showlid

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}

