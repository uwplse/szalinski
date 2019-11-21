/* [Custom] */ 

SCALE = 1.0; // [0.1:0.1:1.0]
NUMBER = 21; // [1,7,21,30,57]
    
if (NUMBER == 1)
{
    finishedWhole();
}
else if (NUMBER == 7)
{
  for(a = [-45 : 15 : 45])
    translate([0,a,0]) finishedWhole();
}
else if (NUMBER == 21)
{    
 for(a = [-45 : 15 : 45])
  for(b = [-61: 61: 61])
   translate([b,a,0]) finishedWhole();    
}
else if (NUMBER == 30)
{    
 for(a = [-45 : 10 : 45])
  for(b = [-61: 61: 61])
   translate([b,a,0]) finishedWhole();    
}
else 
{    
 for(a = [-45 : 5 : 45])
  for(b = [-61: 61: 61])
   translate([b,a,0]) finishedWhole();    
}

module board()
{ 
    cube([4,120,40], center=true);
}

module notch()
{
polyhedron(
  points=[ [-2,-60,15], [-2,-34,0], [-2,-60,-15], 
           [2,-60,15], [2,-34,0], [2,-60,-15], ],                                 
  faces=[ [0,1,2], [0,2,5,3], [0,3,4,1], [1,4,5,2], [3,5,4] ]                         
 );    
}

module hemiPiece()
{
    difference()
    {
        board();
        notch();
    }
}

module roughWhole()
{
    rotate([0,0,30]) translate([-2,-60,0]) hemiPiece();
    rotate([0,0,-30]) translate([2,-60,0]) hemiPiece();
}

module finishedWhole()
{
 scale([SCALE*0.5,SCALE*0.5,SCALE*0.5]) 
  translate([0,55,20])
   union()
   {  
    difference()
    {
        roughWhole();
        cleaver();
    }
    intersection()
    {
     rotate([0,0,30]) translate([-2,-60,0]) hemiPiece();
     rotate([0,0,-30]) translate([2,-60,0]) hemiPiece();        
    }
   }
}

module cleaver()
{
    cube([15,8,45], center=true);
}