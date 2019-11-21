// height (thickness)
h=0.4;

// depth (length)
d=10.0;

// width of needle
w=2.0;

// handle width
hw=10.0;

// handle depth
hd=10.0;

// handle height
hh=1.0;

linear_extrude(height=h)
polygon([[-hd/2,0],
         [d,0],
         [d-w,w],
         [-hd/2,w]]);

translate([0,w/2,0])
rotate([0,0,135])
linear_extrude(height=hh)
polygon([[0,0],
         [hd,0],
         [hd,hw],
         [0,hw]]);


