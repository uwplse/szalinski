/* (Base)   */
xSize=45; // [30:100]
//length of name tag 
ySize=15; // [5:40]
//width of the name tag 
zSize=3; // [3,5,7]
//hole diameter 
holeDiameter = 3; // [3,4,5,6] 
//thickness of the name tag

/* [Text] */
//height above base
textHeight = 2; // [1,2,3,5]
//text size 
textSize = 7.5; // [3:35]
// font for text
myFont = "Liberation Sans";
// text to put on plate
textInput= "Yeehaw";
module base() {
     
    cube([xSize, ySize, zSize], center = true);
    
    
}

module holes() {
    holeRadius = holeDiameter/2;
    
    translate([-xSize/2+holeDiameter, ySize/2-holeDiameter, 0])
    
    #cylinder (r= holeRadius, h = 2*zSize, $fn = 36, center=true);
    
    translate([+xSize/2-holeDiameter, ySize/2-holeDiameter, 0])
    
    #cylinder (r= holeRadius, h = 2*zSize, $fn = 36, center=true);
    
}

difference() {
base();
holes();
}
module textExtrude(){
    
 linear_extrude(height = textHeight) text(textInput,halign = "center", valign = "center", size=textSize, font= myFont);
    
    
    
}
textExtrude();