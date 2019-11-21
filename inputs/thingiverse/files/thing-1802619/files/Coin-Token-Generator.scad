$fn=150;
// I created this after observing an elderly person attemping to insert a coin in an Australian Aldi trolley. This design should help people by providing a flat area to push against. I have printed these at 0.2mm Layer thickness with a 0.3mm nozzle with good results. This is provided free to anyone who needs it.

// Please forgive any code errors. This is my first Scad design.

CoinWidth = 24.8; //This is the diameter of the Coin/Token needed
CoinThickness = 2.6; //This is the thickness of the Coin/Token needed.


        cylinder(h=CoinThickness, r=CoinWidth/2, center=true);
    translate([(CoinWidth/2)+4,0,0])
        cube([13,5,CoinThickness],true);
    translate([(CoinWidth/2)+10,-5.5,-CoinThickness/2])
        cube([2.5,11,9],false);
    
     rotate([0,0,-90])
     translate([-1.5,(CoinWidth/2)-(CoinWidth/10),1])
        prism(3,13,6);
    
module prism(l, w, h){
    polyhedron(
         points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
         faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
     }