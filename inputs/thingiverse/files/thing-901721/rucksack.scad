// Variable description

length      = 50    ;
width       = 30    ;
height      = 2     ;
diameter    = 10    ;
thickness   = 5     ;




  difference(){    
    union(){
        cube( size = [ length, width, height], center = true)   ;
        translate( [ length/2, width/2, 0] ){
            cylinder( h = height, d = diameter, center = true)  ;
        }
        translate( [ length/2, -width/2, 0] ){
            cylinder( h = height, d = diameter, center = true)  ;
        }
        translate( [ -length/2, -width/2, 0] ){
            cylinder( h = height, d = diameter, center = true)  ;
        }
        translate( [ -length/2, width/2, 0] ){
            cylinder( h = height, d = diameter, center = true)  ;
        }
    }
    
  cube( size = [ length-2*thickness, width-2*thickness, height+2], center = true) ; 
    
}   
    
    
    
    
