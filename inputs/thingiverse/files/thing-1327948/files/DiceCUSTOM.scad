/*Parameters*/

/* [Sizes] */

//Size of the dice (distance from one flat surface to the opposite one)
size=6; //[6:0.1:100]

//Thickness of the numbers in the dice
thick = 1; //[0.1:0.1:2.5]


/*End Parameters*/



module flat_heart(size) {
   union(){
  square(size);

  translate([size/2, size, 0])
  circle(size/2,$fn=8*size);

  translate([size, size/2, 0])
  circle(size/2,$fn=8*size);
    }
}

module dNumber(nbr,size,thick)
{
    tsize=size*0.75;
    csize=size*1.5;
    over=0.1;
    for(i=[0:1])
    {
    st = (7-nbr)*i+(1-i)*nbr;
        if(st==6)
        {
            rotate([i*180,0,45]) translate([-csize/7,-csize/7,csize/2-thick]) linear_extrude(thick+over)  flat_heart(csize/4);
        }
        else
        {
            rotate([i*180,0,0]) translate([0,0,csize/2-thick]) linear_extrude(thick+over)
            { 
                text(str(st),tsize,halign="center",valign="center");
            }
        }
    }
}


module draw(size,thick)
{
    csize=size*1.5;
    over=0.1;
rotate([180,0,90]) difference()
{  
   intersection()
    {
        cube([csize,csize,csize],true);
        sphere(size,$fn=100);
    } 
    union()
    {
    dNumber(1,size,thick);
    rotate([0,90,0]) dNumber(2,size,thick);
    rotate([90,0,0]) dNumber(3,size,thick);
    }
}
}

/*Start of the program*/

draw(size,thick);
