x=15;
y=28;
z=6.5;

wall=1;

pin_wall=1.5;//2
pin_hole=2;//2.5

pin_x= (2*pin_wall)+pin_hole;
pin_y= y-(1.5*(pin_x+wall));

base=false;
style=false;
tolerance=0.9;
cord=2;


module pin( base=false){
    
    
    difference(){
        union(){
            translate([0,pin_y+pin_x,0])difference(){
                scale([1,1.5,1])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([pin_x+wall,z]); 
                translate([0,-2*wall,0])rotate([0,0,atan(2*wall/(pin_x+wall))])cube([5*(pin_x+wall),2*wall,2*z]);
            }
            cube([pin_x,pin_y+pin_x+2*wall,z]);
            translate([-x/2,0,0])cube([x/2,pin_x,z]);
            translate([-pin_hole,pin_x,0])cube([pin_hole,pin_hole,z]);
            
            if(base==true){
                translate([-x/2,0,0])cube([x/3,(1.5*(pin_x+wall))+pin_x+pin_y-wall-0.5,wall]);
            
                translate([-x/2,(1.5*(pin_x+wall))+pin_x+pin_y-wall-0.5-2,0])cube([x/3,2,z]);
            }
            
        }
        
        
        
        hull(){
            translate([pin_x/2,pin_x,0])cylinder(d=pin_hole,h=3*z,center=true,$fn=50);
            translate([pin_x/2,pin_x+pin_y,0])cylinder(d=pin_hole,h=3*z,center=true,$fn=50);
        }
        
        hull(){
            translate([-x/3,pin_x+pin_hole/2,0])cylinder(d=pin_hole,h=3*z,center=true,$fn=50);
            translate([-x/3,2*pin_x+pin_y+pin_hole/2-2,0])cylinder(d=pin_hole,h=3*z,center=true,$fn=50);
        }
        
        translate([-pin_hole,pin_x+pin_hole,0])cylinder(d=2*pin_hole,h=3*z,center=true,$fn=50);
        
        translate([-x/2,10,z/2])rotate([90,0,0])cylinder(d=cord,h=20,$fn=30);
            
           
    }
    
    
    
}

module clip(base=false){
    translate([x/2,0,0])pin(base=base);
    
}

module body(easy = false){
    
    difference(){
        union(){
            difference(){
                union(){
                    translate([pin_x,0,0])cube([wall,pin_y+pin_x,z]);
                    translate([0,pin_y+pin_x,0])intersection(){
                        translate([pin_x,0,0])cube([wall,1.5*(pin_x+wall),z]);
                        scale([1,1.5,1])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([pin_x+wall,z]); 
                        
                    }
                }
                
                translate([0,pin_y+pin_x-0.2,0])difference(){
                    scale([2,3,1])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([pin_x+wall,z]); 
                    translate([0,-2*wall,0])rotate([0,0,atan(2*wall/(pin_x+wall))])cube([5*(pin_x+wall),2*wall,2*z]);
            }
                
                
                
            }
            
            difference(){
                translate([-x/2,(1.5*(pin_x+wall))+pin_x+pin_y-wall,0])cube([x/2-0.2,wall,z]);
                translate([-0.2,(1.5*(pin_x+wall))+pin_y+pin_x-2*wall*sqrt(2),0])rotate([0,0,45])cube([2*wall,2*wall,2*z]);
            }
            
            ////////////bottom
            translate([-x/2,0,-wall])cube([x/2+wall+pin_x,pin_y+pin_x,wall]);
            
            translate([-x/2,pin_y+pin_x,-wall])cube([x/2,(1.5*(pin_x+wall)),wall]);
            
            translate([0,pin_y+pin_x,-wall])scale([1,1.5,1])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([pin_x+wall,wall]);
           
           /////////////////top 
            
            translate([-x/2,0,z])cube([x/2+wall+pin_x,pin_y+pin_x,wall]);
            
            translate([-x/2,pin_y+pin_x,z])cube([x/2,(1.5*(pin_x+wall)),wall]);
            
            translate([0,pin_y+pin_x,z])scale([1,1.5,1])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([pin_x+wall,wall]); 
        
        }
        
        
        if(easy == true)
            translate([pin_x+wall,pin_y+pin_x+(1.5*(pin_x+wall))+2*wall,-wall])rotate([0,0,-180])difference(){
                scale([1,1.5,1])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([pin_x+wall,3*z]); 
                translate([0,-2*wall,0])rotate([0,0,atan(2*wall/(pin_x+wall))])cube([5*(pin_x+wall),2*wall,2*z]);
            }
    }    
    
   
    
    
}


            
module full_clip(base=false){            
    color("red")clip(base=base);
    mirror([1,0,0])color("red")clip(base=base);
}

module full_body(){
    translate([x/2,0,0])color("blue")body(easy=style);
    mirror([1,0,0])translate([x/2,0,0])color("blue")body(easy=style);
}

translate([0,0,y+pin_x])rotate([-90,0,0])full_body();

translate([0,z+3*wall,0])scale([1,1,tolerance])full_clip(base=base);




