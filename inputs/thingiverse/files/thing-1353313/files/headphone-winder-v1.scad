

// fins
fin_ratio = .8;
module sub_fins(){
    //minkowski(){
    difference(){
		children()         ;
		
		 for(i=[0:5:spine_height]){
            translate([i, 0,-50]){
					if(i==spine_height) {
							
								#cylinder(100,5,true);
							
					}
					else{
						scale([ fin_ratio+i/(1-i) +1.1 ,((spine_height-i)/spine_height) * i+30, 100]){
						cube(1);
					}
				}
            }
        }
		
      
    };
    //sphere($fn=sphere_resolution, r=1.5);   
//}
}
// spine
spine_height = 50;

// cube
cube_dims = 8;
sphere_resolution = 50;
module draw_spine(){
rotate([0,90,0])
   minkowski(){
       hull(){
           scale([0.15,1,1]){
           translate([0,0,spine_height])
                sphere(cube_dims, $fn=sphere_resolution); 
           scale([1,0.5,1])
                sphere(cube_dims, $fn=sphere_resolution);
           }
      
        }
       
   }
}

module connect_parts(){        
            sub_fins()
                draw_spine();
                
        
}


connect_parts();