
// LadderMaker  v1.0    Cylinder Version    BMB
// Simple ladder (or ladder shaped) maker script.  

// Usage: 1) Set desired user values below, 2) Render with F6, 
// 3) Export to STL, 4) Slice and print.  
// NOTE:  This script has no logic to protect you from putting in crazy
//        settings.  But if the render looks good it should print fine.
 
// ***** User Render Settings
$fn = 30;         // Minimum Angle (number of fragments when rendering, probably don't need to change)
lHeight = 80;     // Ladder Height mm (end-to-end)
lWidth = 20;      // Ladder Width mm (oc-to-oc)
lRungs = 6;       // Number of Rungs  
lRadius = 2;      // Ladder Radius mm  (remember it's radius not diameter!) 
// ***** End User Settings


gap = lHeight / (lRungs + 1);
echo("Rung Spacing: ", gap);
translate([0,0,lRadius]) {
  rotate(a=90,v=[0,1,0]) {
    cylinder(h=lHeight,r=lRadius);
      translate([0,lWidth,0]) {
        cylinder(h=lHeight,r=lRadius);  
      }
   
    for(a=[gap:gap:lHeight-gap/2]) {  
      rotate(a=90,v=[1,0,0]) {
        translate([0,a,-1*(lWidth)]) { 
          echo("Rung: ", a);  
          cylinder(h=lWidth,r=lRadius);
        }
      }
    }
  }
}


