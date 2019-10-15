lenght = 5; 
width = 5;
height = 0.5;

//The angle of the side
degree = 50; // [1:89]

//The depth of the top cutout
depth = .1;
//The margin between the platform and the top cutout
margin = .15;
//The width of the top cutout
innerWidth = .15;
//The width of the side sticks
marginSide = .1;
//The depth of the side cutout
depthSide = .1;

/* [Hidden] */

offset = tan(degree)*height;


difference() {
   cube([lenght,width,height]);

rotate([-degree,0,0]) {
translate([-1,-1*height*width,0]) {
    
       cube([lenght+2,height*width,height*10]); 
    } 
}

rotate([0,degree,0]) {
translate([-1*lenght*height,-1,0]) {
    
       cube([lenght*height,width+2,height*10]); 
    } 
}

translate([0,width,0]){
    rotate([degree,0,0]) {
    translate([-1,0,0]) {
        
           cube([lenght+2,height*width,height*10]); 
        } 
    }
}

translate([lenght,0,0]) {
    rotate([0,-degree,0]) {
    translate([0,-1,0]) {
        
           cube([lenght*height,width+2,height*10]); 
        } 
    }
}

difference() {
translate([offset+margin,offset+margin,height-depth]) {
cube([lenght - 2*offset - margin*2, width-2*offset - margin*2, height]);
}

translate([offset+margin+innerWidth,offset+margin+innerWidth,height-depth-1]) {
cube([lenght - 2*offset - margin*2-2*innerWidth, width-2*offset - margin*2-2*innerWidth, height+2]);
}


}

//FRONT
intersection() {
difference() {
translate([0,0,marginSide]) {
cube([lenght, width, height-2*marginSide]); 
}
translate([marginSide+marginSide*sin(degree),0,0]) {
rotate([0,degree,0]) {
translate([-1*lenght*height,-1,0]) {
    
       cube([lenght*height,width+2,height*10]); 
    } 
}
}
translate([-1*(marginSide+marginSide*sin(degree)),0,0]) {
translate([lenght,0,0]) {
    rotate([0,-degree,0]) {
    translate([0,-1,0]) {
        
           cube([lenght*height,width+2,height*10]); 
        } 
    }
}
}
}

translate([0,depthSide,0]) {
rotate([-degree,0,0]) {
translate([-1,-1*height*width,0]) {
    
       cube([lenght+2,height*width,height*10]); 
    } 
}
}
}


//BACK
intersection() {
    difference() {
translate([0,0,marginSide]) {
cube([lenght, width, height-2*marginSide]); 
}
translate([marginSide+marginSide*sin(degree),0,0]) {
rotate([0,degree,0]) {
translate([-1*lenght*height,-1,0]) {
    
       cube([lenght*height,width+2,height*10]); 
    } 
}
}
translate([-1*(marginSide+marginSide*sin(degree)),0,0]) {
translate([lenght,0,0]) {
    rotate([0,-degree,0]) {
    translate([0,-1,0]) {
        
           cube([lenght*height,width+2,height*10]); 
        } 
    }
}
}
}
translate([0,-depthSide,0]) {
translate([0,width,0]){
    rotate([degree,0,0]) {
    translate([-1,0,0]) {
        
           cube([lenght+2,height*width,height*10]); 
        } 
    }
}
}

}



//LEFT
intersection() {
difference() {
translate([0,0,marginSide]) {
cube([lenght, width, height-2*marginSide]); 
}

translate([0,-1*(marginSide+marginSide*sin(degree)),0]) {
translate([0,width,0]){
    rotate([degree,0,0]) {
    translate([-1,0,0]) {
        
           cube([lenght+2,height*width,height*10]); 
        } 
    }
}
}
translate([0,marginSide+marginSide*sin(degree),0]) {
rotate([-degree,0,0]) {
translate([-1,-1*height*width,0]) {
    
       cube([lenght+2,height*width,height*10]); 
    } 
}
}
}
translate([depthSide,0,0]) {
rotate([0,degree,0]) {
translate([-1*lenght*height,-1,0]) {
    
       cube([lenght*height,width+2,height*10]); 
    } 
}
}
}
//RIGHT
intersection() {
difference() {
translate([0,0,marginSide]) {
cube([lenght, width, height-2*marginSide]); 
}

translate([0,-1*(marginSide+marginSide*sin(degree)),0]) {
translate([0,width,0]){
    rotate([degree,0,0]) {
    translate([-1,0,0]) {
        
           cube([lenght+2,height*width,height*10]); 
        } 
    }
}
}
translate([0,marginSide+marginSide*sin(degree),0]) {
rotate([-degree,0,0]) {
translate([-1,-1*height*width,0]) {
    
       cube([lenght+2,height*width,height*10]); 
    } 
}
}
}
translate([lenght-depthSide,0,0]) {
    rotate([0,-degree,0]) {
    translate([0,-1,0]) {
        
           cube([lenght*height,width+2,height*10]); 
        } 
    }
}
}
}
