width = 100;
height = 5;
handle_width = 15;
handle_height_factor = 1.5;
textX = 0;
textY = 30;
textSize = 17;
text = "Hello";

handle_height = handle_width * handle_height_factor;
rounding = height;

rotate_extrude(convexity = 10, $fn = 100)
{
    square([width/2 - rounding, height], $fn = 100);
    translate([width/2-rounding, height-rounding])
    color("red")
    difference() 
    {
        circle(r=rounding, $fn = 100);
        translate([-rounding, -height])
        square([width, height], $fn = 100);
    };
    
    translate([0, handle_height/ 2 + height - handle_height / 10])
    difference() 
    {
        scale (v=[1,handle_height_factor,1]) 
        circle(r=handle_width/2, $fn = 100);
        
        translate([-handle_width, -handle_height / 2])
        square([handle_width, handle_height], $fn = 100);
    }
}
        
translate([textX, textY, height])
linear_extrude(height = 2) {
    text(text=text, halign="center", valign="center", size=textSize);
}