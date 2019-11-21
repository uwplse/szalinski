//---------------------
//   Drill bit organizer
//   Adam Spontarelli
//   11/2018
//---------------------
starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 29;                // end bin number
units = "imperial";  // "imperial" or "metric"
invert = false;           // true flips the labels

bin_width = 21;
shortest_bin = 67;
growth_rate = 0.027;

l = 2; w = shortest_bin; h = 30;
l2 = l-1; w2 = w-2; h2 = h-2;

echo("last bin height = ", w+((ending_bin)*w*2*growth_rate));
echo("organizer width =", (ending_bin-starting_bin)*bin_width);



for (i=[starting_bin:ending_bin-1])
{
  difference()
    {
      difference()
        {
          hull()
            {      
              translate([i*bin_width, i*w*growth_rate, 0]) 
                cube ([l, w+(i*w*2*growth_rate), h], center=true); 
              translate([(i+1)*bin_width, (i+1)*w*growth_rate, 0]) 
                cube ([l, w+((i+1)*w*2*growth_rate), h], center=true); 
                                                                }
          hull()
            {
              translate([1+i*bin_width, i*w2*growth_rate, 2]) 
                cube ([l2, w2+(i*w2*2*growth_rate), h2], center=true); 
              translate([(i+1)*bin_width-1, (i+1)*w2*growth_rate, 1.5]) 
                cube ([l2, w2+((i+1)*w2*2*growth_rate), h2], center=true);
            }
                    hull()
{
    translate([-2,-shortest_bin,0]) cube([l, 200, h]);
    translate([ending_bin*bin_width,-shortest_bin,h/2]) cube([l, 500, h]);
}
        }
      
      translate([250,15,h-h/2])
        rotate([-5, 90, 0]) 
        cylinder (h = 900, r=22, center = true, $fn=100);
    }

    
      if (units == "imperial")
        {
          labels=["1/16", "5/64", "3/32", "7/64", "1/8", "9/64", "5/32", "11/64", "3/16", "13/64", "7/32", "15/64", "1/4", "17/64", "9/32", "19/64", "5/16", "21/64", "11/32", "23/64", "3/8", "25/64", "13/32", "27/64", "7/16", "29/64", "15/32", "31/64", "1/2"];
          if (invert==true){
              difference()
              {
                  translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
        cube([bin_width+2, 10,h]);
                  
            translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, -4+.4*i])
              rotate([0,0,180])
              linear_extrude(height = 15) {
              text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
              }  
             hull()
               {
                 translate([-2,-shortest_bin,0]) cube([l, 200, h]);
                 translate([ending_bin*bin_width,-shortest_bin,h/2]) cube([l, 500, h]);
               }
            }
          }
          else{
              difference(){
              translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
        cube([bin_width+2, 10,h]);
                  
            translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, -4+.4*i])
              linear_extrude(height = h) {
              text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
              }
               hull()
                {
                    translate([-2,-shortest_bin,0]) cube([l, 200, h]);
                    translate([ending_bin*bin_width,-shortest_bin,h/2]) cube([l, 500, h]);
                }
            }
          }
        }
      else if (units == "metric")
        {
          labels=["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13"];
          if (invert==true){
              difference()
              {
                  translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
        cube([bin_width+2, 10,h]);
            translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, -4+.4*i])
              rotate([0,0,180])
              linear_extrude(height = 15) {
              text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
              }
              hull()
                {
                translate([-2,-shortest_bin,0]) cube([l, 200, h]);
                translate([ending_bin*bin_width,-shortest_bin,h/2]) cube([l, 500, h]);
                }
            }
          }
          else{
              difference(){
              translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
        cube([bin_width+2, 10,h]);
                  
            translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, -4+.4*i])
              linear_extrude(height = h) {
              text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
              }
               hull()
                {
                    translate([-2,-shortest_bin,0]) cube([l, 200, h]);
                    translate([ending_bin*bin_width,-shortest_bin,h/2]) cube([l, 500, h]);
                }
            }
          }
        }
}
 
 

