
// Rule, change for different automata. One or zeros only with 8 numbers
regle = [1,0,0,0,0,0,1,1];
// First line, One or zeros with any length
lignedepart =  [1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1];
//lignedepart = [1,1,0,0,1,0,0,1,0,1,0,1,1,1,0,1,0,1,1,0,0,1,0,1,0,1,0,0,1,0,0,1,0,1];
//lignedepart = [0,0,0,0,1,0,0,1,0,1,1,1,1,1,0,1,0,1,1,0,0,1,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,0,0,1,0,1,0,0,1,0,0,1,1,1,0,1,0,1,1,1,0];
//lignedepart = [1,0,1,1,1,1,0,1,0,1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,0,1,0,0,0,1,0,1,0,1];
//lignedepart = [0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0];

// Bookmark width
largeursignet = 40;
// Bookmark height
longueursignet = 150 ;
// Bookmark thickness
epaisseursignet = .8;
// Number of iterations (higher number takes longer to process !)
nbriterations = 20;
// Overlapping
enchevretrement = 1.6;
// Underlayer thickness
epaisseursouscouche =.2;
// If true, displays the underlayer
avecsouscouche = false;
/* [Hidden] */
hauteurbloc = longueursignet / nbriterations ;
limitelargeur =len(lignedepart);

module afficheligne(uneligne,hauteur=0)
{
largeurbloc = largeursignet / len(uneligne);
for (i = [0:len(uneligne)]){
    if(uneligne[i]== 1)  translate([i*largeurbloc,hauteur*hauteurbloc,0]) cube([largeurbloc*enchevretrement,hauteurbloc*enchevretrement,epaisseursignet]);
    }    
}
//afficheligne(lignedepart,1);

module afficheautomate(n,derniereligne){
        if(n>0){
            //ligneactuelle = [ for (i = [ 1 : len(derniereligne) ]) 
            //i%2==0 ? 1 : i==1 ? 1 :0 ] ;
            ligneactuelle = [ for (i = [ 0 : limitelargeur ]) 
            derniereligne[i-1]==0 && derniereligne[i]==0 && derniereligne[i+1]==0 ? regle[0] : derniereligne[i-1]==0 && derniereligne[i]==0 && derniereligne[i+1]==1 ? regle[1] : derniereligne[i-1]==0 && derniereligne[i]==1 && derniereligne[i+1]==0 ? regle[2]:  derniereligne[i-1]==0 && derniereligne[i]==1 && derniereligne[i+1]==1 ? regle[3] : derniereligne[i-1]==1 && derniereligne[i]==0 && derniereligne[i+1]==0 ? regle[4] : derniereligne[i-1]==1 && derniereligne[i]==0 && derniereligne[i+1]==1 ? regle[5]: derniereligne[i-1]==1 && derniereligne[i]==1 && derniereligne[i+1]==0 ? regle[6]: derniereligne[i-1]==1 && derniereligne[i]==1 && derniereligne[i+1]==1 ? regle[7]: regle[7]];
            /*for(i = [0:len(derniereligne)]) {
                if(i==0){
                ligneactuelle[i]=1;    
                }
                else if(i==len(derniereligne))
                {
                ligneactuelle[i]=1;    
        
                }
                else
                {
                ligneactuelle[i]=1;    

                }
                    
                
            }*/
        afficheligne(derniereligne,n);
        afficheautomate(n-1,ligneactuelle);    
            
        }
        else
            echo(derniereligne);
    
    }
    
    afficheautomate(nbriterations,lignedepart);
    if(avecsouscouche)cube([largeursignet,longueursignet,epaisseursouscouche]);
	//translate([0,0,3]) cylinder(r=rayon+8,h=7);