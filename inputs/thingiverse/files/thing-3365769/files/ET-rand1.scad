/* Alien Configurable/Random
Version 1, Enero 2019
Escrito por Jorge Cifuentes (jorgecif at gmail dot com)*/

tipo="configurable"; //[configurable,random]

//Parametros de configuracion

//Resolution
$fn=10;
//Body radio
radio=40;
//Body height
long_cuerpo=30;

//Neck thickness
cuello_r=11;
//Neck lenght
cuello_h=30;

//Eyes size
ojos_r=10;
//Eyes elevation angle
theta_ojos=70;
//Eyes separation angle
phi_ojos=21;

//Arms thickness
brazos_r=10;
//Arms lenght
brazos_h=15;
//Arms elevation angle
theta_brazos=45;
//Arms separation angle
phi_brazos=70;

//Legs thickness
piernas_r=10;
//Arms lenght
piernas_h=30;
//Arms elevation angle
theta_piernas=160;
//Arms separation angle
phi_piernas=90;


/*
Coordenadas esfericas
phi=angulo entre x y y
theta=angulo entre z y el plano x-y - de 0 a 180
x = r*sin(theta)*cos(phi)
y = r*sin(theta)*sin(phi)
z = r*cos(theta)
*/


module alien(radio,long_cuerpo,cuello_r,cuello_h,ojos_r,theta_ojos,phi_ojos,brazos_r,brazos_h,theta_brazos,phi_brazos,piernas_r,piernas_h,theta_piernas,phi_piernas)
{
//Cuerpo
hull() {
 translate([0,0,long_cuerpo]) sphere(radio*1);
 sphere(radio*1.2);
 }

//Cuello
translate([0,0,(radio+long_cuerpo)*0.9])
cylinder(h=cuello_h,r=cuello_r);

//Cabeza
translate([0,0,radio+(cuello_h+long_cuerpo)*0.9])
hull() {
 translate([40,0,30]) sphere(radio*3/4);
 sphere(cuello_r);
 }
 
 //Ojos
xo = radio*sin(theta_ojos)*cos(phi_ojos);
yo = radio*sin(theta_ojos)*sin(phi_ojos);
z0 = radio*cos(theta_ojos);
translate([xo+40-cuello_r,yo+0,(z0+radio+cuello_h+30+long_cuerpo)*.9])
sphere(ojos_r);
translate([xo+40-cuello_r,(yo+0)*-1,(z0+radio+cuello_h+30+long_cuerpo)*.9])
sphere(ojos_r);
 
//Brazos
x = radio*sin(theta_brazos)*cos(phi_brazos);
y = radio*sin(theta_brazos)*sin(phi_brazos);
z = radio*cos(theta_brazos);
translate([x,y,z+long_cuerpo])

hull() {
 translate([brazos_h,brazos_h,brazos_h]) sphere(brazos_r);
 sphere(8);
 }
translate([x,-y,z+long_cuerpo])
hull() {
 translate([brazos_h,-1*brazos_h,brazos_h]) sphere(brazos_r);
 sphere(8);
 }
//Piernas
xp = radio*sin(theta_piernas)*cos(phi_piernas);
yp = radio*sin(theta_piernas)*sin(phi_piernas);
zp = radio*cos(theta_piernas);
translate([xp,yp,zp])
hull() {
 translate([0,15,-15]) cylinder(30,30,10);
 cylinder(8,8,8);
 }

translate([xp,-yp,zp])
hull() {
 translate([0,-15,-15]) cylinder(30,30,10);
 cylinder(8,8,8);
 }

}



module configurable_alien()
{
    alien(radio,long_cuerpo,cuello_r,cuello_h,ojos_r,theta_ojos,phi_ojos,brazos_r,brazos_h,theta_brazos,phi_brazos,piernas_r,piernas_h,theta_piernas,phi_piernas);
}

module random_alien()
{
    radio=rands(30,50,1)[0]; //40;
	long_cuerpo=rands(10,50,1)[0]; //30;
	cuello_r=rands(9,12,1)[0]; //11;
	cuello_h=rands(0,40,1)[0]; //30
	ojos_r=rands(5,20,1)[0]; //10
	theta_ojos=rands(45,90,1)[0]; //70
	phi_ojos=rands(0,45,1)[0]/2; //21
	brazos_r=rands(10,20,1)[0]; //10
	brazos_h=rands(10,20,1)[0];//30
	theta_brazos=rands(20,75,1)[0];//45
	phi_brazos=rands(60,90,1)[0]; //70
	piernas_r=rands(0,30,1)[0]; //10
	piernas_h=rands(10,60,1)[0];//30
	theta_piernas=rands(150,170,1)[0];//160
	phi_piernas=rands(70,110,1)[0];//90
    
	alien(radio,long_cuerpo,cuello_r,cuello_h,ojos_r,theta_ojos,phi_ojos,brazos_r,brazos_h,theta_brazos,phi_brazos,piernas_r,piernas_h,theta_piernas,phi_piernas);
}

if (tipo=="configurable")
{
    configurable_alien();
}

if (tipo=="random")
{
    random_alien();
}
