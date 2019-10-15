//Base Height
b_height = 80;

//Top Height
t_height = 32;

//Building Depth
length = 60;

//Building Width
width = 55;

//Building Overhang
overhang = 4;

//Cuts in Building
cuts = 7;

//Cut Width
cut_width = 1;

//Cut Depth
cut_depth =5;

//Large Side Fin width
finL_width = 8;

//Large Side Fin length
finL_length = 10;

//Large Side Fin Recess
finL_recess = 30;

//Large Side Fin Overhang
finL_overhang = 4;

//Small Side Fin width
finS_width = 0;

//Small Side Fin Length
finS_length = 6;

//Small Side Fin Recess
finS_recess = 20;

//Small Side Fin Overhang
finS_overhang = 4;

//Large Side Cut Width
cutS_width = 4;

//Small Side Cut Length
cutS_length = 1;

//Large Side Cut Width
cutL_width = 6;



difference()
{
     union() //Main Body
     {
            { //Basic Structure
            
        cube([width,length,b_height]); //Bottom Structure
        translate([0,-overhang,b_height]) cube([width,length+overhang*2,t_height]); //Top Structure
        }
        
            { //Front and Back Overhang Chamfers
        translate([0,0,b_height-overhang]) //Front Overhang Chamfer
               rotate([45,0,0]) 
               cube([width,sqrt(2*(pow(overhang,2))),sqrt(2*(pow(overhang,2)))]);

        translate([0,length,b_height-overhang]) //Back Overhang Chamfer
            rotate([45,0,0]) 
            cube([width,sqrt(2*(pow(overhang,2))),sqrt(2*(pow(overhang,2)))]);
        }
        
        
        
        
        
            { //Large side Fins
            
        translate([-finL_width,finL_recess,0]) //Left Fin Lower 
        cube([finL_width,finL_length,b_height]);
        translate([-finL_width-finL_overhang,finL_recess,b_height]) //Left Fin Upper 
        cube([finL_width+finL_overhang,finL_length,t_height]);
        
        translate([-finL_overhang-finL_width,finL_recess,b_height]) //Left Fin Overhang Chamfer
        rotate([0,45,0]) 
        cube([sqrt(2*(pow(finL_overhang,2))),finL_length,sqrt(2*(pow(finL_overhang,2)))]);
        
        translate([width,finL_recess,0]) //Right Fin Lower 
        cube([finL_width,finL_length,b_height]);
        translate([width,finL_recess,b_height]) //Right Fin Upper 
        cube([finL_width+finL_overhang,finL_length,t_height]);
        
        translate([width+finL_width-finL_overhang,finL_recess,b_height]) //Right Fin Overhang Chamfer
        rotate([0,45,0]) 
        cube([sqrt(2*pow(finL_overhang,2)),finL_length,sqrt(2*pow(finL_overhang,2))]);
            
        }
        
            { //Small side Fins
            
        translate([-finS_width,finS_recess,0]) //Left Fin Lower 
        cube([finS_width,finS_length,b_height]);
        translate([-finS_width-finS_overhang,finS_recess,b_height]) //Left Fin Upper 
        cube([finS_width+finS_overhang,finS_length,t_height]);
        
        translate([-finS_overhang-finS_width,finS_recess,b_height]) //Left Fin Overhang Chamfer
        rotate([0,45,0]) 
        cube([sqrt(2*(pow(finS_overhang,2))),finS_length,sqrt(2*(pow(finS_overhang,2)))]);
        
        translate([width,finS_recess,0]) //Right Fin Lower 
        cube([finS_width,finS_length,b_height]);
        translate([width,finS_recess,b_height]) //Right Fin Upper 
        cube([finS_width+finS_overhang,finS_length,t_height]);
        
        translate([width+finS_width-finS_overhang,finS_recess,b_height]) //Right Fin Overhang Chamfer
        rotate([0,45,0]) 
        cube([sqrt(2*pow(finS_overhang,2)),finS_length,sqrt(2*pow(finS_overhang,2))]); 
            
        }
     }

     for (i=[1:1:7]) // Cuts in front and back of building
     {
         
        translate([((width/(cuts+1))*i)-cut_width/2,-overhang-1,-1]) //Front
        cube([cut_width,cut_depth+1,b_height+t_height+2]);
        
        translate([((width/(cuts+1))*i)-cut_width/2,length-1,-1]) //Back
        cube([cut_width,cut_depth+1,b_height+t_height+2]);
     }
     
     
     
     { // Side Cuts
        translate([-1,finS_recess-cutS_length,-1]) //Small left Cut
        cube([cutS_width+1,cutS_length,b_height+t_height+2]);   
        translate([-1,(finS_recess+finS_length),-1]) //Large left Cut
        cube([cutL_width+1,finL_recess-(finS_recess+finS_length),b_height+t_height+2]);
     
        translate([width-cutS_width,finS_recess-cutS_length,-1]) //Small Right Cut
        cube([cutS_width+1,cutS_length,b_height+t_height+2]);   
        translate([width-cutL_width,(finS_recess+finS_length),-1]) //Large Right Cut
        cube([cutL_width+1,finL_recess-(finS_recess+finS_length),b_height+t_height+2]);
     }
     
}