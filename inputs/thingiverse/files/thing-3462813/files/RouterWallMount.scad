/*
  Wall Support for router
  Dimensions provided are for D-Link DIR605-L model
*/

// wall thickness
wallThick  =   4;

// cross width
width      =   15;

// nail length
nailLength =   5;


// part width in base part
partWidth  =  122;

// part height in base part
partHeight =   82;

// part deep at central part
partDeep   =   17.5;

// part deep at bottom
partDeep2  =   21.5;

// screw dimensions

// screw diameter
screwDiam      = 3.5;

// screw head diameter
screwHeadDiam  = 6;

// screw head height
screwHeadDeep  = 2;

// base cross
difference ()
{
    // base cross
    union () {
        cube( [partWidth+2*wallThick, width, wallThick], center = true );

        translate ([0,partHeight /4,0])
            cube( [width    , partHeight /2 + 2*wallThick,   wallThick], center = true );
    }
    
    // screw holes
    translate ([partWidth/4,0 ,0])
        screwHole(screwDiam, screwHeadDiam, screwHeadDeep);
    
    translate ([-partWidth/4,0 ,0])
        screwHole(screwDiam, screwHeadDiam, screwHeadDeep);
}

// wings
translate ([ (partWidth ) /2 , 0 , wallThick/2 ] )
    wing(partDeep,20);
    
translate ([ -(partWidth ) /2 , 0 ,wallThick/2 ] )
    rotate ([0,0,180])   
        wing(partDeep,20);

translate ([0 , (partHeight) /2 , wallThick /2 ] )
    rotate ([0,0,90])
        wing(partDeep2,20);
    
// wing module
module wing (deep, angle){
    {
        rotate ([0,angle,0])
        translate ([wallThick/2,0,deep/2])
        {
            cube( [wallThick, width, deep], center = true ) ;
            translate ([0,0, ( deep + wallThick)/2]){
                    cube( [wallThick, width, wallThick], center = true ) ;     
            
                rotate ([0,0,270])
                    translate ([0,-wallThick/2,0])
                        prism (width ,nailLength, wallThick);
            }
        }
    }
}

// Screw hole module
module screwHole ( diam , headDiam, headDeep)
{
    translate ([0,0, wallThick/2 - headDeep])
    {
        translate ([0,0,-wallThick/2])
            cylinder (2*wallThick, d = diam, center = true, $fn=100 );
        translate ([0,0,wallThick/2])
            cylinder (wallThick, d = headDiam, center = true , $fn=100);
    }
}

// nail
module prism(l, w, h){
    translate([-l/2,-w,-h/2])
        polyhedron(
            points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
            faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
       );
}