$fn=40;
theta=79;
dheta=90-theta;
N=7;
beta=180*(N-2)/N-90;
echo(beta);
//alpha=atan(((1+sin(beta))*(sin(dheta)*cos(dheta)))/(cos(beta)*cos(dheta)));

alpha=atan(((1-sin(beta))*(sin(dheta)))/(cos(beta)));
echo("alpha",alpha);
w=atan((sin(beta)*pow(cos(dheta),2)+pow(sin(dheta),2))/(cos(beta)*cos(dheta)));
echo("w",w); //I have these projection angles right


inch=25.4;
minir=1/5*inch;
echo("r*2",minir*2);

k=2*minir/cos(alpha);
echo("k",k);

L=2*minir*sin(alpha);
echo("L",L);

m=L/cos(alpha);
echo("m",m);

d=tan(w)*L;
echo("d",d);

p=sqrt(pow((d),2)+pow(m,2));

h=sqrt(pow((d+p),2)+pow(k,2));
echo("h",h);

miniD=h/2/tan(dheta);
echo("miniD",miniD);

miniDistance=miniD*tan((90+beta)/2);
echo(miniDistance);


miniJ=pow(1/cos(90-theta),2)*minir*2;
miniSize=1*inch;
miniR=minir/cos(90-theta);
miniMagic=atan((miniR/minir)*tan(theta));
miniRPrime=sin(miniMagic)*miniR;
miniTemp=cos(miniMagic)*minir; //incomprehensible squishy garbage... https://www.uwgb.edu/DutchS/STRUCTGE/MOHR004.HTM
miniGap=tan(90-theta)*miniTemp;
miniHeight=2*miniRPrime+2*miniGap; //It works perfectly.
//miniDistance=miniHeight/2/tan(90-theta);


module miniJunction(n){
    /*difference(){
        union(){
            for (i=[0:n]){
            rotate([0,0,360/n*i])translate([miniDistance,0,0])rotate([theta,0,0])cylinder(h=miniSize,r=miniR,center=true);
        }
        cube([miniDistance*2,miniDistance*2,miniHeight/2],center=true);
        }*/
        for (i=[0:n]){
            rotate([0,0,360/n*i])translate([miniDistance,0,0])rotate([(theta),0,0])cylinder(h=miniSize*30,r=minir,center=true);
        
        }
    //}
}

rotate([0,w,0]);//rotate([0,0,alpha]);
translate([-miniDistance,0,0])rotate([-theta,0,0]);miniJunction(N);