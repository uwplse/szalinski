/*[General]*/

// What shape would you like to use?
part = "second"; //[first:Cube,second:Hexagonal Prism,third:Snow Flake]
// What Symmetry?
nfold = 6; //[2,3,4,5,6,7,8]
// How Big?
radius = 25; //[5:50]
// How Tall?
height = 2; //[1:5]
// What level of fractal?
level = 3; //[0,1,2,3,4,5]

/*[Map 1]*/

//Scale factor in the x direction for map 1?
xscaleone = 0.2; //[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
//Scale factor in the y direction for map 1?
yscaleone = 0.3; //[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
//shift for map 1?
shiftone = 1.2; //[0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0]

/*[Map 2]*/

//Scale factor in the x direction for map 2?
xscaletwo = 0.2; //[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
//Scale factor in the y direction for map 2?
yscaletwo = 0.3; //[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
//shift for map2?
shifttwo = 0.7; //[0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0]

/*[Hidden]*/
//Scale factor in the z direction for map 1?
zscaleone = 1; 
//Scale factor in the z direction for map 2?
zscaletwo = 1; 


module branch (start,ang,l,h,d)
{
    translate(start)
    rotate([0,0,ang])
    hull()
        {
         for(i=[0:9])
          {
          translate([[-d,0,0],[l,0,0],
                     [0,0,h],[l-d,0,h],
                     [0,0,-h],[l-d,0,-h],
                     [0,d,0],[0,-d,0],
                     [l-d,d,0],[l-d,-d,0]                                         
                     ][i])sphere(r=0.01,$fn=1);
          }
      }
}

module flake (r,h,d)
{
    union()
    {
        hull()
        {
         for(i=[0:8])
          {
          translate([[r*sqrt(3)/6*cos(30),r*sqrt(3)/6*sin(30),0],
                     [r*sqrt(3)/6*cos(150),r*sqrt(3)/6*sin(150),0],
                     [r*sqrt(3)/6*cos(270),r*sqrt(3)/6*sin(270),0],
                     [(r*sqrt(3)/6-d)*cos(30),(r*sqrt(3)/6-d)*sin(30),h],
                     [(r*sqrt(3)/6-d)*cos(150),(r*sqrt(3)/6-d)*sin(150),h],
                     [(r*sqrt(3)/6-d)*cos(270),(r*sqrt(3)/6-d)*sin(270),h],
                     [(r*sqrt(3)/6-d)*cos(30),(r*sqrt(3)/6-d)*sin(30),-h],
                     [(r*sqrt(3)/6-d)*cos(150),(r*sqrt(3)/6-d)*sin(150),-h],
                     [(r*sqrt(3)/6-d)*cos(270),(r*sqrt(3)/6-d)*sin(270),-h]                     
                     ][i])sphere(r=0.01,$fn=1);
          }   
        }
        hull()
        {
         for(i=[0:8])
          {
          translate([[r*sqrt(3)/6*cos(90),r*sqrt(3)/6*sin(90),0],
                     [r*sqrt(3)/6*cos(210),r*sqrt(3)/6*sin(210),0],
                     [r*sqrt(3)/6*cos(330),r*sqrt(3)/6*sin(330),0],
                     [(r*sqrt(3)/6-d)*cos(90),(r*sqrt(3)/6-d)*sin(90),h],
                     [(r*sqrt(3)/6-d)*cos(210),(r*sqrt(3)/6-d)*sin(210),h],
                     [(r*sqrt(3)/6-d)*cos(330),(r*sqrt(3)/6-d)*sin(330),h],
                     [(r*sqrt(3)/6-d)*cos(90),(r*sqrt(3)/6-d)*sin(90),-h],
                     [(r*sqrt(3)/6-d)*cos(210),(r*sqrt(3)/6-d)*sin(210),-h],
                     [(r*sqrt(3)/6-d)*cos(330),(r*sqrt(3)/6-d)*sin(330),-h]                    
                     ][i])sphere(r=0.01,$fn=1);
          }   
        }
        for(i=[0:5]){
            branch([0,0,0],60*i,r*11/12,1.5*h,d);
            rotate([0,0,60*i])branch([r*3/4,0,0],60,r/12,1.5*h,d);
            rotate([0,0,60*i])branch([r*3/4,0,0],-60,r/12,1.5*h,d);
        }
    }
}
module hexagon(r,h,d)
{
    union(){
    hull()
    {
    for(i=[0:17])
    {
    translate([[r*cos(0),r*sin(0),0],[r*cos(60),r*sin(60),0],
               [r*cos(120),r*sin(120),0],[r*cos(180),r*sin(180),0],
               [r*cos(240),r*sin(240),0],[r*cos(300),r*sin(300),0],
               [(r-d)*cos(0),(r-d)*sin(0),h],[(r-d)*cos(60),(r-d)*sin(60),h],
               [(r-d)*cos(120),(r-d)*sin(120),h],[(r-d)*cos(180),(r-d)*sin(180),h],
               [(r-d)*cos(240),(r-d)*sin(240),h],[(r-d)*cos(300),(r-d)*sin(300),h],
               [(r-d)*cos(0),(r-d)*sin(0),-h],[(r-d)*cos(60),(r-d)*sin(60),-h],
               [(r-d)*cos(120),(r-d)*sin(120),-h],[(r-d)*cos(180),(r-d)*sin(180),-h],
               [(r-d)*cos(240),(r-d)*sin(240),-h],[(r-d)*cos(300),(r-d)*sin(300),-h]
               ][i])sphere(r=0.01,$fn=1);
    }
    } 
    translate([0,0,h])flake(r,h,d);
    }
}


module hexcube(r,h,d)
{
        translate([0,0,h])
        for(i=[0:2])
    {
        rotate([0,0,60*i])
        cube([2*r,2*r*sqrt(3),2*h],center=true);
    }
}


module SnowFlake(n,r,h,d)
{
    if(n==0)
    {
        if(part=="first")
        {
            cube(2*r,2*r,h);
        }
        else
        {
            if(part=="second")
        {
            rotate([0,0,30])hexcube(r,h,d);
        }
        else
        {
            rotate([0,0,30])hexagon(2*r,h,d);
        }
        }
        
        
    }
    else
    {
        for(i=[0:nfold-1])
        {
            rotate([0,0,360/nfold*i])
            union()
            {
                rotate([0,0,-180/nfold])translate([0,shifttwo*r,0])
                scale([xscaletwo,yscaletwo,zscaletwo])
                SnowFlake(n-1,r,h,d);  // map2
                
                translate([0,shiftone*r,0])
                scale([xscaleone,yscaleone,zscaleone])
                SnowFlake(n-1,r,h,d); // map1
            }
        }
    }
}

SnowFlake(level,radius,height,1);
