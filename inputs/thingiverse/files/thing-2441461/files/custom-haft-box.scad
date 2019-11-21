/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Stephane BARTHELEMY <stephane@sbarthelemy.com> wrote this file. 
 * As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Stéphane BARTHELEMY
 * ----------------------------------------------------------------------------
 */
 
 /*
 * ----------------------------------------------------------------------------
 * "LICENCE BEERWARE" (Révision 42):
 * Stephane BARTHELEMY <stephane@sbarthelemy.com> a créé ce fichier. 
 * Tant que vous conservez cet avertissement,
 * vous pouvez faire ce que vous voulez de ce truc. Si on se rencontre un jour et
 * que vous pensez que ce truc vaut le coup, vous pouvez me payer une bière en
 * retour. Stéphane BARTHELEMY
 * ----------------------------------------------------------------------------
 */
 

//Length
l = 55 ;
//width
w = 30;
//Height ( print half of height
h = 25 ;
// Thicknesss
e = 5;
// Radius screw
vis=1.5;
// Bottom
fond =3;
// Radius cable
fil = 3;

$fn=50;

difference ()
{
    union () 
    {
        difference ()
        {
            translate ([-e,-e,-fond]) cube ([l+10,w+10,h/2]) ; 
            cube ([l,w,h/2]);
            translate ([l+(e/2),-e/2,-e*2]) cylinder (r1=vis, r2=vis, h=w+(e*2));
            translate ([l+(e/2),w+(e/2),-e*2]) cylinder (r1=vis, r2=vis, h=w+(e*2));
            translate ([-e/2,-e/2,-e*2]) cylinder (r1=vis, r2=vis, h=w+(e*2));
            translate ([-e/2,w + (e/2),-e*2]) cylinder (r1=vis, r2=vis, h=w+(e*2));
        }
        translate ([l+(fil+2),w/2,(h/2)-(fil+2)]) rotate ([0,90,0]) cylinder (r1=(fil+2), r2=(fil+2),10);
        translate ([l+(fil+1),w/2,(h/2)-(fil+1)]) rotate ([0,90,0]) cylinder (r1=(fil+1), r2=(fil+1),15);
        translate ([-10-(fil+2),w/2,(h/2)-(fil+2)]) rotate ([0,90,0]) cylinder (r1=(fil+2), r2=(fil+2),10);
        translate ([-15-(fil+1),w/2,(h/2)-(fil+1)]) rotate ([0,90,0]) cylinder (r1=(fil+1), r2=(fil+1),15);
    }
        translate ([l+(fil)-e,w/2,(h/2)-(fil)]) rotate ([0,90,0]) cylinder (r1=(fil), r2=(fil),15+(2*e));
        translate ([-20-(fil),w/2,(h/2)-(fil)]) rotate ([0,90,0]) cylinder (r1=(fil), r2=(fil),15+(2*e));
    translate ([-e-15,-e,(h/2)-fond]) cube ([l+10+35,w+10,h/2]) ; 
    
}
