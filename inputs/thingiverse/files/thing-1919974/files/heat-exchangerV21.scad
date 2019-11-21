//heat exchanger version 2.1 by akaJes 2016 (c)
/*[pipes]*/
//
pipe_inner_diameter=8;
//
pipe_wall_thickness=2;
//
connector_height=10;
//size for tap
connector_inner_diameter=7.5;
/*[chambers]*/
// of chamber
width=50; 
// of chamber
length=100;
// of chamber
thickness=8;
// chamber thickness
wall=1;
// of chambers 
number=8;
//number
camera_ribs=3;//[1,3,5]

/* [visualization] */
//(cutted chambers)
show_inside=1; //[2:Half,1:Box,0:No]
//colored chambers
show_colors=1; //[1:Yes,0:No]
// chambers
show_split=2; //[0:Red,1:Blue,2:No]
//horizontal
show_split_chamber=0; //[0:Off,1,2,3,4,5,6,7,8,10]
//direction of flow
show_arrows=1; //[1:Yes,0:No]

function colored(c)=show_colors?c:"yellow";
pd=pipe_inner_diameter;
pt=pipe_wall_thickness;

difference(){
  heat_exchager();
  if (show_inside==1)
    translate([width/2+2,10,-thickness*2.5])cube([width/2,length-20,70]);
  else if (show_inside==2)
    translate([width/2+2,-10,-100])cube([width/2,length+20,7000]);
  if (show_split_chamber)
    translate([-10,-10,(thickness-wall)*show_split_chamber-thickness/2])cube([width+20,length+20,7000]);
}
module connector(){
  difference(){
    union(){
      cylinder(d=pd+2*pt,h=connector_height,$fn=6);
      cylinder(d=pd+3*pt,h=pt);
    }
    translate([0,0,-.01])
    cylinder(d=connector_inner_diameter,h=connector_height+.02);
  }
}
module arrow(cl){
  if (show_arrows)
    translate([0,0,20]){
      cylinder(d=pd,h=pd*2);
      translate([0,0,pd*2])cylinder(d1=pd*2,d2=1,h=pd);
    }
}
module heat_exchager(){
  for (i=[0:number-1])
    translate([0,0,(thickness-wall)*i])
      section(i,i==0||i==number-1);
}
module section(side=0,upper=1){
  difference(){
    union(){
      if(show_split!=side%2)
      color(colored(side%2?"red":"blue"))
      camera(width,length,thickness,wall,side);
      holes(side,upper);
    }
    holes(side,upper,1);
  }
}
module holes(side,upper=1,hole=0){
  assign(sh=pd/2+pt*2)
  assign(ch=floor(side/2)%2){
    translate([(width-pd*2)*(side%2)+pd,0,0]){
      color(colored(side%2?"red":"blue"))
      translate([0,ch?sh:length-sh,wall]){
          mirror([0,0,1])pipe(pd,pt,wall,hole);
          if (!hole&&side==0&&upper){ //bottom
            translate([0,0,-pd*8])arrow();
            mirror([0,0,1])translate([0,0,wall])connector();
          }
      }
      translate([0,ch?length-sh:sh,thickness-wall]){
        color(colored(side%2?"red":"blue"))
          pipe(pd,pt,wall,hole);
        color(colored(side%2?"lightcoral":"RoyalBlue"))
          if (!hole&&side!=0&&upper){ //top
            translate([0,0,wall])connector();
            arrow();
          }
      }
    }
    assign(ch2=floor((side+1)/2)%2)
    translate([(width-pd*2)*(1-(side%2))+pd,0,0])
      translate([0,ch2?sh:length-sh,0]){
        color(colored(!side%2?"red":"blue"))
          pipe(pd,pt,thickness,hole);
        if (!hole){
          color(colored(!side%2?"red":"blue"))
            if (side==0&&upper){ //bottom
              translate([0,0,-pd*8])arrow();
              mirror([0,0,1])connector();
            }
          color(colored(!side%2?"lightcoral":"RoyalBlue"))
            if (side!=0&&upper){ //top
              translate([0,0,pd])arrow();
              translate([0,0,thickness])connector();
            }
        }
    }
  }
}
module pipe(d,t,h,hole=0){
  if (hole)
    translate([0,0,-0.1])cylinder(d=d,h=h+.2);
  else
    difference(){
      cylinder(d=d+2*t,h=h);
      translate([0,0,-0.1])cylinder(d=d,h=h+.2);
    }
}
module camera(w,l,h,t,side=0,r=3,ribs=camera_ribs){
  difference(){
    rounded_cube(w,l,h,r);
    translate([t,t,t])rounded_cube(w-2*t,l-2*t,h-2*t,r);
  }
  if (ribs){
    intersection(){
      rounded_cube(w,l,h,r);
      assign(step=l/(ribs+1))
        for (i=[1:ribs])
          assign(hole=w/3,angle=45)
            translate([(i+side)%2?0:hole,step*i,0])
              rotate([angle,0,0])
                cube([w-hole,t,h/cos(angle)]);
      }
    }
}
module rounded_cube(w,d,h,ri){
  if(ri==0)
    cube([w,d,h]);
  else
    resize([w,d,h])
  assign(min_s=min(min(w,d),h))
  assign(r=min(ri,min_s/2))
  hull(){
    for (i=[r,h-r])
      for (j=[r,d-r])
        for (y=[r,w-r])
          translate([y,j,i])sphere(r,$fn=16);
  }
}