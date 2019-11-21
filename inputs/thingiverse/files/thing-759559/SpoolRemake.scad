 SpoolSize = 31.85;
 TabThickness = 1.4;
 BackplateRim = 8.25;
 BackplateThickness = 2.1;
 TabGap = 3;
 TabDepth = 16;
 SpoolRodSize = 18.1;
 Tolerance = 0.1;
 
 TabSize = TabThickness *2;
 
 union(){
     difference(){
        cylinder(h = 1.5,d = SpoolSize + BackplateRim - Tolerance, $fa = 0.1);
        cylinder(h = 1.5,d = SpoolRodSize + Tolerance, $fa = 0.1);
    };
    
    translate( v = [0,0,1.5] ){
        difference(){
                difference(){
                    cylinder(h = TabDepth, d = SpoolSize, $fa = 0.1);
                    cylinder(h = TabDepth, d = (SpoolSize - TabSize), $fa = 0.1);
                }
                translate( v = [- .5 * TabGap,-.5 * SpoolSize,0])
                    cube(size = [TabGap,SpoolSize,TabDepth]);
                translate( v = [-.5 * SpoolSize,-.5 * TabGap,0])
                    cube(size = [SpoolSize,TabGap,TabDepth]);
                    
            }
    }
}
