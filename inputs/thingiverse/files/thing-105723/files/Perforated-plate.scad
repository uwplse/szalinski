// This is a quick customizable way to make an array of holes of any size in a cylindrical plate - specifically for use in a Buchner funnel.

//Defines the diameter of filter paper for your funnel
d_paper = 90;

//Defines the thickness of the perforated plate
t_plate=2;


//Defines the area of the  array
a=100;

//Defines the radius of the holes
r=1; //size

//Defines the spacing of the holes
s=6; //space

t=t_plate+1; //thickness or depth of the holes


module array() {

  q = floor(a/2/s);
    for (x=[-q:q])
      for (y=[-q:q])
        translate([x*s,y*s,r/2])
          cylinder(h=t, r=r, ,center=true);
}

difference(){
cylinder(h=t_plate, r=(d_paper)/2, center=true);
array();
}
