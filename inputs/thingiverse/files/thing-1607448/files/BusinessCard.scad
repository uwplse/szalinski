// preview[view:south, tilt:top]

/* [Words] */
first_name = "Kevin"; 
last_name = "Bragg";
email_extension = "@gmail.com";

/* [Size&Position] */
round_edges = "Yes"; // [Yes, No]
name_font_size = 15;
email_font_size = 8;
first_name_x_pos = -36; 
first_name_y_pos = 8;
last_name_x_pos = -36; 
last_name_y_pos = -8;
email_x_pos = -20; 
email_y_pos = -24;


/* [Hidden] */
card_thickness = 0.9;
text_height = 0.9;
preview_tab = "";
card_generator();

module card_generator() { 
    union () {
        difference() {
            union() { 
                // The blank card
                translate([0, 0, card_thickness]) 
                cube(size = [84, 54, card_thickness], center = true); 

                if (first_name != "" && last_name != ""){ //Place First Name
                    translate([first_name_x_pos, first_name_y_pos, card_thickness+text_height-.45])
                    linear_extrude(height = text_height){
                        text(first_name, size=name_font_size, font = "Liberation Sans");
                    }                    
                    
                    translate([last_name_x_pos, last_name_y_pos, card_thickness+text_height-.45])
                    linear_extrude(height = text_height){
                        text(last_name, size=name_font_size, font = "Liberation Sans");
                    }     
                }
                else if (first_name != "") { // If only a first name
                    translate([first_name_x_pos, first_name_y_pos, card_thickness+text_height-.45])
                    linear_extrude(height = text_height){
                        text(first_name, size=name_font_size, font = "Liberation Sans");
                    }     
                }
                else { // If only a last name
                    translate([last_name_x_pos, last_name_y_pos, card_thickness+text_height-.45])
                    linear_extrude(height = text_height){
                        text(last_name, size=name_font_size, font = "Liberation Sans");
                    }     
                }
                if (email_extension != "") { // If email extension is given
                    translate([email_x_pos, email_y_pos, card_thickness+text_height-.45])
                    linear_extrude(height = text_height){
                        text(email_extension, size=email_font_size, font = "Liberation Sans");
                    } 
                }
            }
            // Remove Square Corners
            if (round_edges == "Yes") {
                translate([84/2-0.75, 54/2-0.75, 0]) 
                cube(size = [1.5, 1.5, 10], center = true);
                translate([84/2-0.75, -(54/2-0.75), 0]) 
                cube(size = [1.5, 1.5, 10], center = true);
                translate([-(84/2-0.75), 54/2-0.75, 0]) 
                cube(size = [1.5, 1.5, 10], center = true);
                translate([-(84/2-0.75), -(54/2-0.75), 0]) 
                cube(size = [1.5, 1.5, 10], center = true);      
            }
        }
        // Add Rounded Edges
        if (round_edges == "Yes") {
            translate([84/2-1.5, 54/2-1.5, card_thickness]) 
            cylinder(card_thickness, d=3, d=3, center = true);
            translate([84/2-1.5, -(54/2-1.5), card_thickness]) 
            cylinder(card_thickness, d=3, d=3, center = true);
            translate([-(84/2-1.5), 54/2-1.5, card_thickness]) 
            cylinder(card_thickness, d=3, d=3, center = true);
            translate([-(84/2-1.5), -(54/2-1.5), card_thickness]) 
            cylinder(card_thickness, d=3, d=3, center = true);
        }
    }
}
