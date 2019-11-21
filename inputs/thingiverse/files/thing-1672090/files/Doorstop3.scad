door_thickness = 35.5;
length = 60; // not overall length, doesn't include the guides
height = 10;
stop_size = 20;
tensioner = 5;
part_thickness = 7;
door_guides = true;
door_tensioners = true;



cube([(door_thickness + (part_thickness)), (part_thickness/2), height]);

cube([(part_thickness/2), (length), height]);

translate([(door_thickness + (part_thickness/2)),0,0])
cube([(part_thickness/2), (length), height]);



difference(){

translate([0,part_thickness/2, height/2]) 
    color("blue") 
    cylinder(r=stop_size/2,h=height,center=true)
     //cube([door_thickness + part_thickness, (length - part_thickness) + (part_thickness/2), height])

    ;  
      
   
translate([part_thickness/2,part_thickness/2,0]) 
    color("Orange")
    cube([door_thickness, (length - part_thickness), height])
    ;
}



if (door_tensioners) {
//tensioner 1
translate([(part_thickness/2)+door_thickness,
            ((length - part_thickness)+(part_thickness/2))-(tensioner/2), 
            (height/2)]) 
         color("red") 
            cylinder(r=tensioner/2,h=height,center=true);


//tensioner 2
translate([part_thickness/2,
            ((length - part_thickness)+(part_thickness/2))-(tensioner/2), 
            (height/2)]) 
        color("green") 
            cylinder(r=tensioner/2,h=height,center=true);
}




//Guides to help put onto door
module guide0(l, w, h, trnx, trny){
    

translate([trnx,trny,height])
    rotate([90,90,180])
    
    color("pink") 
    polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}
module guide1(l, w, h, trnx, trny){
translate([trnx,trny,0]) 
    
    rotate([180,270,90])
    
    color("purple") 
    polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}




if (door_guides) {
    if (door_tensioners) {
        guide0(height, (part_thickness/2)+(tensioner/2), (tensioner*3), 
                (part_thickness/2)+(tensioner/2), 
                ((length - part_thickness)+(part_thickness/2))-(tensioner/2));
        
        
        guide1(height, (part_thickness/2)+(tensioner/2), (tensioner*3),
                (part_thickness/2)-(tensioner/2)+door_thickness,
                ((length - part_thickness)+(part_thickness/2))-(tensioner/2));
    }
    else{
         guide0(height, (part_thickness/2), (tensioner*3),
                (part_thickness/2), 
                ((length - part_thickness)+(part_thickness/2)));
        
         guide1(height, (part_thickness/2), (tensioner*3),
                (door_thickness+part_thickness/2),
                ((length - part_thickness)+(part_thickness/2)));
        
    }
}





//difference(){
//  cube([door_thickness + part_thickness, (length - part_thickness) + (part_thickness/2), height]);  
 // translate([part_thickness/2,part_thickness/2,0]) color("Orange") cube([door_thickness, (length - part_thickness), height]);
//}






