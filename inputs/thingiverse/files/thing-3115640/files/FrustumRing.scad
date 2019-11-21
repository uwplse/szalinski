////----FrustumRing.scad----
////----OpenSCAD 2015.03-2----
////----Kijja Chaovanakij----
////----2018.9.12----
////----Use hull command, the thickness will not change according to the slope.

/*[Var]*/
//number of fragments [30:low,60:medium,90:high,180:quality]
$fn=90; //[30:low,60:medium,90:high,180:quality]
//base inner diameter[44.6]
base_inner_dia=44.6;
//top inner diameter[39]
top_inner_dia=39;
//height of ring exclude round end[23]
ring_height=23;
//thickness of ring[2.3]
ring_thick=2.3;
//total height
total_height=ring_height+ring_thick;
echo("total_height",total_height);

////----main----
color("LightGreen")    
rotate_extrude(angle=360,convexity=10)
  hull(){
//bottom ring
    translate([base_inner_dia/2+ring_thick/2,0,0])
      circle(ring_thick/2);
//top ring
    translate([top_inner_dia/2+ring_thick/2,ring_height,0])
      circle(ring_thick/2);
  }//h
//
