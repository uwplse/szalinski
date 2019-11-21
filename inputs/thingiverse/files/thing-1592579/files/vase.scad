//Simple Bowl

radius = 10;//bowl radius
side = 7;//bowl side
hole = 5.5;
//take away soild's thickness
thickness = side - hole;

h = 50;
//body height

BodyS = "no";
BaseS = "yes";
//inside soild="yes" or "no"

bodyTwist = 90;
//twist angle

bodySlices = 3;
//smoothe

bodyScale = 1.3;
//scale

baseHeight = 1.5;



//$fn : fixed number of fragments in 360 degrees.

//Offset allows moving 2D outlines outward or inward by a given amount.

/////////////////////////////////
//Render

//Base
linear_extrude(height = baseHeight)
{
    Bowl(BaseS);
}

//Body
translate([0,0,baseHeight])
  linear_extrude(height = h , twist =  bodyTwist ,slices = bodySlices , scale = bodyScale )
  {
    Bowl(BodyS);
  }




////////////////////////////////
module Bowl(soild){
  difference()
  {
    //start outside shape
    offset(r = radius ,$fn = 48)
    {
      circle(r = radius,$fn = side);
    }
    //take away inside shape
    if(soild == "no")
    {
      offset(r = radius-thickness ,$fn = 48)
      {
        circle(r = radius,$fn = side);
      }
    }
    
  }
}