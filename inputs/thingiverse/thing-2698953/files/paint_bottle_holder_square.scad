cols=4; // number of columns
rows=2; // number of rows
diam=34.5; // bottle diameter (Revell Aqua 34.5)
t=0.8; // wall thickness
step=10; // step height

for (i=[1:rows]) {
    for (j=[1:cols]) {
        translate([j*(diam+t),i*(diam+t),0]) 
        difference() {
              cube([diam+2*t,diam+2*t,i*step+(20-step)]);
              translate([t,t,(i-1)*step+t]) cube([diam,diam,20]);
          }
    }
}
