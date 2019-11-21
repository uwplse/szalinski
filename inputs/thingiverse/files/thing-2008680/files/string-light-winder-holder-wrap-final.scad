Thickness=4; // z height, determines the sturdiness 
MainBodyLength=200; // 
MainBodyWidth=90; // wires are wrapped around this axis
ExteriorArmWidth=20;
InteriorArmSpacing=70; // how much you HAVE to wrap cord around
InteriorArmWidth=15;
NotchDepth=5;
VaryNotchPosition=0;
NumberCenterSupports=2; 
CenterSupportWidth=10;


module ExteriorArms(){
    union(){
        cube(([MainBodyLength,ExteriorArmWidth,Thickness]));
        translate([0, ((MainBodyWidth)-(ExteriorArmWidth)) ,0])
        cube(([MainBodyLength,ExteriorArmWidth,Thickness]));
    }
}

module InteriorArms(){
    union(){
        cube(([InteriorArmWidth,MainBodyWidth,Thickness]));
        translate([((InteriorArmSpacing)-(InteriorArmWidth)),0,0])
        cube(([InteriorArmWidth,MainBodyWidth,Thickness]));       
    }
}

module CenterSupports(){
    
    union(){
        cube(([0,0,0]));
        translate([0,0,0])
        cube(([0,0,0]));       
    }
    
}


module MainBody(){
    union(){
        ExteriorArms();
        translate([(MainBodyLength/2)-(InteriorArmSpacing/2),0,0])
        InteriorArms();
    }
    for (i=[0:NumberCenterSupports-1]){
        translate([(MainBodyLength/2)-(InteriorArmSpacing/2)*0.99, ((ExteriorArmWidth)-(CenterSupportWidth/2)) + (i+1)*(((MainBodyWidth-(2*ExteriorArmWidth))+ CenterSupportWidth)/(NumberCenterSupports+1)) - (CenterSupportWidth/2)  ,0])
        cube(([InteriorArmSpacing*0.99,CenterSupportWidth,Thickness]));
    
    }
}

module Notch(){
    cube(([100,3,100]));
}

difference(){
    MainBody();
    translate([(MainBodyLength/2)+(InteriorArmSpacing/2)-NotchDepth,MainBodyWidth-ExteriorArmWidth-( (MainBodyWidth-(2*ExteriorArmWidth))/4)+VaryNotchPosition,-0.50])
    Notch();
}




