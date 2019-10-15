//The length of the bracket
bracket_length = 48.2; //[1:0.1:1000]

//The thickness of the bracket
bracket_thickness = 3; //[1:0.1:1000]

//The thickness of the foam channel 
foam_thickness = 24.1; //[1:0.1:100]

//The thickness of the surface channel
mount_surface_thickness = 19.05;//[1:0.1:100]

/*[Screw Holes] */
//Enable screw holes on bottom of surface channel 
has_screw_holes = "no";//[no,yes]

//If screw holes are enabled this will be the size of the hole
screw_hole_diameter = 1;//[1:0.1:10]

number_of_screw_holes = 1;//[1:50]


module plate(length, width, thickness) {
        cube([length, width, thickness]);
}

module bracket(bracketLength, bracketThickness, foamThickness, mountSurfaceThickness) {
    
   plate(
        bracketThickness,
        (bracketThickness + mountSurfaceThickness +bracketThickness+foamThickness),
        bracketLength);
    
   translate(v=[bracketThickness,0,0]){ 
       difference(){
            plate(foamThickness+bracketThickness, bracketThickness, bracketLength);
            
          if(has_screw_holes == "yes"){
    
                //calculate screw hole spacing
                space = bracketLength/number_of_screw_holes;
              
                for(i = [(space/2):space:(bracketLength-space/2)]){
                translate(v=[((bracketThickness+foamThickness+bracketThickness)/2), bracketThickness+1, i]) {
                    rotate(a=90, v=[1,0,0]){
                    cylinder(d=screw_hole_diameter, h=bracketThickness+2, $fn=100);
                    }
                }
              }              
          }
        }
   }
   
   translate(v=[bracketThickness, mountSurfaceThickness+bracketThickness, 0]){
       plate(foamThickness+bracketThickness, bracketThickness, bracketLength);
   }
   
   translate(v=[bracketThickness+foamThickness, bracketThickness+mountSurfaceThickness+bracketThickness, 0]) {
    plate(bracketThickness, foamThickness, bracketLength);
   }
}

bracket(bracket_length, bracket_thickness, foam_thickness, mount_surface_thickness);
