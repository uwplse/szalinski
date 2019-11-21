
// thickness of handle
th = 4; 

// width of handle
wh = 16; 

// length of handle (measured from center)
lh = 50; 

//radius of handle rounding
rh = 1; 

// capacity in ml
c = 33; 

//wall thickness of spoon 
t = 2; 

//relative height of conical part, 0= no conical part, 1= conical height identical to radius of sphere 
hc =0.5; 

// angle of conical part, 90 means cylindrical
phi = 80; 

module dummy() {
    //end of configurable section of customizer
}

fn=128;
fnr = 16;

a1 = sin(phi);
h1 = 1 - cos(phi);
pi = 3.141592;
Vsphere1 = pi/3*sqr(h1)*(3*1-h1);
//rcone1 = a1 * (1 / cos(phi) * hc);
rcone1 = a1 + hc / tan(phi);
Vcone1 = hc * pi / 3 *(sqr(a1) + a1*rcone1 + sqr(rcone1));

s = pow(c*1000 / (Vcone1 + Vsphere1),1/3); //scalefactor
s1= 1;
echo(Vcone1 , Vsphere1, s);
echo(rcone1,a1);
//intersection() { mycube([100,100,100],[true,false,false]);
difference() 
{
    
    union() {
        scale([(rcone1*s+t/sin(phi))/(rcone1*s),(rcone1*s+t)/(rcone1*s),((hc+h1)*s+t)/((hc+h1)*s)]) spoon(rcone1*s,a1*s,1*s,hc*s,(1-h1)*s);
        intersection() {
            mycube([lh,wh,th],[false,true,false]);
            hull() for (dx=[0,1]) for (dy=[-1,1]) for (dz=[0,1])
            translate([dx*(lh-rh),dy*(wh/2-rh),dz*(th-rh)]) sphere(r=rh,$fn=fnr);
        }
    }
    
    translate([0,0,-0.001])spoon(rcone1*s,a1*s,1*s,hc*s,(1-h1)*s);
}
//}
function sqr(a) = ((a)*(a));
module spoon(r1,r2,rs,hc,dh)
{
    cylinder(r1=r1,r2=r2,h=hc,$fn=fn);
    translate([0,0,hc-dh])intersection(){
        sphere(r=rs,$fn=fn);
        //#translate([0,0,rs-dh]) mycube([2*rs+1,2*rs+1,rs],[true,true,false]);
        translate([0,0,dh]) cylinder(r=r2,h=rs,$fn=fn);
    }
}

module mycube(pos,center=[false,false,false])
{   
    translate([center[0]?-pos[0]/2:0,center[1]?-pos[1]/2:0,center[2]?-pos[2]/2:0])cube(pos);
}

