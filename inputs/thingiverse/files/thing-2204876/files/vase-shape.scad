accuracy = 1;    // detalization in mm (0.25,0.4,0.5,1.0,2,3,4,5,6,10,20) 
h        = 180;  // height of vase
d        = 70;   // base diameter

tw  = 30;         // angle of twist
pt  = 3;         // part of sinusoid for twist or 0 for linear

pv  = 1.82;      // part of sinusoid vertical 0.3-2.0 
kv  = 0.35;      // koeff vertical < 1.0
  
e  = h/floor(h/accuracy);
dz = e;          // height of layer
n  = 360/e/2;    // quantity of segments
a  = 360/n;      // step: angle of segment

translate([0,0,-h/2]) shape();

//----------------------------------------------------------------------------

// heart shape 
function x(t)=(12*sin(t)-4*sin(3*t))/10;
function y(t)=(13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t))/10;

// star shape 
/*
mm=5;
n2=3;
n1=1;
function x(t)=cos(t)/pow( pow(abs(cos(mm*t/4)),n2)+pow(abs(sin(mm*t/4)),n2), 1/n1);
function y(t)=sin(t)/pow( pow(abs(cos(mm*t/4)),n2)+pow(abs(sin(mm*t/4)),n2), 1/n1);
*/

//-------------------------------------------------------------------------

function fh(z)      = d/2*(1+sin(pv*180*z/h)*kv);            // radius by height
function ftwist(z)  = (pt==0 ? 1 : sin(pt*180*z/h))*tw*z/h;  // angle by height

// to polar coordinates
function r(v) = sqrt(pow(v[0],2)+pow(v[1],2));
function a(v) = atan2(v[1],v[0]);
// rotate in polar coordinates and back to cartesian
function twist(v,z) = [sin(a(v)+ftwist(z))*r(v), cos(a(v)+ftwist(z))*r(v), v[2]];

module shape()
{
  p = [for(z=[0:dz:h], angle=[0:a:360-a]) 
         twist([x(angle)*fh(z),y(angle)*fh(z),z],z)];
  
  m = n*h/dz;
  f1 = [for( q=[0:n:m-n], i=[0:n-1], j=[0:1]) 
         (j==0)? ( (i==n-1)? [q+n-1, q,   q+n    ] : [q+i, q+i+1,   q+i+n+1] ):
                 ( (i==n-1)? [q+n-1, q+n, q+2*n-1] : [q+i, q+i+n+1, q+i+n  ] )];

  f = concat([[for(i=[0:n-1]) i]],[[for(i=[m:m+n-1]) i]], f1); // add bottom and top
   
  polyhedron(points=p, faces=f);
}
