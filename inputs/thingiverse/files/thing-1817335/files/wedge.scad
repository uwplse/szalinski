// Angle to tilt the carboy/bucket
tilt_angle = 10;
// Radius of the carboy or bucket
radius = 150;
// Length of wedge piece
length = 60;
// Width of tall part of wedge
width = 20;
// Bevel size
bevel_size = 1.5;
// Width of the base/stabilizer
base_width = 40;
// height of stabilizer base
base_height = 5;

/* [Hidden] */
angle = tilt_angle;
r = radius;
l = length;
w = width;
b = bevel_size;
basew = base_width;
baseh = base_height;

module bevels(w,h,l,a,b=b) {
  ba = b*sin(a);
  la = l*sin(a);

  x = [0,b,b*2,l-b*2,l-b,l];
  y = [0,b,b*2,w-b*2,w-b,w];
  z = [0,h-b*2,h-b,h];
  zo = [0,-ba,-ba*2,-la+ba*2,-la+ba,-la];

  points = [[x[0],y[1],z[0]+zo[0]],
            [x[0],y[4],z[0]+zo[0]],
            [x[0],y[1],z[1]+zo[0]],
            [x[0],y[4],z[1]+zo[0]],
            [x[0],y[2],z[2]+zo[0]],
            [x[0],y[3],z[2]+zo[0]],
            [x[1],y[0],z[0]+zo[0]],
            [x[1],y[5],z[0]+zo[0]],
            [x[1],y[0],z[1]+zo[1]],
            [x[1],y[5],z[1]+zo[1]],
            [x[1],y[2],z[3]+zo[1]],
            [x[1],y[3],z[3]+zo[1]],
            [x[2],y[0],z[0]+zo[0]],
            [x[2],y[5],z[0]+zo[0]],
            [x[2],y[0],z[2]+zo[2]],
            [x[2],y[5],z[2]+zo[2]],
            [x[2],y[1],z[3]+zo[2]],
            [x[2],y[4],z[3]+zo[2]],
            [x[3],y[0],z[0]+zo[0]],
            [x[3],y[5],z[0]+zo[0]],
            [x[3],y[0],z[2]+zo[3]],
            [x[3],y[5],z[2]+zo[3]],
            [x[3],y[1],z[3]+zo[3]],
            [x[3],y[4],z[3]+zo[3]],
            [x[4],y[0],z[0]+zo[0]],
            [x[4],y[5],z[0]+zo[0]],
            [x[4],y[0],z[1]+zo[4]],
            [x[4],y[5],z[1]+zo[4]],
            [x[4],y[2],z[3]+zo[4]],
            [x[4],y[3],z[3]+zo[4]],
            [x[5],y[1],z[0]+zo[0]],
            [x[5],y[4],z[0]+zo[0]],
            [x[5],y[1],z[1]+zo[5]],
            [x[5],y[4],z[1]+zo[5]],
            [x[5],y[2],z[2]+zo[5]],
            [x[5],y[3],z[2]+zo[5]],
            ];
   hull() {
    for (p = points) {
      translate(p)
      sphere(r=0.1, center=true);
    }
  }
}

bevels(w,r*2*sin(angle),l,angle);
translate([0,-(basew-w)/2])
bevels(basew,baseh,l,0);
translate([0,-b])
bevels(w+b*2,baseh+b,l,0);
