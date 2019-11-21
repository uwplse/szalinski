// Customizable Wall Bracket
// (c) 2013 Wouter Robers

// How thick is the thing you want to bracket?
ClampSize=10;

// Material thickness (thicker makes stronger, but less flexible).
Thickness=2;

// Height of the rim in the front of the bracket
RimHeight=3; 

// Corner bevel size (bigger bevel gives better strength)
Corner=2;


MakeBracket();

module MakeBracket(){
Width=20;
rotate([0,0,-90]) difference(){
linear_extrude(height = Width)
polygon([[0,0],[0,20+Thickness],[Thickness,20+Thickness],[Thickness,Thickness+Corner],[Thickness+Corner,Thickness],[Thickness+ClampSize-Corner,Thickness],[Thickness+ClampSize,Thickness+Corner],[Thickness+ClampSize,Thickness+RimHeight],[2*Thickness+ClampSize,Thickness+RimHeight],[2*Thickness+ClampSize,Corner],[2*Thickness+ClampSize-Corner,0]]);

# translate([-0.1,10+Thickness,Width/2]) rotate([0,90,0]) cylinder(r1=2.5,r2=5,h=Thickness+0.2);
}
}