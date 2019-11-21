neck_width = 41;
strings_gap = 6.8;
base_height = 0.5;
action = 1.3;
compensation = [0.6, 1.8, 1, 1.6, 2.3, 3];
extrusion_width = 0.5;
layer = 0.2;

for (i=[-1:1]) {
  translate ([0, i*20, 0]) {
    compensation(compensation, action+(i*layer));
  }
}

module compensation (compensations, action) {
compensator_width = max(compensations);    
union() {
translate([-neck_width/2, 0, 0]) 
    cube([neck_width, compensator_width, base_height]);
for (i=[0:5]) {
  translate([(i-3)*strings_gap,0,0]) 
      cube ([strings_gap, compensation[i], action-layer]);   
  translate([(i-3)*strings_gap,compensation[i]-extrusion_width, 0])
      cube ([strings_gap, extrusion_width, action]);
}
}
}