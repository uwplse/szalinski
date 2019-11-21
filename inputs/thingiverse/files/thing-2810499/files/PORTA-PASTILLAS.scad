include <image_extrude.scad>;

y=50;
x=40;
z=5;
wall=2;
tolerance=0.95;
module clip(){
    
    difference(){
        translate([x/2-((x/4-wall)/2),0,0]){
            rotate_extrude(angle=90,cenvexity=2,$fn=100)square([x/4,z]);
            translate([0,-(y-(x/4)),0])cube([x/4-wall,y-x/4,z]);
            translate([-(x/2-((x/4-wall)/2)),-(y-(x/4)),0])cube([2*(x/4)+wall/2,x/4-wall,z]);
        }
        
        hull(){
            translate([x/2-((x/4-wall)/2)+(x/4-wall)/2,0,0])cylinder(d= (x/4-wall)-2*wall, h=3*z,$fn=50,center=true);
            translate([x/2-((x/4-wall)/2)+(x/4-wall)/2,-((y-x/4)-((x/4-wall)/2)),0])cylinder(d= (x/4-wall)-2*wall, h=3*z,$fn=50,center=true);
        }
        
    
    }
    
}

module cover(){
    
         //mid
        translate([0,y-(y-(x/4)),0])cube([2*(x/4)-(x/4-wall)/2,wall,z]);
        translate([(x/2)+(x/4)/2 -(wall/2),-(y-(x/4)),0])cube([wall,y-x/4,z]);
    
        //bottom
        translate([0,-(y-(x/4)),-wall])cube([2*(x/4)-((x/4-wall)/2)+(x/4),y-(x/4),wall]);
        translate([0,0,-wall])cube([2*(x/4)-(x/4-wall)/2,(x/4)+wall,wall]);
        translate([x/2-((x/4-wall)/2),0,-wall])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([x/4,wall]);
    
    //top
    translate([0,-(y-(x/4)),z])cube([2*(x/4)-((x/4-wall)/2)+(x/4),y-(x/4),wall]);
        translate([0,0,z])cube([2*(x/4)-(x/4-wall)/2,(x/4)+wall,wall]);
        translate([x/2-((x/4-wall)/2),0,z])rotate_extrude(angle=90,cenvexity=2,$fn=100)square([x/4,wall]);
    
}



module all(){
    clip();
    color("BLUE")cover();
}

module case(){
    difference(){
        union(){
            color("BLUE")cover();
            color("BLUE")mirror([1,0,0])cover();
            color("BLUE")translate([0,x/4+wall,z/2])rotate([90,0,0])cylinder(d=z,h=wall,$fn=50,center=true);
        }
        //color("green")translate([0,-15,z+wall+0.7])img();
        translate([0,x/4+wall,z/2])rotate([90,0,0])cylinder(d=2,h=wall,$fn=50,center=true);
    }
    
    
    
}

module box(){
    color("red")clip();
    color("red")mirror([1,0,0])clip();
    
}
//all();
translate([0,0,y-x/4])rotate([90,0,0])case();
translate([0,-y/2,0])scale([1,1,tolerance])box();