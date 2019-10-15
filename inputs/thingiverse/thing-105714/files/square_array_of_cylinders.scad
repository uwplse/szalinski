//  This is a quick customizable way to make an array of columns of any size and any size columns


//Defines the area of the  array
a=100;

//Defines the radius of the columns
r=1; //size

//Defines the thickness of the columns
t=5;

//Defines the spacing of the columns
s=10; //space


module array() {

  q = floor(a/2/s);
    for (x=[-q:q])
      for (y=[-q:q])
        translate([x*s,y*s,r/2])
          cylinder(h=t, r=r, ,center=true);
}


array();
