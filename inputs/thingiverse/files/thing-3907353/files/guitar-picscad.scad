/// personalized guitar pic


/* [Text] */
// height above base
textHeight = 2; //{1,2,3,5]
// text size 
textSize = 5; // [3:35]
//text font
myFont = "Liberation Sans";
// text to put on plate 
textInput = "";


hull(){
sphere(r=l+h-.1);
translate([30,30,0])
    sphere(r=l-h);
rotate([0,0,300])translate([-30,30,0]) 
    sphere(r=l-h);
rotate([0,0,240])translate([30,30,0])
    sphere(r=l-h);
rotate([0,0,100])translate([30,30,0])
    sphere(r=l-h);
}

module textExtrude(){
    
    linear_extrude(height = textHeight) text("my text", halign = "center", valign = "center", size = textSize, font = myFont);
    
    
    
    
    
    

    
    
    
}
textExtrude();