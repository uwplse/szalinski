
//LABELS FOR CUSTOMIZER

// Adjust parameters here:
/*[Main]*/
Height = 7.5; //
OuterDiameter = 95; //
InnerDiameter = 78; // 
WallThickness = 3;

/*[Holes]*/
PipeHoles = 5; //
HoleDiameter = 8.7; // to fit 8mm pipe
HolePosition = 90; // 100% is outer limit
CenterHole = 10; //
HexHole = 16; //

/*[Hidden]*/
fn=30;  //100 is good, 30 is for viewing

module SolidLid(){
    //Main
    color("deeppink") translate([0,0,0]) cylinder(h=Height,d=OuterDiameter, $fn = fn); 
    color("pink") translate([0,0,Height*1]) cylinder(h=6,d=InnerDiameter, $fn = fn); 
    
    //Rim
   translate([0,0,Height]) cylinder(h=2,d1=OuterDiameter-4, d2=InnerDiameter, $fn = fn);


        
    
}

difference(){
    SolidLid();
    //Center
    translate([0,0,WallThickness+5]) cylinder(h=Height*5,d=InnerDiameter-2*WallThickness, $fn = fn); 
    //Rim for steel spring
    translate([0, 0, Height-4]) rotate_extrude(convexity = 10, $fn = fn) translate([OuterDiameter/2-1, 0, 0]) circle(r = 2, $fn = fn);
    
    translate([0, 0, Height+3]) rotate_extrude(convexity = 10, $fn = fn) translate([InnerDiameter/2+1, 0, 0]) circle(r = 1.5, $fn = fn);
    
    translate([0,0,-2]) cylinder(h=40,d=CenterHole, $fn = fn); 
    
    rotate([0, 0, 0]) translate([0.9*(InnerDiameter/2-WallThickness-HexHole/2), 0, -5])  rotate([0, 0, 30]) cylinder($fn = 6, h = 50, d = HexHole);
    
    for(i = [0 : PipeHoles-1]) rotate([0, 0, ((i +2)* (360 / (PipeHoles+3)))]) translate([HolePosition/100*(InnerDiameter/2-WallThickness-HoleDiameter/2), 0, -5]) cylinder($fn = fn/2, h = 50, d = HoleDiameter);
        


}


    
