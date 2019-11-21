/* [Global] */

// - Define the wall thickness
Wall_Thickness=1.4; 

// - Define wall thickness in the center
Center_Wall_Thickness=2; 

// - Define the x dimension of the test member
Stock_X_Dimension=20; 

// - Define the y dimension of the test member
Stock_Y_Dimension=10; 

// - Define the depth of the glue joint
Hole_Length=30; 

// - Define the tolerance for the hole
Tolerance=0.3;

// - Define the depth of the texturing in the holes
Groove_Depth=1;

// - Define the width of the texturing in the holes
Groove_Width=2;

// - Define the distance between grooves
Groove_Spacing=3;

/* [Hidden] */
wall=Wall_Thickness+Groove_Depth;

length=2*Hole_Length+Center_Wall_Thickness; //Calculate max length
holeX=Stock_X_Dimension+(2*Tolerance); //Calculate hole dim. with tolerance.
holeY=Stock_Y_Dimension+(2*Tolerance);
X_dim=holeX+(2*wall); //Calculate external dimensions
Y_dim=holeY+(2*wall);
zTrans=Hole_Length/2+Center_Wall_Thickness/2+1; //Calculate translational value

grooveDist=Groove_Spacing+2;
grooveX=holeX+Groove_Depth*2;
grooveY=holeY+Groove_Depth*2;

difference()
    {
    cube(size = [X_dim,Y_dim,length], center=true);
    translate([0,0,zTrans]) cube(size=[holeX,holeY,Hole_Length+2], center=true);
    translate([0,0,-zTrans]) cube(size=[holeX,holeY,Hole_Length+2], center=true);
        for ( i = [(Center_Wall_Thickness+Groove_Width)/2 : grooveDist : Hole_Length] )
        {
            translate([0,0,i]) cube(size=[grooveX,grooveY,Groove_Width], center=true);
            translate([0,0,-i]) cube(size=[grooveX,grooveY,Groove_Width], center=true);
        }
    }
    
