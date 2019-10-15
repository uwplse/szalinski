$fn=50+0;

depth    =  9;
thick    =  2;
border   =  4;
transomD =  2;
transomW =  2;
squareW  = 45;
squareH  = 60;
circleH  = 19;
transomO1= 22;
transomO2= 46;

//Vertical frame
difference(){
    square(squareW+2*thick,squareH+thick,depth+thick);
    translate([0,0.01,0.01]){square(squareW,squareH,depth+thick+0.02);}
}
difference(){
    circle(  squareW+2*thick,  circleH+thick*2  ,depth+thick);
    translate([0,0.01,0.01]){
        circle(squareW,circleH,depth+thick+0.02);
    }
    
    translate([-squareW,-circleH*2,-(depth+thick)-0.01]){ 
        cube([squareW*2,circleH*2,depth+thick+0.02]); 
    }
}


//Horizontal frame
difference(){
   union(){
        difference(){
            circle(squareW+border*2,circleH+border*2,depth+thick);
            translate([0,0.01,0.01]){circle(squareW,circleH, depth+thick+0.02);}   
            translate([-squareW,-circleH*2,-(depth+thick)-0.01]){ 
                cube([squareW*2,circleH*2,depth+thick+0.02]); 
            }
        }
        difference(){
            square(squareW+border*2,squareH+border,depth+thick);
            translate([0,0.01,0.01]){square(squareW,squareH,depth+thick+0.02);}
        }
    }
    w = squareW+border*2+thick*2;
    h = squareH+circleH;
    translate([-w/2-1,-squareH-border-thick-1, -depth-thick-thick]){
        cube([w+2,h+2,depth+thick]);
    }
}

//Transom
translate([-transomW/2,-squareH,-transomD]){
    cube([transomW,squareH+circleH/2,transomD]);
}


translate([-squareW/2, -squareH+transomO1, -transomD]){
    cube([squareW,transomW,transomD]);
}

translate([-squareW/2, -squareH+transomO2, -transomD]){
    cube([squareW,transomW,transomD]);
}



module circle(w,h,d){    

    scale = h/w;
    
    scale([1,scale,1]){
        translate([0,0,-d]){
            cylinder(r=w/2,h=d);
        }
    }    
}


module square(w,h,d){
    translate([-w/2,-h,-d]){
        cube([w,h,d]);
    }  
}   





