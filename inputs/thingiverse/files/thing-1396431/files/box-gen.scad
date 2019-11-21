lenght=100;//[20:5:200]
width=50;//[20:5:200]
hight=80;//[20:5:200]
thikness=1;//[0.1:0.1:3]
bottom=1;//[0.1:0.1:3]

difference(){
cube([lenght,width,hight],center=true);
translate(v=[0,0,bottom])
cube([lenght-thikness*2,width-thikness*2,hight-bottom],center=true);}