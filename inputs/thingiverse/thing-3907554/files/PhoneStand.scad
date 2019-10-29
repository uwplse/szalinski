//Customizable Electronics Stand
//Width of Phone or Tablet
w=80;
//Height of Phone
h=155;
//Thickness of Phone or Tablet
t=20;
//Stand Angle
a=65;

baseHeight=h*0.75;
legHeight=h*0.50;
baseWidth=w*0.95;
module stand()
{
    union(){
        cube([baseHeight,4,baseWidth]);
        translate([-.5,4,0])cylinder(h=baseWidth,r=4,$fn=50);
        rotate([0,0,75])cube([baseHeight,4,baseWidth]);
        translate([cos(75)*baseHeight,sin(75)*baseHeight,0])cylinder(h=baseWidth,r=4,$fn=50);
        translate([cos(75)*baseHeight,sin(75)*baseHeight,0])rotate([0,0,-a])cube([legHeight,4,baseWidth]);
        difference(){
            translate([cos(75)*baseHeight+cos(a)*legHeight,sin(75)*baseHeight-sin(a)*legHeight,0])rotate([0,0,90-a])cube([t+2,4,baseWidth]);
            translate([cos(75)*baseHeight+cos(a)*legHeight,sin(75)*baseHeight-sin(a)*legHeight,0.25*baseWidth])rotate([0,0,90-a])cube([t+2,4,0.5*baseWidth]);
        }
        difference(){
            translate([cos(75)*baseHeight+cos(a)*legHeight+cos(90-a)*(t+2),sin(75)*baseHeight-sin(a)*legHeight+sin(90-a)*(t+2),0])rotate([0,0,180-a])cube([t+2,4,baseWidth]);
            translate([cos(75)*baseHeight+cos(a)*legHeight+cos(90-a)*(t+2),sin(75)*baseHeight-sin(a)*legHeight+sin(90-a)*(t+2),0.25*baseWidth])rotate([0,0,180-a])cube([t+2,4,0.5*baseWidth]);
        }
    }   
        
}
stand();