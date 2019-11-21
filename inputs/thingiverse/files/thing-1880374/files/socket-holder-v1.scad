d10=24.1;
d13=24.1;
d14=24.1;
d15=24.1;
d17=26.1;
d18=28.1;
d19=28.1;
d21=30;
d22=32;
d24=34;
d27=38.1;
d30=41.9;
d32=44.1;


module s(diam,x=0,y=0){
    translate([x,y+(diam/2),5])cylinder(100,d=diam+1,true,$fn=500);
}
module s2(diam,x=0,y=0){
    translate([x,100-(y+(diam/2)),5])cylinder(100,d=diam+1,true,$fn=500);
}

module t(num,spac=0){
    translate([spac-6.5,0.5,35])rotate([90,0,0])linear_extrude(height = 0.5)text(str(num));
}

module t2(num,spac=0){
    translate([spac+6.5,79.5,35])rotate([90,0,180])linear_extrude(height = 0.5)text(str(num));
}

difference(){
cube ([250,80,50]); //main body
    
r1=5; //first row
spacing=-10;
mult=1.15;
s(d10,(spacing+d10)*mult,r1);
s(d13,(spacing+d10+d13)*mult,r1);
s(d14,(spacing+d10+d13+d14)*mult,r1);
s(d15,(spacing+d10+d13+d14+d15)*mult,r1);
s(d17,(spacing+d10+d13+d14+d15+d17)*mult,r1);
s(d18,(spacing+d10+d13+d14+d15+d17+d18)*mult,r1);
s(d19,(spacing+d10+d13+d14+d15+d17+d18+d19)*mult,r1);
s(d21,(spacing+d10+d13+d14+d15+d17+d18+d19+d21)*mult,r1);

spacin2=-19;
r2=25; //second row
mult2=1.3;
s2(d32,(spacin2+d32)*mult2,r2);
s2(d30,(spacin2+d32+d30)*mult2,r2);
s2(d27,(spacin2+d32+d30+d27)*mult2,r2);
s2(d24,(spacin2+d32+d30+d27+d24)*mult2,r2);
s2(d22,(spacin2+d32+d30+d27+d24+d22)*mult2,r2);

t(10,(spacing+d10)*mult);
t(13,(spacing+d10+d13)*mult);
t(14,(spacing+d10+d13+d14)*mult);
t(15,(spacing+d10+d13+d14+d15)*mult);
t(17,(spacing+d10+d13+d14+d15+d17)*mult);
t(18,(spacing+d10+d13+d14+d15+d17+d18)*mult);
t(19,(spacing+d10+d13+d14+d15+d17+d18+d19)*mult);
t(21,(spacing+d10+d13+d14+d15+d17+d18+d19+d21)*mult);

t2(32,(spacin2+d32)*mult2);
t2(30,(spacin2+d32+d30)*mult2);
t2(27,(spacin2+d32+d30+d27)*mult2);
t2(24,(spacin2+d32+d30+d27+d24)*mult2);
t2(22,(spacin2+d32+d30+d27+d24+d22)*mult2);

}