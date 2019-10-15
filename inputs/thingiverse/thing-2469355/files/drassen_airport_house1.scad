module window(wx,wz,ww,wh)
{
    translate([wx,1,wz]) cube([ww,1,1]);
    translate([wx,1,wz+wh-1]) cube([ww,1,1]);
    translate([wx,1,wz]) cube([1,1,wh]);
    translate([wx+wz-1,1,wz]) cube([1,1,wh]);
}

module door(dx)
{
    translate([dx,0.5,0]){
        difference() {
            cube([20,2,40]);
            union() {
                translate([3,0,5]) cube([14,0.5,14]);
                translate([3,0,23]) cube([14,0.5,14]);
                translate([3,1.5,5]) cube([14,0.5,14]);
                translate([3,1.5,23]) cube([14,0.5,14]);
            }
        }
    }
}

l=180; // length
w=160; // width
h=50; // height
t=3; // wall thickness
offset=0; // explosion offset

// floor
translate([t,t,-offset]) cube([l-2*t,w-2*t,t]);

// front wall
translate([0,-offset,0]) difference() {
    cube([l,t,h]);
    for(x=[4:4:l]) translate([x,0,0]) cube([0.5,0.5,h*1.5]);
}
        
// rear wall
translate([0,offset,0]) difference() {
translate([0,w-t,0]) cube([l,t,h]);
    for(x=[4:4:l]) translate([x,w-0.5,0]) cube([0.5,0.5,h*1.5]);
    }
    
// left wall
translate([t,0,0]) rotate([0,0,90]) 
{
    difference()
    {       
        cube([w,t,h*2]);
        union()
        {
            cube([t,t,h]);
            translate([w-t,0,0]) cube([t,t,h]);
            translate([0,0,h]) rotate([0,-20,0]) cube([w*1.5,t,w]);
            translate([w,t+1,h]) rotate([0,-20,180]) cube([w*1.5,t*2,w]);
        for(x=[4:4:w]) translate([x,t-0.5,0]) cube([0.5,0.5,h*1.7]);
        }
    }
}

// center wall
translate([60,0,t]) rotate([0,0,90]) 
{
    difference()
    {       
        cube([w,t,h*2]);
        union()
        {
            cube([t,t,h-t]);
            translate([w-t,0,0]) cube([t,t,h-t]);
            translate([0,0,h-t]) rotate([0,-20,0]) cube([w*1.5,t,w]);
            translate([w,t+1,h-t]) rotate([0,-20,180]) cube([w*1.5,t*2,w]);
            translate([120,0,0]) cube([20,t,40]);
        }
    }
    door(120);
}
// right wall
translate([l,0,0]) rotate([0,0,90]) 
{
    difference()
    {       
        cube([w,t,h*2]);
        union()
        {
            cube([t,t,h]);
            translate([w-t,0,0]) cube([t,t,h]);
            translate([0,0,h]) rotate([0,-20,0]) cube([w*1.5,t,w]);
            translate([w,t+1,h]) rotate([0,-20,180]) cube([w*1.5,t*2,w]);
            translate([125,0,20]) cube([20,t,20]);
            translate([100,0,0]) cube([20,t,40]);
            translate([60,0,20]) cube([20,t,20]);
            for(x=[4:4:w]) translate([x,0,0]) cube([0.5,0.5,h*1.7]);
        }
    }
    window(60,20,20,20);
    window(125,20,20,20);
    door(100);
}
