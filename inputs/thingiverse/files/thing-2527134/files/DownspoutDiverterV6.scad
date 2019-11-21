insideWidth=70;
insideHeight=70;
wall=4;
overlap=40;
rounding=8;

diverterSteps=60;
diverterLength=40;
diverterHoleSize=30;

screwHole=6;
standWidth=15;
standHeight= 40;

small=0.01;
//[hidden]
$fn=20;


module roundedCubeLength(length,width,height){
  translate([1,rounding,rounding])
  minkowski(){
    cube([length-0*rounding,width-2*rounding,height-2*rounding]);
    translate([0,0,0])rotate([0,-90,0])cylinder(r=rounding,h=1);
  }
}


module diverter2d()
{
    translate([0,-15,0])
    {
      difference(){
        square([20,30]);
        translate([rounding/2,0,0])
        circle(d=rounding);

        translate([rounding/2,30,0])
        circle(d=rounding);
        
        translate([rounding/2-1,rounding/2-.1,0])
        rotate(-67.5)
        square([20,30]);
        
        translate([0,30,0])
        mirror([0,1,0])
        translate([rounding/2-1,rounding/2-.1,0])
        rotate(-67.5)
        square([20,30]);
      }
      translate([20,15,0])
      circle(d=rounding);
    }
}
//!diverter2d();

module diverter(smooth=false)
{
     // the diverter that expands by the square of the distance
    diverterIncrement=diverterLength/diverterSteps/2;
    for(i=[1:diverterSteps])
    {
        factor=(i/diverterSteps)*(i/diverterSteps);
        translate([0,0,overlap+(i-1)*diverterIncrement])
        rotate([0,0,90])
        linear_extrude(height=diverterIncrement+small) scale([factor,factor,1])diverter2d();
    }
    // now smooth it down, instead of a flat end
    if (smooth)
    {
        translate([0,0,diverterLength/2])
        for(i=[0:diverterSteps])
        {
            factor=1;
            translate([0,0,overlap+(i-1)*diverterIncrement])
            rotate([0,0,90])
            linear_extrude(height=diverterIncrement+small) 
            scale([factor,factor,1])diverter2d();
        }
        
    }
}
//!diverter(true);

module triangle(x)
{
    // a triangle
    polygon(points=[[0,-x/2],[x,0],[0,x/2]]);
}
module casing2d()
{
    difference()
    {
        minkowski()
        {
            square([insideWidth+2*wall-2*rounding,insideHeight+2*wall-2*rounding],center=true);
            circle(r=rounding);
        }
        minkowski()
        {
            square([insideWidth-2*rounding,insideHeight-2*rounding],center=true);
            circle(r=rounding);
        }
    }
}

// the outer shell, taking out some holes
difference()
{
    union()
    {
        linear_extrude(height=overlap)casing2d();
        translate([0,0,overlap-small])
        linear_extrude(height=diverterLength,scale=[2,1])casing2d();
    }
    // 2 holes on the side to divert some water backwards
    translate([-insideWidth, -diverterLength/2+wall, diverterLength*1.4])
    rotate([0,45,0])
    linear_extrude(height=20) 
    triangle(diverterHoleSize);
    
    translate([insideWidth, -diverterLength/2+wall, diverterLength*1.4])
    rotate([0,-45,0])
    linear_extrude(height=20) 
    mirror([1,0,0])
    triangle(diverterHoleSize);
    
    // the mounting screw holes
    translate([0,0,overlap/2])
    rotate([0,90,0])
    cylinder(d=screwHole, h=3*insideWidth,center=true);
}

offset=[-insideWidth/2.7,-insideWidth/2.7/2*3,-insideWidth/2.7*2];

for(i=[0:2])
{
    translate([-insideWidth/2.7,-small,0])
    translate([insideWidth/2.7*i,-insideHeight/2-small,0])
    diverter(true);
}
translate([-insideWidth/2.7*2,-small,0])
translate([insideWidth/2.7*0,-insideHeight/2-small,diverterLength/2])
diverter(false);
translate([-insideWidth/2.7*2,-small,0])
translate([insideWidth/2.7*4,-insideHeight/2-small,diverterLength/2])
diverter(false);


// the triangular support to hold it up off the grass
translate([0,-insideHeight/2-wall+small,overlap+diverterLength-standWidth])
rotate([0,0,-90])
linear_extrude(height=standWidth)triangle(standHeight);


