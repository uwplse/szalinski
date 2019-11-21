b_1 = 12.8;
b_2 = 12.8;
t_1 = 3.2;
t_2 = 3.2;
L = 127;


cube(size=[b_1,L,t_1]);
translate(v=[(b_1-t_2)/2,0,t_1])cube(size=[t_2,L,b_2]);
translate(v=[0,0,t_1+b_2])cube(size=[b_1,L,t_1]);