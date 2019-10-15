//Altura del tub
tub_mida = 100; // [1:500]

//Diametre del tub
tub_diametre = 50; // [1:100]

//Gruix de la pared del tub
tub_gruix = 5; // [1:100]

difference()
{
cylinder(r=tub_diametre/2,h=tub_mida);
cylinder(r=(tub_diametre/2)-tub_gruix,h=tub_mida);
}
