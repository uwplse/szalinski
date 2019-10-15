// 

// Cell diameter (usually 18.7, some cell varies)
cell_diameter = 19;
// Cell Holder Height
height=10.6;

// Cell Spacing
cell_space = 1.5; 
// Number of rows
x_size = 1; // [1:20]
// Number of columns
y_size = 1; // [1:20]

//Support height
base_h=1;
//Nickel tab width in rows
x_strip_width= 7; 
//Nicel tab width in cols
y_strip_width= 8; 


calc_cell_space = cell_diameter + cell_space;
// number of faces in circle
$fn=48; 

for ( i = [1 : y_size] )
{
    translate([0,i*(calc_cell_space),0])
        for ( i = [1 : x_size] )
        {
            translate([i*(calc_cell_space),0,0])                             
                difference()
                {                      
                    cube(size = [calc_cell_space,calc_cell_space,height], center = true);                    
                        cylinder(h = height+0.01, r=cell_diameter/2,center=true);                                                                        
                }  
                
            translate([i*(calc_cell_space),0,(base_h/2) +(height/2) ])                             
                difference()
                {                   
                    cube(size = [calc_cell_space,calc_cell_space,base_h], center = true);
                    union()
                        {                        
                            cube(size = [x_strip_width,calc_cell_space+1,base_h+0.01], center = true);                       
                            cube(size = [calc_cell_space+1,y_strip_width,base_h+0.01], center = true);                             
                        }
                }                                  
        }
}


