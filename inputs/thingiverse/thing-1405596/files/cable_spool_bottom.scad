$fn=50;

outer_dia =80;
inner_dia =47;
height=20;
//wall strength
wall=2;
//number of holes (should be devideable by num_holes)
holes=12;
//diameter of mounting holes
drill=3;


module calcdrill()
{
    
   n=0;
    
      if(holes%3==0) {
      for (i= [360/holes/2:360/3:360])
        {   
            D=(outer_dia-(2*drill));
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])cylinder(d=drill,h=wall+1);
        }  
          }
 else if(holes%4==0) {       
     for (i= [360/holes/2:360/4:360])
        {   
            D=(outer_dia-(2*drill));
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])cylinder(d=drill,h=wall+1);
        }  
       }
 else if(holes%5==0) {
            for (i= [360/holes/2:360/5:360])
        {   
            D=(outer_dia-(2*drill));
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])cylinder(d=drill,h=wall+1);
        }  }
 else             {
            for (i= [360/holes/2:360/holes:360])
        {   
            D=(outer_dia-(2*drill));
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])cylinder(d=drill,h=wall+1);
        }  }
 
}


difference()
{
       union()
       {
         cylinder(d=outer_dia,h=wall);
         cylinder(d=inner_dia+wall,h=height);
       }
       cylinder(d=inner_dia,height+1);
       
        

        for (i= [0:360/holes:360])
        {
            D=inner_dia+((outer_dia-inner_dia)/2);
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])cylinder(d=((outer_dia-inner_dia)/2-(2*wall)),h=wall+1);
        }

        // create the drilling holes
        calcdrill();
        /*
        for (i= [360/holes/2:360/num_drill:360])
        {   
            D=(outer_dia-(2*drill));
            R=D/2;
            translate ([R*sin(i),R*cos(i),0])cylinder(d=drill,h=wall+1);
        }  
        */
        
}



       
