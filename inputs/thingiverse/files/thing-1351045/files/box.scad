//box

// preview[view:south, tilt:top]

// Which part to generate?
part = "both"; // [first:Box Only,second:Cover Only,both:Box and Cover]

inside_length =37;
inside_width = 34;
inside_height = 38;

side_wall_thickness = 3.5;

ceiling_thickness = 2;

floor_thickness = 2;

slot_depth = .7; 

//increase tolerance to loosen sliding cover
tolerance = .5;

outside_length = inside_length + side_wall_thickness * 2;
outside_width = inside_width + side_wall_thickness * 2;
outside_height = inside_height + ceiling_thickness + floor_thickness;

slot_height = (outside_height - ceiling_thickness - tolerance)/2 - ceiling_thickness;


/* [Extra] */
lock = true; //[true:yes, false:no]


/* [Cover Text] */
//blank this to remove text
text_1 = "hello";
//blank this for 1 line text
text_2 = "world";

text_size = 6;

text_leading = 1;

rotate([0,0,180])print_part();

module print_part() {
	if (part == "first") {
		box();
	} else if (part == "second") {
		cover();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

module both() {
	translate([-outside_length/2, 0, -inside_height]) cover();
	translate([outside_length/2, 0, 0]) box();
}


module box(){
    union(){
        difference(){
            cube([outside_length, outside_width, outside_height],center=true);
            //main cut
            translate([0, 0, floor_thickness]) cube([inside_length , inside_width, outside_height],center=true);
            
            //slot cut
            translate([0, side_wall_thickness - slot_depth, slot_height]) cube([inside_length + slot_depth *2 + tolerance, inside_width + side_wall_thickness *2, ceiling_thickness + tolerance],center=true);
            translate([0, (inside_width + side_wall_thickness)/2, slot_height + (ceiling_thickness)/2 + 1]) cube([inside_length, side_wall_thickness+1, ceiling_thickness *2 + tolerance],center=true);
            }
            if(lock){
                    translate([0, -(inside_width - side_wall_thickness)/2 , slot_height - ceiling_thickness/1.5]) 
                    rotate([0,90,0]) 
                    difference(){
                        cylinder(d = ceiling_thickness/2, h = inside_length + slot_depth *2 + 1, center=true , $fn = 32);
                        cylinder(d = ceiling_thickness/2 + 1, h = inside_length, center=true , $fn = 32);
                        }
                    }
            }
}

module cover(){
    
    difference(){
        translate([0, side_wall_thickness/2 - slot_depth, slot_height]) cube([inside_length + slot_depth *2, inside_width + slot_depth *2 + side_wall_thickness, ceiling_thickness],center=true);
        if(lock){
            translate([0, -(inside_width - side_wall_thickness)/2 , slot_height - ceiling_thickness/2]) 
            rotate([0,90,0]) 
            difference(){
                cylinder(d = ceiling_thickness/2, h = inside_length + slot_depth *2 + 1, center=true , $fn = 32);
                cylinder(d = ceiling_thickness/2 + 1, h = inside_length, center=true , $fn = 32);
                }
            }
                    
    if(text_1){   

        rotate([0,0,180])translate([0, 0, inside_height/2-1.5]) linear_extrude(height = 2){
                
                    if(text_2){
                            translate([0, -text_size/2 - text_leading, inside_height/2-1.5]) text(text_1, spacing = 1.2, font="Liberation Sans:style=Bold", size = text_size, halign = "center", valign = "center");
                            translate([0, text_size/2 + text_leading, inside_height/2-1.5]) text(text_2, spacing = 1.2, font="Liberation Sans:style=Bold",size = text_size, halign = "center", valign = "center");
                        }
                        else{
                            translate([0, 0, inside_height/2-1.5]) text(text_1, spacing = 1.2, font="Liberation Sans:style=Bold Italic",size = 5, halign = "center", valign = "center");
                        }
             }     
         }
     }
                
    translate([0, (inside_width + side_wall_thickness) /2, (outside_height - (ceiling_thickness + tolerance/2))/2]) cube([inside_length - tolerance, side_wall_thickness, ceiling_thickness + tolerance/2],center=true);
}


