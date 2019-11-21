
//CUSTOMIZER VARIABLES

//Width of the sign
signWidth=50;

//Height of the sign
signHeight=30;

//Text to be displayed
textMsg = "Tomate";

//Size of the text; Adjust until it fits
textSize = 9;

//Length of the stick 
stickLength = 90;

//Border thickness in mm ourund the sign
border = 1;

//Thickness of the sign
thickness = 2;

//CUSTOMIZER VARIABLES END

module renderSign(length,height,border,thickness) {
    color([0.5,0.5,0.5]){
    difference (){
        cube(size=[length+(2*border),height+(2*border),(thickness+0.5)],center=false);
        translate([border,border,thickness]) {
           cube(size = [length,height,thickness], center=false);
        }
    };
    };
}

module renderText(textMsg,textSize,signWidth,signHeight,border,thickness){
    color([1,1,1]){
    translate([(signWidth/2)+border,(signHeight/2)+border,thickness],center=false){
        linear_extrude(height = 1){
            text(text=textMsg,size=textSize,halign="center",valign="center");   
        };
    }
};
}

module renderStick(stickLength,signWidth,signHeight,thickness){
    color([0.5,0.5,0.5]){
        translate([ ((signWidth+(2*border))/2)-((signWidth/10)/2), stickLength * -1,0]){
                cube(size=[signWidth/10,stickLength,thickness]);
        };
    };
    
    
}

union(){
    renderSign(signWidth,signHeight,border,thickness);
    renderText(textMsg,textSize,signWidth,signHeight,border,thickness);
    renderStick(stickLength,signWidth,signHeight,thickness);
}

