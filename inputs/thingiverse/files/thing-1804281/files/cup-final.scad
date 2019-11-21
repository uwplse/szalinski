

// How much should the angle of the cup should be? (Based on the tangent graph)
rotate_angle = 3; // [0:4]

//  How narrow should be the lower part of the cup?
tendency = -0.2; // [-1: Thick, -0.2: Norm, 0: Bit narrow, 1: Very Narrow]

// How tall should the cup be?
heightOfCup = 46; // [42: low, 46: Medium, 50: Tall]



k = (-3+0);
difference() {
    difference() {
        
        union() {
            union() {  
                for(i=[1:1:heightOfCup]) {
                
                    translate([0,0,i]){
                        rotate([rotate_angle,0,0])
                        rotate_extrude(convexity =10, $fn=50)
                        
                        projection(cut=true)
                        rotate([0,90,0]) {
                         
                            k = k + 0.1*i;
                            
                            cylinder(r=1, h=10*(((((1.5+tendency/4) * (atan(2.5*k)))*3.14/180))+3)); 
                            
                        };
                    };
                };
            };
            union() {
                translate([0,0,24]) {
                    if ( tendency/4 > 0.4) {
                        for(i=[24:-1:1]) {
                            translate([0,0,-i]){
                            rotate([rotate_angle,0,0])
                            rotate_extrude(convexity =10, $fn=50)
                            
                            projection(cut=true)
                            rotate([0,90,0]) {
                             
                                k = k + 0.1*i;
                                
                                cylinder(r=1, h=10*(((((1.5+tendency/4) * (atan(2.5*k)))*3.14/180))+3)); } 
                                
                            };
                        };
                    };
                };
            };
                 
        };
        
    
            
        for(i=[12:1:(heightOfCup+2)]) {
        
            translate([0,0,i]){
                rotate_extrude(convexity =10, $fn=50)
               
                projection(cut=true)
                rotate([0,90,0]) {
                 
                    k = k + 0.1*i;
               
                    
                    cylinder(r=1.5, h=10*(((((1.65+tendency/4) * (atan(2.3*k-0.5)))*3.14/180))+2.6));
                };
            };
        };
    };
    

rotate([0,180,0]){ 
        translate([0,0,-1.5]){
            cylinder(r=20, h=10);
        };
    };
}; 

