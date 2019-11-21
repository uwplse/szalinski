/* [Settings] */
ShaftDiameter = 5;
PlasticSaverRingDepth = 0;
ShaftCut = 1;

/* [Gear 1] */
Gear1Height = 4;
Gear1TeethCount = 40;
Gear1TeethSpacing = 2;
Gear1TeethDepth = 2;

/* [Gear 2] */
Gear2Height = 10;
Gear2TeethCount = 12;
Gear2TeethSpacing = 3;
Gear2TeethDepth = 2;


difference(){
  union(){
    linear_extrude(height = Gear2Height)
      gear3(Gear2TeethCount,Gear2TeethSpacing,Gear2TeethDepth);
    translate([0,0,-Gear1Height]) linear_extrude(height = Gear1Height)
      gear3(Gear1TeethCount,Gear1TeethSpacing,Gear1TeethDepth);
  }
  if(ShaftCut>0){
   difference(){
     cylinder(h=(Gear1Height+Gear2Height)*3, d=ShaftDiameter,center=true,$fn=64);
    translate([0,ShaftDiameter-ShaftCut])
       cube([ShaftDiameter+1,ShaftDiameter,
             (Gear1Height+Gear2Height)*3],center=true);
   } 
  }else{
    cylinder(h=(Gear1Height+Gear2Height)*3, d=ShaftDiameter,center=true,$fn=64);
  }
  
  if(PlasticSaverRingDepth > 0){
    translate([0,0,-PlasticSaverRingDepth])difference(){
      diameter1 = (Gear1TeethCount*Gear1TeethSpacing)/3.1415-Gear1TeethDepth-1;
      diameter2 = (Gear2TeethCount*Gear2TeethSpacing)/3.1415+Gear2TeethDepth+1;
      
      cylinder(h=5+PlasticSaverRingDepth, d=diameter1,$fn=64);
      translate([0,0,-0.1]) 
        cylinder(h=6+PlasticSaverRingDepth, d=diameter2,$fn=64);
    }
  }
}
module gear3(TeethCount, TeethSpacing, TeethDepth){
  diameter = (TeethSpacing*TeethCount)/3.1415;
  gear2(TeethCount,diameter,TeethDepth);
}
module gear2(TeethCount, Diameter, TeethDepth){
  Radius = Diameter/2;
  teethDepth = TeethDepth;
  
  totalPoints = 6*TeethCount; // 6 poits per teeth
  degPoint = 360.0/totalPoints;
  //echo (degPoint);
  points = [ 
    for (a = [0 : totalPoints]) 
      //(Radius + (((a%4 < 2 )? 0.5 : -0.5) * teethDepth )) 
      (Radius + teeth(a)*teethDepth)
        * [ sin(a*degPoint), cos(a*degPoint) ] ];
  polygon(concat(points, [[0, 0]]));
}
module gear1(){
  Radius = 10;
  teethDepth = 2;
  points = [ 
    for (a = [0 : 360]) 
      //(Radius + (((a%4 < 2 )? 0.5 : -0.5) * teethDepth )) 
      (Radius + teeth(a)*teethDepth)
        * [ sin(a), cos(a) ] ];
  polygon(concat(points, [[0, 0]]));
}

function teeth(x) = (x % 6 == 0) ? 0.5 : 
                    (x % 6 == 1) ? 0.25:
                    (x % 6 == 2) ? -0.5: 
                    (x % 6 == 3) ? -0.5:
                    (x % 6 == 4) ? 0.25: 0.5 ;