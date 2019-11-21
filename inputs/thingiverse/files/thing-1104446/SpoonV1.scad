/* [Cup] */
CutToSee = false; // Cut object for better view
UpperRadius = 24;
LowerRadius = 20;
Height = 10;
Thickness = 5;
/* [Handle] */
HandleSize = 70;
HandleHole = 5;
HandleThickness = 5;
HandleInBottom = false;
/* [Text] */
TextOffsetX=0;
TextOffsetY=-1.5;
TextOffsetZ=0;
TextLowRelief = true;
Text = "RafaelEstevam.Net";

/* [HIDDEN] */
$fn = 75;

doAll();

module doAll(){
    SpoonCup();
    
    X=(HandleInBottom?LowerRadius:UpperRadius)-Thickness;
    Z=HandleInBottom?-Height:0;    
    translate([X,0,Z]) 
        Handle();
}

module SpoonCup(){
    difference(){
        hull(){
            cylinder(r=UpperRadius,h=Thickness);
            translate([0,0,-Height]) 
                cylinder(r=LowerRadius,h=Thickness);
        }
        hull(){
            cylinder(r=UpperRadius-Thickness,h=Thickness);
            translate([0,0,-Height+Thickness]) 
                cylinder(r=LowerRadius-Thickness,h=Thickness);
        }
        if(CutToSee) 
            translate([0,0,-50])
                cube([100,100,100]);
    }
}
module Handle(){
    difference(){
        hull(){
            translate([0,-LowerRadius/2,0])
                cube([LowerRadius,LowerRadius,HandleThickness]);
            translate([HandleSize,0,0])
                cylinder(r=LowerRadius/2,h=HandleThickness);
        }
        if(HandleHole > 0){
            translate([HandleSize,0,0])
                cylinder(r=HandleHole,h=HandleThickness);
        }
        if(TextLowRelief)
            Text();
    }
    if(!TextLowRelief)
        Text();
}
module Text(){
    translate([TextOffsetX,TextOffsetY,TextOffsetZ])
    {
        if(HandleInBottom){
            translate([2*Thickness,0,HandleThickness-1])
                textRender();
        }
        else{
            translate([Thickness,-1.5,HandleThickness-1])
                textRender();
        }
    }
}
module textRender(){
    linear_extrude(height=2)
        text(Text,size=HandleSize/15);
}



