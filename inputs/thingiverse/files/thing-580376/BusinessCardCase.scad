//Width of one business card
CardWidth=88.9; 
// Height of one business card
CardHeight=50.8; 
// Extra space around the card to allow for size variation
CardMargin=1; 
// how much space for cards.
CardDepth=3; 
// 1.5 seems to work best on a Rep2
WallThickness=1.5; 
FingerHoleRadius=25.4*0.375;
// Yes, this is really high because we're just cutting out a small arc of the cylinders affected by it.
$fn=800; 

/* [Hidden] */
//when using the customizer, importing a DXF doesn't work, setting the
// inlay depth to zero (or less than zero) bypasses using the DXF file entirely
InlayDepth=0.0; 
// When using OpenScad, create a DXF with layers named "Detail" and "Monogram"
InlayFilename="BusinessCardInlay_Circuit.dxf"; 

Curve=3*CardHeight;
translate([0,0,0]) {
 difference(){
  intersection(){
   difference(){
    translate([0,Curve+CardDepth/2+WallThickness,0]) rotate([0,90,0]) cylinder(r=Curve+CardDepth+2*WallThickness,h=CardWidth+2*CardMargin+3*WallThickness,center=true);
    translate([0,Curve+CardDepth/2,0]) rotate([0,90,0]) cylinder(r=Curve-WallThickness,h=CardWidth+2*CardMargin+1+WallThickness*3,center=true);
   }
 
   translate([0,0,-WallThickness/2]) cube([CardWidth+3*CardMargin+2*WallThickness,CardDepth*2+10*CardMargin,CardHeight+3*CardMargin+WallThickness], center=true);
  }

  intersection(){
   difference(){
    translate([0,Curve+CardDepth/2,0]) rotate([0,90,0]) cylinder(r=Curve+CardDepth,h=CardWidth+2*CardMargin,center=true);
    translate([0,Curve+CardDepth/2,0]) rotate([0,90,0]) cylinder(r=Curve,h=CardWidth+2*CardMargin+1,center=true);
   }

   translate([0,0,1]) cube([CardWidth+3*CardMargin,CardDepth*2+3*CardMargin,CardHeight+3*CardMargin+1], center=true);
  }
  //Finger hole:
  hull(){
   translate([0,0,CardHeight/6]) rotate([-90,0,0]) cylinder(r=FingerHoleRadius,h=Curve);
   translate([0,0,-CardHeight/6]) rotate([-90,0,0]) cylinder(r=FingerHoleRadius,h=Curve);
  }

  if ( InlayDepth > 0 ) {
   //inlay:
   translate([0,InlayDepth,0])
   difference(){
    //Sample inlay
    union() {
     //rotate([90,0,0]) cylinder(r=10,h=Curve,center=true);
     rotate([90,0,0]) translate([-CardWidth/2,-CardHeight/2,0]) linear_extrude(height=Curve) import(InlayFilename,layer="Detail");
     rotate([90,0,0]) translate([-CardWidth/2,-CardHeight/2,0]) linear_extrude(height=Curve) import(InlayFilename,layer="Monogram");
    }
    
    //Trim to the surface to be inlaid:
    translate([0,Curve+CardDepth/2+WallThickness,0]) rotate([0,90,0]) cylinder(r=Curve+CardDepth+2*WallThickness,h=CardWidth+2*CardMargin+3*WallThickness,center=true);
   }
  }

  //Bevel Edges a bit:
  translate([CardWidth/2+WallThickness*2.5,0,CardHeight/2+WallThickness*1.5]) rotate([0,45,0]) cube([WallThickness*2,Curve,WallThickness*2], center=true);
  translate([-1*(CardWidth/2+WallThickness*2.5),0,CardHeight/2+WallThickness*1.5]) rotate([0,45,0]) cube([WallThickness*2,Curve,WallThickness*2], center=true);
  translate([CardWidth/2+WallThickness*2.5,0,-1*(CardHeight/2+WallThickness*2.5)]) rotate([0,45,0]) cube([WallThickness*2,Curve,WallThickness*2], center=true);
  translate([-1*(CardWidth/2+WallThickness*2.5),0,-1*(CardHeight/2+WallThickness*2.5)]) rotate([0,45,0]) cube([WallThickness*2,Curve,WallThickness*2], center=true);
 }
}
