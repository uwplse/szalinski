// 104 x 24mm max

// length of slide (minus handle, 4mm)
h=120;

// width of slide (diameter)
w=26;

// number of buckets
c=7;

// thickness of walls
t=1;

// text
txt="MTWTFSS"; // ["MTWTFSS","SMTWTFS","12345...","...54321","none"]

// text size
txtsz=7;

// font
txtfont="Droid Sans";

hs=(h-t)/c-t;

module box(pos,size) { translate(pos) cube(size); }

module write(pos=[0,0,0],rot=[0,0,0],size=3,h=1.5,text="?",halign="center",valign="center")
{
   translate(pos)
      rotate(rot)
      linear_extrude(height=h)
      text(text,size=size,halign=halign,valign=valign,font=txtfont);
}

module cyl_x(base=[0,0,0],h=10,r=5)
{
   translate(base)
      rotate([0,90,0])
      cylinder(h=h,r=r);
}


module thetext()
{
   if (txt=="MTWTFSS")
   {
      write([-10+t-0.4,0,(hs+t)*7-hs/2],rot=[90,90,90],size=txtsz,text="M");
      write([-10+t-0.4,0,(hs+t)*6-hs/2],rot=[90,90,90],size=txtsz,text="T");
      write([-10+t-0.4,0,(hs+t)*5-hs/2],rot=[90,90,90],size=txtsz,text="W");
      write([-10+t-0.4,0,(hs+t)*4-hs/2],rot=[90,90,90],size=txtsz,text="T");
      write([-10+t-0.4,0,(hs+t)*3-hs/2],rot=[90,90,90],size=txtsz,text="F");
      write([-10+t-0.4,0,(hs+t)*2-hs/2],rot=[90,90,90],size=txtsz,text="S");
      write([-10+t-0.4,0,(hs+t)*1-hs/2],rot=[90,90,90],size=txtsz,text="S");
   }
   else if (txt=="SMTWTFS")
   {
      write([-10+t-0.4,0,(hs+t)*7-hs/2],rot=[90,90,90],size=txtsz,text="S");
      write([-10+t-0.4,0,(hs+t)*6-hs/2],rot=[90,90,90],size=txtsz,text="M");
      write([-10+t-0.4,0,(hs+t)*5-hs/2],rot=[90,90,90],size=txtsz,text="T");
      write([-10+t-0.4,0,(hs+t)*4-hs/2],rot=[90,90,90],size=txtsz,text="W");
      write([-10+t-0.4,0,(hs+t)*3-hs/2],rot=[90,90,90],size=txtsz,text="T");
      write([-10+t-0.4,0,(hs+t)*2-hs/2],rot=[90,90,90],size=txtsz,text="F");
      write([-10+t-0.4,0,(hs+t)*1-hs/2],rot=[90,90,90],size=txtsz,text="S");
   }
   else if (txt=="12345...")
   {
      for (i=[1:1:c])
         write([-10+t-0.4,0,(hs+t)*(c-i+1)-hs/2],rot=[90,90,90],size=txtsz,text=str(i));
   }
   else if (txt=="...54321")
   {
      for (i=[1:1:c])
         write([-10+t-0.4,0,(hs+t)*(i)-hs/2],rot=[90,90,90],size=txtsz,text=str(i));
   }
   
}

rotate([0,-90,0])
union()
{

difference()
{
   cylinder(h=h,r=w/2,$fn=90);
   box([-30,-50,-1],[20,100,h+2]);
   difference()
   {
      union()
      {
         for (n=[0:1:c-1])
         {
            translate([0,0,t+n*(hs+t)])
               union()
            {
               cylinder(h=hs,r=w/2-t,$fn=90);
               box([5,-50,0],[50,100,hs]);
            }
            
         }
      }
      box([-10,-50,-1],[t,100,h+2]);
   }

   thetext();
   
}

if (1)
difference()
{
   box([-5,-3,h],[10,6,4]);
   cyl_x([-11,-3,h+1.5],h=22,r=1.5,$fn=48);
   cyl_x([-11,3,h+1.5],h=22,r=1.5,$fn=48);
   
}

}
