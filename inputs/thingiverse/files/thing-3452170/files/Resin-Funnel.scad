// Customiseable Resin Funnel
// Created 25/02/2019 by Nick Wells

/* [Funnel Paramaters] */
// Funnel Angle (degrees)
funnelA     = 50; // [20:5:60]
// Funnel Height (mm)
funnelH     = 50; // [30:5:100]

// Inner spout outside diameter (mm) 
spoutOD  = 22; // [5:1:30]
// Inner spout length (mm) 
spoutH   = 18; // [2:1:30]

// Outer collar inside diameter (mm)
collarID = 46; // [20:1:50]
// Outer collar height (mm)
collarH  = 18; 

// Wall thickness (mm)
wallT    = 2; // [0.5:0.5:5]

// Circle sections (try 3 or 4, cool eh!)
$fn=100; // [3,4,5,6,8,10,12,20,50,100]


//                  ID    OD    H
// Anycubic resin   25    38    25
// Elegoo resin     25    38    25
// Wannhao resin    28    42    16


funnel();

module funnel()
{
  rotate_extrude(convexity = 10)
  translate([(spoutOD/2)-wallT/2, 0, 0])
  {
    // funnel
    hull()
    {
      width = funnelH/tan(funnelA);
      translate([width-wallT/2,funnelH-wallT/2])circle(d=wallT);
      circle(d = wallT);
  
    }
    // spout
    hull()
    {
       circle(d = wallT);
       translate([0,-spoutH+wallT/2])circle(d=wallT);
    }
    
    // collar
    hull()
    { 
      circle(d = wallT);
      translate([(collarID-spoutOD)/2+wallT,0])circle(d=wallT);
    }
    hull()
    { 
      translate([(collarID-spoutOD)/2+wallT,0])circle(d=wallT);
      translate([(collarID-spoutOD)/2+wallT,-collarH+wallT/2])circle(d=wallT);
    }
  }
}