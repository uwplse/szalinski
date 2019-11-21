// Size (diameter) of pom pom
pompom_diameter = 65; // [10:200]
// Fluffiness on a scale from firm to firmester
fluffiness = 3; // [2:firm,3:firmer,4:firmest,5:firmester]

MAX_FLUFFINESS = 5*1;
THICKNESS=3*1;
TRAPEZOID_A=20*1;
TRAPEZOID_B=12*1;

pompom(pompom_diameter, fluffiness);

module pompom(od, fluffiness_factor)
{
  _ff = fluffiness_factor % (MAX_FLUFFINESS+1);
  id = (_ff / (MAX_FLUFFINESS+1)) * od;
  or = od/2;
  ir = id/2;
  linear_extrude(height=THICKNESS)
  {
    minkowski()
    {
      difference()
      {
        $fa=.1;
        $fs=.1;
        circle(r=or);
        circle(r=ir);
        wedge(or, ir);
      }
      circle(1, $fa=.1, $fs=.1);
    }
  }
}

module wedge(or, ir)
{
  // find the sagitta!
  buffer = 5;
  si = ir - sqrt( pow(ir,2) - pow((TRAPEZOID_B/2),2) );
  so = or - sqrt( pow(or,2) - pow((TRAPEZOID_A/2),2) );
  x_ioffset = ir - si;
  x_ooffset = or - so;
  polygon([ [x_ioffset,TRAPEZOID_B/2],
            [x_ioffset,-TRAPEZOID_B/2],
            [x_ooffset+buffer,-TRAPEZOID_A/2],
            [x_ooffset+buffer,TRAPEZOID_A/2]
          ]);
}

