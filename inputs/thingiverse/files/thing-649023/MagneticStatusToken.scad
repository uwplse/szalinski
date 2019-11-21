use <write/Write.scad>
/* [Disc] */
Diameter=25.4;//[25.4:1 Inch, 38.1:1.5 Inch, 50.8:2 Inch,30:Reaper Mini Base,0:Custom]
// in mm
Height=5;
//in mm
EdgeBevel=0.5;
//Text for the edge of the token
EdgeText="";
//Text for the top face of the token
TopText="";
//Text for the bottom face of the token
BottomText="";
//Inset the Edge Text twice, rotated 180 degrees to be on both sides of the disc. Most useful with short status texts.
DoubleEdgeText=1;//[1:Yes,0:No]
//Also add the Top and/or Bottom Text twice, rotated 180 degrees. Less useful in my opinion but easy to include. Again, best with short status text.
DoubleFaceText=1;//[1:Yes,0:No]
//Need something bigger or smaller, set the Diameter to Custom and fill in your diameter in mm here.
CustomDiameter=25;

/* [Magnets] */ 

//in mm, default creates a flush hole for a 1/16 inch disc magnet on Makerbot Rep2
MagnetDepth=1.6;
//in mm, default creates a tight fit for a 1/8 inch disc magnet on Makerbot Rep2
MagnetDiameter=3.3;
//Should there be a hole for a magnet in the top?
TopHole=1;//[1:Yes,0:No]
//Should there be a hole for a magnet in the bottom?
BottomHole=1;//[1:Yes,o:No]
// Create a small extrusion on the inside edge of the magnet chamber to allow them to just "snap" in, instead of requiring glue.
SnapFit=1;//[1:Yes,0:No]
// Adjust upward for finer quality.
$fn=80;

module doToken(){
/* [Hidden] */
TokenDiameter=Diameter==0?abs(CustomDiameter):Diameter;
TokenHeight=abs(Height);
LipHeight=abs(EdgeBevel);
MagnetSnapBevel=SnapFit?0.4:0; // Create a slight bevelled edge on the top of the top magnet chamber so magnets just "click" in, this corresponds to the "Squish" of the first layers holding in the bottom magnet.
BottomMagnetDiameter=MagnetDiameter;


translate([0,0,TokenHeight/2])
difference(){
 union(){
  translate([0,0,TokenHeight/2-LipHeight]) cylinder(r1=TokenDiameter/2, r2=TokenDiameter/2-LipHeight, h=LipHeight);
  cylinder(r=TokenDiameter/2,h=TokenHeight-2*LipHeight,center=true);
  translate([0,0,-TokenHeight/2]) cylinder(r2=TokenDiameter/2, r1=TokenDiameter/2-LipHeight, h=LipHeight);
 }

 // Add text, if any has been defined
 if (EdgeText != ""){
  writecylinder(text=EdgeText,height=TokenHeight-2*LipHeight,h=TokenHeight-2*LipHeight, radius=TokenDiameter/2);
  if (DoubleEdgeText) rotate([0,0,180]) writecylinder(text=EdgeText,height=TokenHeight-2*LipHeight,h=TokenHeight-2*LipHeight, radius=TokenDiameter/2);
 }

 if (TopText != ""){
   writecylinder(text=TopText, where=[0,0,0], radius=TokenDiameter/2, height=TokenHeight/2, face="top");
   if (DoubleFaceText) rotate([0,0,180]) writecylinder(text=TopText, where=[0,0,0], radius=TokenDiameter/2, height=TokenHeight/2, face="top");
 }

 if (BottomText != ""){
  rotate([0,180,0]) writecylinder(text=BottomText,where=[0,0,0], radius=TokenDiameter/2, height=TokenHeight/2, face="top");
  if (DoubleFaceText) rotate([0,180,180]) writecylinder(text=BottomText,where=[0,0,0], radius=TokenDiameter/2, height=TokenHeight/2, face="top");
 }

 // Add holes for magnets to be installed after printing
 if (TopHole){
  //Top hole can have a bevelled top edge to allow for just snapping a magnet in.
  translate([0,0,TokenHeight/2-MagnetDepth]) cylinder(r=MagnetDiameter/2,h=MagnetDepth-MagnetSnapBevel+0.01);
  translate([0,0,TokenHeight/2-MagnetSnapBevel]) cylinder(r1=MagnetDiameter/2, r2=MagnetDiameter/2-MagnetSnapBevel);
 }
 //The bottom magnet needs to be just a tad higher to stay flush with the bottom.
 // Also, there may not be room for it, in which case we're going to leave it out
 if (BottomHole) {
   translate([0,0,-TokenHeight/2+MagnetSnapBevel/2]) cylinder(r=BottomMagnetDiameter/2,h=MagnetDepth-MagnetSnapBevel/2+0.2);
   #translate([0,0,-TokenHeight/2]) cylinder(r1=BottomMagnetDiameter/2-MagnetSnapBevel/2, r2=BottomMagnetDiameter/2,h=MagnetSnapBevel/2+0.01);
  }
}
}

doToken();
