include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

//hight of the text in mm
Text_height = 2;
// Text size
Text_size = 10;
// Text itself
Text1 = "Nuc";
Text2 = "";

// hight of the label
height = 4;

// Text only = 1, Base only 2, Both 3
stl = 3;

if (stl==1){  
    label_text(); 
}

else if (stl==2){
    nuc_entrance();
}
else if (stl==3){
union(){
    label_text();
    nuc_entrance();
}
}

module nuc_entrance()
{
//the base
difference(){
    tube(h=2.5, od=121, id=4,$fn=60);

    // Open entrance
    translate([32,19,2])
    {
        cyl(l=5, d=28);
    }
    
    // Queen excluder
    slot([0,-23,0], [0,-52,0], r1=2.5, r2=2.5, h=7);
    slot([7,-26,0], [7,-47,0], r1=2.5, r2=2.5, h=7);
    slot([-7,-26,0], [-7,-47,0], r1=2.5, r2=2.5, h=7);
    slot([-14,-31,0], [-14,-42,0], r1=2.5, r2=2.5, h=7);
    slot([14,-31,0], [14,-42,0], r1=2.5, r2=2.5, h=7);
    
    // Ventilation
    translate([-33,19,2])
    {
        hexregion = [for (a = [0:60:359.9]) 18.01*[cos(a), sin(a)]];
        grid2d(spacing=5, stagger=true, in_poly=hexregion){
            cyl(l=5, d=3,$fn=60);
        }
    }
}


    
// Hex handle    
difference(){
    tube(h=12,od=39,wall=39,$fn=6);
    tube(h=12,od=5,wall=5,$fn=60);
    translate([0,0,19])
    {
      cyl(l=20, d=15, chamfer1=3);
    }
}
}

// Text
module label_text()
{
    rotate([0,0,150]){
        translate([-37,-1,height/2]){ 
            linear_extrude( Text_height/2, twist=0, center=false){
            text(str(Text1), font = "Roboto", size = Text_size *0.75, halign="center", valign=   "bottom");
            }
            linear_extrude( Text_height/2, twist=0, center=false){
            text(str(Text2), font = "Roboto", size = Text_size *0.75, halign="center", valign=   "top");
            }
           }
  } 
    
    
}