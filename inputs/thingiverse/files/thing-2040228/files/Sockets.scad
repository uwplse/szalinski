// Sockets

type = "Double Hex"; // [Hex, Double Hex]
base_size = .5;
base_depth = .5;
socket_sizes = [13/16,1/2,1];
socket_length = .6;
style = "Straight"; //[Tapered, Straight]
spacing = 15;
number = len(socket_sizes);
units = "Imperial"; //[Imperial, Metric]


xc = number;
yc = round(sqrt(number));
count = number;
if(units=="Imperial"){
    if(type == "Hex"){
        build_socket_imperial();
    }
    if(type == "Double Hex"){
        build_socket_imperial_double();
    }
}
else{
    if(type == "Hex"){
        build_socket_metric();
    }
    if(type == "Double Hex"){
        build_socket_metric_double();
    }
}
module build_socket_metric(){
    
    for(x=[0:xc-1]){
        for(y=[0:yc-1]){
            county= count-y;
            if(county>0){
                base_size = base_size*1.1;
                socket_sizes = socket_sizes*1.16;
                difference(){
                    union(){
                        translate([x*(base_size+         spacing),y*(base_size+spacing),base_depth+1]) linear_extrude (height = socket_length, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
                        
                        
                        if(style == "Straight" && socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
                        }
                        else
                            {
                        translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, (base_size+2)/2));
                        }
                        if(socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-2]) cylinder($fn=30, h = 3, r1 = socket_sizes[y+(yc*x)]/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                        }
                        else{
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth]) cylinder($fn=30, h = 3, r1 = base_size/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                            }
                        
                    }
               translate([x*(base_size+spacing),y*(base_size+spacing),-.1]) linear_extrude (height = base_depth+.5, center = false, convexity = 10) polygon(ngon(4, base_size/2));
                    translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-.5]) linear_extrude (height = socket_length+2, center = false, convexity = 10) polygon(ngon(6, socket_sizes[y+(yc*x)]/2));
                }
                
                
            }
        }
        count = count-x*yc;
    }
}

module build_socket_metric_double(){
    
    for(x=[0:xc-1]){
        for(y=[0:yc-1]){
            county= count-y;
            if(county>0){
                base_size = base_size*1.1;
                socket_sizes = socket_sizes*1.16;
                difference(){
                    union(){
                        translate([x*(base_size+         spacing),y*(base_size+spacing),base_depth+1]) linear_extrude (height = socket_length, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
                        
                        
                        if(style == "Straight" && socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
                        }
                        else
                            {
                        translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, (base_size+2)/2));
                        }
                        if(socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-2]) cylinder($fn=30, h = 3, r1 = socket_sizes[y+(yc*x)]/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                        }
                        else{
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth]) cylinder($fn=30, h = 3, r1 = base_size/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                            }
                        
                    }
               translate([x*(base_size+spacing),y*(base_size+spacing),-.1]) linear_extrude (height = base_depth+.5, center = false, convexity = 10) polygon(ngon(4, base_size/2));
                    translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-.5]) linear_extrude (height = socket_length+2, center = false, convexity = 10) polygon(ngon(6, socket_sizes[y+(yc*x)]/2));
                    translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-.5]) rotate(30) linear_extrude (height = socket_length+2, center = false, convexity = 10) polygon(ngon(6, socket_sizes[y+(yc*x)]/2));
                }
                
                
            }
        }
        count = count-x*yc;
    }
}


module build_socket_imperial(){
    
    for(x=[0:xc-1]){
        for(y=[0:yc-1]){
            county= count-y;
            if(county>0){
                conv = 25.4;
                base_size = (base_size*conv)*1.1;
                base_depth = base_depth*conv;
                socket_sizes = (socket_sizes*conv)*1.16;
                socket_length = socket_length*conv;
                spacing = spacing;
                difference(){
                    union(){
                        translate([x*(base_size+spacing),y*(base_size+spacing),base_depth]) linear_extrude (height = socket_length, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
  
                        if(style == "Straight" && socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
                        }
                        else
                            {
                        translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, (base_size+2)/2));
                        }
                        if(socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-2]) cylinder($fn=30, h = 2, r1 = socket_sizes[y+(yc*x)]/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                        }
                        else{
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth]) cylinder($fn=30, h = 3, r1 = base_size/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                            }
                    }
               translate([x*(base_size+spacing),y*(base_size+spacing),-.1]) rotate (45) linear_extrude (height = base_depth+.1, center = false, convexity = 10) polygon(ngon(4, base_size/2));
                    translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-.1]) linear_extrude (height = socket_length+1, center = false, convexity = 10) polygon(ngon(6, socket_sizes[y+(yc*x)]/2));
                
                   
                    }
                
            }
        }
        count = count-x*yc;
    }
}

module build_socket_imperial_double(){
    
    for(x=[0:xc-1]){
        for(y=[0:yc-1]){
            county= count-y;
            if(county>0){
                conv = 25.4;
                base_size = (base_size*conv)*1.1;
                base_depth = base_depth*conv;
                socket_sizes = (socket_sizes*conv)*1.16;
                socket_length = socket_length*conv;
                spacing = spacing;
                difference(){
                    union(){
                        translate([x*(base_size+spacing),y*(base_size+spacing),base_depth]) linear_extrude (height = socket_length, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
  
                        if(style == "Straight" && socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, socket_sizes[y+(yc*x)]/2+1));
                        }
                        else
                            {
                        translate([x*(base_size+spacing),y*(base_size+spacing),0]) linear_extrude (height = base_depth, center = false, convexity = 10) polygon(ngon(30, (base_size+2)/2));
                        }
                        if(socket_sizes[y+(yc*x)] > base_size){
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-2]) cylinder($fn=30, h = 2, r1 = socket_sizes[y+(yc*x)]/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                        }
                        else{
                            translate([x*(base_size+spacing),y*(base_size+spacing),base_depth]) cylinder($fn=30, h = 3, r1 = base_size/2+1, r2 = socket_sizes[y+(yc*x)]/2+1);
                            }
                    }
               translate([x*(base_size+spacing),y*(base_size+spacing),-.1]) rotate (45) linear_extrude (height = base_depth+.1, center = false, convexity = 10) polygon(ngon(4, base_size/2));
                    translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-.1]) linear_extrude (height = socket_length+1, center = false, convexity = 10) polygon(ngon(6, socket_sizes[y+(yc*x)]/2));
                    translate([x*(base_size+spacing),y*(base_size+spacing),base_depth-.1]) rotate(30) linear_extrude (height = socket_length+1, center = false, convexity = 10) polygon(ngon(6, socket_sizes[y+(yc*x)]/2));
                
                   
                    }
                
            }
        }
        count = count-x*yc;
    }
}

function ngon(num, r) = 
    [for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a)]];