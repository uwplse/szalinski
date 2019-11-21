w=3; //grid density

gridNumber=20; //increase if high density, (performance heavy)

ow=0.2; //width of grid
wT=0.2; //width T Shape
 
h=5; // heigth

c=0.2; //top cut offset
sl=9.2; // length of T Shape 
 
////////mount
offsetX=-ow; //mount offset
offsetZ=1; //height adjustment mount
offsetHull=1; //offset mount
percentRadius=0.4; //inner diameter in percent, 0.0 - 1.0
width=1; //width of mounts
twoMounts=true; //use one or two mounts
offsetTwoMounts=2.3; //offset of the two mounts
circleMountRadius=3; //radius of circle at mount(inner)
circleMountOffset=0; //offset of circle at the mount
 
 
////////offsets of shape points
//middle points
o1x=0.3;
o1y=0;
//only middle point 2
o2x=0;
o2y=0;
//last points top
o3x=0;
o3y=0;
 
////////shape
op=[[0,0],[1,0],[2+o1x,4+o1y],[2+o1x+o2x,5+o1y+o2y],[1+o3x,10+o3y],[-1-o3x,10+o3y],[-2-o1x-o2x,5+o1y+o2y],[-2-o1x,4+o1y],[-1,0],[-1,0]]; //outer points
pList=concat(op,
//inner points
[[0,0+ow],[1-ow,0+ow],[2-ow+o1x,4.0+o1y],[2-ow+o1x+o2x,5.0+o1y+o2y],[1-ow+o3x,10.0-ow+o3y],
[-1+ow-o3x,10.0-ow+o3y],[-2+ow-o1x-o2x,5.0+o1y+o2y],[-2+ow-o1x,4.0+o1y],[-1+ow,0.0+ow]]);
   
//Path:  first array outer shape indices, second array inner shape array
p=[[0,1,2,3,4,5,6,7,8,9],[10,11,12,13,14,15,16,17,18]];

t=10; //translate

 difference(){
     union(){
         intersection(){
                grid();
                outerBounds();
         }

            finShape();
            tShape();
            
            intersection(){
                rotate([0,0,-45])
                translate([0,t - circleMountOffset,h/2 - offsetZ/2])
                cylinder(r=circleMountRadius,h=h-offsetZ,$fn=20,center=true);
                outerBounds();
            } 
         
        }
        
        cylinderSub();
        
        translate([0,0,h-c])
        cube([200,200,10]);
}

mount();

   

module tShape(){
    rotate([0,0,-45])
    translate([0,t,0])
    cube([wT,sl,h]);
    
    rotate([0,0,-45])
    translate([-sqrt(w)-ow/2,t+sl,0])
    cube([sqrt(w)*2+ow,wT,h]);
}

module finShape(){
    rotate([0,0,-45])
    translate([0,t,h/2])
    scale([3,3,1])
    linear_extrude(height=h,center=true,convexity=20)
    polygon(points=pList, 
        paths=p,convexity=10);
}

module mount(){
    difference(){
        if(twoMounts){
            union(){
                mountPart(-offsetTwoMounts);
                mountPart(offsetTwoMounts);
            }         
        }else{
            mountPart(0);
        }
        
        rotate([0,90,-45])
        translate([-h/2+offsetZ/2,t+offsetX-offsetHull, 0])
        cylinder(r=(h - offsetZ) /2 * percentRadius ,h=100,$fn=50,center=true);
    }
} 

module mountPart(yOffset){
    hull(){
            rotate([0,90,-45])
            translate([-h/2+offsetZ/2,t+offsetX-offsetHull, yOffset])
            cylinder(r=(h - offsetZ) /2 ,h=width,$fn=50,center=true);
            
            rotate([0,0,-45])
            translate([yOffset,t+offsetX,h/2 - offsetZ/2])
            cube([width,1,h - offsetZ],center=true);
    }
}

module outerBounds(){
    rotate([0,0,-45])
    translate([0,t,0])
    scale([3,3,1])
    linear_extrude(height=100,center=true,convexity=10)
    polygon(points=op);
}

module cylinderSub(){
        union() {
            for(z=[0:1:gridNumber])
                    rotate([0,90,0]) translate([-h,z*w + w/2,0]) cylinder(h=w*gridNumber,r=w/2,$fn=40);
            for(z=[0:1:gridNumber])
                    rotate([-90,0,0]) translate([z*w + w/2,-h,0]) cylinder(h=w*gridNumber,r=w/2,$fn=40);
        }
}

module grid(){
         union() {
             for(z=[0:1:gridNumber])
                translate([0,z*w,0]) cube([gridNumber*w,ow*2,h]);
             for(z=[0:1:gridNumber])
                translate([z*w,0,0]) cube([ow*2,gridNumber*w,h]);
             
        }
}