//
//        __    
//       /\ \            Moebius by 
//      / /\ \           Vanlindt Marc
//     / /  \ \          Licence GNU GPL V3
//    / /____\_\ 
//    \/_______/ 
//
//

nombresections 		= 90;	// nombre de divisions de la forme
rayon 			= 10;	// Rayon...
nbrcotes 		= 3;		// Nombre de côtés de la forme
tours                   = 1;	// Nombre de tours effectués.




//Exemples : (décommentez la ligne de l'exemple voulu)
//nombresections=90;rayon=10;nbrcotes=4;nbrtour=1/2;
//nombresections=180;rayon=12;nbrcotes=4;nbrtour=2;
//nombresections=360;rayon=12;nbrcotes=4;nbrtour=4;
//nombresections=30;rayon=10;nbrcotes=3;nbrtour=1/3;
//nombresections=30;rayon=10;nbrcotes=3;nbrtour=1/3;
//nombresections=45;rayon=5;nbrcotes=5;nbrtour=3/5;


nbrtour 		= tours/nbrcotes;
moebius();

module moebius()
{
    union()
    {
    	for (i=[0:nombresections])
   	{
            union()
            {
                hull()
            	{
                    rotate ([0,0,i*360/nombresections])
                    translate ([20,0,0])
                    rotate([90,i*360*nbrtour/nombresections,0])
                    cylinder(r=rayon,h=0.1,center=true,$fn=nbrcotes);        
 
                    rotate ([0,0,(i+1)*360/nombresections])
                    translate ([20,0,0])
                    rotate([90,(i+1)*360*nbrtour/nombresections,0])
                    cylinder(r=rayon,h=0.000001,center=true,$fn=nbrcotes);     
                }
            }
        }
    }
}
