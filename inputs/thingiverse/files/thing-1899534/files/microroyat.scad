// Logo du Club Micro
// Lettre C dans le M
// 2016 - FRA
// Et un jour peut-etre notre Super Micro ... :D

echo(version=version());

y=100; // Largeur lettre M

ll=y/5; // Largeur de trait des lettres
x=y-ll;  // Longueur lettre M
z=15;  // Epaisseur lettre M

union() {
  // Le M bleu
  color("blue")
  cube([x, y, z]);

  // Le C orange
  difference() {
    color("orange")
    translate([-ll, ll, 0])
    cube([x, y-2*ll , z*2]);
    
    translate([0, 2*ll, 0])
    cube([x-ll+1, ll+1, z*2+1]);
  }
}

