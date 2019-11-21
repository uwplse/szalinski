//Office Steps
//by: Brett Mattas
//date: March 22, 2019
//units: mm


//Description:
// Office steps without back or bottom

/////////////////////////////////////////////
/////////  PARAMETERS ///////////////////////
/////////////////////////////////////////////

//Global Parameters
$fn = 50; //Roundness parameter
// Arbitrary small number to avoid coincident faces
EPS = 0.01; 

L = 150; //Length
W = 150; //Width
H = 150; //Height
nSteps = 3; //Number of steps
t = 10; // Minimum thickness




/////////////////////////////////////////////
/////////  RENDERS //////////////////////////
/////////////////////////////////////////////

//Driver
Steps();




/////////////////////////////////////////////
/////////  FUNCTIONS ////////////////////////
/////////////////////////////////////////////

//Spherical Coordinates
function radius(x, y, z) = pow(pow(x,2)+pow(y,2)+pow(z,2),0.5);

/////////////////////////////////////////////
/////////  MODULES //////////////////////////
/////////////////////////////////////////////

module Steps()
{
    difference(){
        //Elements added
        union(){
            
            for (istep = [0:nSteps-1])
            {
                cube(size = [
                    (nSteps-istep)/nSteps*L,
                    W,
                    (istep+1)/nSteps*H
                ], center = false);
            }
            
        }
        
        //Elements removed
        union(){
            translate([L-EPS, t, -EPS])
                rotate([90, 0, 180])
                linear_extrude(
                        height=W-2*t,
                        center=false,
                        convexity=10
                        )
                CavityShape();
                    
        }
    }
}


module CavityShape()
{
    theta = atan(H/L);
    x1 = t/sin(theta);
    y1 = t/cos(theta);
    difference(){
        //Elements added
        union(){
        
            translate([0, 0, 0])
                polygon(points = [
                    [x1, 0],
                    [L, H-y1],
                    [L, 0]
                ]);
        }
        
        //Elements removed
        union(){
            
        }
    }
}

module TemplateModule()
{
    difference(){
        //Elements added
        union(){
        
            
        }
        
        //Elements removed
        union(){
            
        }
    }
}




