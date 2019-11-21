$fn = 60;

deckSize = [94,24,68];
thickness = 2;
lib = 5;

cornerRadius = 1;
frameRadius = 20;
innerFrameRadius = 5;

slideDepth = 10;
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
        translate([thickness+frameRadius+lib,0,thickness+frameRadius+lib])
        Corner();
            
        translate([thickness+deckSize.x-frameRadius-lib,0,thickness+frameRadius+lib])
        Corner();
            
        translate([thickness+lib,0,thickness+deckSize.z])
        cube(deckSize+[-lib*2,thickness*2,0]);
    }
    
    hull(){
        translate([thickness,thickness,deckSize.z-thickness-slideDepth])
        cube(deckSize);
            
        translate([thickness-slideWidth,thickness-slideWidth,deckSize.z+thickness])
        cube(deckSize+[slideWidth*2,slideWidth*2,0]);
    }
    
    hull(){
        translate([thickness+lib+innerFrameRadius,thickness+lib+innerFrameRadius,0]){
            cylinder(r = innerFrameRadius, h = thickness);
            translate([0,deckSize.y-innerFrameRadius*2-lib*2,0])
            cylinder(r = innerFrameRadius, h = thickness);
            
            translate([deckSize.x-innerFrameRadius*2-lib*2,0,0]){
                cylinder(r = innerFrameRadius, h = thickness);
                translate([0,deckSize.y-innerFrameRadius*2-lib*2,0])
                cylinder(r = innerFrameRadius, h = thickness);
            }
        }
    }
}

module Corner() {
    rotate([-90,0,0])  
    cylinder(r = frameRadius, h = deckSize.y+thickness*2);
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