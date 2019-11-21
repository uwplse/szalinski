accuracy =1;   // detalization in mm (0.25,0.4,0.5,1.0,2,3,4,5,6,10,20) 
vase = 1;      // 1 for vase, 0 for candybowl

qty = 10;      // quantity of protrusion
tw  = 60;      // angle of twist
pvv = 0.82;    // part of sinusoid vertical 0.3-1.0 
pt  = 1.5;     // part of sinusoid for twist or 0 for linear
kv  = 0.6;     // koeff vertical < 1.0
kp  = 0.06;    // koeff protrusion < 0.5

pv  = ((vase==1)?1:0) + pvv; // part of sinusoid vertical 0.5-1.0 for bowl, 1.5-1.9 for vase
h   = (vase==1)?180:60;      // height of vase
d   = 100;                   // base diameter


function fz(z)     = d/2+sin(pv*180*z/h)*kv*d/2;             // radius by height
function fy(angle) = sin(angle*qty)*kp*d/2;                  // radius by angle
function fx(z)     = ((pt==0)?1:sin(pt*180*z/h))*tw*z/h;     // twist: angle by height

function f(z,angle)= fz(z)+fy(angle+fx(z));

e  = h/floor(h/accuracy);
dz = e;              // height of layer
n  = 360/e;          // quantity of segments
a  = 360/n;          // step: angle of segment


module shape()
{
   p  = [for( z=[0:dz:h], angle=[0:a:360-a]) [ sin(angle)*f(z,angle), cos(angle)*f(z,angle), z ]];
   
   m = n*h/dz;
   echo("accuracy",e, "faces",2*m+2);
   f1 = [for( q=[0:n:m-n], i=[0:n-1], j=[0:1]) 
           (j==0)? ( (i==n-1)? [q+n-1, q,   q+n    ] : [q+i, q+i+1,   q+i+n+1] ):
                   ( (i==n-1)? [q+n-1, q+n, q+2*n-1] : [q+i, q+i+n+1, q+i+n  ] )];

   f = concat([[for(i=[0:n-1]) i]],[[for(i=[m:m+n-1]) i]], f1); // add bottom and roof
   
   polyhedron(points=p, faces=f);
}

translate([0,0,-h/2])
shape();



