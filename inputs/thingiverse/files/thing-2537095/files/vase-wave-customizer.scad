/*

    Vase-wave generator/customizer
    
    Fernando Jerez 2017
    
    License: CC-NC (Non commercial)


*/
// Use 'preview' for fast render
part = "preview"; // [preview:Low poly (fast render), print: High detail (slow render)]

// Style / Shape
shape = "barrel"; // [barrel: Penholder/Barrel, vase1:Vase, vase2:Vase 2, glass: Glass, bowl:Bowl, cup: Cup, cone: Cone ]

// Radius 
radius= 60; // [40:100]

// Number of ripples
ripples  = 6; // [1:15]

// Ripple size
ripple_size = 20; // [10:30]

// Twisting factor
twist = 0.5; // [-1:0.05:1]

// Waving 
wave = 10; // [-30:5:30]



/* [Hidden] */
ripple_width = 100/ripples;


altura = 180; // z-steps
step = (part=="preview")?10:1; // resolution in Z (1 is the best and slower)

sides = 360; // Don't touch!

// Calculate....
//points...
puntos = [
    for(z = [0:step:altura])
        for(i = [0:sides-1])
            let(
                rot2  = twist*z + wave*sin(z*2),
                rad2  = ripple_size*sin(z),

                rgi   = ripple_width * sin(z),
                giro  = rgi * sin(i*ripples*2),
                
                // shape 
                zrad  = (shape=="barrel")   ? 1 :
                        (shape=="vase1")    ? 0.7+ 0.4*sin(z*2) :
                        (shape=="vase2")    ? 0.6+ 0.4*pow(sin(z+60),2) :
                        (shape=="glass")    ? 0.6+ 0.4*pow(sin(z*0.7-30),2) :
                        (shape=="cup")      ? 0.65+ 0.4 * cos(z*2) :
                        (shape=="bowl")     ? 0.6+ 0.4 * sin(z*0.5) :
                        cos(z*0.5),
        
            
                r     = zrad * (radius+ rad2*(cos(i*ripples))), 
        
                px   = r*cos(i+giro+rot2),
                py   = r*sin(i+giro+rot2)

            )
        
            [px,py,z]
];
      
// faces...  
caras = concat(
    [
    // Triangle #1
    for(z = [0:(altura-1) / step])
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
    // Triangle #2
    for(z = [0:(altura-1) / step])
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
    [[ for(s = [0:sides-1]) s]],  //bottom
    [[ for(s = [sides-1:-1:0]) (altura/step)*(sides) + s]] //top
        
 );   
    
 // Draws vase
zscale = (shape=="bowl")?0.5:1;
scale([1,1,zscale]) polyhedron (points=puntos,faces = caras);
 
