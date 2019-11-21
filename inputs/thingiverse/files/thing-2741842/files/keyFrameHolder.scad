/*                ____
   ###           /#  #
   ###===========##  #      --  
                 \#  #      h
                  ''''      --
                            l
        |breite|            --
*/

r = 3.6;  // radius of the key
h = 7;
l = 4;
breite = 15;   // width
spalt  = 0.5; // thickness of the frame holder
dicke  = 0.8; // thickness of the key holder

// printing variants
rotate(a=[-90,0,0])   
//rotate(a=[180,0,0])
difference() {
    union() {
      cube([breite, 2*(r+dicke), l+h+r]);
      // key holder
      translate([breite/2, r+dicke, l+h+r]) {
          rotate(a=[0,90,0]) { 
            cylinder(breite, r+dicke, r+dicke, center=true, $fn=40); 
          }
      } 
    }
    // Hole in key holder
    translate([breite/2, r+dicke, l+h+r]) {
        rotate(a=[0,90,0]) { 
            cylinder(breite, r, r, center=true, $fn=40); 
        }
    }
    // Cut of from key holder
    translate([0,0,l+h+r+(1.2*r/3)]) cube([breite, 2*(r+dicke), r]);
    // cut for the frame holder
    cube([breite, 2*(r+dicke) - spalt, l]);
}
