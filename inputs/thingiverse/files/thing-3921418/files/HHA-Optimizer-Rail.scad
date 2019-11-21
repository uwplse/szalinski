segments        = 12;    
laenge          = 10.0076 * (0.5 + segments);
degree          = 3;
gap             = 1.2;
holder_len      = 30;
holder_height   = 10;
holder_width    = 30;

HHA_Riser();


module spacer()
{
    beta = (-degree)+90;
    b = laenge;
    c = b / sin(beta);
    a = sqrt(-(b*b)+(c*c)); //6.56
    
    rotate([90,0,90])
    {
        translate([0,0,-7.8])
        {
            linear_extrude(height = 15.6)
            {
               polygon(points=[[0, 0], [laenge, 0], [laenge, a]], paths=[[0,1,2,0]]); 
            }
        }   
    }
}

module HHA_Riser()
{
    union()
    {
        rotate([90+degree,0,0])
        {
            translate([0,5,-(laenge/2)-0.1])
            {
                rail(segments);
            }
        }
        
        //translate([-7.8,0,0]) cube([15.6,laenge,3.5]); //3.85
        spacer();
        translate([0,2.5019,-10]) rotate([0,0,0]) mountblock();
        translate([0,90.5019,-10]) rotate([0,0,0]) mountblock();
    }
}

module mountblock()
{
    difference()
    {
        translate([-1*(holder_width/2),0,0])
        {
            cube([holder_width, holder_len, holder_height]);
        }
        
        rotate([90,0,180])
        {
            translate([0,4,-1*(gap)])
            {
               mountrail(holder_len+2,0); 
            } 
        }
        
        translate([holder_width/2-1.9,holder_len/2,holder_height/2+0.7])
        {
            rotate([90,0,90])
            {
                cylinder(d=9.4, $fn=6, h=2);
            }  
        }  
        
        translate([-1*(holder_width/2+0.1),holder_len/2,holder_height/2+0.7])
        {
            rotate([90,0,90])
            {
                cylinder(d=5.3, $fn=100, h=holder_width);
                cylinder(d=8.5, $fn=100, h=2);
            }  
        }
        
        translate([holder_width/2,holder_len,holder_height+0.1])
        {
            rotate([90,180,0])
            {
                linear_extrude(height=holder_len)
                cornercut();
            }
        }
        
        translate([holder_width/2+0.1,holder_len,0])
        {
            rotate([90,270,0])
            {
                linear_extrude(height=holder_len)
                cornercut();
            }
        }
        
        translate([-1*(holder_width/2+0.1),holder_len,holder_height])
        {
            rotate([90,90,0])
            {
                linear_extrude(height=holder_len)
                cornercut();
            }
        }
        
        translate([-1*(holder_width/2+0.1),holder_len, 0])
        {
            rotate([90,0,0])
            {
                linear_extrude(height=holder_len)
                cornercut();
            }
        }
    }
}

module mountrail(length,extra_height) 
{
	translate(v = [0, 0, 0])
    {
        linear_extrude(height = length)
   		mountrailprofile(extra_height,gap);
    }
   	
}

module mountrailprofile(extra_height,gap) 
{
	polygon(   points=[[-10.6-gap,0],
                        [-8.4-gap,2.2+gap],
                        [8.4+gap,2.2+gap],
                        [10.6+gap,0],
                        [7.8+gap,-2.8],
                        [7.8+gap,-3.8-extra_height-gap],
                        [-7.8-gap,-3.8-extra_height-gap],
                        [-7.8-gap,-2.8]], 
                paths=[[0,1,2,3,4,5,6,7,0]]);
}

module cornercut() 
{
	polygon(points=[[0, 0], [0,3.5], [3.5, 0]], paths=[[0,1,2,0]]);
}

module Aussparung()
{
    linear_extrude(height = 40)
    {
       polygon(points=[[-12, -0.8], [0, 16], [115.5, 16], [127.5, -0.8]], paths=[[0,1,2,3,0]]); 
    }
}

module rail(sections) 
{
	translate(v = [0, 0, -5 * sections - 2.5])
        difference() {
		linear_extrude(height = (10.0076 * (0.5 + sections)))
               railprofile();
            translate([0,-0.6,0])
		union() {
			for (s = [1:sections]) {
				translate(v = [0, 0, s * 10.0076 - 10.0076/2.0])
                           #linear_extrude(height = 5.334)
                             cutprofile();
			}
		}
	  }
}

module railprofile() 
{
    extra_height = 1.4;
	polygon(points=[   [-10.6,0],
                        [-8.4,2.2],
                        [8.4,2.2],
                        [10.6,0],
                        [7.8,-2.8],
                        [7.8,-3.8-extra_height],
                        [-7.8,-3.8-extra_height],
                        [-7.8,-2.8]], 
            paths=[[0,1,2,3,4,5,6,7,0]]);
}

module cutprofile() 
{
	polygon(points=[[-12, -0.8], [-12, 3], [12, 3], [12, -0.8]], paths=[[0,1,2,3,0]]);
}