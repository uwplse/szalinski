$fn=12;

rotation=360;
step=0.04;

X=20;
Y=20;
Z=0;
Radius=1;
Thickness=1;

Kb=0.5;
Kb1=15;
Kb2=15;


              for (b=[0:step:rotation])
              {
                  rotate([b*Kb,b*Kb1,b*Kb2])
                  translate([X,Y,Z])
                  cylinder(r=Radius,h=Thickness,center=true);
              }
              
            