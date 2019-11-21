 
// length of the first segment in mm
segment_length = 40; 
// thickness of the first segment (from tree)
thickness = 4; 
// extrusion heigh of the whole tree base
height = 4;
// tolerance for center hole
tolerance = 0.4;
// Settings END //

max =   (thickness < height) ? height : thickness ;

module base(length, thickness) {
        
difference(){
    union(){
        translate ([-thickness/2,-length/2,0])
            square([thickness, length]);
   
        rotate([0,0,90])  
            translate ([-thickness/2,-length/2,0]) 
                square([thickness, length]);
        
        circle(d=sqrt(thickness*thickness+height*height)+3);
    
        difference(){
            circle(d=sqrt(thickness*thickness+length*length)+0.5);
            circle(d=length-3);
        }
    }
    translate ([-(thickness+tolerance)/2,-(height+tolerance)/2,0])
        square([thickness+tolerance, height+tolerance]);
}
}

linear_extrude(height = height/2){
    base(segment_length, thickness);
}
linear_extrude(height = height*2){
    
    difference(){
        circle(d=sqrt(thickness*thickness+height*height)+3);
        translate ([-(thickness+tolerance)/2,-(height+tolerance)/2,0]) 
            square([thickness+tolerance, height+tolerance]);
    }
}
