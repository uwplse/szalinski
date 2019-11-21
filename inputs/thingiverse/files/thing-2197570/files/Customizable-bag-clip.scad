// Author: Martin Cloutier
// Email:  mxclouti@gmail.com
// Date:   2017-03-22

$fn = 16;

h = 12;
w = 20;
l = 150;

module pie(rotate_angle, radius, height) {
  linear_extrude(height) {
    rotate([0,0,rotate_angle]) 
    {
      difference() 
      {          
        circle(r=radius,center=true);
        square([radius,radius]);        
        translate([-radius,-radius,0]) square([radius*2,radius]);          
      }
    }
  }
}

module extruded_square(size,height)
{
    linear_extrude(height) square(size,center=true);    
}

module upper_part()
{   
    pie(0,w/2,h);
    translate([l/2,w/4,0]) extruded_square([l,w/2],h);
    translate([l,0,0]) pie(270,w/2,h);

    translate([0,0,h/2-h/4+0.5]) linear_extrude(h/2-1) polygon(points=[[-w/4,2],[-w/4,-2],[l+w/4,-2],[l+w/4,2]]);
    
    linear_extrude(h) polygon(points=[[-w/2+2,0],[-w/2-3,0],[-w/2-3,2],[-w/2,2],[-w/2+2,2]]);
        
    translate([l+w/2,0,h/4]) linear_extrude(h/2) polygon(points=[[0,0],[6,-4],[6,4],[-w/4,5]]);
    
    translate([l+w/2+6,0,0]) cylinder(r=3.0,h=h);       
    translate([l+w/2+6,0,h/2-(h/4)]) cylinder(r=5.5,h=h/2);       
}

module bottom_part()
{
  difference() { 
    union() 
    {
      difference() 
      {
        union() 
        {        
          translate([-w/4,-w/4,0]) extruded_square(w/2,h);
          translate([l/2,-w/4,0]) extruded_square([l,w/2],h);
          translate([l,0,0]) pie(180,w/2,h);    
          translate([-w/2,0,0]) linear_extrude(h) 
          polygon(points=[[-1,2+0.5],[-1,4],[-8,w/2],[-8,w/2-2],[-5,0],[-5,-w/2],[0,-w/2],[0,-w/2+2],[-3-0.5,-w/2+2],[-3-0.5,2.5]]);
        }      
        translate([0,0,h/2-h/4]) linear_extrude(h/2) polygon(points=[[-w/4-3,2+3],[-w/4-3,-2-3],[l+w/4+3,-2-3],[l+w/4+3,2+3]]);
      }  
      mirror([0,-1,0]) 
      {
        translate([l+w/2,0,0.5]) linear_extrude(h/4-1) polygon(points=[[0,0],[6,-4],[6,4],[-w/4,5]]);
      }
      mirror([0,-1,0]) 
      {
        translate([l+w/2,0,h/2+h/4+0.5]) linear_extrude(h/4-1) polygon(points=[[0,0],[6,-4],[6,4],[-w/4,5]]);
      }
      translate([l+w/2+6,0,0]) cylinder(r=5.5,h=h);
    }    
    translate([l+w/2+6,0,0]) cylinder(r=4.0,h=h);
    translate([l+w/2+6,0,h/4-0.5]) cylinder(r=5.5,h=h/2+1);    
  }
}

upper_part();

translate([(l+w/2+6),0,0])
rotate([0,0,15]) {
  translate([-(l+w/2+6),0,0]) 
  bottom_part();
}














