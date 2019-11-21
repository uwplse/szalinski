
//CUSTOMIZER VARIABLES

//Type: simple, round, old
type="simple"; //[simple,round,old]

//Radius of rounded edges
radius = 5;

//Width of the sign
signWidth=50;

//Height of the sign
signHeight=30;

//1 or 2 lines of text?
lines=1; //[1,2]

//Text to be displayed line 1
textMsg1 = "Tomate-T";

//Text to be displayed line 2
textMsg2 = "Tomate-T";

//Size of the text line 1; Adjust until it fits
textSize1 = 8;

//Size of the text line 2; Adjust until it fits
textSize2 = 8;

//Length of the stick 
stickLength = 90;

//Width of the stick 
stickWidth = 5;

//Border thickness in mm ourund the sign
border = 1;

//Thickness of the sign
thickness = 2;

//Quality
quality=100;

//CUSTOMIZER VARIABLES END

module renderSignSimple(length,height,border,thickness) {
    color([0.5,0.5,0.5]){
    difference (){
        cube(size=[length+(2*border),height+(2*border),(thickness+0.5)],center=false);
        translate([border,border,thickness]) {
           cube(size = [length,height,thickness], center=false);
        }
    };
    };
}

module renderSignRound(length,height,border,thickness) {
    color([0.5,0.5,0.5]){
        difference (){
            union(){
                cube(size=[length+(2*border),height+(2*border),(thickness+0.5)],center=false);
                translate([0,(height/2)+border,0]){
                    cylinder(h=(thickness+0.5),d=height+(2*border));
                };
                translate([length,(height/2)+border,0]){
                    cylinder(h=(thickness+0.5),d=height+(2*border));
                };
            }
            translate([border,border,thickness]) {
               cube(size = [length,height,thickness], center=false);
            };
            translate([0,(height/2)+border,thickness]){
                cylinder(h=thickness,d=height);
            };
            translate([length,(height/2)+border,thickness]){
                cylinder(h=thickness,d=height);
            };
        };
    };
}

module renderSignOld(length,height,border,thickness,radius) {
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

module renderText(textMsg1,textSize1,textMsg2,textSize2,signWidth,signHeight,border,thickness){
    color([1,1,1]){
        if(lines==2){
            translate([(signWidth/2)+(border/2),3*(signHeight/4)+border,thickness],center=false){
                linear_extrude(height = 1){
                    text(text=textMsg1,size=textSize1,halign="center",valign="center");   
                };
            }
            translate([(signWidth/2)+(border/2),(signHeight/4)+border,thickness],center=false){
                linear_extrude(height = 1){
                    text(text=textMsg2,size=textSize2,halign="center",valign="center");   
                };
            }
        }else{
            translate([(signWidth/2)+(border/2),(signHeight/2)+border,thickness],center=false){
                linear_extrude(height = 1){
                    text(text=textMsg1,size=textSize1,halign="center",valign="center");   
                };
            }
        };
     }
}


module renderStick(stickLength,stickWidth,signWidth,signHeight,thickness,border){
        color([0.5,0.5,0.5]){
            translate([ ((signWidth/2)+(border/2))-(stickWidth/2), stickLength * -1,0]){
                    cube(size=[stickWidth,stickLength,thickness]);
            };
            translate([ ((signWidth/2)+(border/2))-(stickWidth),border * -2 ,0]){
                    cube(size=[stickWidth*2,border*2,thickness]);
            };
        };
   
}

union(){
    $fn=quality;
    if(type=="simple"){
        renderSignSimple(signWidth,signHeight,border,thickness);
    }else if(type == "round"){
        renderSignRound(signWidth,signHeight,border,thickness);
    }else if(type=="old"){
        renderSignOld(signWidth,signHeight,border,thickness,radius);
    }
    
    renderText(textMsg1,textSize1,textMsg2,textSize2,signWidth,signHeight,border,thickness);
    renderStick(stickLength,stickWidth,signWidth,signHeight,thickness,border);
}

