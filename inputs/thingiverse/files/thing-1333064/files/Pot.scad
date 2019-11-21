/*Welcome to my customizable twisted pot ! Feel free to look at the code ;)*/

/*[Pot]*/
//The twist of the pot
twist = 90;
//The height of the pot
height = 80;//[1:200]
//The width of the pot
side = 40;//[1:200]
//The thickness of the pot
thick = 1;//[0.5:0.5:10]
/*[Holes]*/
//Enables the holes
holes = 1;//[1:True,0:False]
//Holes thickness
holes_thick = 5;//[1:20]
//Precision of the convex shapes (Use 1 for low poly)
poly = 30;//[1:1:200]


/*[Hidden]*/
size = side+20;
fn = poly;


difference()
{
twistPot(height,size/2,side/2,thick,twist);

if(holes==1)
{
       color("red") randomHoles(height,holes_thick,thick,size);
}
}



/*Modules*/
module randomHoles(height,d,base_thick,size)
{
    union()
    {
    for(i=[base_thick+d:d*2:height-d/2])
    {
        angle = rands(1,180,1)[0];
        translate([0,0,i]) rotate([angle,90,0]) cylinder(h=size*3,d=d,$fn=fn,center=true);
    }
}
}




module twistPot(height,size,side,thick,t)
{
color("LightBlue") union() {
    difference() {
linear_extrude(height,$fn=fn,twist=t)
{
     offset(r=side/2)
        {
            square(size,center=true);
        }
}

translate([0,0,height/2+thick]) cube([size*4,size*4,height],center=true);

}
linear_extrude(height,twist=t,$fn=fn)
{
    difference()
    {
        offset(r=side/2)
        {
            square(size,center=true);
        }
        offset(r=side/2-thick)
        {
            square(size,center=true);
        }
    }
}
}
}