/***************************************************
*** (c) 2018 by saarbastler.de
***************************************************/

$fn=100;

// the inner width of the box = card width
cardWidth= 57;

// the inner height of the box = card height
cardHeight= 88;

// the inner depth of the box = deck of card depth
cardThick= 46;//33;

// the corner radius
radius= 5;

// the wall thickness
wall= 1.5;

// card tolerance
tolerance= 0.5;

// clip tolerance
toleranceClip= 0.4;


module cubeRC(wx, wy, wz, rad)
{
  hull()
  {
    translate([-wx/2+radius,-wy/2+radius,0]) cylinder(r=rad, h=wz);
    translate([ wx/2-radius,-wy/2+radius,0]) cylinder(r=rad, h=wz);
    translate([-wx/2+radius, wy/2-radius,0]) cylinder(r=rad, h=wz);
    translate([ wx/2-radius, wy/2-radius,0]) cylinder(r=rad, h=wz);
  }
}

module box()
{
  bx= cardWidth +2*wall +2*tolerance;
  by= cardHeight+2*wall +2*tolerance;
  bz= cardThick +2*wall +2*tolerance;
  
  difference()
  {
    translate([-bx/2,-by/2,0]) cube([bx,by*.5,bz]);
    
    translate([0,0,wall]) cubeRC(cardWidth+2*tolerance,cardHeight+2*tolerance,cardThick+2*tolerance,radius);
    
    translate([0,0,bz-wall-1]) cubeRC(2*cardWidth/3+2*toleranceClip,cardHeight*.5+2*toleranceClip,3*wall,2);
  }
  
  *translate([-cardWidth/4,0,0]) cube([cardWidth/2,cardHeight*.1,wall]);
  cubeRC(2*cardWidth/3,cardHeight*.5,wall,2);
}

*color("darkgrey") translate([0,0,wall+tolerance/2]) cubeRC(cardWidth,cardHeight,cardThick,radius);
//rotate([90,0,0]) 
box();

