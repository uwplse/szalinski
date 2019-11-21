/* [Part] */
screw_vis_1 = 1; // [1:yes, 0:no]
screw_vis_2 = 1; // [1:yes, 0:no]
nut_ecrou_1 = 1; // [1:yes, 0:no]
nut_ecrou_2 = 1; // [1:yes, 0:no]
/* [Pipe diameter] */
diametre_exterieur=20;
/* [Pipe height] */
hauteur=60;
/* [Cutting angle] */
angle_decoupe=60;
/* [Base height] */
hauteur_base=10;
/* [Wall thickness] */
epaisseur=5;
/* [Screw thread angle] */
angle_filet=90;
/* [Screw thread] */
pas_filet=5;
/* [Interval]*/
jeu=0.5;
/* [Picture] */
geocaching_picture_image = 1; // [1:yes, 0:no]
/* [Font] */
write_text = 1; // [1:yes, 0:no]
font_police = "Allerta Stencil"; //[Allerta Stencil, Stardos Stencil, Sirin Stencil, Stencil, Stencil Std]
texte = "GC12345";
write_www_geocaching_com = 1; // [1:yes, 0:no]
texte2 = "www.geocaching.com";
/* [Hidden] */
value=100000;
rayon=(diametre_exterieur/2+epaisseur)/cos(angle_decoupe/2);
diametre_interieur=diametre_exterieur+2*epaisseur;
//diametre_interieur=diametre_exterieur;
hauteur_totale_filet = hauteur-pas_filet;
hauteur_filet=pas_filet/2*tan((180-angle_filet)/2);
angle_decoupe2 = (360 - 2*angle_decoupe)/2;
echo(rayon);
echo(diametre_interieur);
echo(angle_decoupe2);
$fn=100;



if (screw_vis_1 == 1){translate([0,2*diametre_interieur+5,hauteur_base])casse_tete_partie_1();}
if (screw_vis_2 == 1){translate([2*diametre_interieur+5,2*diametre_interieur+5,hauteur_base+hauteur])rotate([0,180,0])casse_tete_partie_2();}
if (nut_ecrou_1 == 1){translate([0,0,0])casse_tete_partie_3();}
if (nut_ecrou_2 == 1){translate([2*diametre_interieur+5,0,-hauteur+hauteur_base])casse_tete_partie_4();}

/***********************************************************************/
module casse_tete_partie_1(){
difference(){
    union(){
    translate([0,0,-pas_filet])for (hauteur=[0:hauteur_totale_filet/pas_filet+1])
        {for (angle=[angle_decoupe:2*angle_decoupe-2])
        {
        translate([0,0,hauteur*pas_filet])hull(){ filet(angle,pas_filet,angle_filet,diametre_interieur);
                filet(angle+1,pas_filet,angle_filet,diametre_interieur);
            }
        }
    }
    translate([0,0,-pas_filet])for (hauteur=[0:hauteur_totale_filet/pas_filet+1])
        {for (angle=[2*angle_decoupe+angle_decoupe2:2*angle_decoupe+2*angle_decoupe2-2])
        {
        translate([0,0,hauteur*pas_filet])hull(){ filet(angle,pas_filet,angle_filet,diametre_interieur);
                filet(angle+1,pas_filet,angle_filet,diametre_interieur);
            }
        }
    }
    difference(){
        cylinder(r=cos(angle_decoupe/2)*rayon,h=hauteur);
        cylinder(r=cos(angle_decoupe/2)*rayon-epaisseur,h=hauteur);
        hexa(rayon,hauteur);
        
    }
    }
translate([0,0,-pas_filet+0.01])cylinder(r=diametre_interieur,h=pas_filet);
translate([0,0,hauteur-0.01])cylinder(r=diametre_interieur,h=pas_filet);    
}
difference(){
    translate([0,0,-hauteur_base])cylinder(r=diametre_interieur,h=hauteur_base,$fn=6);
    if (geocaching_picture_image == 1){translate([0,0,-hauteur_base+1])rotate([180,0,0])resize([diametre_interieur*1,diametre_interieur*1,0])poly_path3351(5);}
}
}
/***********************************************************************/
module casse_tete_partie_2(){
difference(){
    union(){
    translate([0,0,-pas_filet])for (hauteur=[0:hauteur_totale_filet/pas_filet+1])
        {for (angle=[0:angle_decoupe-2])
        {
        translate([0,0,hauteur*pas_filet])hull(){ filet(angle,pas_filet,angle_filet,diametre_interieur);
                filet(angle+1,pas_filet,angle_filet,diametre_interieur);
            }
        }
    }
    translate([0,0,-pas_filet])for (hauteur=[0:hauteur_totale_filet/pas_filet+1])
        {for (angle=[2*angle_decoupe:2*angle_decoupe+angle_decoupe2])
        {
        translate([0,0,hauteur*pas_filet])hull(){ filet(angle,pas_filet,angle_filet,diametre_interieur);
                filet(angle+1,pas_filet,angle_filet,diametre_interieur);
            }
        }
    }
    difference(){
        cylinder(r=cos(angle_decoupe/2)*rayon,h=hauteur);
        cylinder(r=cos(angle_decoupe/2)*rayon-epaisseur,h=hauteur);
        hexa2(rayon,hauteur);
        
    }
    }
translate([0,0,-pas_filet+0.01])cylinder(r=diametre_interieur,h=pas_filet);
translate([0,0,hauteur-0.01])cylinder(r=diametre_interieur,h=pas_filet);    
}
difference(){
    translate([0,0,hauteur])cylinder(r=diametre_interieur,h=hauteur_base,$fn=6);
    if (geocaching_picture_image == 1){translate([0,0,hauteur+hauteur_base-1])resize([diametre_interieur*1,diametre_interieur*1,0])poly_path3351(5);}
}
}
/***********************************************************************/
module casse_tete_partie_3(){
    difference(){
    translate([0,0,0/*hauteur-hauteur_base*/])cylinder(r=diametre_interieur,h=hauteur_base,$fn=6);
    translate([0,0,-0.01/*hauteur-hauteur_base*/])cylinder(r=diametre_exterieur/2+epaisseur+hauteur_filet,h=hauteur_base+0.02);
    if (write_text == 1){translate([-diametre_interieur/2+1,-0.8*diametre_interieur,1])rotate([90,0,0])resize([diametre_interieur-2,hauteur_base-2,0])linear_extrude(height = 5) {
       text(text = texte, font = font_police, size = 20);
        }
      }
    if (write_www_geocaching_com == 1){translate([diametre_interieur/2-1,0.8*diametre_interieur,2.5])rotate([90,0,180])resize([diametre_interieur-2,hauteur_base-2,0])linear_extrude(height = 5) {
       text(text = texte2, font = font_police, size = 20);
        }
      }      
    }
difference(){    
union(){    
translate([0,0,-pas_filet])for (hauteur=[0:hauteur_base/pas_filet+1])
{for (angle=[angle_decoupe+1:2*angle_decoupe-2])
{
translate([0,0,hauteur*pas_filet])hull(){ filet_interieur(angle,pas_filet,angle_filet,diametre_interieur);
        filet_interieur(angle+1,pas_filet,angle_filet,diametre_interieur);
    }
}
}
translate([0,0,-pas_filet])for (hauteur=[0:hauteur_base/pas_filet+1])
{for (angle=[2*angle_decoupe+angle_decoupe2+1:2*angle_decoupe+2*angle_decoupe2-2])
{
translate([0,0,hauteur*pas_filet])hull(){ filet_interieur(angle,pas_filet,angle_filet,diametre_interieur);
        filet_interieur(angle+1,pas_filet,angle_filet,diametre_interieur);
    }
}
}
}
translate([0,0,0-hauteur_base+0.01])cylinder(r=diametre_interieur,h=hauteur_base);
translate([0,0,hauteur_base-0.01])cylinder(r=diametre_interieur,h=hauteur_base);
}
}
/***********************************************************************/
module casse_tete_partie_4(){
    difference(){
    translate([0,0,hauteur-hauteur_base])cylinder(r=diametre_interieur,h=hauteur_base,$fn=6);
    translate([0,0,hauteur-hauteur_base-0.01])cylinder(r=diametre_exterieur/2+epaisseur+hauteur_filet,h=hauteur_base+0.02);
    if (write_text == 1){translate([-diametre_interieur/2+1,-0.8*diametre_interieur,hauteur-hauteur_base+1])rotate([90,0,0])resize([diametre_interieur-2,hauteur_base-2,0])linear_extrude(height = 5) {
       text(text = texte, font = font_police, size = 20);
        }
      }
    if (write_www_geocaching_com == 1){translate([diametre_interieur/2-1,0.8*diametre_interieur,hauteur-hauteur_base+2.5])rotate([90,0,180])resize([diametre_interieur-2,hauteur_base-2,0])linear_extrude(height = 5) {
       text(text = texte2, font = font_police, size = 20);
        }
      }      
    }
difference(){    
union(){    
translate([0,0,hauteur-hauteur_base-pas_filet])for (hauteur=[0:hauteur_base/pas_filet+1])
{for (angle=[1:angle_decoupe-2])
{
translate([0,0,hauteur*pas_filet])hull(){ filet_interieur(angle,pas_filet,angle_filet,diametre_interieur);
        filet_interieur(angle+1,pas_filet,angle_filet,diametre_interieur);
    }
}
}
translate([0,0,hauteur-hauteur_base-pas_filet])for (hauteur=[0:hauteur_base/pas_filet+1])
{for (angle=[2*angle_decoupe+1:2*angle_decoupe+angle_decoupe2-2])
{
translate([0,0,hauteur*pas_filet])hull(){ filet_interieur(angle,pas_filet,angle_filet,diametre_interieur);
        filet_interieur(angle+1,pas_filet,angle_filet,diametre_interieur);
    }
}
}
}
translate([0,0,hauteur-2*hauteur_base+0.01])cylinder(r=diametre_interieur,h=hauteur_base);
translate([0,0,hauteur-0.01])cylinder(r=diametre_interieur,h=hauteur_base);
}    
}
/***********************************************************************/
module hexa(rayon,hauteur)
 {
 intersection(){    
     linear_extrude(height=hauteur)
     polygon(points=[[0,0],[rayon,0],[cos(angle_decoupe)*value,sin(angle_decoupe)*value]]);
     cylinder(r=cos(angle_decoupe/2)*rayon,h=hauteur);
 }    

 intersection(){ 
     linear_extrude(height=hauteur)
     polygon(points=[[0,0],[cos(2*angle_decoupe)*value,sin(2*angle_decoupe)*value],[cos(2*angle_decoupe+angle_decoupe2)*value,sin(2*angle_decoupe+angle_decoupe2)*value]]);
     cylinder(r=cos(angle_decoupe/2)*rayon,h=hauteur);
 } 
  
 }
module hexa2(rayon,hauteur)
 {
    
 intersection(){ 
     linear_extrude(height=hauteur)
     polygon(points=[[0,0],[rayon,0],[cos(360-angle_decoupe2)*value,sin(360-angle_decoupe2)*value]]);
     cylinder(r=cos(angle_decoupe/2)*rayon,h=hauteur);
 }

 intersection(){  
     linear_extrude(height=hauteur)
     polygon(points=[[0,0],[cos(angle_decoupe)*value,sin(angle_decoupe)*value],[cos(2*angle_decoupe)*value,  sin(2*angle_decoupe)*value]]);
     cylinder(r=cos(angle_decoupe/2)*rayon,h=hauteur);
 }     
 }     
     
 module filet(angle,pas_filet,angle_filet,diametre_interieur)    
    {            
    rotate([0,0,angle])translate([(diametre_interieur/2),0,angle/360*pas_filet])rotate([90,0,0])linear_extrude(height = 0.1,center=true)polygon(points=[[0,0],[0,pas_filet],[hauteur_filet,pas_filet/2]]);
    }
module filet_interieur(angle,pas_filet,angle_filet,diametre_interieur)    
    {            
    rotate([0,0,angle])translate([(diametre_interieur/2+hauteur_filet),0,angle/360*pas_filet+pas_filet/2])rotate([90,180,0])linear_extrude(height = 0.1,center=true)polygon(points=[[0,0],[0,pas_filet],[hauteur_filet,pas_filet/2]]);
    }    

fudge = 0.1;

module poly_path3351(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-137.500000,75.473947],[-137.500000,13.447907],[-122.316890,13.723947],[-107.133779,13.999997],[-105.799996,21.902917],[-103.956652,30.304497],[-101.264338,39.203889],[-97.978246,47.852066],[-94.353569,55.499997],[-89.931342,63.395847],[-86.705698,61.716094],[-80.047229,57.519622],[-73.472982,53.097198],[-70.500000,50.739587],[-73.442298,45.100847],[-76.152149,39.374874],[-79.035189,31.798787],[-81.510344,24.036018],[-82.996543,17.749997],[-83.675796,13.499997],[-48.087898,13.499997],[-12.500000,13.499997],[-12.500000,50.999997],[-12.677910,77.484372],[-13.105660,88.499997],[-19.797810,86.922827],[-25.684108,85.069847],[-32.031302,82.511632],[-38.270386,79.499990],[-43.832353,76.286727],[-47.930062,74.036371],[-48.926520,73.992274],[-49.537396,74.574027],[-55.925625,83.425737],[-59.862527,88.883726],[-61.500000,91.578497],[-61.018111,92.294199],[-59.675412,93.423035],[-55.025391,96.537966],[-48.785552,100.158994],[-42.191512,103.521827],[-36.684149,105.858137],[-30.523887,107.987223],[-23.462059,109.986734],[-15.250000,111.934317],[-12.500000,112.538097],[-12.500000,125.019047],[-12.500000,137.499997],[-75.000000,137.499997],[-137.500000,137.499997],[-137.500000,75.473947]]);
    difference()
    {
       linear_extrude(height=h)
         polygon([[13.500000,75.499947],[13.500000,13.499947],[75.500000,13.499947],[137.500000,13.499947],[137.500000,75.499947],[137.500000,137.499947],[75.500000,137.499947],[13.500000,137.499947],[13.500000,75.499947]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[63.500000,128.472177],[59.907150,105.478517],[57.617292,89.580403],[57.113390,84.569505],[57.157150,82.521737],[87.500000,60.490187],[108.921875,44.889022],[119.000000,37.245057],[119.575015,36.595834],[119.516008,36.115768],[118.388653,35.789757],[115.758621,35.602696],[104.253226,35.585011],[81.525210,35.941887],[41.900450,36.808077],[49.094282,82.510578],[56.851260,128.972927],[57.282449,129.386317],[58.103923,129.642924],[60.365672,129.727361],[62.532400,129.309393],[63.235098,128.937994],[63.500000,128.472177]]);
    }
    difference()
    {
       linear_extrude(height=h)
         polygon([[-137.500000,-74.999997],[-137.500000,-137.499997],[-75.000000,-137.499997],[-12.500000,-137.499997],[-12.500000,-74.999997],[-12.500000,-12.500003],[-49.928044,-12.500003],[-87.356087,-12.500003],[-88.071904,-18.229203],[-88.404202,-26.108304],[-88.197939,-37.006403],[-87.349439,-46.876432],[-85.740684,-55.636473],[-83.361165,-63.329878],[-80.200375,-69.999997],[-78.863268,-72.134909],[-77.710924,-73.298914],[-76.365314,-73.734014],[-74.448407,-73.682211],[-71.251511,-73.068316],[-67.956306,-71.826173],[-64.604199,-69.988674],[-61.236599,-67.588710],[-57.894913,-64.659174],[-54.620548,-61.232959],[-51.454913,-57.342955],[-48.439415,-53.022056],[-44.221511,-46.499997],[-38.578684,-46.499997],[-32.987627,-46.083456],[-27.469270,-45.081984],[-21.792520,-43.874148],[-21.828412,-44.549313],[-22.371016,-45.959342],[-24.588746,-50.288362],[-27.670486,-55.469960],[-30.841010,-60.112884],[-33.710698,-63.597203],[-37.059239,-67.117855],[-44.914490,-74.046979],[-53.849994,-80.457908],[-63.308977,-85.908294],[-68.617954,-88.593461],[-63.338523,-94.075007],[-58.332836,-99.773980],[-53.711558,-105.778275],[-50.121917,-111.477472],[-46.472148,-118.098433],[-43.639195,-123.953478],[-42.500000,-127.354929],[-42.658846,-128.078262],[-43.096534,-128.468448],[-44.575333,-128.340316],[-46.470193,-127.152397],[-48.314911,-125.086554],[-52.520508,-119.917952],[-58.673888,-113.473473],[-65.413436,-107.106162],[-71.377537,-102.169066],[-75.416852,-99.288579],[-76.889742,-98.564935],[-78.296156,-98.316756],[-79.859622,-98.542342],[-81.803666,-99.239994],[-87.727598,-102.044689],[-89.576153,-103.020121],[-90.529917,-103.789460],[-90.707521,-104.508808],[-90.227598,-105.334266],[-90.184929,-105.660333],[-90.976232,-105.450225],[-94.500000,-103.643399],[-110.231749,-94.733659],[-117.366294,-90.390510],[-119.465339,-88.840700],[-120.151573,-87.999997],[-119.182212,-86.871353],[-117.289641,-85.562059],[-115.734113,-84.866551],[-114.272895,-85.050298],[-112.215094,-86.417872],[-108.869818,-89.273846],[-103.000000,-94.423571],[-98.751895,-90.255436],[-95.594039,-86.815034],[-93.967168,-84.396553],[-94.008228,-83.317689],[-94.516713,-81.630046],[-96.591514,-77.352901],[-99.627691,-71.753344],[-102.272763,-65.901820],[-104.525580,-59.802803],[-106.384990,-53.460764],[-107.849844,-46.880177],[-108.918991,-40.065512],[-109.591281,-33.021244],[-109.865563,-25.751843],[-110.000000,-12.503683],[-123.750000,-12.501683],[-137.500000,-12.499683],[-137.500000,-74.999677]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-116.866903,-101.013874],[-113.208339,-102.328699],[-110.972934,-102.882122],[-109.583520,-102.739565],[-108.462928,-101.966447],[-107.373287,-101.197963],[-106.128855,-101.083706],[-104.224404,-101.705034],[-101.154705,-103.143306],[-96.956839,-105.584715],[-96.391511,-106.427913],[-96.658296,-107.190732],[-97.212899,-108.206814],[-96.455778,-108.499997],[-95.721041,-108.675695],[-95.764787,-109.098117],[-100.791537,-108.470526],[-111.410665,-106.524343],[-122.098413,-104.332375],[-127.331020,-102.967428],[-127.277788,-102.039709],[-126.495698,-100.529550],[-125.420425,-99.121472],[-124.487645,-98.499997],[-116.866903,-101.013874]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-76.098574,-107.894364],[-73.495547,-109.371197],[-71.528219,-111.289345],[-70.210753,-113.535628],[-69.557311,-115.996867],[-69.582057,-118.559880],[-70.299152,-121.111487],[-71.722759,-123.538508],[-73.867040,-125.727761],[-75.951582,-126.908716],[-78.314605,-127.418643],[-80.806865,-127.314505],[-83.279118,-126.653265],[-85.582121,-125.491886],[-87.566629,-123.887333],[-89.083398,-121.896568],[-89.983185,-119.576555],[-90.173019,-117.904249],[-90.047390,-116.179112],[-88.965352,-112.805181],[-86.968293,-109.924450],[-85.698887,-108.815811],[-84.287433,-108.006604],[-81.832726,-106.996152],[-80.154415,-106.647547],[-78.495398,-106.950410],[-76.098574,-107.894364]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-82.300000,-109.699997],[-83.254803,-111.038380],[-83.408263,-112.268381],[-82.779714,-113.298038],[-81.388493,-114.035388],[-79.398633,-114.105293],[-77.638493,-113.041658],[-76.791942,-112.093699],[-76.545425,-111.412046],[-76.921101,-110.769504],[-77.941130,-109.938879],[-79.401345,-108.948170],[-80.429416,-108.588266],[-81.303062,-108.843949],[-82.300000,-109.699997]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-107.175681,-110.130972],[-102.572220,-110.761946],[-110.786110,-119.592280],[-114.905474,-123.885611],[-117.869580,-126.603717],[-120.032923,-128.033361],[-121.750000,-128.461305],[-123.692188,-128.327169],[-124.500000,-127.950337],[-124.070026,-126.465293],[-122.923723,-124.050279],[-119.343858,-117.820996],[-115.483856,-112.043799],[-113.987382,-110.193891],[-113.067168,-109.499997],[-107.175681,-110.130972]]);
    }
    linear_extrude(height=h)
      polygon([[13.500000,-49.579452],[13.500000,-86.658908],[16.750000,-85.974557],[24.587465,-83.770505],[33.098494,-80.497500],[41.052285,-76.685192],[47.218040,-72.863234],[50.436080,-70.446967],[56.718040,-79.061875],[61.154675,-85.590783],[63.000000,-89.190412],[62.483139,-90.104227],[61.043904,-91.425667],[56.066397,-94.873913],[49.403652,-98.700122],[42.391840,-102.069266],[35.588787,-104.612336],[27.858774,-107.013092],[20.861591,-108.799618],[16.257030,-109.499997],[13.500000,-109.499997],[13.500000,-123.499997],[13.500000,-137.499997],[75.500000,-137.499997],[137.500000,-137.499997],[137.500000,-74.972540],[137.500000,-12.445093],[123.316770,-12.722543],[109.133540,-13.000003],[107.859710,-20.548653],[105.515331,-30.450126],[101.911342,-41.171445],[97.656522,-51.112045],[95.475294,-55.289401],[93.359650,-58.671366],[91.475790,-61.342735],[82.047160,-54.904710],[72.618520,-48.466686],[76.378880,-41.113684],[79.157291,-35.088719],[81.675385,-28.520586],[83.715376,-22.033081],[85.059480,-16.250003],[85.722580,-12.500003],[49.611290,-12.500003],[13.500000,-12.500003],[13.500000,-49.579452]]);
  }
}    