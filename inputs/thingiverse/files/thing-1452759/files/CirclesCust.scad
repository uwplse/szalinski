//Variables
nox = 4;
noy = 4;


//Line Connection module
module forbind(x, y,)
{

translate([x-13, y+11.0, 0])
color("pink")
cube(size=[0.7, 3, 0.4], center = false);

translate([x-13, y+13.7, 0])
color("green")
cube(size=[(nox*25), 0.7, 0.4], center = false);

translate([x-13+(nox*25)-00.7, y+13.7, 0])
color("yellow")
cube(size=[0.7, 22, 0.4], center = false);

}

//Cirkle module
module enhed(x, y,)
{
 difference()
{
color("yellow")
    translate([x, y, 0])
cylinder(h=0.4, d=15, center=false) ;
    color("white")
    translate([x, y, 0])
    cylinder(h = 0.4, d=13.6, center=false);
    //cutout
    color("white")
    translate([x, y+2, 0])
    rotate ([0, 0, 135])
cube(size=[7.5, 2.5, 0.4], center = false);
}
translate([x-13, y+3.9, 0])
color("brown")
cube(size=[7.5, 0.7, 0.4], center = false);

translate([x-13, y+3.9, 0])
color("purple")
cube(size=[0.7, 7.1, 0.4], center = false);

translate([x-4.1, y+10.3, 0])
color("blue")
cube(size=[16.1, 0.7, 0.4], center = false);

translate([x-4.1, y+5.7, 0])
color("red")
cube(size=[0.7, 5.3, 0.4], center = false);
}

   
//Generate circles
for (tmpx=[0:25:(nox*25-25)]) 
    {
        //tmpx = i;
        for (tmpy = [0:25:(noy*25-25)])
        {
        //tmpy = j;
        enhed(tmpx, tmpy);
            //echo ("y1: ",j);  
        }
        
 for (tmpy = [0:25:(noy*25-50)])
 {
     forbind (0,tmpy);
 }     
        
}        
        
        
        
        
        
        
        
     