$fa = 0.01;
size = 100;
height= 5;
thick = 5;
union() {
difference() 
{
    cube([size,size,height]);    
    translate([thick / 2.0,thick/2.0,-10])cube([size-thick,size-thick,height+50]);        
}
difference() {
translate([size/2.0,size/2.0,0])cylinder(height,size/2.0,size/2.0);
translate([size/2.0,size/2.0,-10])cylinder(height+20,size/2.0 - thick/2.0,size/2.0 - thick/2.0);
}
};

