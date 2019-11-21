//////////////////////////////////
wallThickness=30;
castleLength=50;
castleHeight=15;

$fn=16*1;
s = [wallThickness, castleLength, castleHeight];
walls=2;

castle();
module castle() 
{
    difference(){
        union(){
            //four corner towers
            for(x=[-1:2:1], y=[-1:2:1])
            translate([s[0]/2*x, s[1]/2*y, 0])
            tower(height=s[2]);
    
            //sidewalls
            for(y=[-1:2:1])
            translate([0,y*s[1]/2, 0])
            wall([s[0], walls, s[2]*3/4], false);
            //front and back walls
            for(x=[-1:2:1])
            translate([x*s[0]/2, 0, 0])
            wall([walls, s[1], s[2]*3/4]);
        }
        maindoor();
    }
}
module tower(height = 15)
{
    translate([0, 0, height/2])
    union()
    {
        cylinder(d=height/3, h=height, center=true);
        translate([0,0, height*5/8])
        cylinder(d1=height/2.75, d2=0, h=height/4, center=true);
    }
}
module wall(dims=[30, 3, 10])
{
    translate([0, 0, dims[2]/2])
    cube(dims, center=true);
    
} 
module maindoor()
{
      translate([14,-3,-.07]) cube([10,10,6]);
} 

