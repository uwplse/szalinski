//Use Noise(x,y,z,seed);
Seed=1955;
step=2;//[0.25:0.25:10]
iscale=0.5;//[0.1:0.1:10]
oscale=5;//[0.1:0.25:10]
for (z=[0:8: 30]){for (x=[-20:step: 20]){for (y=[-20:step: 20]){
p1=[x,y,z+Noise(x*iscale ,y*iscale ,z*iscale,Seed)*oscale];
p2=[x+step,y,z+Noise((x+step)*iscale ,y*iscale ,z*iscale,Seed)*oscale];
p3=[x+step,y+step,z+Noise((x+step)*iscale ,(y+step)*iscale ,z*iscale,Seed)*oscale];
p4=[x,y+step,z+Noise(x*iscale ,(y+step)*iscale ,z*iscale,Seed)*oscale];
color(un([
(Noise(x*iscale ,y*iscale ,z*iscale,Seed+1)),
(Noise(x*iscale ,y*iscale ,z*iscale,Seed/2)),
(Noise(x*iscale ,y*iscale ,z*iscale,Seed/3))+(20-z)/30
])*min(Noise(x*iscale ,y*iscale ,z*iscale,Seed),1))polyhedron ([p1,p2,p3,p4],[[3,2,1,0]]);
}}}
// end of demo code */

function Noise(x=1,y=1,z=1,seed=1)=let(SML=octavebalance())(Sweetnoise(x*1,y*1,z*1,seed)*SML[0]+Sweetnoise(x/2,y/2,z/2,seed)*SML[1]+Sweetnoise(x/4,y/4,z/4,seed)*SML[2]);
function lim31(l,v)=v/len3(v)*l;
function octavebalance()=lim31(1,[40,150,280]);
function len3(v)=sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function Sweetnoise(x,y,z,seed=69840)=tril(SC3(x-floor(x)),(SC3(y-floor(y))),(SC3(z-floor(z))),Coldnoise((x),(y),(z),seed),Coldnoise((x+1),(y),(z),seed),Coldnoise((x),(y+1),(z),seed),Coldnoise((x),(y),(z+1),seed),Coldnoise((x+1),(y),(z+1),seed),Coldnoise((x),(y+1),(z+1),seed),Coldnoise((x+1),(y+1),(z),seed),Coldnoise((x+1),(y+1),(z+1),seed));
function tril(x,y,z,V000,V100,V010,V001,V101,V011,V110,V111)=	
/*V111*(1-x)*(1-y)*(1-z)+V011*x*(1-y)*(1-z)+V101*(1-x)*y*(1-z)+V110*(1-x)*(1-y)*z+V010*x*(1-y)*z+V100*(1-x)*y*z+V001*x*y*(1-z)+V000*x*y*z
*/
V000*(1-x)*(1-y)*(1-z)+V100*x*(1-y)*(1-z)+V010*(1-x)*y*(1-z)+V001*(1-x)*(1-y)*z+V101*x*(1-y)*z+V011*(1-x)*y*z+V110*x*y*(1-z)+V111*x*y*z;
function Coldnoise(x,y,z,seed=69940)=
((3754853343/((abs((floor(x+40))))+1))%1+(3628273133/((abs((floor(y+44))))+1))%1+(3500450271/((abs((floor(z+46))))+1))%1+(3367900313/(abs(seed)+1))/1)%1;
function SC3(a)=(a*a*(3-2*a));
function un(v)=v/max(len3(v),0.000001)*1;
