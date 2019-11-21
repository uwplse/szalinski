//
//    Coral Tubular
//    Fernando Jerez 2017
//    License: CC Attributtion only
//


// PART: Previes / Render
part = "preview"; // [preview:Low Poly for faster preview, render: High Quality for render ]

// Number of tubes
tubes = 10; // [1:20]

// Surface rugosity of tubes
rugosity = 5; // [0:10]

// Height of tubes (standard/random)
tube_heights = "standard"; // [standard: standard ,random: Random]

/* [Hidden] */

noiseZoom = 0.2; // Detalle (zoom) del ruido

stepz = (part=="preview") ? 5:2;
stepa = (part=="preview") ? 20:5;



// Phyllotaxis
c = tubes*0.6;
num = tubes;
phy = 137.5;

angle = 0;
rot = 0;

ini = (tubes==1)?0:1;
end = (tubes==1)?0:num;

translate([0,0,2+tubes]){
    for(i=[ini:end]){
        r = c*sqrt(i);
        h = (tube_heights=="random") ? 10*round(rands(4,20,1)[0]) : 20+(num-i)*15;//
        curve = i / (num*2);
        rad = 5+round((num-i)*0.5);
        rx = 0;
        ry = 0;//i*0.25;
        rz = phy*i;
        //echo([rad,h,curve,rz]);
        rotate([rx,ry,rz]){
            translate([r,0,0]){
                rotate([0,i*2,0]){
                    tubular(rad,50+h,curve,rugosity,0.5,stepz,stepa);
                }
            }
        }
    }
}
   
color("Orange")
difference(){
    scale([1,1,0.55]) randomRock(10+15*sqrt(num),2,70);
    translate([0,0,-(50+rugosity)]) cube([300,300,100],center = true);
}







// Tubular branch

module tubular(
    rad = 10, // radio 
    height=70, // Altura
    curve = 0.5, // curva en la parte baja (something between [0:1]
    noiseScale = 4, // Grosor del ruido
    flatlevel = 0.5, // Corte para la zona plana
    
    zstep = 4, // incremento de altura por nivel
    astep = 6, // increento de angulo (como $fn)
    )
    {

    Seed=rands(1000,10000,1)[0];
    sides = 360/astep;
    levels =floor(height/zstep);
    // Some sort of cylinder made vertex by vertex, my own version from scratch
    puntos = [
    for(z = [0:zstep:height])
        for(ang = [0:astep:360-astep])
            let(
                rot = 180/height,
                r = max(rad,rad + 0.5*rad*cos(z*rot)),
                noi = ((rugosity==0) || (z+zstep*2)>height/2  )?0: min((height-z)*0.1,noiseScale) * cos(z*rot)* max(flatlevel,Noise((ang)*noiseZoom ,z*noiseZoom *2 ,0,Seed)),
        
                px = -(noi+r) * cos(ang), //invert the x to move back the 0 seam
                py = (noi+r) * sin(ang),
                pz = z + (z*cos(z*rot)), 
        
                // Apply rotation on Y axis 
                // (https://es.wikipedia.org/wiki/Matriz_de_rotaci%C3%B3n)
            
                a =  (-90+60*(sin(pz*rot)))*curve, 
                npx = (px*cos(a)-pz*sin(a)), 
                npz = (px*sin(a)+pz*cos(a))
            )
                
            [npx,py,npz]

    ];
        
    caras = concat(
    [
    for(z = [0:levels-1])
        for(s = [0:sides-1])
            let(
                // clockwise from left-down corner
                f1 = s + sides*z,
                f2 = s + sides*(z+1),
                f3 = ((s+1) % sides) + sides*(z+1),
                f4 = ((s+1) % sides) + sides*z
            )
        
            [f1,f2,f3]
 
    ],
    [
    for(z = [0:levels-1])
        for(s = [0:sides-1])
            let(
                // clockwise from left-down corner
                f1 = s + sides*z,
                f2 = s + sides*(z+1),
                f3 = ((s+1) % sides) + sides*(z+1),
                f4 = ((s+1) % sides) + sides*z
            )
        
            [f3,f4,f1]
 
    ],
    [
        for(s = [0:sides-1])
            let(
                // clockwise from left-down corner
                f1 = s ,
                f2 = ((s+1) % sides),
                f3 = (((s+1) % sides)) + sides*(levels),
                f4 = s+ sides*(levels)
            )
            [f1,f2,f3]
    ],
    [
        for(s = [0:sides-1])
            let(
                // clockwise from left-down corner
                f1 = s ,
                f2 = ((s+1) % sides),
                f3 = (((s+1) % sides)) + sides*(levels),
                f4 = s+ sides*(levels)
            )
            
            [f3,f4,f1]
        
    ]       
        );
        

   
    polyhedron (points=puntos,faces = caras);

}

// NOISE FUNCTIONS

function Noise(x=1,y=1,z=1,seed=1)=let(SML=octavebalance())(Sweetnoise(x*1,y*1,z*1,seed)*SML[0]+Sweetnoise(x/2,y/2,z/2,seed)*SML[1]+Sweetnoise(x/4,y/4,z/4,seed)*SML[2]);
function lim31(l,v)=v/len3(v)*l;
function octavebalance()=lim31(1,[40,150,280]);
function len3(v)=sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function Sweetnoise(x,y,z,seed=69840)=tril(SC3(x-floor(x)),(SC3(y-floor(y))),(SC3(z-floor(z))),Coldnoise((x),(y),(z),seed),Coldnoise((x+1),(y),(z),seed),Coldnoise((x),(y+1),(z),seed),Coldnoise((x),(y),(z+1),seed),Coldnoise((x+1),(y),(z+1),seed),Coldnoise((x),(y+1),(z+1),seed),Coldnoise((x+1),(y+1),(z),seed),Coldnoise((x+1),(y+1),(z+1),seed));
function tril(x,y,z,V000,V100,V010,V001,V101,V011,V110,V111)=	
    V000*(1-x)*(1-y)*(1-z)+
    V100* x*(1-y)*(1-z)+
    V010*(1-x)*y*(1-z)+
    V001*(1-x)*(1-y)*z+
    V101* x*(1-y)*z+
    V011*(1-x)*y*z+
    V110* x*y*(1-z)+
    V111* x*y*z;
    
function Coldnoise(x,y,z,seed=69940)=
((3754853343/((abs((floor(x+40))))+1))%1+(3628273133/((abs((floor(y+44))))+1))%1+(3500450271/((abs((floor(z+46))))+1))%1+(3367900313/(abs(seed)+1))/1)%1;
function SC3(a)=(a*a*(3-2*a));
function un(v)=v/max(len3(v),0.000001)*1;



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


// Module randomRock : draws a random rock
module randomRock(radius,corner_size,number_of_corners){
    // Draw rock
    hull(){
        // Make a hull..
        for(i=[0:number_of_corners]){
            // random position in sphere
            y = rands(0,360,1)[0];
            z = rands(0,360,1)[0];
            rotate([0,y,z])
            
            // translate radius (minus half of corner size)
            translate([radius-corner_size*0.5,0,0])
            
            // draw cube as corner
            rotate([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]]) // random rotation
            cube(rands(corner_size*0.5,corner_size,1)[0],center = true);
            
        }
    }

    // Done
}