$fn = 60;

deckSize = [94,24,68];
thickness = 2;
sideLib = 5;
bottomLib = 7;

cornerRadius = 1;
frameRadius = 20;
holeCornerRadius = 5;

slideDepth = 10;
innerSlideDepth = 2;
slideWidth = 0.5;

difference(){
    hull(){
        translate([0,0,cornerRadius])
        Bottom();
        translate([0,0,deckSize.z+thickness-cornerRadius])
        Bottom();
    }  
    
    translate([thickness,thickness,thickness])
    cube(deckSize);
    
    hull(){
        translate([thickness+frameRadius+sideLib,0,thickness+frameRadius+bottomLib])
        Corner(deckSize.y+thickness*2);
            
        translate([thickness+deckSize.x-frameRadius-sideLib,0,thickness+frameRadius+bottomLib])
        Corner(deckSize.y+thickness*2);
            
        translate([thickness+sideLib,0,thickness+deckSize.z])
        cube(deckSize+[-sideLib*2,thickness*2,0]);
    }
    
    hull(){
        translate([thickness+frameRadius+sideLib,thickness-slideWidth,thickness+frameRadius+bottomLib])
        Corner(deckSize.y+slideWidth*2);
            
        translate([thickness+deckSize.x-frameRadius-sideLib,thickness-slideWidth,thickness+frameRadius+bottomLib])
        Corner(deckSize.y+slideWidth*2); 
        
        translate([thickness+frameRadius+sideLib,thickness,thickness+frameRadius+bottomLib-innerSlideDepth])
        Corner(deckSize.y);
            
        translate([thickness+deckSize.x-frameRadius-sideLib,thickness,thickness+frameRadius+bottomLib-innerSlideDepth])
        Corner(deckSize.y);
    }
    
    hull(){
        translate([thickness,thickness,deckSize.z-thickness-slideDepth])
        cube(deckSize);
            
        translate([thickness-slideWidth,thickness-slideWidth,deckSize.z+thickness])
        cube(deckSize+[slideWidth*2,slideWidth*2,0]);
    }
    
    hull(){
        translate([thickness+sideLib+holeCornerRadius,thickness+sideLib+holeCornerRadius,0]){
            Hole();
            
            translate([deckSize.x-holeCornerRadius*2-sideLib*2,0,0])
                Hole();
        }
    }
}

module Corner(width) {
    rotate([-90,0,0])  
    cylinder(r = frameRadius, h = width);
}

module Bottom(){
    translate([cornerRadius,0,0]){
        translate([0,cornerRadius,0])
        sphere(r = cornerRadius);
        
        translate([0,deckSize.y+2*thickness-cornerRadius,0])
        sphere(r = cornerRadius);
    }
    
    translate([deckSize.x+2*thickness-cornerRadius,0,0]){
        translate([0,cornerRadius,0])
        sphere(r = cornerRadius);
        
        translate([0,deckSize.y+2*thickness-cornerRadius,0])
        sphere(r = cornerRadius);
    }
}

module Hole(){
    cylinder(r = holeCornerRadius, h = thickness);
    translate([0,deckSize.y-holeCornerRadius*2-sideLib*2,0])
    cylinder(r = holeCornerRadius, h = thickness);
}