// all dimensions in millimeters
//How thick each wall is in mm
wall_thickness = 10/8; 
//How tall is the grid?
grid_height=10; 
//side length of pen hole square
square_size=10; 
//How many squares long?
X_squares=7; 
//How many squares Wide?
Y_squares=7;
//rounded corners?, 0 means sharp corners
corner_radius=3; 
//0 means no floor
floor_height = 1; 


//example 1: seen on http://www.thingiverse.com/thing:1294085/#files
//cubistand base.stl
//wall_thickness = 10/8;
//square_size=10;
//X_squares=7;
//Y_squares=7;
//corner_radius=3;
//grid_height=10;
//floor_height = 1;

//example 2: seen on http://www.thingiverse.com/thing:1294085/#files
//cubistand main.stl
//wall_thickness = 10/8;
//square_size=10;
//X_squares=7;
//Y_squares=7;
//corner_radius=3;
//grid_height=10;
//floor_height = 0; //0 means no floor

//example 3: seen on http://www.thingiverse.com/thing:1294085/#files
//cubistand_rod_cap.stl
//wall_thickness = 10/8;
//square_size=10;
//X_squares=1;
//Y_squares=1;
//corner_radius=0;
//grid_height=5;
//floor_height = 1; //0 means no floor


total_height=grid_height+floor_height;
$fn=30; //higher number, smoother curve surface, longer render time

//generation of grid  
translate([0,0,floor_height ])
difference()
{
for (j=[1:Y_squares])
    translate([0,(j-1)*(square_size+wall_thickness),0])
for (i=[1:X_squares])
   translate([(i-1)*(square_size+wall_thickness),0,0])
     difference () {
         cube([square_size+2*wall_thickness,square_size+2*wall_thickness,grid_height]);
         translate([wall_thickness,wall_thickness,0])
            cube([square_size,square_size,grid_height]);

     }

//remove corners   
 cube([corner_radius,corner_radius,grid_height]);  
 
  translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0,0])
      cube([corner_radius,corner_radius,grid_height]);  
     
  translate(  [0,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
      cube([corner_radius,corner_radius,grid_height]); 

  translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
      cube([corner_radius,corner_radius,grid_height]);      
   
 }  
 
 //make rounded corners
 intersection()
 {
  cube([corner_radius,corner_radius,total_height]);    
 translate(  [corner_radius,corner_radius,0])
  difference()
     {    
     cylinder(  total_height,    corner_radius,    corner_radius);  
       cylinder(  total_height,    corner_radius-wall_thickness,    corner_radius-wall_thickness);  
     }
 }
 
 
 intersection()
 {
  cube([corner_radius,corner_radius,total_height]);    
 translate(  [corner_radius,corner_radius,0])
  difference()
     {    
     cylinder(  total_height,    corner_radius,    corner_radius);  
       cylinder(  total_height,    corner_radius-wall_thickness,    corner_radius-wall_thickness);  
     }
 }
 
 
 translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0,0])
  intersection()
 {
  cube([corner_radius,corner_radius,total_height]);    
 translate(  [0,corner_radius,0])
  difference()
     {    
     cylinder(  total_height,    corner_radius,    corner_radius);  
       cylinder(  total_height,    corner_radius-wall_thickness,    corner_radius-wall_thickness);  
     }
 }
 
translate(  [0,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
  intersection()
 {
  cube([corner_radius,corner_radius,total_height]);    
 translate(  [corner_radius,0,0])
  difference()
     {    
     cylinder(  total_height,    corner_radius,    corner_radius);  
       cylinder(  total_height,    corner_radius-wall_thickness,    corner_radius-wall_thickness);  
     }
 }
 
 translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
  intersection()
 {
  cube([corner_radius,corner_radius,total_height]);    
 translate(  [0,0,0])
  difference()
     {    
     cylinder(  total_height,    corner_radius,    corner_radius);  
       cylinder(  total_height,    corner_radius-wall_thickness,    corner_radius-wall_thickness);  
     }
 }
 
 
 //para hacer el suelo, si lo hay (floor_height>1)
 //hago un cubo del tamaño total, de altura -floorheight
 //le quito las esquinas y añado cilindros
 difference()
{
 cube(  [X_squares*(square_size+wall_thickness)+wall_thickness,Y_squares*(square_size+wall_thickness)+wall_thickness, floor_height]);
    
    
    //remove corners   
 cube([corner_radius,corner_radius,floor_height]);  
 
  translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0,0])
      cube([corner_radius,corner_radius,floor_height]);  
     
  translate(  [0,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
      cube([corner_radius,corner_radius,floor_height]); 

  translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
      cube([corner_radius,corner_radius,floor_height]);  
}

//añado cilindros en las esquinas del suelo
// esquina 0,0
translate(  [corner_radius,corner_radius,0])
     cylinder(  floor_height,    corner_radius,    corner_radius);  

//esquina X,0
 translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,corner_radius,0]) 
     cylinder(  floor_height,    corner_radius,    corner_radius);  

//esquina 0,Y 
translate(  [corner_radius,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
     cylinder(  floor_height,    corner_radius,    corner_radius);  
 
 
//esquina X,Y 
 translate(  [X_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,Y_squares*(square_size+wall_thickness)-corner_radius+wall_thickness,0])
     cylinder(  floor_height,    corner_radius,    corner_radius);  
       



