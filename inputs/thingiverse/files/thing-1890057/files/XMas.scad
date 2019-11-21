XPointStar = 5; // [3:10]
Height = 100;
Twist = 0.5; // [0:0.1:2]
BaseSizeMax = 30;
BaseSizeMin = 15;

/* [Hidden] */
$fn = 256;
ScaleFactor = 0.1;

arc = 360 / (XPointStar*2);
points = [ 
  for(a=[0:XPointStar*2])
      (a%2==0 ? BaseSizeMin:BaseSizeMax) *
        [sin(arc*a),
         cos(arc*a)]
];

linear_extrude(height=Height,
               twist=Twist*360,
               scale=ScaleFactor)
    polygon(points);