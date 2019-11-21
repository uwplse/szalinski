/*

Un générateur de machin dans lequel on met des trucs.

version aux alentours de 15.42

*/


/* [Informations générales] */
Subdvisions             = [4,4,4,4,4,4,4];
Hauteur                 = 150;
Diametre_haut           = 120;
Diametre_bas            = 80;
Epaisseur               = 3;
Epaisseur_fond          = 10;
/* [Rotation] */
Rotation_angle          = 0; //[-360:360]
Rotation_multiplicateur = 1; //[0,1,2,3,4,5]
/* [Courbure en hauteur] */
Courbure_force                  = 0; //[0:100]
Courbure_vagues                 = 0; //[0:300]
Courbure_deplacement_vertical   = 1;//[-500:500]


/* [Déplacement vertical X] */
Vague_X       = 0;//[-360:360]
Force_X       = 0;//[-150:150]
Deplacement_X = 0;//[-360:360]
/* [Déplacement vertical Y] */
Vague_Y       = 0;//[-360:360]
Force_Y       = 0;//[-150:150]
Deplacement_Y = 0;//[-360:360]


MonRecipient(
  p   = Subdvisions,
  h   = Hauteur,
  d1  = Diametre_bas,
  d2  = Diametre_haut,
  e   = Epaisseur,
  ef  = Epaisseur_fond,
  ra  = Rotation_angle,
  rm  = Rotation_multiplicateur,
  cf  = Courbure_force,
  cv  = Courbure_vagues,
  cd  = Courbure_deplacement_vertical,
  xv  = Vague_X,
  xf  = Force_X,
  xd  = Deplacement_X,
  yv  = Vague_Y,
  yf  = Force_Y,
  yd  = Deplacement_Y,
  hlp = true 
);



module MonRecipient(p,h,d1,d2,e,ef,ra,rm,cf,cv,cd,xv,xf,xd,yv,yf,yd,hlp)
{   
  p  = p  == undef ? [8,16,32] : p;  
  h  = h  == undef ? 100       : h;
  d1 = d1 == undef ? 50        : d1;
  d2 = d2 == undef ? 80        : d2;
  e  = e  == undef ? 3         : e;
  ef = ef == undef ? 10        : ef;
  ra = ra == undef ? 0         : ra;
  rm = rm == undef ? 1         : rm;
  cf = cf == undef ? 0         : cf;
  cv = cv == undef ? 0         : cv;
  cd = cd == undef ? 0         : cd;
  xv = xv == undef ? 0         : xv;
  xf = xf == undef ? 0         : xf;
  xd = xd == undef ? 0         : xd;
  yv = yv == undef ? 0         : yv;
  yf = yf == undef ? 0         : yf;
  yd = yd == undef ? 0         : yd;

  hlp = hlp == undef ? false : true;

  help(p,h,d1,d2,e,ef,ra,rm,cf,cv,cd,xv,xf,xd,yv,yf,yd,hlp);

  function fccu(a,b,c,d)    = sin(a*d*(b+c/10));
  function fcsi(a,b,c,d,e)  = sin(360/a*b*c+e)*d/a*c;

  modxv = xv/100;
  modyv = yv/100;
  modcf = cf/100;
  div   = len(p)-1;
  cnew  = 360/h;
  d3    = 360/div;
  d4    = (d2-d1)/div;
  cdnew = cd*div/10;
  
  difference()
  {
    obj(e=0,ef=0);
    obj(e=e,ef=ef);
  }
  
  module obj(e,ef)
  {  
    difference()
    {
      for(i=[0:div-1])
      {
        hull()
        {
          for(j=[0,1])
          {
            translate([fcsi(div, modxv,i+j,xf,xd),fcsi(div, modyv,i+j,yf,yd),h/div*(i+j)])
            rotate([0,0,ra/div*(i+j)*rm])
            linear_extrude(0.0000001)
            circle(d=d1-e+(fccu(d3,(i+j),cdnew,cv/100)*d1*modcf)+(d4*(i+j)),$fn=p[(i+j)]);
          }
        }
      }
      cube([d1*4,d1*2,ef*2],center=true);
    }
  }
  
  module help(p,h,d1,d2,e,ef,ra,rm,cf,cv,cd,xv,xf,xd,yv,yf,yd,hlp)
  {
      if ( hlp == false )
      {
        echo("<hr><h1>Informations</h1>
        <p>Pour obtenir de l'aide sur une variable ou des informations sur l'objet, ajouter la variable suivante :<br/><b>hlp=true</b></p><hr>");
      }
      else{
      echo("
<hr><h1>Variables</h1>
<b>p =</b> Subdvisions,<br/>
<b>h =</b> Hauteur,<br/>
<b>d1 =</b> Diametre_bas,<br/>
<b>d2 =</b> Diametre_haut,<br/>
<b>e =</b> Epaisseur,<br/>
<b>ef =</b> Epaisseur_fond,<br/>
<b>ra =</b> Rotation_angle,<br/>
<b>rm =</b> Rotation_multiplicateur,<br/>
<b>cf =</b> Courbure_force,<br/>
<b>cv =</b> Courbure_vagues,<br/>
<b>cd =</b> Courbure_deplacement_vertical,<br/>
<b>xv =</b> Vague_X,<br/>
<b>xf =</b> Force_X,<br/>
<b>xd =</b> Deplacement_X,<br/>
<b>yv =</b> Vague_Y,<br/>
<b>yf =</b> Force_Y,<br/>
<b>yd =</b> Deplacement_Y<br/>
<hr>
<h1>Informations</h1>
<table>
<tr> 
  <td><b><h2>Paramètre               </h2></b></td>
  <td><b><h2>Valeur</h2></b></td>
  <td><b><h2>Unité    </h2></b></td>
</tr>
<tr> 
  <td><i>Subdvisions</i></td>
  <td><i>",p,"</i></td>
  <td><i></i></td>
</tr>
<tr> 
  <td><i>Hauteur</i></td>
  <td><i>",h,"</i></td>
  <td><i>mm</i></td>
</tr>
<tr> 
  <td><i>Diamètre base</i></td>
  <td><i>",d1,"</i></td>
  <td><i>mm</i></td>
</tr>
<tr> 
  <td><i>Diamètre au sommet</i></td>
  <td><i>",d2,"</i></td>
  <td><i>mm</i></td>
</tr>
<tr> 
  <td><i>Epaisseur</i></td>
  <td><i>",e,"</i></td>
  <td><i>mm</i></td>
</tr>
<tr> 
  <td><i>Epaisseur du fond</i></td>
  <td><i>",ef,"</i></td>
  <td><i>mm</i></td>
</tr>
<tr> 
  <td><i>Angle de rotation</i></td>
  <td><i>",ra,"</i></td>
  <td><i>°</i></td>
</tr>
<tr> 
  <td><i>Multiplicateur de rotation</i></td>
  <td><i>",rm,"</i></td>
  <td><i>°</i></td>
</tr>
<tr> 
  <td><i>Courbure verticale - force</i></td>
  <td><i>",cf,"</i></td>
  <td><i>%</i></td>
</tr>
<tr> 
  <td><i>Courbure verticale - vague</i></td>
  <td><i>",cv,"</i></td>
  <td><i>%</i></td>
</tr>
<tr> 
  <td><i>Courbure verticale - déplacement</i></td>
  <td><i>",cd,"</i></td>
  <td><i>°</i></td>
</tr>
<tr> 
  <td><i>X - Vague </i></td>
  <td><i>",xv,"</i></td>
  <td><i>%</i></td>
</tr>
<tr> 
  <td><i>X - Force</i></td>
  <td><i>",xf,"</i></td>
  <td><i>mm</i></td>
</tr>
<tr> 
  <td><i>X - Déplacement</i></td>
  <td><i>",xd,"</i></td>
  <td><i>°</i></td>
</tr>
<tr> 
  <td><i>Y - Vague </i></td>
  <td><i>",yv,"</i></td>
  <td><i>%</i></td>
</tr>
<tr> 
  <td><i>Y - Force</i></td>
  <td><i>",yf,"</i></td>
  <td><i>mm</i></td>
</tr>
<tr> 
  <td><i>Y - Déplacement</i></td>
  <td><i>",yd,"</i></td>
  <td><i>°</i></td>
</tr>
</table>
<hr>
<h1>Volume</h1>
WIP :)
<hr>

"

//for(i=[0:p-1]){p[i]};

);
        }
      }
  
}