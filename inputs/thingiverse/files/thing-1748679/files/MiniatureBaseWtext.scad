use <write/Write.scad>
/* [Base] */

base_type = 1; //	[1:Cool, 2:Basic, 3:Plain]
base_shape = 30; //	[30:Low-res Circle, 100: Hi-res Circle, 5:Pentagon, 6:Hexagon, 8:Octagon, 4:Square, 3:Triangle]

diameter = 20; // [5:100]
height = 3; // [1:35]
slant = 95; // [50:100]

// Percentage: 
stretch = 100; // [50:200]

//('Cool' base only)
inner_circle_ratio = 40; // [10:80]

/* [Text] */
text = "personalize";
text_font = "Letters.dxf";//[write/Letters.dxf,write/orbitron.dxf,write/knewave.dxf,write.braille.dxf,write/Blackrose.dxf]
text_diam_ratio = 85; // [30:100]
text_z_adj = 0; // [-9:9]
text_height = 1; // [0:10]
text_bold = 0; // [0:500]
text_spacing = 100; // [80:200]
text_scale = 100; // [25:500]

/* [Color] */
red = 136; // [0:255]
green = 118; // [0:255]
blue = 155; // [0:255]

color([red/255, green/255, blue/255])

union(){
    scale([text_scale/100, text_scale/100, 1])
    writecylinder(text, [0,0,height + text_z_adj], radius=diameter * (text_diam_ratio/100) * (100/text_scale), space = text_spacing/100, height = 0, t = text_height, bold = text_bold/100, face="top", ccw=true, font = text_font);
    
    scale([stretch/100, 1, 1]){
        if (base_type == 1){
            // Cool base
            
            cyl1_height = height * (1-inner_circle_ratio/100);
            cylinder(cyl1_height, diameter, diameter * slant/100, $fn=base_shape);
            
            cyl2_diameter = diameter  * slant/100 * .95;
            cyl2_height = height - cyl1_height;
            
            translate([0, 0, cyl1_height]){
                // Cylinder 2
                //color("green")        
                cylinder(cyl2_height, cyl2_diameter, cyl2_diameter * slant/100, $fn=base_shape);
                
                // Cylinder 3
                
                cylinder(cyl2_height*.5, diameter * slant/100, cyl2_diameter, $fn=base_shape);
            }
        } else if (base_type == 2){
            // Okay Base
            cylinder(height, diameter, diameter * slant/100, $fn=base_shape);
        } else if (base_type == 3){
            // Boring Circle Base
            
            cylinder(height, diameter, diameter, $fn=base_shape);
        } 
    }
}
