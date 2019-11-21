/***************************************************
*** (c) 2016 by saarbastler.de
***************************************************/

$fn=100;

// the inner depth of the box
depth= 80;
// the inner width of the box
width= 125;
// the inner height ob the box
height= 20;
// width of the loop, typically printed in a different color
loopWidth= 20;
// corner radius
rad= 10;
// border thickness
thick= 2;
// overlap of bootom and cover
overlap= 2;
// clearance of parts, so there is a little gap to fit together
clearance= 0.25;
// sse bootom of the file to prepare separate parts
// Which one would you like to see?
part = "complete"; // [complete:Complete giftbox,cover:the cover,bottom: the bottom,bottomLoop:the bottom loop,topLoop:the top loop,bow:the bow]

module frame( w, d, h )
{
  hull()
  {
    translate([-w/2+rad,-d/2+rad,0]) cylinder(r=rad, h= h);
    translate([-w/2+rad, d/2-rad,0]) cylinder(r=rad, h= h);
    translate([ w/2-rad, d/2-rad,0]) cylinder(r=rad, h= h);
    translate([ w/2-rad,-d/2+rad,0]) cylinder(r=rad, h= h);
  }
}

module box(w, d, h, t, bottomThickness)
{
  difference()
  {
    frame(w +2*t, d+2*t, h+bottomThickness);
    
    translate([0,0,bottomThickness-.01]) frame(w, d, h+bottomThickness+2);
  }
}

module bottom()
{
  box(width, depth, height/2-overlap, 2*thick, thick);
  box(width, depth, height/2+overlap, thick-clearance, thick);
}

module cover()
{
  box(width+4, depth+4, height/2+overlap, thick, thick);
}

module loop( offset )
{
  w= width + 4*thick;
  d= depth + 4*thick;
  
  translate([0,0,-thick-clearance])
  {
    translate([-w/2,-loopWidth/2,0]) cube([w,loopWidth,thick]);
    translate([-w/2-thick/2,-loopWidth/2,0]) cube([thick,loopWidth,height/2+2*thick+clearance-overlap+offset]);
    translate([ w/2-thick/2,-loopWidth/2,0]) cube([thick,loopWidth,height/2+2*thick+clearance-overlap+offset]);
    
    translate([-loopWidth/2,-d/2,0]) cube([loopWidth, d, thick]);
    translate([-loopWidth/2,-d/2-thick/2,0]) cube([loopWidth,thick,height/2+2*thick+clearance-overlap+offset]);
    translate([-loopWidth/2, d/2-thick/2,0]) cube([loopWidth,thick,height/2+2*thick+clearance-overlap+offset]);

    translate([-width/4,0,thick]) cylinder(d=5-2*clearance,h=thick+clearance);
    translate([ width/4,0,thick]) cylinder(d=5-2*clearance,h=thick+clearance);
    translate([0,-depth/4,thick]) cylinder(d=5-2*clearance,h=thick+clearance);
    translate([0, depth/4,thick]) cylinder(d=5-2*clearance,h=thick+clearance);
  }
}

module bottomLoop()
{
  loop(0);
}

module giftBottom()
{
  w= width + 4*thick;
  d= depth + 4*thick;
  difference()
  {
    bottom();
    
    translate([-w/2-thick/2+clearance,-clearance-loopWidth/2,-thick]) cube([thick,loopWidth+2*clearance,height/2+2*thick-overlap+1]);
    translate([ w/2-thick/2-clearance,-clearance-loopWidth/2,-thick]) cube([thick,loopWidth+2*clearance,height/2+2*thick-overlap+1]);
    
    translate([-clearance-loopWidth/2,-d/2-thick/2+clearance,-thick]) cube([loopWidth+2*clearance,thick,height/2+2*thick-overlap+1]);
    translate([-clearance-loopWidth/2, d/2-thick/2-clearance,-thick]) cube([loopWidth+2*clearance,thick,height/2+2*thick-overlap+1]);
    
    translate([-width/4,0,-1]) cylinder(d=5,h=thick+1);
    translate([ width/4,0,-1]) cylinder(d=5,h=thick+1);
    translate([0,-depth/4,-1]) cylinder(d=5,h=thick+1);
    translate([0, depth/4,-1]) cylinder(d=5,h=thick+1);
  }
}

module topLoop()
{
  difference()
  {
    loop(overlap+thick);
    
    *translate([0,0,-thick-1]) cylinder(d=5,h=thick+2);
    translate([-3-clearance,-loopWidth/2-clearance,-thick-1]) cube([6+2*clearance,loopWidth+2*clearance,thick+2]);

  }
}

module giftCover()
{
  w= width + 4*thick;
  d= depth + 4*thick;
  difference()
  {
    cover();
    
    translate([-w/2-thick/2+clearance,-clearance-loopWidth/2,-1]) cube([thick,loopWidth+2*clearance,height/2+2*thick+overlap+1]);
    translate([ w/2-thick/2-clearance,-clearance-loopWidth/2,-1]) cube([thick,loopWidth+2*clearance,height/2+2*thick+overlap+1]);
    
    translate([-clearance-loopWidth/2,-d/2-thick/2+clearance,-1]) cube([loopWidth+2*clearance,thick,height/2+2*thick+overlap+1]);
    translate([-clearance-loopWidth/2, d/2-thick/2-clearance,-1]) cube([loopWidth+2*clearance,thick,height/2+2*thick+overlap+1]);
    
    translate([-width/4,0,-1]) cylinder(d=5,h=thick+1);
    translate([ width/4,0,-1]) cylinder(d=5,h=thick+1);
    translate([0,-depth/4,-1]) cylinder(d=5,h=thick+1);
    translate([0, depth/4,-1]) cylinder(d=5,h=thick+1);
    
    *translate([0,0,-1]) cylinder(d=5,h=thick+2);    
    translate([-3-clearance,-loopWidth/2-clearance,-1]) cube([6+2*clearance,loopWidth+2*clearance,thick+2]);
  }

}

module bow(h)
{
  rad= 30;
  n= 6;
  th= 3;
    
  alpha= 180/n;
  a= .5* rad / (2*sin(alpha*2));

  translate([-rad-1,-h/2,0]) cube([2*rad+2,h,1]);
  
  translate([-3,-loopWidth/2,-2*thick-2*clearance]) 
    cube([6,loopWidth,2*thick+2*clearance]);
  
  translate([0,h/2,1]) rotate([90,0,0]) linear_extrude( height= h)
  for(i=[alpha:alpha:180])
    rotate([0,0,i-alpha/2])
      difference()
      {
        polygon( concat([[0,0]]
          ,[ for(al=[-90:5:90]) [rad+a*cos(al),a*sin(al)] ]
          ) );
        
        polygon( concat([[2,0]]
          ,[ for(al=[-75:5:75]) [rad-th+(a-th/2)*cos(al),(a-th/2)*sin(al)] ]
          ) );
      }
}

module complete()
{
  translate([0,0,height+3*thick+3*clearance]) bow(loopWidth);

  giftCover();
  topLoop();

  difference()
  {
    union()
    {
      *bottomLoop();
      *giftBottom();
      translate([0,0,height+2*thick+.25]) rotate([180,0,0]) 
      {
        giftCover();
        topLoop();
      }
    }

    *translate([0,0,-1]) cube([100,100,40]);
  }
}


// comment in for generating print files
*complete();

//  comment out each single line to generate STL files for print
*giftBottom();
*bottomLoop();
*giftCover();
*topLoop();
*rotate([90,0,0]) bow(loopWidth);


// added for Customizer
module customizer()
{
  if(part == "cover")
    giftCover();
  else if(part == "bottom")
    giftBottom();
  else if(part == "bottomLoop")
    bottomLoop();
  else if(part == "topLoop")
    topLoop();
  else if(part == "bow")
    rotate([90,0,0]) bow(loopWidth);
  else
    complete();
}

customizer();
