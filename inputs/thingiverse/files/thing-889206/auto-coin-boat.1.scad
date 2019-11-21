p_num=10;
n_num=0;
d_num=0;
q_num=0;

p_gram=p_num*2.5;
n_gram=n_num*5;
d_gram=d_num*2.268;
q_gram=q_num*5.670;

coin_gram=p_gram+n_gram+d_gram+q_gram;

WtoL=0.5;
HtoL=0.5;

fluid_density=1;
PLA_density=1.3;

volume=1.1*coin_gram/fluid_density;

L=pow(volume/(WtoL*HtoL),0.3333);
W=L*WtoL;
H=L*HtoL;

difference(){
    cube([W+0.2,L+0.2,H+0.1],true);
    translate([0,0,0.1]) cube([W,L,H],true);
}