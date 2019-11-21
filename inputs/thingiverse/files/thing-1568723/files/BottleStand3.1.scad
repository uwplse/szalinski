// Modern Inverted Bottle Stand
// by Urban Reininger - aka: UrbanAtWork on Thingiverse and Twitter
// Version 0.1 - May 2016


// Depth of stand
depth = 90; // [1:250]
// How Tall?
tall = 40; // [1:300]
// Bottle Hole Size
bottleHole = 40; // [1:0.1:250]
// Top Width - top of trapazoid
topWidth = 70; // [1:300]
// Base Width - bottom of trapazoid
baseWidth =100;   // [1:300]

// preview[view:south, tilt:bottom diagonal]

// detail level
//$fn =100; 

// RENDERS
color("orange")
rotate([0,0,0])
difference(){

    linear_extrude(height = depth, center = true, convexity = 10){
        difference(){
            
            offset(r = 10){
                hull(){
                    translate([tall,-topWidth,0])
                        circle(30);    
                    translate([tall,topWidth,0])
                        circle(30);  
                        
                    translate([0,-baseWidth,0])
                        circle(30);
                    translate([0,baseWidth,0])
                        circle(30);
                }
            }

        // the cut out
                hull(){
                    translate([tall,-topWidth,0])
                        circle(30);    
                    translate([tall,topWidth,0])
                        circle(30);  
                        
                    translate([0,-baseWidth,0])
                        circle(30);
                    translate([0,baseWidth,0])
                        circle(30);
                }
            }
        }
        
   // cut out for bottle top
        translate([tall,0,0])
        rotate([0,90,0])
        cylinder(d=bottleHole,h=60, center=false);
    }