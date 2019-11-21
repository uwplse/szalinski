$fn=50;
staerke=10;

reihen=2;
spalten=10;
startradius=1.5;
increment=.05;

perimeter=3;


anzahl=reihen*spalten;
abstand= 2*startradius+(2*anzahl-3)*increment+2*perimeter*0.42;

echo (abstand);

difference() {
cube([spalten*abstand,reihen*abstand,staerke]);
for(x=[1:spalten])    
 for(y=[1:reihen])    
translate([(x-.5)*abstand,(y-.5)*abstand]) cylinder(r=startradius+((x-1)+(y-1)*spalten)*increment,h=staerke);
}
translate([abstand,0,3]) rotate([90,0,0]) linear_extrude(.2) text(str("start ", startradius," incr ",increment),size=4);
