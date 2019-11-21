width=3;
length=14;
height=8;
tab_width=1;
tab_length=7;
tab_height=6;
resolution=50;

$fn=resolution;

difference(){
  hull(){
    cube ([width,length-width*2,height-width],center=true);
    translate ([0,-length/2+width/2,height/2-width/2])
      sphere (r=width/2,center=true);  
    translate ([0,length/2-width/2,height/2-width/2])
      sphere (r=width/2,center=true);  
    translate ([0,-length/2+width/2,-height/2+.5])
      cylinder (r=width/2,h=1,center=true);
    translate ([0,length/2-width/2,-height/2+.5])
      cylinder (r=width/2,h=1,center=true);  
}
  translate ([0,0,(tab_height-height)/2])
    cube ([tab_width,tab_length,tab_height],center=true);  
}