//ID badge with safety pin
// JFRocchini 17/08/2016
//change the name ;) print put the safety pin in place warm the half cylinder with a solder iron pinch with plyers let it cold and enjoy !


$fn=50;
difference(){
union(){
 translate([40,15,-2]) rotate([0,90,0])  cylinder (d=5,h=10);
translate([62,15,-2]) rotate([0,90,0]) cylinder (d=5,h=10);
    
color("black") translate([19,0,0]) cube([72,30,2]);
translate([30,22,1.5])
color("white") linear_extrude(height=1.5, convexity=4)
text("ROCCHINI",size=7,
                     font="Bitstream Vera Sans"
                     );
    translate([25,12,1.5])
color("white") linear_extrude(height=1.5, convexity=4)
text("Jean-François",size=7,
                     font="Bitstream Vera Sans"
                     );
        translate([35,2,1.5])
color("white") linear_extrude(height=1.5, convexity=4)
text("PlasciLab",size=7,
                     font="Bitstream Vera Sans"
                     );
    }
    
 translate([0,15,-2]) rotate([0,90,0])   cylinder (d=2.5,h=100);
 translate([0,14,-8]) #cube([100,2,6]);
 //translate([126,15,-1]) cylinder (d=3,h=6);  
}
                     