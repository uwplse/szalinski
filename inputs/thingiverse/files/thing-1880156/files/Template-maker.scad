shape = 1; //[1: star, 2: polygon, 3: circle, 4: rectangle]

// For stars, polygons and circle
radius = 20;

// For stars and polygons, 3 sided star does not work.
sides = 5;

// For stars only
inner_radius = 10;

// For rectangle
width = 20;

// For rectangle
height = 20;

/*[Adjust]*/
// Thickness of the cutting edge
thickness = 0.8;
// Width of the padding at the bottom
pad_width = 5;
// Height of the padding at the bottom
pad_height = 1;
// Height of the overall cutter
depth = 10;

/* [Hidden] */

if(shape == 1) {
    templatify(star(radius, inner_radius, sides));
}
else if(shape == 2) {
    templatify(ngon(radius, sides));
}
else if(shape == 3) {
    templatify(ngon(radius, radius * 6));
}
else if(shape == 4) {
    templatify([[0,0],[width,0],[width,height],[0,height]]);
}

function star(r_out, r_in, sides) = 
    let(a = 360 / (sides*2))
    [for(i = [0:(sides*2-1)]) 
        let(r = i%2 ? r_out : r_in)
        [cos(a*i+a/2) * r, sin(a*i+a/2) * r]];
    
function ngon(r, sides) = star(r, r, sides / 2);
    
function circ(r) = star(r, r, 48);

function get(points, i, cp) = 
    (i<0) ? points[cp+i%cp] : points[i%cp];
    
function dist(p) = sqrt(p[0]*p[0] + p[1]*p[1]);
function slope(p1, p2) = (p2[1]-p1[1])/(p2[0]-p1[0]);
function getderiv(p1, p2) = let(diff = p2-p1) diff / dist(diff);
function getperp(p1, p2) = 
    let(deriv = getderiv(p1, p2))
    [deriv[1], -deriv[0]];
    
function offset(p, c, n, off) = 
    let(
        pp = getperp(p, c), 
        pcp = c + pp * off,
        ppp = p + pp * off,
        np = getperp(c, n), 
        ncp = c + np * off,
        nnp = n + np * off,
        
        x1 = ppp[0], y1 = ppp[1],
        x2 = pcp[0], y2 = pcp[1],
        x3 = ncp[0], y3 = ncp[1],
        x4 = nnp[0], y4 = nnp[1],
        
        d = (x1-x2) * (y3-y4) - (y1-y2) * (x3-x4),
        a = (x1*y2 - y1*x2),
        b = (x3*y4 - y3*x4)
    )

    [
        (a * (x3-x4) - (x1-x2) * b) / d,
        (a * (y3-y4) - (y1-y2) * b) / d
        
    ];
     

module templatify(
    points, 
    depth = depth, 
    thickness = thickness,
    pad_width = pad_width,
    pad_height = pad_height,
    convexity = 4
) {
  cp = len(points);
    
  prev = [for(i=[0:cp-1]) get(points, i-1, cp)];
  next = [for(i=[0:cp-1]) get(points, i+1, cp)];
  cur = points;
  
  bord = [for(i=[0:cp-1])
       offset(prev[i], cur[i], next[i], thickness)
  ];
    
  pad = [for(i=[0:cp-1])
       offset(prev[i], cur[i], next[i], pad_width)
  ];
      
  
  difference() {
    union() {
        linear_extrude(height = depth, convexity=convexity)
        polygon(bord, convexity=convexity);

        linear_extrude(height = pad_height, convexity=convexity)
        polygon(pad, convexity=convexity);
    }

    translate([0, 0, -0.1])
    linear_extrude(height = depth+0.2, convexity=convexity)
    polygon(points, convexity=convexity);
  }
}

