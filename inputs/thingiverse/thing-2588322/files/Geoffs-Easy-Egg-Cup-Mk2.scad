// Geoffs-Easy-Egg-Cup-Mk2.scad

include <geoff.scad>

$fn         =  10             ; // No of segments in 360 deg -  8-20 test, >= 60 final

inHt        =  24             ;
inDia       =  42             ;    

wall        =   6             ;

// Calculated vars     
botWall     = 2               ; 
outHt       = inHt+botWall    ;
outDia      = inDia+wall*2    ;    

difference() {
  union () {

    translate([0, 0, botWall/2])
    rCyl(h=inHt, d=outDia, botRnd=outDia/4, topRnd=wall/2) ; // egg Cup Top outside part

    rCyl(h=botWall, d=outDia-wall/2, botRnd=botWall/2, topRnd=botWall/2) ; // egg Cup bot outside part

  } // Subtract parts after here
   
    translate([0, 0, botWall/2])
    rCyl(inHt, inDia, botRnd=inDia/2, topRnd=-wall/2) ; // hollow out space for egg

}

