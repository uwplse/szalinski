// ventilation grid
// Remix of https://www.thingiverse.com/thing:3115753
// Modified and extended by Kakiemon @ Thingiverse
// Rolf Jethon
// Begin of input parameters
length=100; //0 : 1000 Note: overall length and width = length + diameter
width=40;  //0 : 1000 
border=10;        //0 : 1000
borderinternal=4; // 0 : < diameter
diameter=8;      // 0.01 to 1000
spacerborder=3;   // 0 : <= spacerinternal
spacerinternal=10;// 0 : 1000
grid_x=6;         // > gridthickness : < length
grid_y=6;        // > gridthickness : < width
grid_height=5;    // < spacerinternal
grid_thickness=1; // < grid_x : < grid_Y
// End of input parameters

echo ("overall length= ",length + diameter," and overall width= ",width + diameter);
translate([-length/2,0,0])
difference(){
    union(){
        hull(){   
            cylinder(d=diameter+border,h=spacerborder);
            translate([length,0,0])
            cylinder(d=diameter+border,h=spacerborder);
            translate([0,width,0])
            cylinder(d=diameter+border,h=spacerborder);
            translate([length,width,0])
            cylinder(d=diameter+border,h=spacerborder);
        }

        hull(){   
            cylinder(d=diameter,h=spacerinternal);
            translate([length,0,0])
            cylinder(d=diameter,h=spacerinternal);
            translate([0,width,0])
            cylinder(d=diameter,h=spacerinternal);
            translate([length,width,0])
            cylinder(d=diameter,h=spacerinternal);
             }
         }
translate([0,0,-1])
hull(){   
cylinder(d=diameter-borderinternal,h=spacerinternal+2);
translate([length,0,0])
cylinder(d=diameter-borderinternal,h=spacerinternal+2);
translate([0,width,0])   
cylinder(d=diameter-borderinternal,h=spacerinternal+2);  
translate([length,width,0])
cylinder(d=diameter-borderinternal,h=spacerinternal+2);    
}

}

intersection(){
    translate([-length/2,0,0])
    hull(){   
            cylinder(d=diameter,h=spacerinternal);
            translate([length,0,0])
            cylinder(d=diameter,h=spacerinternal);
            translate([0,width,0])  
            cylinder(d=diameter,h=spacerinternal);
            translate([length,width,0])
            cylinder(d=diameter,h=spacerinternal);
             }
union(){
for (a =[0:grid_x:length+diameter])
{
    translate([a-length/2-diameter/2,-diameter/2,0])
    cube([grid_thickness,diameter+width,grid_height]);
}

for (a =[0:grid_y:width+diameter-1])
{
    translate([-length/2-diameter/2,a-diameter/2,0])
    cube([length+diameter,grid_thickness,grid_height]);
}
}
}