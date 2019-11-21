height=3;
length=100;
width=40;
t="text here";

module tooth(){
polygon(points=[[0,0],[4.99,0],[2.5,7.5]], paths=[[0,1,2]]);
}

module teeth(length,y, z){
    count=(length/5)-1;
    
    linear_extrude(height = z, center = false, convexity = 10, twist = 0)  {  
        translate([0,y,0]){
            for (i = [0 : count]) {
                translate([i*5,0,0]){
                    tooth();
                }
            }
        }
    }
}



module earc(r,w,h,xloc,yloc){
    
    chlen = w/2;
    xpos = sqrt((pow(r,2))-(pow(chlen,2)));
    translate([(0-xpos)+xloc,(w/2)+ yloc,0]){
        intersection(){
            translate([xpos,0-(w/2),0]){
                cube([w,w,h+1]);
            }
            cylinder(h=h, r=r,$fn=360);
        }
    }
}

module body(length,width,height){
    
    
    difference(){
        union(){
            cube([length,width,height]);
        teeth(length,width,height);
        earc(60,width,height,length,0);
        }
        union(){
            rotate([30,0,0]){
                cube([length +10,height*2,4]);
            }
            rotate([0,-30,0]){
                cube([height*2,width+10,4]);
        
            }
        }
    }
}

module add_text(t,length,width,height){
    translate([length/2,width/2,height]){
        linear_extrude(height = 1, center = false, convexity = 10, twist = 0)  { 
        text(t,halign = "center", valign="center");
        }
    }
}



body(length,width,height);
add_text(t,length,width,height);
