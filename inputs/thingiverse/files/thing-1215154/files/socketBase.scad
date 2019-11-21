/* [Base] */

NUMBERSOCKETS = 8;

/* [Hidden] */
BASE=21;

case();

module case()
{   
 obWidth = BASE+20;
 obLength = (BASE+1)*NUMBERSOCKETS+15;

 difference()
  {
    difference()
    {
      outerBlock(obWidth, obLength);
      union()
      {
       translate([0,BASE/2-5,-1])
        cube([BASE+10, (BASE)*NUMBERSOCKETS+15, 4], center=true);            
       translate([0,BASE/2-5,1])
        cube([BASE+2, (BASE)*NUMBERSOCKETS+15, 8], center=true);
      }        
    }
    cuts(obWidth, obLength);
  }
       tracks(obWidth, obLength);
}

module outerBlock(obWidth, obLength)
{
    union()
    {
      cube([obWidth, obLength, 10], center=true); 
      translate([0,6,-4.5])
       cube([obWidth, obLength+12,3], center=true); 
      translate([0,obLength/2+5,-3])
       rotate([0,90,0])
        cylinder(r=3,h=obWidth/3, $fn=50, center=true); 
    }
}

module cuts(obWidth, obLength)
{
   union()
   { 
    translate([-obWidth/4,0,-7])
     cube([1,obLength/2,4]);
    translate([obWidth/4,0,-7])
     cube([1,obLength/2,4]);     
    translate([-obWidth/2,obLength/2,-6])
     cube([obWidth/4+1,1,3]);      
    translate([obWidth/4,obLength/2,-6])
     cube([obWidth/4,1,3]); 
   }
}

module tracks(obWidth, obLength)
{
    union()
    {
        track(obWidth, obLength);
        mirror([1,0,0]) track(obWidth, obLength);
    }
}

module track(obWidth, obLength)
{
 translate([-obWidth/4-5.25,-obLength/2,-3.0])
 polyhedron(
    points=[ [0,0,0],[0,0,4],[4,0,4],
           [0,obLength,0],[0,obLength,4],[4,obLength,4]  ], 
    faces=[ [0,1,2],[4,1,0,3],[1,4,5,2],[0,2,5,3],              
              [5,4,3] ]                         
 );
    
}