
edgeLength = 35;
borderwidth = 2;

holeRadius = 2;

height = 3;
extrusionHeight = 1;

textSize = 11;
name = "Name";


union(){
    radius = edgeLength / 2;
    
    difference(){
        linear_extrude(height){
            square(edgeLength);
            
            $fn = 64;
            translate([radius, edgeLength, 0]){
                circle(radius);
            }

            translate([edgeLength, radius, 0]){
                circle(radius);  
            } 
        }
        
        cutoutSize = edgeLength - borderwidth;
        cutoutRadius = radius - borderwidth;
        
        translate([borderwidth, borderwidth, height - extrusionHeight]){
            linear_extrude(extrusionHeight + 0.1){
                
                
                square([cutoutSize, edgeLength - borderwidth * 2]);
                square([edgeLength - borderwidth * 2, cutoutSize]);
                
                $fn = 64;
                translate([cutoutRadius, cutoutSize, 0])
                    circle(cutoutRadius);
                translate([cutoutSize, cutoutRadius, 0])
                    circle(cutoutRadius);
            }
        }
        
        linear_extrude(height){
            translate([radius, (edgeLength - borderwidth * 2) * 1.5, 0])
                circle(holeRadius,$fn = 16); 
        }
    }
    
    linear_extrude(height){
        rotate([ 0, 0, -45]){
            translate([0, sqrt(2) * radius + borderwidth, height - extrusionHeight]){
                text(name, size = textSize, halign = "center", font = "Consolas:style=Bold Italic");
            }
        }
    }
}