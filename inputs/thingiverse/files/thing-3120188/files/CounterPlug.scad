
//How deep is the hole to plug?
PlugH = 40.84; // [1:.25:100]
//What is the diameter of the hole to plug?
PlugD = 12.25; // [1:.25:100]

//How much larger than the plug should I make the cap? (0 for no cap)
CapD = 4; //[0:50]
//How tall should I make the cap? (0 for no cap)
CapH = 2; //[0:50]
//Do you want a dimple in the cap?
CapDimple = 0; // [1:yes,0:no]

//How tall should I make the the retention clips? (0 for no clips)
ClipH=3;  //[0:.25:10]
//How wide should I make the the retention clips? (0 for no clips)
ClipW=3; //[0:.25:10]
//Select the quality (resolution) of the model
Resolution = 60; //[60:Draft,180:Good,270:Better,360:Best]

$fn=Resolution;

CLipL = PlugD+5;

color("gray")
difference() {    
    union(){
        translate([0,0,PlugH])
            Cap(CapD+PlugD,CapH,25,CapDimple);
        cylinder(d=PlugD,h=PlugH);
        if (ClipH > 0 && ClipW > 0) {
            translate([-CLipL/2,0,0])
                ClipEnd(CLipL,ClipH,ClipW) ;
        }
    }
    if (ClipH > 0 && ClipW > 0) {
        translate([-(PlugD-5)/2,-ClipW/2,-ClipH])
            cube([PlugD-5,ClipW,(PlugH*.25)+ClipH]);
        translate([-PlugD/2,-(ClipW/2)-1.5,-.1])
            cube([PlugD,1.5,PlugH*.25]);
        translate([-PlugD/2,ClipW/2,-.1])
            cube([PlugD,1.5,PlugH*.25]);
    }
}

module Cap(Len,Height,Bevel,Dimple) {
    BevAdj = Bevel * .01;
    Dia=Len/2;
    rotate_extrude(convexity = 10)    
    polygon(points = [
                      [0,0]
                     ,[(Dia*(BevAdj*Dimple)),Height]
                     ,[Dia,0]
                     ,[(Dia*(1-BevAdj)),Height]
                     ]
            ,paths=[[0,1,3,2]]  
     );  
}

module ClipEnd(Len,Height,Width) {
    rotate([-90,0,0])
    linear_extrude(height = Width, center = true, convexity = 10, scale = 1.0) 
    polygon(points = [
                      [0,0]
                     ,[(Len*.25),Height]
                     ,[Len,0]
                     ,[(Len*.75),Height]
                     ]
            ,paths=[[0,1,3,2]]
    );
}
    
