/************************************************/
/*       Propeller for Spiral Launch Pad        */
/************************************************/
/*          programmed by Tiger M. Cho          */
/*                 2017. 9. 6                   */
/*              tigermcho@gmail.com             */
/************************************************/


No_of_Blades = 3;    // [2:1:6]
Pitch_angle = 30;    // [20:5:45]
Ring_Diameter = 100;   // [70:5:150]
Ring_Height = 4 ;      // [3:0.5:5] 
Ring_Thickness= 1 ;    // [0.8:0.2:2.0]

/*[hidden]*/
$fn = 120;  // resolution
Hub_Diameter=17;
Hub_Height=Ring_Height;

/*Draw a Ring*/

  difference(){
    cylinder(h=Ring_Height,d=Ring_Diameter);
    cylinder(h=Ring_Height,d=Ring_Diameter-Ring_Thickness*2);    
  }

/*Draw Blades*/
l_h=Ring_Diameter/2-2-Ring_Thickness/2;
l_y=Ring_Height;
l_x=l_y/tan(Pitch_angle);
difference(){
   make_Propeller(No_of_Blades,l_h,l_x,l_y);
   cylinder(h=Hub_Height,d=Hub_Diameter);  
}

/*Draw a Propeller Hub*/
{
difference(){
      cylinder(h=Hub_Height,d=Hub_Diameter);    
      translate([0,0,Ring_Height/2]) cube([8.5,11.5,Ring_Height],true);
} 

difference(){
   translate([11.5,0,0]) cylinder(h=Hub_Height,d=18); 
   translate([14.25,0,Ring_Height/2]) cube([19.5,19.5,Ring_Height],true);  
} 
difference(){
   translate([-11.5,0,0]) cylinder(h=Hub_Height,d=18); 
   translate([-14.25,0,Ring_Height/2]) cube([19.5,19.5,Ring_Height],true);  
} 
}


module make_Propeller(n,h,x,y){ 
  if(n>1) {
      blade(h,x,y);  
      angle=360/n;  nend=n;
            
      for (i =[2:nend]) {
          rotate([0,0,angle*(i-1)])blade(h,x,y); 
      } 
      
  } else {
      blade(h,x,y);  
      rotate([0,0,180])blade(h,x,y); 
  } 
}


module blade(h,x,y ){  // modeling a blade.
    
    rotate([90,0,0]) translate([-(1.2+x)/2,0.0,2.0])
    linear_extrude(height = h)
    polygon(points=[[0,0],[1.2,0],[1.2+x,y],[x,y]]);
}
