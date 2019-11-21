//krabicka na promanum
//65 mm šířka
//75 mm délka
//80 mm výška přední
//100 mm výška zadní
//boky skosené
//vzadu 2x díra 3 mm průměr


delka = 75;
sirka = 65;
vyska_predek = 80;
vyska_zadek = 100;
dira = 3;
tryska = 0.4;
sirka_steny = 6*tryska;
fudge = 1;
delka_sikme = sqrt(sirka*sirka+(vyska_zadek-vyska_predek)*(vyska_zadek-vyska_predek));
rozdil_zadek = vyska_zadek - vyska_predek;

difference()
{
cube ([delka,sirka,vyska_zadek]);
    
    translate([sirka_steny/2,sirka_steny/2,sirka_steny/2,])
cube ([delka-sirka_steny,sirka-sirka_steny,vyska_zadek+fudge]);   
    

translate ([0,0,vyska_predek])
rotate([asin(rozdil_zadek/delka_sikme),0,0])
#cube ([delka,delka_sikme,vyska_predek]);
echo(delka_sikme);

 //dírka první
translate([(delka/4),sirka+fudge,(vyska_zadek-rozdil_zadek/2)])
rotate([90,0,0])
#cylinder(d=dira, h=sirka_steny+4*fudge, $fn = 64);

    //díra druhá
translate([(3/4*delka),sirka+fudge,(vyska_zadek-rozdil_zadek/2)])
rotate([90,0,0])
#cylinder(d=dira, h=sirka_steny+4*fudge, $fn = 64);
    
}
