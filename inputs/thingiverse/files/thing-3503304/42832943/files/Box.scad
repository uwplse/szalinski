x = 20;
y = 30;
z = 20;

edge = 2;
lipw = edge/2;
liph = 2;
sep = 5;
tol = 0.2;

epsilon = 0.01;

difference() 
    {
        union()
        {   
            translate(v=[0,0,0]) 
                {
                    cube(size=[x,y,z], center=false);
                }
            translate(v=[lipw,lipw,0]) 
                {
                    cube(size=[x-edge,y-edge,z+liph], center=false);
                }
        }
        translate(v=[edge,edge,edge+epsilon]) 
            {
                cube(size=[x-(edge*2),y-(edge*2),z-edge+liph], center=false);
            }
    }

difference()
    {
         translate(v=[-(x+sep),0,0]) 
                {
                    cube(size=[x,y,liph+edge], center=false);
                }
         translate(v=[-(x+sep-lipw+(tol/2)),edge-(lipw+(tol/2)),lipw+epsilon]) 
            {
                cube(size=[x+tol-(lipw*2),y-(lipw*2)+tol,lipw+liph], center=false);
            }
        }