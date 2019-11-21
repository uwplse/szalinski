// Rangweezus Education Cubes
    //inspired by mathgrrl testbots
////////////////////////////////////////////////////
// parameters

fontType = "Source Sans Pro:style=Bold";
fontDepth = 1.5*1;


////////////////////////////////////////////////////
// Start Values

//appears on cube
Label = "Concentric";

//fontSize
  fontSize = 5;

// side length in mm
cubeSize = 40;

////////////////////////////////////////////////////
//  Render


//  Union of Text and Cube

union(){
    cube([cubeSize, cubeSize, cubeSize]);
    rotate(90, [1,0,0])
    translate([.5*cubeSize, .5*cubeSize, -.5])
    color("white")
    linear_extrude(height=fontDepth)
    text(Label,font=fontType,size=fontSize,halign="center",valign="center");
}
   




