assemble(segments=3,s_length=60,height=12,shifter_height=8,shifter_length=30,hole_diameter=3);

module assemble(segments,s_length,height,shifter_height,shifter_length,hole_diameter)
{  union()
    { fixpoints(segments,s_length,height,hole_diameter);
      difference()
      {translate([0,7.0,0])shifter_2(s_length*(segments-1)+15,shifter_length,shifter_height,2);
    union()
    { for (x = [0 :  (segments-2)])
        { translate([(s_length)*x+2,12,-1]) cube([s_length-5,shifter_length-10,20]);
		 }
	 }
  }  
  }
     
   
}

module shifter_2(length,width,height,shift)
{ translate([length-7.5,0,0]) rotate([0,-90,0]) linear_extrude(height = length,$fn=2) polygon( points=[[0,0],[0,width],[0+shift,width],[height/2,width/2],[height,0],[height,0]] );


}

module fixpoints(segments,s_length,height,hole_diameter)
{ difference()
  { difference()
    { translate([-7.5,-7.5,0]) cube([s_length*(segments)-15,15,height]);
	  
      union()
      { for (x = [0 :  segments])
        { sinkhole(x*s_length,0,hole_diameter,30,5);
          echo ("Segment ",x);
		 }
      }
    }
	union()
      { for (x = [0 :  segments])
        { translate([(s_length)*x+7,-8.5,-1]) cube([s_length-15,17,height+2]);
		 }
      }
    
  }
}


module sinkhole(x,y,diameter,height,sinkheight)
{ translate([x,y,-1])
  cylinder(h = height,r1=diameter, r2=diameter,center=false,$fn=16);
  translate([x,y,-1])
  cylinder(h = sinkheight,r1=diameter+diameter*0.5, r2=diameter,center=false,$fn=16);

}

