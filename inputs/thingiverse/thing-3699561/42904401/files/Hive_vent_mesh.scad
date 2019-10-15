include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>


roundmesh();
//squaremesh();

//round base
module roundmesh(){
difference(){
    tube(h=2.5, od=60, id=3,$fn=60);

    // Ventilation
    ventilation_pattern(); 
    
    ydistribute(spacing=48) {
    // Screw holes
        cyl(l=6, d=5,$fn=60);
        cyl(l=6, d=5,$fn=60);
    }
  }
 }
 
 
//square base
module squaremesh(){
difference(){
    cuboid([40,100,2.5], chamfer=1);
    
    // Ventilation
    ydistribute(spacing=26) {
      ventilation_pattern();
      ventilation_pattern();
      ventilation_pattern();  
    }
    
    // Screw holes    
    ydistribute(spacing=90) {

        cyl(l=6, d=5,$fn=60);
        cyl(l=6, d=5,$fn=60);
    }
  }
 }

// ventilation pattern
module ventilation_pattern(){
    translate([0,0,1])
    {
        hexregion = [for (a = [0:60:359.9]) 15.01*[cos(a), sin(a)]];
        grid2d(spacing=5, stagger=true, in_poly=hexregion)
        {
            cyl(l=5, d=3,$fn=60);
        }
    }  
}