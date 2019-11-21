/* main */
word_text = "englische Literatur";
// adjust that after adjusting the text
width = 115;

union(){
    translate ([2, -11, 0]) linear_extrude(1.2) text(word_text, size=10);
    xy_extrude([[0, 1.5],[0, -15],[width, -15],[width, 1.5]], 1.5);
    xz_extrude([[0, 0],[0, -50], [1.5, -50],[width, 0]], 1.5, false);
    yz_extrude([[0, 0],[0, -50], [1.5, -50],[40, -35],[40, -15]], 1.5, false);
};

module xy_extrude(points , width , center = true){
    if(center == true) 
        translate ([0, 0, width/-2])  
                linear_extrude(width) 
                    polygon(points = points);
   else
        linear_extrude(width) 
            polygon(points = points);
};

module xz_extrude(points , width , center = true){
    if(center == true) 
        translate ([0, width/2, 0])        
            rotate([90, 0, 0])
                linear_extrude(width) 
                    polygon(points = points);
   else
       translate ([0, width, 0])    
           rotate([90, 0, 0])
               linear_extrude(width) 
                   polygon(points = points);
};

module yz_extrude(points , width , center = true){
    if(center == true) 
        translate ([width/-2, 0, 0])        
            rotate([90, 0, 90])
                linear_extrude(width) 
                    polygon(points = points);
   else
        rotate([90, 0, 90])
            linear_extrude(width) 
                polygon(points = points);
};