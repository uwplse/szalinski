/* [Parameters] */
width=4.6;
height=2;
// Holes per edge
holes=3;
// Hole diameter
diameter=1.6;
// Separation between holes
separation=0.6;
// Edge roundness
edge=0.5;

union(){

  difference(){

    cube([diameter*holes+separation*(holes+1),width,height]);

    for(i=[0:holes-1]){
     
      hull(){
        translate([(separation+diameter/2)+(separation+diameter)*i,0.1+diameter/2,-0.05])
          cylinder(r=diameter/2, h=height+0.1,$fn=25);
      
        translate([(separation+diameter/2)+(separation+diameter)*i,-diameter/3,-0.05])
          cylinder(r=diameter/2, h=height+0.1,$fn=25);
      }
    }

    for(i=[0:holes-1]){
      hull(){
        translate([(separation+diameter/2)+(separation+diameter)*i, width-diameter/2-0.1, -0.05])
          cylinder(r=diameter/2, h=height+0.1,$fn=25);
      
        translate([(separation+diameter/2)+(separation+diameter)*i,width+diameter/3,-0.05])
          cylinder(r=diameter/2, h=height+0.1,$fn=25);
      }
    }

  }

  for(i=[0:holes]){
    translate([separation/2+(diameter+separation)*i,0,0])
      cylinder(r=edge, h=height, $fn=20);
  }

  for(i=[0:holes]){
    translate([separation/2+(diameter+separation)*i,width,0])
      cylinder(r=edge, h=height, $fn=20);
  }

}
