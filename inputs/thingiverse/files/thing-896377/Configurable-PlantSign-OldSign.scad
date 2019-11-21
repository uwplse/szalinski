
//CUSTOMIZER VARIABLES

//Width of the sign
signWidth=60;

//Height of the sign
signHeight=30;

//Radius of rounded edges
radius = 10;

//Text to be displayed
textMsg = "Tomato";

//Size of the text; Adjust until it fits
textSize = 9;

//Length of the stick 
stickLength = 90;


//Width of the stick 
stickWidth = 5;

//Border thickness in mm ourund the sign
border = 1;

//Thickness of the sign
thickness = 2;

//CUSTOMIZER VARIABLES END

module renderSign(length,height,border,thickness,radius) {
    color([0.5,0.5,0.5]){
        difference(){
        union(){
            difference (){
                cube(size=[length+(2*border),height+(2*border),(thickness+0.5)],center=false);
                translate([border,border,thickness]) {
                   cube(size = [length,height,thickness], center=false);
                };
            };
            cylinder(h = (thickness+0.5), r=radius,center=false);
            translate([0,height+(2*border),0]){
                cylinder(h = (thickness+0.5), r=radius,center=false);
            };
            translate([length+(2*border),height+(2*border),0]){
                cylinder(h = (thickness+0.5), r=radius,center=false);
            };
            translate([length+(2*border),0,0]){
                cylinder(h = (thickness+0.5), r=radius,center=false);
            };
        };
            //lower left
            cylinder(h = (thickness+0.5), r=radius-border,center=false);
            translate([0,radius * -1,0]){
                cube([radius,radius,thickness+0.5]);
            };
            translate([radius * -1,0,0]){
                cube([radius,radius,thickness+0.5]);
            };
            translate([radius * -1, radius * -1,0]){
                cube([radius,radius,thickness+0.5]);
            };
            
            //upper left
            translate([0,height+(2*border)],0){
                cylinder(h = (thickness+0.5), r=radius-border,center=false);
            };
            translate([radius *-1,height+(2*border),0]){
              cube([radius,radius,thickness+0.5]);  
            };
            translate([0,height+(2*border),0]){
              cube([radius,radius,thickness+0.5]);  
            };
            translate([radius *-1,height+(2*border)-radius,0]){
              cube([radius,radius,thickness+0.5]);  
            };
            
            //upper right
            translate([length+(2*border),height+(2*border)],0){
                cylinder(h = (thickness+0.5), r=radius-border,center=false);
            };
            translate([length+(2*border),height+(2*border),0]){
              cube([radius,radius,thickness+0.5]);  
            };
            translate([length+(2*border)-radius,height+(2*border),0]){
              cube([radius,radius,thickness+0.5]);  
            };
            translate([length+(2*border),height+(2*border)-radius,0]){
              cube([radius,radius,thickness+0.5]);  
            };
            
            
            //lower right
            translate([length+(2*border),0,0]){
                cylinder(h = (thickness+0.5), r=radius-border,center=false);
            };
            translate([length+(2*border),0,0]){
              cube([radius,radius,thickness+0.5]);  
            };
            translate([length+(2*border)-radius,radius * -1,0]){
              cube([radius,radius,thickness+0.5]);  
            };
            translate([length+(2*border),radius *-1,0]){
              #cube([radius,radius,thickness+0.5]);  
            };

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

module renderStick(stickLength,stickWidth,signWidth,signHeight,thickness,border){
        color([0.5,0.5,0.5]){
            translate([ ((signWidth/2)+border)-(stickWidth/2), stickLength * -1,0]){
                    cube(size=[stickWidth,stickLength,thickness]);
            };
            translate([ ((signWidth/2)+border)-(stickWidth),border * -2 ,0]){
                    cube(size=[stickWidth*2,border*2,thickness]);
            };
        };
   
}

union(){
    renderSign(signWidth,signHeight,border,thickness,radius);
    renderText(textMsg,textSize,signWidth,signHeight,border,thickness);
    renderStick(stickLength,stickWidth,signWidth,signHeight,thickness,border);
}

