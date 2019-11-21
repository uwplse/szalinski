//Diameter of the flashlight barrel
BarrelDiameter=14.4; //mm
//Height of the diffuser portion, half barrel diameter makes a good diffuser, twice barrel diameter makes a signal wand...
CapHeight=14;
WallThickness=1; //mm
//Adjustment margin for your printer.
Margin=0.2; //mm
//Cut a cone out of the tip
DoCutout=1;//[0:No,1:Yes]
//Cut a notch out of the side-wall for a lanyard (attached to the flashlight)
NotchWidth=0;//[0:5]
//Cut out a hole to attach a lanyard to the tip itself
LanyardHole=0;//[0:5]
/* [Hidden] */
TipDiameter=BarrelDiameter*10/14; //mm
GripHeight=BarrelDiameter*3/14; //mm
NotchHeight=0.5;//[1:5]
// Facets in the anti-roll portion of the grip.
AntiRoll=8;

difference(){
 union(){
   //Cone Portion:
   difference(){
    cylinder(r1=TipDiameter/2+WallThickness, r2=(BarrelDiameter+Margin)/2+WallThickness,h=CapHeight);
    translate([0,0,WallThickness]) cylinder(r1=TipDiameter/2, r2=(BarrelDiameter+Margin)/2, h=CapHeight);
   }
   //Barrel Grip Portion:
   translate([0,0,CapHeight])
    difference(){
     union(){
      cylinder(r=(BarrelDiameter+Margin)/2+2*WallThickness, h=GripHeight+1, $fn=AntiRoll);
      translate([0,0,-1*((BarrelDiameter+Margin)/2+2*WallThickness)]) cylinder(r2=(BarrelDiameter+Margin)/2+2*WallThickness,r1=0,h=(BarrelDiameter+Margin)/2+2*WallThickness,$fn=AntiRoll);
     }
     translate([0,0,0]) cylinder(r=(BarrelDiameter+Margin)/2, h=GripHeight*10,center=true);
    }
  //Central, light-reflecting cone
  translate([0,0,0]) cylinder(r1=TipDiameter/2+WallThickness, r2=WallThickness, h=CapHeight);
 }
 if ( DoCutout ) translate([0,0,-0.01]) cylinder(r1=TipDiameter/2, r2=0, h=CapHeight-1);
 if ( NotchWidth ) {
  #translate([0,BarrelDiameter/2+WallThickness/2,CapHeight+GripHeight+NotchHeight])
   hull(){
    translate([0,0,NotchHeight]) rotate([90,0,0]) cylinder(r=NotchWidth/2,h=WallThickness*2,$fn=6, center=true);
    translate([0,0,-NotchHeight]) rotate([90,0,0]) cylinder(r=NotchWidth/2,h=WallThickness*2,$fn=6, center=true);
   }
 }
 if ( LanyardHole ){
  # translate([0,-BarrelDiameter/2+WallThickness/2,CapHeight+GripHeight-LanyardHole/2]) rotate([90,22.5,0]) cylinder(r=LanyardHole/2,h=WallThickness*2,$fn=8);
 }
 //translate([-50,-50,30]) cube([100,100,100]);
}

