// Customizable Wall Bracket
// (c) 2013 Wouter Robers
// remixed 2015 by Fritz Toch

// variable description

// How thick is the thing you want to bracket, in mm?
ClampSize=12;

// Material thickness (thicker makes stronger, but less flexible) in mm?
Thickness=3;

// Height of the rim in the front of the bracket, in mm?
RimHeight=7; 

// Corner bevel size (bigger bevel gives better strength) in mm?
Corner=3;

// Width of bracket, in mm?
BracketWidth=16;

// Height of bracket 'tail'-the part against the wall, in mm?
TailHeight=30;


MakeBracket();

module MakeBracket(){
rotate([0,0,-90]) difference(){
linear_extrude(height = BracketWidth)
polygon([[0,0],[0,TailHeight+Thickness],[Thickness,TailHeight+Thickness],[Thickness,Thickness+Corner],[Thickness+Corner,Thickness],[Thickness+ClampSize-Corner,Thickness],[Thickness+ClampSize,Thickness+Corner],[Thickness+ClampSize,Thickness+RimHeight],[2*Thickness+ClampSize,Thickness+RimHeight],[2*Thickness+ClampSize,Corner],[2*Thickness+ClampSize-Corner,0]]);

}
}
