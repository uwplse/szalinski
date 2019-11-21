


diametre_ext = 10  ;
diametre_int = 8   ;
hauteur      = 10  ;
resolution = 160 ;


/* fin du parametrable  */
$fn=resolution  ;
linear_extrude ( height= hauteur ){
difference(){
circle (d=diametre_ext );
circle (d=diametre_int );
}
}