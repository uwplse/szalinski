dia = 290;
nr0fArms = 4;
angleStep = 180/nr0fArms;

for (phi =[0:angleStep:180-angleStep]){
  rotate([0,0,phi])cube(size = [dia,5,5], center=true);
}
