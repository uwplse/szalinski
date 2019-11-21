/*
    Yet Another Vase Customizer
    
    Fernando Jerez 2017.
    
    License CC-Attribution

*/

// Use 'preview' for fast render
part = "preview"; // [preview:Low poly (fast render), print: High detail (slow render, for print)]

// Style / Shape
shape = "vase1"; // [cylinder: Cylinder, vase1:Vase, vase2:Vase 2, glass: Glass, bowl:Bowl, cup: Cup, cup2: Cup 2, cone: Cone ]

// Offset
offs="no"; // [no: All tiles aligned, offsetz: Alternate Rows, diagonal: Diagonal tiles]

// Radius 
radius= 60; // [30:100]

// Number of ripples in every tile
ripples  = 5; // [1:15]

// Ripple Thickness
ripple_size = 1.5; // [1:0.5:4]

// Tiles in Vertical (rows)
znum = 3; // [1:10]

// Tiles in Horizontal (around the vase)
xnum = 5;  // [1:20]

/* [Hidden] */

altura = 180; // z-steps
step = (part=="preview")?4:1; // resolution in Z (1 is the best and slower)

sides = 360; // Don't touch!

puntos = [
    for(z = [0:step:altura])
        for(i = [0:sides-1])
            let(

                
                // shape 
                zrad  = (shape=="cylinder") ? 1 :
                        (shape=="vase1")    ? 0.7+ 0.4*sin(z*1.9) :
                        (shape=="vase2")    ? 0.6+ 0.4*pow(sin(z+60),2) :
                        (shape=="glass")    ? 0.6+ 0.4*pow(sin(z*0.7-30),2) :
                        (shape=="cup")      ? 0.65+ 0.3 * cos(z*2+35) :
                        (shape=="cup2")     ? 0.6+ 0.35*cos(180 - z+50)*sin(180-z*2.5+45) :
                        (shape=="bowl")     ? 0.6+ 0.4 * sin(z*0.5) :
                        cos(z*0.5),
        
                // Alternate tiles offset
                offz = (offs=="offsetz") ? 90 * floor(z/ (180/znum)) : 0,
        
                // waves/ripples
            
                zrad2 =  (offs=="diagonal") ? ripple_size * cos( ripples * ( 180*sin((z-i)*znum) ) * sin((z+i)*xnum*0.5)) 
                                            : ripple_size * cos( ripples * (180*sin(z*znum))*sin(i*xnum*0.5 +offz) ) ,
                // vertex
                r     = zrad2 + zrad* radius, 
                px    = r*cos(i),
                py    = r*sin(i)
        
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
        
            [f1,f2,f3]
 
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
        
            [f3,f4,f1]
 
    ],
    [[ for(s = [sides-1:-1:0]) (altura/step)*(sides) + s]], //top
    [[ for(s = [0:sides-1]) s]] //bottom
        
 );       
 scale([1,1,(shape=="bowl")?0.33:1])    
 polyhedron (points=puntos,faces = caras);
//echo (caras);
