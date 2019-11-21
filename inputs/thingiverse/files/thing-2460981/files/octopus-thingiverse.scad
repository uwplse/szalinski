/*

    Octopus generator
    
    Fernando Jerez 2017
    
    License:CC-NC. Creative Commons, Non Commercial

    This script uses Noise functions taken from Torleif's website:
    https://openscadsnippetpad.blogspot.com.es/2017/05/1-dimensional-noise.html
    

*/

// This is only to force Customizer create many files. Changes doesnt matter.
part = "octopus1"; // [octopus1: Octopus #1,octopus2: Octopus #2,octopus3: Octopus #3,octopus4: Octopus #4,octopus5: Octopus #5 ]

// Tentacles style
style = "mechanic"; // [mechanic: Mechanic style, organic: Organic style]
// head style
headstyle = "mechanic"; // [mechanic: Mechanic style, organic: Organic style]

/* [Hidden] */

// Generates a Smooth Noise list with values between -0.5 and 0.5
sem = round(rands(1,1000,1)[0]);
echo (sem);
//sem=705;
maxnoi = 1000;
noi2 = [ for (i = [0 : maxnoi]) single_noise_1d(i*0.1+sem)-0.5];
//echo(min(noi));
//echo(max(noi));

// Reduces 'non-rotating zones' from noise sequence
noi = [ for (i = [0 : maxnoi]) noi2[ (i + 1*max(0.1,5-10*abs(noi2[i])))%maxnoi] ];
//echo (noi);


 

// Generate a rotation list using Recursion
function noiserot(i,n) = (i==0) ? 0 : noiserot(i-1,n) + 50*noi[(i+n)%maxnoi];
rotlist = [for (i=[0:maxnoi]) noiserot(i,0)];




// Generates a list of positions using RECURSION
function stepPos(steps,i,n)= 
    (i==0)
    ?
    [0,0,0]
    : let(m=(steps-i)*0.75, g=rotlist[(i+n)%maxnoi])
    stepPos(steps,i-1,n)+[m*sin(g),m*cos(g),m*sin(g)];

lados = 8;
grados = 360/lados;
 

difference(){
    scale([0.1,0.1,0.1]){
        for(g=[0:grados:360-grados]){
            // Generate position list (var g is for offset in noiserot list)
            limit = 60; 
            offs = g;
            
            poslist = [for (i=[0:limit]) stepPos(limit,i,offs)];

            rotate([0,0,g])
            translate([50,0,0])//0.45*limit*limit])
            {
            // Draw geometry using list positions
     
                for(i=[0:limit]){
                    rad = limit-i;
                    px = poslist[i][0];
                    py = poslist[i][1];
                    pz = (800*cos((i)))/(i+3);// -0.45*rad*rad;//rad;
                    gg=-pz*0.15;
                    
                    if(style=="organic"){
                        // organic
                        translate([px,py,pz]) rotate([90-45,0,-rotlist[i+offs]])  sphere(r=rad,$fs=20);
                    }else if(style=="mechanic"){
                        // Mechanic
                        translate([px,py,pz]) 
                        rotate([90+gg,0,-rotlist[1+i+g]]) 
                        translate([0,0,-rad*1]) 
                        cylinder(r1=rad*1,r2=rad*0.6,h=rad*1.4,$fn=5);
                    }
                    
                }
            }
        }    
    }
    translate([0,0,-50]) cube([500,500,105], center = true);
}
if(headstyle=="organic"){
    // organic head
    color("Orange") translate([-10,0,30]) scale(1.2) octopushead_ball();
}else if(headstyle=="mechanic"){
    // mechanic head
    color("Orange") translate([-5,0,30]) scale(1.2) octopushead_punk();
}


module octopushead_punk(){
    rotate([0,-30,0])
    scale([2,1,1])
    randomRock(10,2,20);
    
    translate([-5,0,0]){
        rotate([0,-75,60]){
            difference(){
                cylinder(r=4,h=9);
                translate([0,0,7])
                cylinder(r=3,h=5);
            }
            translate([0,0,7]) sphere(r=3);
        }
        rotate([0,-70,-60]){
            difference(){
                cylinder(r=4,h=9);
                translate([0,0,7])
                cylinder(r=3,h=5);
            }
            translate([0,0,7]) sphere(r=3);
        }
    }

    rotate([0,15,0])
    translate([5,0,0])
    scale([2,2.75,2])
    randomRock(5,2,10);

 

}


module octopushead_ball(){
    difference(){
        hull(){
            translate([0,0,-2]) rotate([0,-20,0]) scale([0.5,0.5,0.5]) sphere(r=12);
            translate([15,0,5])
            scale([1,0.7,0.7]) sphere(r=18);
        }
        
    }
    translate([3, 4,5]) rotate([-25,0,0]) scale([1,1,0.75])sphere(r=6);
    translate([3,-4,5]) rotate([25,0,0]) scale([1,1,0.75]) sphere(r=6);
}

module randomRock(radius,corner_size,number_of_corners){
    // Draw rock
    hull(){
        // Make a hull..
        for(i=[0:number_of_corners]){
            // random position in 'sphere'
            y = rands(0,360,1)[0];
            z = rands(0,360,1)[0];
            rotate([0,y,z])
            
            // translate radius (minus half of corner size)
            translate([radius-corner_size*0.5,0,0])
            
            // draw cube as corner
            rotate([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]]) // random rotation
            cube(rands(corner_size*0.5,corner_size,1)[0],center = true);
            
            rotate([0,y,-z])
            
            // translate radius (minus half of corner size)
            translate([radius-corner_size*0.5,0,0])
            
            // draw cube as corner
            rotate([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]]) // random rotation
            cube(rands(corner_size*0.5,corner_size,1)[0],center = true);
            
        }
    }

    // Done!
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

function  noise_1d(i,
low_range=1/4,mid_range=1,hi_range=8,
low_magnitude=1/2,mid_magnitude=0.25,hi_magnitude=0.5)=
 (  
single_noise_1d(i/low_range)*low_magnitude+
single_noise_1d(i/mid_range)*mid_magnitude+
single_noise_1d(i/hi_range)*hi_magnitude

)/(low_magnitude+mid_magnitude+hi_magnitude);

function smooth_curve(a) =let (b = clamp(a))(b * b * (3 - 2 * b));
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
