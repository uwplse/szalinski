how_many_rows=10;
how_many_columns=10;
thickness=0.1;
outer_radius =1.5;
/* [Hidden] */
module draw_cylinder(radius,inithick){
    cylinder(r=radius,h=inithick);
}
$fn=30;
rad = outer_radius;
module draw_arm()
{  
    trans = rad;
    cuttout_rad=rad*.8;
      difference(){
          draw_cylinder(rad,thickness);
          for(i=[1:3]){
              rotate([0,0,i*120]){
                  translate([trans,0,0]){
                      draw_cylinder(    cuttout_rad,thickness*1.1);
                  }
              }
          }
        
      }
  
    
}
size_x = 1;
size_y = 1;

steps_x = rad;
steps_y = rad*1.75;

max_x = steps_x*size_x;
max_y = steps_y*size_y;

start_x = 0;
start_y = 0;


module draw_row(){
    for(i=[start_x:steps_x:steps_x*how_many_columns])    
    {
        
                translate([i,0,0])
                draw_arm();
            
        
    }
}

// Draw a set of rows
module draw_matrix(){
    
    for(j=[0:steps_y:how_many_rows*steps_y])
{
    
        translate([0,j,0])
            draw_row();        
}

}
union(){
draw_matrix();
translate([steps_x/2,steps_y/2,0])
    {
        draw_matrix();
    }
    
    }
/*
for(j=[steps_y/2:steps_y:5]){
       translate([steps_x/2,j,0])
            draw_row();   
}
    */