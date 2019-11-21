// variable description
text1 = "siripong.rungsang";
text2 = "@gmail.com";

fontsize = 4;


module floor(){
    
    //translate([-0.5, -18,-0.5])
    translate([22, 0,0])
    difference(){
    linear_extrude(height=1)
  {
        minkowski(){
    
            square([44,23],center=true);
             circle(r=3,$fn=32);
        }
    }
    
    translate([0, 0,0.6])
    linear_extrude(height=1)
  {
        minkowski(){
    
            square([42,21],center=true);
             circle(r=3,$fn=32);
        }
    }
    
}    
    }
    
    
    
    floor();
    
    translate([0, 3,0])
    linear_extrude(height=1)
  {
    text(text1, size = fontsize, font = str("Helvetica", ""), $fn = 32);
  }
  translate([0, -6,0])
    linear_extrude(height=1)
  {
    text(text2, size = fontsize, font = str("Helvetica", ""), $fn = 32);
  }