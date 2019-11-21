wallThickness=8.0;         // thickness of brace walls. 
frameThickness=8.0;        // thickness of anet a8 frame.
frontTriangleHeight=58.0;
frontTriangleWidth=80.0;
sideTriangleHeight=55.0;
sideTriangleWidth=156.0;
sideTriangleOffset=27.5;  // offset from zero. zero is where horizontal ad vertical frame parts meet ( see axis cross here in openscad!.  -|-
frontScrewsDia=3.0;
sideScrewsDia=4.0;
screw1Distance=18.0;
screw2Distance=37.0;
screw3Distance=47.0;

gap=0.1;       // tiny amount of "play" in order to be able to put in corner brace more easily.

// sin(α)=Gegenkathete/Hypotenuse;
alpha = asin( frontTriangleHeight / sqrt( pow(frontTriangleWidth/2,2) + pow(frontTriangleHeight,2) ) );
echo("alpha: ", alpha);
// cos(α)=Ankathete/Hypotenuse     => Ankathete = cos(α)*Hypotenuse => Hypotenuse = Ankathete/cos(α)*
// tan(α)=Gegenkathete/Ankathete   => Ankathete = GegenKathete/tan(α)
// Gegenkathete = wallThickness
// gesucht ist Ankathete
ankathete01 = wallThickness / tan(alpha); 
echo("ankathete01: ", ankathete01);
// side triangle
beta = asin( sideTriangleHeight / sqrt( pow(sideTriangleWidth/2,2) + pow(sideTriangleHeight,2) ) );
echo("beta: ", beta);
ankathete02 = wallThickness / tan(beta); 
echo("ankathete02: ", ankathete02);

///////////////////////////////////////////////////////////////////////////////
rotate([90,0,180])
difference()
{
    union()
    {
        // front triangle
        translate([0,-wallThickness,-wallThickness-frameThickness])
        difference()
        {
            linear_extrude(height=2*wallThickness+frameThickness, center=false)
            polygon(points=[ [(-frontTriangleWidth/2)-ankathete01, 0], 
                             [(frontTriangleWidth/2)+ankathete01, 0], 
                             [0, frontTriangleHeight+wallThickness] ]);
            // cut out hole for first screw on front
            translate([0, wallThickness+screw1Distance, -frameThickness/2])
            cylinder($fn=20, (wallThickness+frameThickness/2), r=frontScrewsDia/2);
            // cut out hole for second screw on front
            translate([0, screw2Distance+wallThickness, -frameThickness/2])
            cylinder($fn=20, (wallThickness+frameThickness/2), r=frontScrewsDia/2);           
        }
   
        // side triangle
        translate([wallThickness+frameThickness/2, -sideTriangleOffset,-wallThickness])
        rotate([90,0,-90])
        difference()
        {
            linear_extrude(height=2*wallThickness+frameThickness, center=false)
            polygon(points=[ [(-sideTriangleWidth/2)-ankathete02, 0], 
                             [(sideTriangleWidth/2)+ankathete02, 0], 
                             [0, sideTriangleHeight+wallThickness] ]);
             // cut out hole for left side screw
            translate([0, screw3Distance+wallThickness, -10])
            cylinder($fn=20, (2*wallThickness+frameThickness+20), r=sideScrewsDia/2);
        }
    }

//// cut out front triangle.
translate([-frontTriangleWidth/2-10, -gap/2, -wallThickness-gap/2])   // x,z,y
cube(size = [frontTriangleWidth+20, frontTriangleHeight+20, frameThickness+gap]);

////// cut out junction between front and side triangle.
translate([-frameThickness/2-gap, -gap/2, 0])  // x,z,y
    cube(size = [frameThickness+gap, frontTriangleHeight+10, wallThickness]);   //   x,z,y

//// cut out side triangle.
rotate([90,0,-90])
translate([-frontTriangleHeight-10, -gap/2, -wallThickness+frameThickness/2])  // z,y,x
    cube(size = [sideTriangleWidth+20, sideTriangleHeight+20, frameThickness+gap]);
}
