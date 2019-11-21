Tubes = 7;
// Tube Height
TubeHeight = 100;
// Tube diameter
TubeDiameter = 16;
// Hole diameter
HoleDiameter = 17;
// Inter tube space
InterTubeSpace = 1;
// Walls thickness
HolderThickness = 5;
Angle = 20;
AlternateZ = 1; // [0:No,1:Yes]
Text = "RafaelEstevam.Net";
TextRelief = 0; // [0:Hight,1:Low]
TextOffsetX=5;
TextOffsetZ=0;


difference(){
    base();
    drawTubes(HoleDiameter);
    if(TextRelief == 1) drawText();
}
if(TextRelief == 0) color("lightblue") drawText();

module drawText(){
    posY = TubeHeight*0.75;    
    h = posY*tan(Angle);   
    w = Tubes*(1+HoleDiameter+InterTubeSpace);    
    translate([w-TextOffsetX-HoleDiameter*0.75,posY-HolderThickness/2,h*0.4-TextOffsetZ])
        rotate([90,0,180])
            linear_extrude(height=HolderThickness*0.75) text(Text);
}
module base(Diameter=HoleDiameter){
    w = TubeHeight*0.75;
    h = w*tan(Angle);
    cX=Tubes*(1+Diameter+InterTubeSpace);
    translate([-(Diameter/1.5+InterTubeSpace),0,0]){        
        cube([cX,w,HolderThickness]);
        cube([cX,Diameter,Diameter]);
        translate([0,w-HolderThickness,0])
            cube([cX,HolderThickness,h+Diameter*0.5]);
    }    
}
module drawTubes(Diameter){
    translate([0,0,HolderThickness+Diameter/2])    
        for(i = [0:Tubes-1])
            translate([i*(Diameter+InterTubeSpace),
                       5,AlternateZ == 1 && i%2==1?Diameter*0.25:0])
                rotate([90-Angle,0,180])
                    cylinder(r=Diameter/2,TubeHeight);
        
}