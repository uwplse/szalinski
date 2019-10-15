
width=30;
length=30; 
height=20;
//of walls (must be more than nozzle size)
thickness=.3; 
rounding=0;
empty=1;//[0:No,1:Yes]

difference(){
  rounded_brick(d=[width,length,height],r=rounding);
  if (empty)
  translate([0,0,thickness])
    rounded_brick(d=[width-2*thickness,length-2*thickness,height],r=rounding);
}

module rounded_brick(d=[10,10,10],sides=[1,1,1,1],r=-1,$fn=36){
  module rounded_(d=[10,10,10],sides=[1,1,1,1]){
    if(max(sides)){
      hull()
        for (i=[0:3])
          mirror([floor(i/2),0,0])mirror([0,i%2,0])
            if (sides[i])
              translate([d[0]/2-sides[i],d[1]/2-sides[i],0])
                cylinder(h=d[2],r=sides[i],$fn=$fn);
            else
              translate([d[0]/2-1,d[1]/2-1,0])
                cube([1,1,d[2]]);
    }else
      translate([-d[0]/2,-d[1]/2,0])
        cube(d);
  }
  if(r>=0)
    rounded_(d,[r,r,r,r]);
  else
    rounded_(d,sides);
}
