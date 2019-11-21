/*

LOW POLY VASE FACTORY

Fernando Jerez 2017
License: CC


*/

// Style / Shape
shape = "cylinder"; // [cylinder: Cylinder, vase1:Vase, vase2:Vase 2, glass: Glass, bowl:Bowl, cup1: Cup, cup2: Cup 2, cone: Cone ]

// Radius 
radius= 60; // [20:100]

// Spike size
spikes = 5; //[-20:20]

// Number of Sides
sides = 20; // [3:30]

// Number of Levels
levels = 10; // [3:30]

// Twisting factor
twist = 0; //[-1:0.1:1]

/* [Hidden] */

vase();

module vase(){

altura = 180 - 180%levels; // z-steps
step = floor(180/levels); // resolution in Z (1 is the best and slower)

 
stepc = 360/sides; // Don't touch!

puntos = [
    for(z = [0:step:altura])
        for(i = [0:stepc:359])
            let(

                
                // shape 
                zrad  = (shape=="cylinder") ? 1 :
                        (shape=="vase1")    ? 0.7+ 0.4*sin(z*1.9) :
                        (shape=="vase2")    ? 0.6+ 0.4*pow(sin(z+60),2) :
                        (shape=="glass")    ? 0.6+ 0.4*pow(sin(z*0.7-30),2) :
                        (shape=="cup1")      ? 0.65+ 0.3 * cos(z*2+35) :
                        (shape=="cup2")     ? 0.6+ 0.35*cos(180 - z+50)*sin(180-z*2.5+45) :
                        (shape=="bowl")     ? 0.6+ 0.4 * sin(z*0.5) :
                        cos(z*0.5),
        
                rad2  = ((z/step)%2==1 && (i/stepc)%2==1)?spikes:0,
                g = z*twist,
                
                // vertex
                r     = rad2+  zrad* radius, 
                px    = r*cos(i+g),
                py    = r*sin(i+g)
        
            )
        
            [px,py,z]
];
        
caras = concat(
    [
    for(z = [0:(altura/step)-1])
        for(s = [0:sides-1])
            let(
                // clockwise from left-down corner
                f1 = s + sides*z,
                f2 = s + sides*(z+1),
                f3 = ((s+1) % sides) + sides*(z+1),
                f4 = ((s+1) % sides) + sides*z
            )
        
            ( (s+z)%2==0) ? [f1,f2,f3] : [f2,f3,f4]
 
    ],
    [
    for(z = [0:(altura/step)-1])
        for(s = [0:sides-1])
            let(
                // clockwise from left-down corner
                f1 = s + sides*z,
                f2 = s + sides*(z+1),
                f3 = ((s+1) % sides) + sides*(z+1),
                f4 = ((s+1) % sides) + sides*z
            )
            ( (s+z)%2==0) ? [f3,f4,f1] : [f4,f1,f2]
         
    ],
   
    (shape!="cone")?[[ for(s = [sides-1:-1:0]) (altura/step)*(sides) + s]]:[], //top
    [[ for(s = [0:sides-1]) s]] //bottom
        
 );       
 scale([1,1,(shape=="bowl")?0.33:1])    
 polyhedron (points=puntos,faces = caras);

}