//parameters
height = 20;
x = 55;
y = 55;
vertical_shift = 5; // the value can be between 0 and 'height'
tilting = 3; 
thickness = 5;
phone_thicness = 10;

text = "AB";
text_size = 20;
text_depth = 3;
position_of_text_x = 53;
position_of_text_y = -20;
position_of_text_z = 19;
//body
  rotate([90,0,0])
  difference() {
    // Extrudes the body of the model from the polygon shape
    linear_extrude(height = y, center = true, convexity = 10,  slices = 20, scale = 1.0) {polygon(points=[[0,0],[x,0],[x+height/tilting,height],[phone_thicness+thickness+height/tilting-(height-vertical_shift)/tilting+height/tilting+thickness-(vertical_shift)/tilting,height],[phone_thicness+thickness+height/tilting-(height-vertical_shift)/tilting+height/tilting+thickness,vertical_shift+height], [phone_thicness+thickness+height/tilting-(height-vertical_shift)/tilting+height/tilting,vertical_shift+height],[phone_thicness+thickness+height/tilting-(height-vertical_shift)/tilting,vertical_shift], [thickness+height/tilting-(height-vertical_shift)/tilting,vertical_shift], [thickness+height/tilting,height], [height/tilting,height]]);}
    // Imprints text 'AB' on the top surface of the model
    rotate([0,90,90]) translate([position_of_text_y,-position_of_text_x,height-text_depth])
    linear_extrude(height = text_depth,   convexity = 10,  slices = 20, scale = 1.0) {text(text, font = "Liberation Sans:style=Bold Italic", size = text_size);}  
}
