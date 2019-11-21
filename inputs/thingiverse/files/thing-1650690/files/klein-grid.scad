//  Klein Bottle scaffold

// PARAMETERS

// Number of strands running along the Klein bottle
long_ribs = 10;         // [3:25]

// Number of strands cutting across the Klein bottle
lat_ribs = 10;          // [5:50]
center=[0,0,0]*1;
normal=[0,0,1]*1;

// Radius of the self-intersection circle
outer_radius=50;      // [10:100]

// Radius of each of the component circles
inner_radius=15;      // [1:40]

// Thickness of each strand
thickness=1;          // [1:20]

// Smoothness of curves running along the Klein bottle
outer_density=10;     // [1:100]

// Smoothness of curves cutting across the Klein bottle
inner_density=10;     // [1:100]


for(i=[0:1:2*lat_ribs]) {
  for(j=[0:1:long_ribs]) {
    for(x=[i:1/outer_density:i+1]) {
      pipe(klein_pos(x,j), klein_pos(x+1/outer_density,j), thickness);
    }
    for(y=[j:1/inner_density:j+1]) {
      pipe(klein_pos(i,y), klein_pos(i,y+1/inner_density), thickness);
    }
  }
}


function klein_pos(i,j) =
  let(a_i = i*360/lat_ribs)
  let(a_j = j*360/long_ribs)
  let(uv0 = [1,0,0])
  let(uv1 = rotate_matrix(0,0,a_j)*uv0)
  let(uv2 = uv1+uv0)
  let(uv3 = rotate_matrix(0,0,a_i/2)*uv2)
  let(uv4 = inner_radius*uv3)
  let(uv5 = rotate_matrix(90,0,0)*uv4)
  let(uv6 = rotate_matrix(0,0,a_i)*uv5)
  let(uv7 = uv6+outer_radius*rotate_matrix(0,0,a_i)*uv0)
  uv7;

function rotate_matrix(a,b,c) = 
  // tait-bryan: yaw, then pitch, then roll
    [[1,0,0],
     [0,cos(a),-sin(a)],
     [0,sin(a),cos(a)]] *
    [[cos(b),0,-sin(b)],
     [0,1,0],
     [sin(b),0,cos(b)]] *
    [[cos(c),-sin(c),0],
     [sin(c),cos(c),0],
     [0,0,1]];

module pipe(from, to, thickness) {
  hull() {
    translate(from)
      sphere(thickness);
    translate(to)
      sphere(thickness);
  }
}

module torus(center, normal, radius, thickness, sides) {
  for(i=[0:1:sides]) {
    pipe(center+radius*[sin(i*360/sides), cos(i*360/sides), 0],
	 center+radius*[sin((i+1)*360/sides), cos((i+1)*360/sides), 0],
	 thickness
      );
  }
}
