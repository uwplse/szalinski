//  This is a quick customizable way to make an array of columns of any size and any size columns


//Defines the area of the  array in mm
a=100;

//Defines the radius of the columns in mm
r=1;

//Defines the thickness of the columns in mm
t=0.2;

//Defines the spacing of the columns in mm
s=10; 



//Choose your desired shape from the drop down menu
$fn = 4;//[3:Triangle, 4:Square, 6:Hexagon, 100:Circle]

 



module array() {

  q = floor(a/2/s);
    for (x=[-q:q])
      for (y=[-q:q])
        translate([x*s,y*s,r/2])
          cylinder(h=t, r=r, ,center=true);
}


array();
