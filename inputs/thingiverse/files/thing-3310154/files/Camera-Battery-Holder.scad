
//Input Parameters


/* [Batteries] */

//Battery width
Sy = 16.8; 

//Battery depth
Sx = 36.068; 

//Battery height
Sz = 50.546; 

//Number of batteries in X direction
Nx = 3; 

//Number of batteries in Y direction
Ny = 2; 


/* [Build] */

//Clearance between batteries and print
C = 0.3; 

//Wall thickness
Tw = 2.4; 

//Bottom thickenness
Tb = 2.2; 




//X dimension of block
Dx = Tw+Nx*(2*C+Sx+Tw);
Dy = Tw+Ny*(2*C+Sy+Tw);
Dz = Sz+Tb+C;

echo(Dx=Dx,Dy=Dy,Dz=Dz);

//Battery Void Dimensions
Vx = Sx+2*C;
Vy = Sy+2*C;
Vz = Sz+C;

echo(Vx=Vx,Vy=Vy,Vz=Vz);


/* [Hidden] */


void_over = 5; //Void Extension



module Block()
{
    cube([Dx,Dy,Dz]);
}


module BatteryVoids()
{
    for(i=[0:Nx-1]){
        for(j=[0:Ny-1]){
            Txi = Tw+i*(Vx+Tw); 
            Tyi = Tw+j*(Vy+Tw);
           
            echo(i=i,j=j,Vx=Vx,Vy=Vy,Vz=Vz,Txi=Txi,Tyi=Tyi);
            
            translate([Txi,Tyi,Tb]){
                cube([Vx,Vy,Vz+void_over]);
            }
        }
    }
}

module NotchVoids()
{
    for(i=[0:Nx-1]){
        
        
        Wx = (Dx-Tw)/Nx/3;
        Wz = Dz/3;
        
        Txi = i*(Vx+Tw)+Tw+Vx/2-Wx/2;
        
        
        
          translate([Txi,-void_over,-void_over]){
                cube([Wx,Dy+2*void_over,Wz+void_over]);
            }   
            
          translate([Txi,-void_over,2*Wz]){
                cube([Wx,Dy+2*void_over,Wz+void_over]);
            }  
    }
}




//BatteryVoids();


difference() {
    Block();
    BatteryVoids();
    NotchVoids();
}


