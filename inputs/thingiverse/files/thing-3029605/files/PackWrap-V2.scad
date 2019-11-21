/* [Battery Dimensions] */
//The width of your battery in mm, determines the width of the center section.
batteryWidth = 34; //[20:150]
//The length of your battery in mm, determines the length of the PackWrap.
batteryLength = 90; //[20:300]
//The depth of your battery in mm, determines the width of the side sections.
batteryDepth = 28; //[20:150]

/* [Strap Options] */
//Larger batteries may require more straps.
strapCount = 1; //[0,1,2,3]
//Width of your battery strap in mm, determines the size of the space in the center section.
strapWidth = 20; //[0:40]
//Determines the distance between straps if using more than one.
strapSeperation = 20; //[5:200]
//Offsets the center of the strap(s) in mm.
strapCenterOffset = 0; //[-300:300]


/* [PackWrap Specs] */
//Determines how thick to print the walls in mm (in addition to the base thickness below).
wallThickness = 1.5; //[0:0.1:3]
//Thickness of the base in mm, determines tab and joint thickness.  Probably does not need to be changed if printing with TPU.
baseThickness = 1; //[0.5:0.1:3]
//Determines thicknes of the front "bumper" in mm.
bumperThickness = 5; //[0:15]



/* [Additional Options] */
//You can choose to add a strap to the rear for wire and battery retention, slots to use a second battery strap, or leave the rear open.
rearOption = "None"; //[None,Strap,Slots]
//Larger batteries may require additional tabs for the PackWrap to hold its shape.
tabCount = 1; //[1,2]









module stripe(){
    rotate([0,0,45]){
        translate([0,-batteryDepth/2+5,0]){
            hull(){
                cylinder(h=wallThickness+baseThickness*4, d=4, center=true, $fn=16);
                translate([0,batteryDepth-10,0]){
                    cylinder(h=wallThickness+baseThickness*4, d=4, center=true, $fn=16);
                }
            }
        }
    }
}

module stripes(){
    stripeClearance = (batteryDepth/sqrt(2))/2+8;
    stripeCount = floor((batteryLength-15)/stripeClearance);
    stripeOffset = batteryLength/stripeCount;
    echo (stripeCount);
    
    translate([-(batteryLength)/2,0,0]){
        for(i=[1:1:stripeCount-1]){
            translate([stripeOffset*i,0,0]){
                stripe();
            }
        }
    }
}



module strapTab(){
    tabHeight = baseThickness+0.4;
    translate([0,0,-(tabHeight)]){   
        cylinder(h=tabHeight, d=5, $fn=24);
    }
    translate([0,0,-(tabHeight+1.5)]){
        cylinder(h=1.5, d1=8, d2=5, $fn=24);
    }
    translate([0,0,-(tabHeight+3.5)]){
        cylinder(h=2, d=8, $fn=24);
    }
}


rotate([180,0,0]){
//center
difference(){
translate([0,0,0]){

    cube([batteryLength, batteryWidth, baseThickness], true);
    translate([0,0,-baseThickness/2]){
        hull(){
            cube([batteryLength, batteryWidth, 0.0001], true);

            translate([0,0,-wallThickness]){
                cube([batteryLength-(wallThickness*sqrt(2)*2), batteryWidth-wallThickness*(wallThickness*sqrt(2)*2), 0.0001], true);
            }
        }
    } 
}
if(strapCount>0){
    if(strapCount==1){
        translate([strapCenterOffset,0,0]){
            cube([strapWidth, batteryWidth, batteryWidth+wallThickness+5], true);
        }
    }else if(strapCount==2){
        translate([strapCenterOffset+(strapWidth/2)+(strapSeperation/2),0,0]){
            cube([strapWidth, batteryWidth, batteryWidth+wallThickness+5], true);
        }
        translate([strapCenterOffset-(strapWidth/2)-(strapSeperation/2),0,0]){
            cube([strapWidth, batteryWidth, batteryWidth+wallThickness+5], true);
        }
    }else if(strapCount==3){
        translate([strapCenterOffset+strapWidth+(strapSeperation),0,0]){
            cube([strapWidth, batteryWidth, batteryWidth+wallThickness+5], true);
        }
        translate([strapCenterOffset,0,0]){
            cube([strapWidth, batteryWidth, batteryWidth+wallThickness+5], true);
        }
        translate([strapCenterOffset-strapWidth-(strapSeperation),0,0]){
            cube([strapWidth, batteryWidth, batteryWidth+wallThickness+5], true);
        }
    }
}
}
 
//right
difference(){
    translate([0,batteryWidth/2+batteryDepth/2,0]){
        cube([batteryLength, batteryDepth, baseThickness], true);
        
        translate([0,0,-baseThickness/2]){
            hull(){
                cube([batteryLength, batteryDepth, 0.0001], true);
                translate([0,0,-wallThickness]){
                    cube([batteryLength-(wallThickness*sqrt(2)*2), batteryDepth-wallThickness*(wallThickness*sqrt(2)*2), 0.0001], true);
                }
            }
        }
            
        if(rearOption == "Strap"){
            translate([-batteryLength/2+8,0,-(baseThickness/2+wallThickness)]){
                strapTab();
            }
        }
            
            
            
        if(tabCount == 1){
            translate([batteryLength/2-8,0,-(baseThickness/2+wallThickness)]){
                strapTab();
            }
        }else if(tabCount == 2){
            translate([batteryLength/2-8,batteryDepth/5,-(baseThickness/2+wallThickness)]){
                strapTab();
            }
            translate([batteryLength/2-8,-batteryDepth/5,-(baseThickness/2+wallThickness)]){
                strapTab();
            }
        }
    }
    translate([0,batteryWidth/2+batteryDepth/2,0]){stripes();}
    
    if(rearOption == "Slots"){
        translate([-batteryLength/2+5,batteryWidth/2+batteryDepth/2-strapWidth/2,-5]){cube([3,strapWidth,10]);}
    }
}

//left
difference(){
    translate([0,-batteryWidth/2-batteryDepth/2,0]){
        cube([batteryLength, batteryDepth, baseThickness], true);
            translate([0,0,-baseThickness/2]){
                hull(){
                    cube([batteryLength, batteryDepth, 0.0001], true);
                    translate([0,0,-wallThickness]){
                        cube([batteryLength-(wallThickness*sqrt(2)*2), batteryDepth-wallThickness*(wallThickness*sqrt(2)*2), 0.0001], true);
                    }
                }
            }
    
            if(tabCount == 1){
                translate([batteryLength/2-8,0,-(baseThickness/2+wallThickness)]){
                    strapTab();
                }
            }else if(tabCount == 2){
                translate([batteryLength/2-8,batteryDepth/5,-(baseThickness/2+wallThickness)]){
                    strapTab();
                }
            translate([batteryLength/2-8,-batteryDepth/5,-(baseThickness/2+wallThickness)]){
                strapTab();
            }
        }
    }
    translate([0,-(batteryWidth/2+batteryDepth/2),0]){
        rotate([180,0,0]){
            stripes();
        }
    }
   
if(rearOption == "Slots"){
        translate([-batteryLength/2+5,-batteryWidth/2-batteryDepth/2-strapWidth/2,-5]){cube([3,strapWidth,10]);}
    } 
}

if(rearOption == "Strap"){
    translate([-batteryLength/2-batteryWidth-8,-batteryWidth/2-batteryDepth/2-6,-baseThickness/2]){
        difference(){
            hull(){
                cube([batteryWidth+8, 12,baseThickness]);
                translate([0,6,0])cylinder(h=baseThickness, d=12, $fn=24);
            }
            translate([0,6,-1])cylinder(h=baseThickness+2, d=6, $fn=24);
        }
    }
}


//top/bumper
translate([batteryLength/2+batteryDepth/2,0,0]){
    difference(){
        hull(){
            cube([batteryDepth, batteryWidth, baseThickness], true);
            if(tabCount == 1){
                translate([0, batteryWidth/2+10, 0]){
                    cylinder(h=baseThickness, d=15, $fn=24, center=true);
                }
                translate([0, -(batteryWidth/2+10), 0]){
                    cylinder(h=baseThickness, d=15, $fn=24, center=true);
                }
            }else if(tabCount == 2){
                translate([batteryDepth/5, batteryWidth/2+10, 0]){
                    cylinder(h=baseThickness, d=15, $fn=24, center=true);
                }
                translate([-batteryDepth/5, batteryWidth/2+10, 0]){
                    cylinder(h=baseThickness, d=15, $fn=24, center=true);
                }
                translate([batteryDepth/5, -(batteryWidth/2+10), 0]){
                    cylinder(h=baseThickness, d=15, $fn=24, center=true);
                }
                translate([-batteryDepth/5, -(batteryWidth/2+10), 0]){
                    cylinder(h=baseThickness, d=15, $fn=24, center=true);
                }
            }
        }
        if(tabCount == 1){
            translate([0, batteryWidth/2+10, 0]){
                cylinder(h=baseThickness+1, d=6, $fn=24, center=true);
            }
            translate([0, -(batteryWidth/2+10), 0]){
                cylinder(h=baseThickness+1, d=6, $fn=24, center=true);
            }
        }else if (tabCount == 2){
            translate([batteryDepth/5, batteryWidth/2+10, 0]){
                cylinder(h=baseThickness+1, d=6, $fn=24, center=true);
            }
            translate([-batteryDepth/5, batteryWidth/2+10, 0]){
                cylinder(h=baseThickness+1, d=6, $fn=24, center=true);
            }
            translate([batteryDepth/5, -(batteryWidth/2+10), 0]){
                cylinder(h=baseThickness+1, d=6, $fn=24, center=true);
            }
            translate([-batteryDepth/5, -(batteryWidth/2+10), 0]){
                cylinder(h=baseThickness+1, d=6, $fn=24, center=true);
            }
        }
    }
    
    translate([0,0,-baseThickness/2]){
        hull(){
            cube([batteryDepth, batteryWidth, 0.0001], true);

            translate([0,0,-bumperThickness]){
                cube([batteryDepth*.75-(wallThickness*sqrt(2)*2), batteryWidth*.75-wallThickness*(wallThickness*sqrt(2)*2), 0.0001], true);
            }
        }
    }
}
}
