/* [Base] */
//length of name tag
xSize=45; //[30:100]
//width of name tag
ySize=15; //[5:40]
//thickness of name tag
zSize=3; //[3,5,7]
//hole diameter
holeDiameter = 3;// [3,4,5,6]

/* [Text] */
//height above base
textHeight = 2; // [1,2,3,5]
//text size
textSize = 7.5; // [3:35] 
// font for text
myFont = "Liberation Sans";
//text to put on plate
textInput = "My Text";

module base() {
    
    cube ([xSize, ySize, zSize], center = true);
    
    
        
}

module holes(){
    holeRadius = holeDiameter/2; 
        translate([-xSize/2+holeDiameter, ySize/2-holeDiameter, 0])
    
        #cylinder (r = holeRadius, h = 2*zSize, $fn = 36, center = true);
    
        translate([+xSize/2-holeDiameter, ySize/2-holeDiameter, 0])
    
        #cylinder (r = holeRadius, h = 2*zSize, $fn = 36, center = true);
}
difference() {
base();
holes();
}
module textExtrude(){
    
    linear_extrude(height = textHeight) text(textInput, halign = "center", valign = "center", size = textSize, font = myFont);
    
     
    
}
textExtrude();
