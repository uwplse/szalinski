
radius1=1.9;
radius2=2.4;
miny=-9;
maxy=9;
minx=-12;
maxx=13;

height=5;

bearingx=14;

off=minx+(maxx-minx)*2/3;
$fn=50+0;

difference() {
  union() {
    difference() {
    linear_extrude(height=height)
     difference() {
     offset(r=-2*radius2)
      offset(r=4*radius2)
        polygon(
          [
           [maxx,miny-5],
           [bearingx,-1],
           [bearingx/3*4,0],
           [bearingx,1],
           [maxx,maxy+5],
           [minx,maxy],
           [.1,0],
           [minx,miny],
          ]
          );
    
      offset(r=-radius2)
       offset(r=2*radius2)
        polygon([
                [bearingx,miny-6.3],
                [bearingx+.5,miny-5],
                [bearingx-2,miny],
                [0,0],
                [bearingx-1,maxy],
                [bearingx+.5,maxy+5],
                [bearingx,maxy+6.3],
                [-5,9],
                [0,0],
                [-5,-9],
                ]);
    
     }
    translate([-15,0,(height-1)/2])
      cube([30,9,height-1], center=true);
    }
    #scale([5,1,1])
      cylinder(r=4, h=height-1.5);
  }
  translate([minx,maxy,0])
   cylinder(r=radius1, h=height);
  translate([minx,miny,0])
   cylinder(r=radius1, h=height);

  translate([bearingx,0,0])
   cylinder(r=radius2, h=height);
}

