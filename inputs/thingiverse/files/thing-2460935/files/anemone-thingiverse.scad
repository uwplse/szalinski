//    Anemone generator
//    Fernando Jerez 2017
//    License:CC Attributtion only
//    This script uses Noise functions taken from Torleif website:
//    https://openscadsnippetpad.blogspot.com.es/2017/05/1-dimensional-noise.html
//    
//

// This is only to force Customizer create many files. Changes doesnt matter. Just click CREATE THING
part = "all"; // [all:See anemone and base, anemone1: Anemone 1, anemone2: Anemone 2,base1: Base 1,base2: Base 2]


// Number of tentacles
tentacles = 20; //[1:40]

// Twist (of tentacles)
twist = 50; // [0:100]

// Tentacle max length
maxlength = 60; //[1:100]

// Tentacle min length
minlength = 30; //[1:100]

/* [Hidden] */

sem = round(rands(1,10000,1)[0]); // Random seed

// Generates a Smooth Noise list with values between -0.5 and 0.5
maxnoi = 1000;
noi2 = [ for (i = [0 : maxnoi]) single_noise_1d(i*0.1+sem)-0.5];
// Reduces non-rotating zones from noise sequence
noi = [ for (i = [0 : maxnoi]) noi2[ (i + 1*max(0.1,5-10*abs(noi2[i])))%maxnoi] ];

// Generate a rotation list using Recursion
function noiserot(i,n) = (i==0) ? 0 : noiserot(i-1,n) + twist*noi[(i+n)%maxnoi];
rotlist = [for (i=[0:maxnoi]) noiserot(i,0)];

// Generates a list of positions using RECURSION
function stepPos(steps,i,n)= 
    (i==0)
    ?
    [0,0,0]
    : 
    stepPos(steps,i-1,n)+[(steps-i)*0.75*sin(rotlist[(i+n)%maxnoi]),(steps-i)*0.75*cos(rotlist[(i+n)%maxnoi]),(steps-i)*0.75*sin(rotlist[(i+n)%maxnoi])];

lados = tentacles;
grados = 360/lados;
limits = rands(min(maxlength,minlength),max(maxlength,minlength),lados,sem);


// FIGURE 

if(part=="all" || part=="base1" || part=="base2" || part=="base3" ){
    // anemone - base
    translate([0,0,-10]){
        color("Orange") anemone_base(radius=10,height=20);
    }
}

if(part=="all" || part=="anemone1" || part=="anemone2" || part=="anemone3" ){
    // anemone - tentacles
    cylinder(r=10,h=7);
    translate([0,0,-1]) cylinder(r1=9,r2=10,h=1);

    translate([0,0,5])
    difference(){
        scale([0.1,0.1,0.1]){
            for(g=[0:grados:360-grados]){
                // Generate position list var g is for offset in noiserot list
                limit = round(limits[g/grados]);
                offs = g;
                
                poslist = [for (i=[0:limit]) stepPos(limit,i,offs)];

                rotate([0,0,g])
                translate([0,0,0.3*limit*limit])
                {
                // Draw geometry using list positions
         
                    for(i=[0:limit]){
                        rad = limit-i;
                        px = poslist[i][0];
                        py = poslist[i][1];
                        pz = -0.3*rad*rad;
                        translate([px,py,pz]) rotate([90+38,0,-rotlist[i+offs]]) cylinder(r=rad, h=rad*1.3,$fn=12);
                    }
                }
            }    
        }
        translate([0,0,-50]) cube([300,300,100], center = true);
    }
}


module anemone_base(radius = 10, height=30){
    numpuntos = height;
    puntos = concat([[2,height],[0,height-2]],[[0,0]],[ for (i = [0 : numpuntos]) [0.2*(height-i)+1+radius*0.35*single_noise_1d(i*0.2+sem),i] ]);
    rotate_extrude(angle=360){
        translate([radius,0,0])
        polygon( puntos);
    }
}

// NOISE FUNCTIONS
// https://openscadsnippetpad.blogspot.com.es/2017/05/1-dimensional-noise.html
function single_noise_1d(i)=
let(
a=floor(i),
b=ceil(i),
c=smooth_curve(i-a),
arnd=rnd(1,0,a),
brnd=rnd(1,0,b),
out=lerp(arnd,brnd,c)
)
out
;


function smooth_curve(a) =let (b = clamp(a))(b * b * (3 - 2 * b));
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
