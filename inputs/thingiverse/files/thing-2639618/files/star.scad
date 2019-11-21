
// outer points radius
outer_radius = 25;
// inner points radius
inner_radius = 10;
// number of spikes
spikes       = 5;
// heigth
height       = 10;
// wall width (width == 0: solid)
width        = 2;
// top is wider/narrower than bottom
scale        = 1;


module starBox(ro = 1, ri = 2, n = 5, h = 1, w = 0.2, s = 1)
{
  // create 2d vector shape: star
  poly = [for(i=[0:(2*n-1)])
      (i%2==0)?
        [ri*cos(180*i/n),ri*sin(180*i/n)]:
        [ro*cos(180*i/n),ro*sin(180*i/n)]
      ];

  difference()
  {
    linear_extrude(h, scale=s)
      polygon(points=poly) ;
    if ((w > 0) && (s != 0))
      translate([0,0,w])
        linear_extrude(h-w*0.999, scale=s)
        offset(delta=-w)
        polygon(points=poly) ;
    }
}


starBox(ro = outer_radius,
        ri = inner_radius,
        n  = spikes,
        h  = height,
        w  = width,
        s  = scale) ;

