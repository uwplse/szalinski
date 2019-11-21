//the u-shaped base
outerUWidth = 92;
outerUHeight = 53.5;

baseWidth = 5;
slotWidth = 6;

frontThickness = 1;
frontWidth = 10;

tabHeight = 3.2;
tabWidth = 2.5;

backingHeight = 4;
backingWidth = 2.5;

triangleWidth = 20;


//uHeight - the height of the u-shape.
//uWidth - the thickness of the u-shape.
module drawU(uHeight, uWidth, modOuterUWidth, modOuterUHeight){
    linear_extrude(height=uHeight)
    polygon([[0,0],[modOuterUWidth, 0],[modOuterUWidth, modOuterUHeight],[modOuterUWidth-uWidth, modOuterUHeight],[modOuterUWidth-uWidth, uWidth],[uWidth, uWidth],[uWidth, modOuterUHeight],[0, modOuterUHeight]]);
    }
    
module drawTriangle(xOffset, xRotate, zRotate){
    triangleHeight = frontThickness + slotWidth + tabHeight;
    rotate([xRotate, 0, zRotate])
    linear_extrude(height = 400)
    polygon([[xOffset, triangleHeight],[xOffset+triangleWidth, triangleHeight],[xOffset+triangleWidth/2,triangleHeight+triangleWidth/2]]);
    }
    
module drawPin(){
    difference(){
        linear_extrude(height = 6)
        polygon([[0,0],[triangleWidth-1.1,0],[(triangleWidth-1.1)/2, (triangleWidth-1.1)/2]]);
        translate([0,4,-1])
        linear_extrude(height=8)
        square(triangleWidth, false);
        }
    }

module drawAllU(){
    drawU(frontThickness, frontWidth, outerUWidth, outerUHeight);
    
    //the part that touches the outside front  
    translate([0,0,frontThickness])
    drawU(slotWidth, baseWidth, outerUWidth, outerUHeight);
    
    translate([tabWidth/2,tabWidth/2,frontThickness + slotWidth])
    drawU(tabHeight, tabWidth, outerUWidth-tabWidth, outerUHeight-tabWidth);
    
    translate([tabWidth/2,tabWidth/2,frontThickness+slotWidth+tabHeight])
    drawU(backingHeight, backingWidth, outerUWidth-backingWidth, outerUHeight-backingWidth); 
    }


difference(){
drawAllU();
translate([0,50,0])
drawTriangle(55, 90, 0); 
translate([0,50,0])
drawTriangle(15, 90, 0);  
drawTriangle(17, 90, 90);   
}

translate([15,14,0])
drawPin();
translate([15,24,0])
drawPin();
translate([15,34,0])
drawPin();
translate([15,44,0])
drawPin();
  
    