Rim_Diameter=10;
Groove_Diameter=8;
Arbor_Diameter=8;
Rim_Width=2;
Rim_Edge_Width=1;
Groove_Width=4;
Screw_Diameter=2.8;






module build()
{
    Rim_Diameter=Rim_Diameter*2;
Groove_Diameter=Groove_Diameter*2;
    Arbor_Diameter=Arbor_Diameter*2;
union() {
 cylinder(h=Rim_Width, r1=Groove_Diameter, r2=Rim_Diameter, center=false,$fn=100);
    translate(v = [0, 0, Groove_Width*-1]) {rotate(a=[0,180,0]) { 
  cylinder(h=Rim_Width, r1=Groove_Diameter, r2=Rim_Diameter, center=false,$fn=100);} 
 
 translate(v = [0, 0, Groove_Width]) {rotate(a=[0,180,0]) { 
  cylinder(h=Groove_Width, r1=Groove_Diameter, r2=Groove_Diameter, center=false,$fn=100);} 
 
 translate(v = [0, 0, Rim_Width - Rim_Edge_Width + Rim_Edge_Width ]) {
  cylinder(h=Rim_Edge_Width, r1=Rim_Diameter, r2=Rim_Diameter, center=false,$fn=100);}  
  
  translate(v = [0, 0, Groove_Width  *-1 - Rim_Edge_Width- Rim_Width]) {
  cylinder(h=Rim_Edge_Width, r1=Rim_Diameter, r2=Rim_Diameter, center=false,$fn=100);} 
        
    }}}}
  

  difference()
    {
    build();
    translate(v = [0, 0, -50]) {
         cylinder(h=100, r1=Arbor_Diameter, r2=Arbor_Diameter, center=false,$fn=100); } 
       
      translate(v = [0, 0, -Groove_Width/2]) rotate(a=[0,90,0]) { cylinder(h=100, r1=Screw_Diameter, r2=Screw_Diameter, center=false,$fn=100); 
        rotate(a=[0,90,90])  cylinder(h=100, r1=Screw_Diameter, r2=Screw_Diameter, center=false,$fn=100); 
      } 
    }





