
itens_per_line = 2;
z_size = 15;
colorama_lines = [2];
risque_lines   = [1];
num_x = len(colorama_lines) + len(risque_lines);

for(x = [1 : 1 :num_x])
{
    for( y = [1 : 1 : itens_per_line])
    {     
        for ( z = [0 : 1 : len(colorama_lines)])
        {           
            if ( colorama_lines[z] == x )
            {                
                 colorama((38*x),(38*y));              
            }
        }
        
        for ( z = [0 : 1 : len(risque_lines)])
        {           
            if ( risque_lines[z] == x )
            {                
                 risque((38*x),(38*y));
            }
        }
    }
  
}




module colorama(x,y)
{
    translate([x,y,0]){
        difference(){
            translate([0,0,0])
                cube([38,38,z_size],center=true);
            translate([0,0,1])
                oval(21.5,33,z_size,true);
        }
    }   
}

module risque(x,y)
{
      translate([x,y,0]){
        difference(){
            translate([0,0,0])
                cube([38,38,z_size],center=true);
            translate([0,0,10])
                cylinder(30,29/2,29/2,true);
        }
    }   
}
module oval(w,h, height, center = false) { 
    h = h/2;
    w = w/2;
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center); 
 } 