



$fn=30; //number of fragments
Width=40;
Depth=20;
BaseHeight=6;    
TopWidth=20;
TopGap=3;
Height=40;
RodDiameter=10;



module Base_SK(Width,Depth,BaseHeight,TopWidth,Height)
{
    
cube([Width,Depth,BaseHeight]);
translate([(Width/2-TopWidth/2),0,BaseHeight])
    cube([TopWidth,Depth,Height-BaseHeight]);
}


difference()
{
    difference()
    {
        difference()
        {
            difference()
            {
                difference()
                {
                Base_SK(Width,Depth,BaseHeight,TopWidth,Height);
                translate([(Width/2-TopWidth/2)+TopWidth/2,Depth,Height/2+3])
                    rotate(90, [ 1, 0, 0 ])
                        cylinder(h=Depth+1,r=RodDiameter/2);
                }
                translate([Width/2-TopGap/2,0,Height/2+5]) // Rod Hole Gap 
                    cube([TopGap,Depth,15]);
            }
            translate([(Width-TopWidth)/4,Depth/2,0]) //Left base hole
                rotate(90, [ 0, 0, 1 ])
                    cylinder(h=BaseHeight+5,r=1.5);     
        }
        translate([Width-(Width-TopWidth)/4,Depth/2,0]) //Right base hole
            rotate(90, [ 0, 0, 1 ])
                cylinder(h=BaseHeight+5,r=1.5);
    }
    translate([0,Depth/2,Height-Height/5]) //Rod Hole
        rotate(90, [ 0, 1, 0 ])
            cylinder(h=BaseHeight+25,r=1.5);   
}