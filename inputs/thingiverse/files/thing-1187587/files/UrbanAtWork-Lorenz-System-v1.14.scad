// Lorenz System - Lorenz Chaotic attractor
// 2015-12-09
// by Urban Reininger with lots of help from David Morgan, JeanInNepean and Atartanian
//
// Tested with OpenSCAD 2015.03
// 
// for OpenSCAD use beta=8.0/3.0;
//
// Parameters
sigma=10.0;
// is ~ 8/3:
beta = 2.6666666667;
rho=28.0;

// dt Move this just a small amount for chaotic results:
dt=0.009; //[0.01:0.001:0.02]

// Recursions (number of spheres):
recursions = 2000; // [1:1:3000]

// Sphere size (one is default):
size=1; // [1:1:11]

function gen_p(p,n=0)=n==0?p:concat([p],gen_p([
        p.x+dt*(-sigma*p.x+sigma*p.y),
        p.y+dt*(rho*p.x-p.y-p.x*p.z),
        p.z+dt*(-beta*p.z+p.x*p.y)
    ],n-1));

color("red")
for (i=gen_p([1,1,1],recursions)) translate(i) sphere(size);