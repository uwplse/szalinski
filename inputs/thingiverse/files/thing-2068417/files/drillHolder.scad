/* [base] */
//between drill axis and  mount pad
distance = 25;
//inner collar
diameter_upper = 35; 
//inner collar
diameter_bottom = 20; 

/* [additional] */
//collar thickness
holder_thickness = 2.5;
//overall size
holder_height = 8;

/* [mounts]*/
pad_width = 30;
pad_thickness = 2;
hole_distance = 20;
hole_diameter = 3.5;

/* [hidden]*/

if(diameter_upper)
  translate([-30,0,0])
    holder(diameter_upper);
if(diameter_bottom)
  translate([30,0,0])
    holder(diameter_bottom);

module holder(diameter,dist=3){
  difference(){
    pipe(diameter+2*holder_thickness,diameter,holder_height,$fn=diameter*3);
    translate([0,-dist/2,-.1])cube([diameter,dist,holder_height+.2]);
  }
  for(i=[1,0])
    mirror([0,i,0])
      translate([diameter/2,dist/2,0])
        difference(){
          cube([8,2,holder_height]);
          translate([5,-.1,holder_height/2])
            rotate([-90,0,0])
              cylinder(d=hole_diameter,$fn=16,h=pad_thickness+.2);
        }
  translate([0,distance,0]){
    difference(){
      translate([-pad_width/2,0,0])
        cube([pad_width,pad_thickness,holder_height]);
      for (i=[-1,1])
        translate([i*hole_distance/2,-.1,holder_height/2])
          rotate([-90,0,0])
            cylinder(d=hole_diameter,$fn=16,h=pad_thickness+.2);
    }
  
  translate([0,0,holder_height/2])
  rotate([90,0,0])
  trapezoid([hole_distance/2,holder_height,distance-diameter/2],[hole_distance/2.8,holder_height]);
  }
}

module pipe(do,di,h,fi=[0,0],fo=[0,0]){
  vis=.01;
  difference(){
    intersection(){
      cylinder(d=do,h=h);
      if(fo[0])
        cylinder(d1=do-fo[0]*2,d2=do-fo[0]*2+2*h,h=h);
      if(fo[1])
        cylinder(d2=do-fo[1]*2,d1=do-fo[1]*2+2*h,h=h);
    }
    if(di)
      translate([0,0,-vis]){
        cylinder(d=di,h=h+2*vis);
        if (fi[0])
          cylinder(d1=di+fi[0]*2,d2=di,h=fi[0]);
        if (fi[1])
          translate([0,0,h-fi[1]+2*vis])
            cylinder(d1=di,d2=di+fi[1]*2,h=fi[1]); //flange top
      }
  }
}
module trapezoid(s=[2,2,2],t=[1,1]){
  translate([-s[0]/2,-s[1]/2,0])
  intersection(){
    hull(){
      translate([0,0,-1])cube([s[0],s[1],1]);
      assign(x=t[0]?t[0]:s[0],y=t[1]?t[1]:s[1])
      translate([(s[0]-x)/2,(s[1]-y)/2,s[2]-1])cube([x,y,1]);
    }
    cube(s);
  }
}

