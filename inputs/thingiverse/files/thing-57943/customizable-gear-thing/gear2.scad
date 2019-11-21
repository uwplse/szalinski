//CUSTOMIZER VARIABLES

//radius of the bottom gear (to edge of teeth)
_Radius_1 = 20;//[6:50]
//radius of the center hole
_Radius_center = 5;//[0:20]
// number of teeth on the bottom gear
_Teeth_1 = 40;//[6:60]
//height of the bottom gear
_Height_1 = 5;//[1:10]
//radius of the top gear (to edge of teeth)
_Radius_2 = 10;//[6:50]
//number of teeth on the top gear
_Teeth_2 = 20;//[6:60]
//height of the top gear
_Height_2 = 5;//[1:10]

//CUSTOMIZER VARIABLES END

r = _Radius_1*1;
rc = _Radius_center * 1;
t = _Teeth_1*1;
h = _Height_1*1;

r2 = _Radius_2*1;
t2 = _Teeth_2*1;
h2 = _Height_2*1;

 
module gear()
{
  q = 360/t;
  w = q/2;
difference()
{
  circle(r-.9);
  circle(rc);
}
  for(i=[0:t])
  {
    polygon([[sin(i*q)*(r-1.1),cos(i*q)*(r-1.1)],[sin((i*q)+w)*(r),cos((i*q)+w)*(r)],[sin((i+1)*q)*(r-1.1),cos((i+1)*q)*(r-1.1)]]);
  }
}

module gear2()
{
 
  q2 = 360/t2;
  w2 = q2/2;
difference()
{
  circle(r2-.9);
  circle(rc);
}

  for(i=[0:t2])
  {
    polygon([[sin(i*q2)*(r2-1.1),cos(i*q2)*(r2-1.1)],[sin((i*q2)+w2)*(r2),cos((i*q2)+w2)*(r2)],[sin((i+1)*q2)*(r2-1.1),cos((i+1)*q2)*(r2-1.1)]]);
  }
}
module final()
{

union(){
 // cylinder((h+h2),rc+1,rc+1);
  linear_extrude(height=h)
    gear(); 

  translate([0,0,h])
  linear_extrude(height=h2)
    gear2(); 
  }

}

//difference(){
final();
//cylinder((h+h2),rc,rc);
//}