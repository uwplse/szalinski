// Print with no infill and wall thickness t

//Resolution
$fn=48;

//Radius of joint sphere
r=7;

// Wall thickness. Don't forget to adjust slicer!
t=1;

// Height of top sphere, affects max bending angle and inner diameter of tube
h = 0.7;

// Height of bottom sphere segment. Determines how difficult it is to join parts.
d= 0.3; 

// Determines slope of neck. Decrease to make tube segment longer. Should not be lower than d.
neck = 0.3;

tube(r,t,h,neck,d);

module tube(r,t,u,l1,l2)
{
  trunc_r = r*sqrt(1-u*u); // Radius of truncated circle on top sphere
  cone_h = (r+t)/l1 - (r+t)*l1; // height of cone
  cone_r = (r+t)*sqrt(1-l1*l1); // base radius
  cone_factor = trunc_r/cone_r; // Truncate cone
  zscale = r/(r+t); // Squash bottom sphere to make inside more spherical
  p = ((r+t)*l1+cone_h*(1-cone_factor))*zscale+r*u;

  union() {
    scale([1,1,zscale]) {
      truncSphere(r+t,l2,l1);
      translate([0,0,(r+t)*l1])cylinder(r1=cone_r,r2=cone_r*cone_factor,h=cone_h*(1-cone_factor));
    }
    translate([0,0,p])truncSphere(r,u,u);
  }
}

module truncSphere(r,h1,h2) {
  intersection() {
    sphere(r);
    translate(-r*[1,1,h1])cube(r*[2,2,h1+h2]);
  }
}
