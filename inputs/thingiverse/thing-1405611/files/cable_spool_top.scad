// All Values should be the same as in cable_spool_bottom
$fn=100;


outer_dia =80;

//spool will sit INSIDE the inner diameter
inner_dia =47;

height=20;
//wall strength
wall=2;
//number of holes (should be devideable by num_holes)
holes=12;
//diameter of mounting holes
slot=2.5;


module calcslots()
{
    
   n=0;
    
      if(holes%3==0) {
      for (i= [360/holes/2:360/3:360])
            {   
            D=(outer_dia);
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])  rotate([0,0,360-i]) cube([slot,((outer_dia-inner_dia)-(wall*2)),wall*5],center=true); 
            translate ([R*sin(i),R*cos(i),0])
                {   m=(outer_dia-inner_dia)/2;
                    rotate([0,0,360-i])
                    {translate([0,0,0])
                    {
                    difference()
                        {
                        cube([m,m,m],center=true);
                        translate([m/2+(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);
                        translate([-m/2-(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);

                        
                        }
                        
                    }
                    }
                }
            }
        }
    // end if 3 mod holes = 0
      else if(holes%4==0) {
      for (i= [360/holes/2:360/4:360])
            {   
            D=(outer_dia);
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])  rotate([0,0,360-i]) cube([slot,((outer_dia-inner_dia)-(wall*2)),wall*5],center=true); 
            translate ([R*sin(i),R*cos(i),0])
                {   m=(outer_dia-inner_dia)/2;
                    rotate([0,0,360-i])
                    {translate([0,0,0])
                    {
                    difference()
                        {
                        cube([m,m,m],center=true);
                        translate([m/2+(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);
                        translate([-m/2-(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);

                        
                        }
                        
                    }
                    }
                }
            }
        }
    // end if 4 mod holes = 0
    else if(holes%5==0) {
      for (i= [360/holes/2:360/5:360])
            {   
            D=(outer_dia);
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])  rotate([0,0,360-i]) cube([slot,((outer_dia-inner_dia)-(wall*2)),wall*5],center=true); 
            translate ([R*sin(i),R*cos(i),0])
                {   m=(outer_dia-inner_dia)/2;
                    rotate([0,0,360-i])
                    {translate([0,0,0])
                    {
                    difference()
                        {
                        cube([m,m,m],center=true);
                        translate([m/2+(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);
                        translate([-m/2-(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);

                        
                        }
                        
                    }
                    }
                }
            }
        }
    // end if 5 mod holes = 0
    else {
     i=360/holes/2;  
            D=(outer_dia);
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])  rotate([0,0,360-i]) cube([slot,((outer_dia-inner_dia)-(wall*2)),wall*5],center=true); 
            translate ([R*sin(i),R*cos(i),0])
                {   m=(outer_dia-inner_dia)/2;
                    rotate([0,0,360-i])
                    {translate([0,0,0])
                    {
                    difference()
                        {
                        cube([m,m,m],center=true);
                        translate([m/2+(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);
                        translate([-m/2-(slot/2),-m/2,0]) cylinder(d=m,h=m,center=true);

                        
                        }
                        
                    }
                    }
                }
            
        }
    // end if 4 mod holes = 0      
   

}


difference()
{
       union()
       {
         cylinder(d=outer_dia,h=wall);
         cylinder(d=inner_dia,h=height/2);
       }
       cylinder(d=inner_dia-wall,height+1);
       
        

        for (i= [0:360/holes:360])
        {
            D=inner_dia+((outer_dia-inner_dia)/2);
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])cylinder(d=((outer_dia-inner_dia)/2-(2*wall)),h=wall+1);
        }

calcslots();      
        
}


       
