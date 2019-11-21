/* 2017-2018 CC-BY Jan "jprofesorek" K. */

/***************/
/* latch setup */
/***************/

latchPolygonH=3;
latchTotalWidth=10;
latchSide=1.5;
module baseLatchPolygon(){
    polygon([
      [0.0, 0.0],
      [3.0, 0.0],
      [2.0, 0.6]
    ]);
}

/***********/
/* the box */
/***********/

// outerDimensionsBoxPlusLid( // Dimensions are outer dimensions of the box with lid
innerDimensionsBoxPlusLid(        // Dimensions are inner dimensions of the box
    [50,30,20],               // Dimensions of the box. Latch is along X axis
    radius=1.5,                   // Radius of rounded edges of the box
    clearence=0.05,           // Distance between lid wall and box wall (how tightly it fits)
    wall=1.2,                     // Wall thickness
    $fn=50
);

/**************/
/* modules... */
/**************/

module hsphere(radius)                         //  "muffin" shape - sphere + cut cone
union(){                                       //  (sphere has overhangs up to 90°,
    translate([radius,radius,radius])          //   this shape has overhangs up to 45°)
    sphere(r=radius);                          //    .-.
                                               //   (   )
    cr=sqrt(2)/2*radius;                       //    \_/
    ch=radius-cr;

        translate([radius,radius,0])
        cylinder(h=radius-cr,r2=cr,r1=cr-ch);
}


module bottom(dim_x,dim_y,radius=5,hsph=true){ 
    module shape(){                            
        if(hsph)                               
            hsphere(radius);                   
        else
            translate([radius,radius,radius])
                sphere(radius);
    }
    difference(){
        union(){                               // places spheres / muffins in corners
            shape();
                                               //         ___           ___
            translate([dim_x-2*radius,0])      //        (   )         (   )
                shape();                       //         \_/           \_/
                                               //    ___           ___
            translate([0,dim_y-2*radius])      //   (   )         (   )
                shape();                       //    \_/           \_/
            
            translate([dim_x-2*radius,dim_y-2*radius])
                shape();
        }
        translate([0,0,radius])                // and cuts the top of it
            cube([dim_x,dim_y,radius+1]);
    }
}

module top(dim_x,dim_y,radius=5){
    hair=1e-4;
    translate([radius,radius,-hair])               //  cylinders in corners on Z=0
        cylinder(h=hair,r=radius);
    
    translate([dim_x-radius,radius,-hair])
        cylinder(h=hair,r=radius);                 //      .--.             .--.
                                                   //     `.__.`           `.__.`
    translate([radius,dim_y-radius,-hair])         //
        cylinder(h=hair,r=radius);                 //   .--.             .--.
                                                   //  `.__.`           `.__.`
    translate([dim_x-radius,dim_y-radius,-hair])
        cylinder(h=hair,r=radius);
}

module box (geometry,radius=5, hsph=true){
    hull(){                                           // cube with side and bottom edges rounded.
        bottom(geometry.x,geometry.y,radius,hsph);    
                                                      // if hsph=true, then the bottom edges are
        translate([0,0,geometry.z])                   //            rounded only to 45° overhang
            top(geometry.x,geometry.y,radius);
    }
}

module emptyBox(geometry,outerRadius=5,wall=1.2){    // substracts smaller rounded cube from a larger rounded cube 
    difference(){                                    //"inner" is all rounded, "outer" is all rounded up to 45° overhang
        box(geometry,outerRadius);

        translate([wall,wall,wall])
        box([geometry.x-2*wall,
             geometry.y-2*wall,
             geometry.z
            ],outerRadius-wall, false);
    }
}


module lid(dim_x,dim_y,innerRadius=5,clearence = 0.5, extrah = 7, wall=1.2){
    extraxy=2*wall+clearence;
    radius=innerRadius;

    emptyBox([dim_x,dim_y,radius+wall], radius, wall);    // lid is made of two parts: one has same x and y dimenson as the box, 
    translate([-extraxy/2,-extraxy/2])                    //                           the other is wall wider in each direction
        emptyBox([dim_x+extraxy,
                  dim_y+extraxy,
                  radius+wall+extrah
                 ], radius+extraxy/2, wall);
}

module latch(){                                          // constructs the latch from the parameters given on top of this file.
    side=latchSide;
    main=latchTotalWidth-2*side;
    rotate([0,-90,0]){
        translate([0,0,-main/2])
            linear_extrude(height=main)
                baseLatchPolygon();
        for(m=[0,1]) mirror([0,0,m]) translate([0,0,main/2])
            linear_extrude(height=side, scale=[1,0],slices=10)
                baseLatchPolygon();
    }
}

module latchPlusHair(){                                 // latch + a thin cube to make it look right when the latch gets substracted from shapes
    hair=1e-4;
    union(){
        latch();
        translate([-latchTotalWidth/2,-1,0])
            cube([latchTotalWidth,1+hair,latchPolygonH]);
    }
}

module latchUpsidedown(){
translate([0,0,latchPolygonH])
    rotate([0,180,0])
        latch();
}

module lidWithLatch(dim_x,dim_y,innerRadius=5,clearence = 0.5, wall=1.2){
    radius = innerRadius;
    lid(dim_x, dim_y, clearence = clearence, innerRadius = radius, extrah=latchPolygonH+2, wall=wall);

    translate([dim_x/2,-clearence/2, radius+1+wall])
        latchUpsidedown();

    translate([dim_x/2,dim_y+clearence/2, radius+1+wall])
        rotate([0,0,180])
            latchUpsidedown();
}

module boxWithLatch(geometry, outerRadius=5, wall=1.2){
    difference(){
        emptyBox(geometry,outerRadius,wall);
        
        translate([geometry.x/2,0,geometry.z-latchPolygonH-1])
            latchPlusHair();
        
        translate([geometry.x/2,geometry.y,geometry.z-latchPolygonH-1])
            rotate([0,0,180])
                latchPlusHair();
    }
}

module innerDimensionsBoxPlusLid(geometry, radius=5, clearence=0.5, wall=1.2){
    
    boxWithLatch([
                    geometry.x+2*wall,
                    geometry.y+2*wall,
                    geometry.z+2*wall-radius
                 ], radius, wall);
    
    translate([0,geometry.y+3*wall+clearence/2 + 2,0])
        lidWithLatch(geometry.x+2*wall,
                     geometry.y+2*wall,
                     radius,
                     clearence,
                     wall);
}

module outerDimensionsBoxPlusLid(geometry, radius=5, clearence=0.5, wall=1.2){
    
    boxWithLatch([
                    geometry.x-2*wall-clearence,
                    geometry.y-2*wall-clearence,
                    geometry.z-2*wall-clearence-radius
                 ], radius, wall);
    
    translate([0,geometry.y-3*wall+clearence/2 + 2,0])
        lidWithLatch(geometry.x-2*wall-clearence,
                     geometry.y-2*wall-clearence,
                     radius,
                     clearence,
                     wall);
}






