boxWid=150;
boxLen=187;
boxHei=140;
wall=5.0;

groove=wall/2;
grooveAngle=11;
shrinkage=0.33;

//text
line1="Beth ♥";
line2="coffee";
textSize=50;
line3="& Doug";
smallTextSize=textSize/4;


bedWid=145;
bedLen=225;
bedHei=150;

small=0.01;

halfBoxWid=boxWid/2;

module buildGroove(reduce)
{
    translate([reduce/2,reduce/2,reduce])
    linear_extrude(height=boxHei+wall-reduce+2*small)
    {
        polygon([
        [0,0],
        [(groove-reduce/2)*sin(grooveAngle),groove-reduce],
        [(groove-reduce)-(groove-reduce/2)*sin(grooveAngle),groove-reduce],
        [groove-reduce,0]    
        ]);
        
        if (reduce>0)
        {
            translate([(groove-reduce/2)*sin(grooveAngle),groove-reduce-small])
            square([(groove-reduce)-(groove-reduce/2)*sin(grooveAngle)*2,reduce]);
        }
    }

}
//!buildGroove(shrinkage);

module buildOverlap(reduce)
{

    translate([reduce/2,0,reduce])
    rotate([0,90,0])
    linear_extrude(height=boxLen-reduce)
    polygon([[0,0],[-groove+reduce,-groove+reduce],[-groove+reduce,0]]);    
}
//!buildOverlap();
module box1()
{
    difference()
    {
        cube([boxLen+2*wall, halfBoxWid+wall,boxHei+wall]);

        translate([wall, wall+small, wall+small])
        cube([boxLen, halfBoxWid+small,boxHei]);

        translate([wall/2-groove/2,halfBoxWid+wall-groove+small, -small])
        buildGroove(0);

        translate([wall/2-groove/2+boxLen+wall,halfBoxWid+wall-groove+small, -small])
        buildGroove(0);

        translate([wall,halfBoxWid+wall+small,wall-groove+2*small])
        buildOverlap(0);
          
        translate([boxLen/2+wall,0.5,(boxHei+wall)/2])
        rotate([90,0,0])
        linear_extrude(height=wall/2)
        text(text=line1, size=textSize, halign="center", valign="center");
    }  
}
module box2()
{
  difference()
  {
    cube([boxLen+2*wall, halfBoxWid+wall,boxHei+wall]);
    
    translate([wall, wall+small, wall+small])
    cube([boxLen, halfBoxWid+small,boxHei]);
      
    translate([wall,halfBoxWid+wall-shrinkage/sqrt(2)+small,-wall+groove+shrinkage-+small])
    cube([boxLen,shrinkage,wall]);
      
            
    translate([boxLen/2+wall,0.5,(boxHei+wall)/2])
    rotate([90,0,0])
    linear_extrude(height=wall/2)
    text(text=line2, size=textSize, halign="center", valign="center");
      
    translate([boxLen/2+wall,0.5,smallTextSize])
    rotate([90,0,0])
    linear_extrude(height=wall/2)
    text(text=line3, size=smallTextSize, halign="center", valign="center");
  }
    
  translate([wall/2-groove/2,halfBoxWid+wall+groove-small, -small])
  mirror([0,1,0])
  buildGroove(shrinkage);
  
  translate([wall/2-groove/2+boxLen+wall,halfBoxWid+wall+groove-small, -small])
  mirror([0,1,0])
  buildGroove(shrinkage);

    
  translate([wall,halfBoxWid+wall-small,wall-groove+small])
  mirror([0,1,0])
  buildOverlap(shrinkage);
  

    
}

module allTogether()
{
    intersection()
    {
        union()
        {
            box1();
            translate([boxLen+2*wall,boxWid+2*wall,0])
            rotate([0,0,180])
            box2();
        }
        cube([100,100,100]);
    }
}
//allTogether();
box2();