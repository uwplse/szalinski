// number of bins
n = 2;

/* [Hidden] */

a = 6;
b = 9;
w = 48;
h = 39;
m = 3;
z = 54; 
 
outer_points =[[0,a], [0,h+2*m-b], [b,h+2*m], [w+2*m-b,h+2*m], [w+2*m,h+2*m-b], [w+2*m,a], [w+2*m-a,0], [a,0]];
inner_points =[[m,a], [m,h+2*m-b], [b,h+m], [w+2*m-b,h+m], [w+m,h+2*m-b], [w+m,a], [w+2*m-a,m], [a,m]];
hole_points = [[-10,0], [-14,4], [-14,19], [-11,22], [-11,26], [-8, 29], [8,29], [11,26], [11,22], [14,19], [14,4], [10,0]];
profile_points = [[0,0], [0, 54], [b, 54], [h+2*m, 40], [h+2*m+5, 40], [h+2*m+5, 4+5], [h+2*m-4, 0]]; 
 
 module wiimote()
 { 

       difference()
        {
            // main
            linear_extrude(height = z) 
               polygon(outer_points);    
            // cavity
            translate([0, 0, m])
                linear_extrude(heigth = m)
                    polygon(inner_points);    
            // cable hole
            translate([m+(w/2),6.5+1,0]) 
               linear_extrude(heigth =m)
                 polygon(hole_points);
        }
    
 }

module nunchuk_positive()
{
    // nunchuck holder
    translate([ m+(w/2), m, 39.5])
      rotate([90,360/16, 0])
        cylinder(h=6.5, d=25, $fn=8);
} 

module nunchuk_negative()
{
    // nunchuck holder
    translate([ m+(w/2), 1+m, 39.5])
      rotate([90,360/16, 0])
        {
            cylinder(h=6.5+1, d=11+1, $fn=8);
            cylinder(h=m+1, d=17+1, $fn=8);
        }

} 


module bin()
{
  difference()
  {
      intersection()
      {
         translate ([w+2*m, h + 2*m, 0]) 
           rotate([90, 0, -90])       
             linear_extrude(heigth = w + 2*m)
               polygon(profile_points); 
          union()
            {
                wiimote();
                nunchuk_positive();
            }
      }
        
  // front entrance
  translate([m+(w/2)-(7/2), -5, 0])
    cube([7, 6.5+5+1, z]);
  nunchuk_negative();
  }
}


difference()
{
  for (i = [1:n])
    translate([(i-1)*(w+m), 0, 0]) bin();
  // hanging holes
  translate([m+(w/2), h+2*m, 35]) rotate([90, 0, 0]) cylinder(h=2*m, d=5);
  translate([m+(w/2)+(n-1)*(w+m), h+2*m, 35]) rotate([90, 0, 0]) cylinder(h=2*m, d=5);
  # translate([7, 2, 5]) rotate([90, 0, 0])   linear_extrude(height = 2) text("Wii", font = "Arial Rounded MT Bold:style=Regular", size =7);
  }