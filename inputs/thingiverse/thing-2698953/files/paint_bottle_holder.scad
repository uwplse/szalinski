cols=8; // number of columns
rows=2; // number of rows
diam=25.5; // bottle diameter : Vallejo 25.5, Citadel 33, Citadel old 34.5
t=0.8; // wall thickness
step=10; // step height

for (i=[1:rows]) {
    for (j=[1:cols]) {
        translate([j*(diam+t),i*(diam+t),0]) 
        difference() {
              cylinder(h=i*step+(20-step),r1=diam/2+t,r2=diam/2+t,$fn=100);
              translate([0,0,(i-1)*step+t]) cylinder(h=20,r1=diam/2,r2=diam/2,$fn=100);
          }
    }
}
