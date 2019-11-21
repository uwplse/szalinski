$fa=15;
$fs=0.2;

//wall distance to pipe (axial)
wd=40;
//pipe diameter
pd=14;
//clip thickness
ct=2;
//clip heigth
ch=15;
//clip apperture
ca=160;
//strut thickness
st=3;
//strut heigh
sh=20;
//strut min size
sms=4;
//should a hole be drilled through the strut (1) or not (0). value > 1 will result in havoc, 
//but floats in the 0-1 range will yeld fonctional results.
//for small clip heigth (<10) , it may be better to lower this a bit (for robustness). 
hole_in_strut=1;

w1=4*(pd/2+ct);

//wall
//translate([-100,wd,-100]) cube([200,2,200]);


	//--------- clip tuyau -------------------------------------------------------
	difference() {
		cylinder(h=ch,d=pd+ct*2);
		translate([0,0,-1]) linear_extrude(height = ch+2)	
			polygon(points=[[0,0],[-w1*cos(90+ca/2),-w1*sin(90+ca/2)],[w1,-w1],[-w1,-w1],[-w1*cos(90-ca/2),-w1*sin(90-ca/2)]]);
		translate([0,0,-100]) cylinder(h=200,d=pd);	
		}
	//cylindres au bout du clip
	rotate([0,0,-(180-ca)/2]) translate([(pd+ct)/2,0,0]) cylinder(h=ch,d=ct);
	rotate([0,0,180+(180-ca)/2]) translate([(pd+ct)/2,0,0]) cylinder(h=ch,d=ct);
	//--------- etai  -------------------------------------------------------
	//central strut
	difference() {
		translate([-st/2,pd/1.99,-sh])cube([st,wd-pd/1.99,sh+ch]);
		translate([0,pd/2+ct,-sh]) scale([st*5,wd-pd/2-sms-ct,sh])  rotate([0,90,0])cylinder(r=1,h=st*2,center=true);
		translate([(pd+ct)/-2,0,-sh+0.02]) cube([pd+ct,pd/2+ct,sh]);
		//hole through the strut
		translate([-st,pd/2+ct+(wd-sms-ct-pd/2)*0.44,ch/2]) rotate([90,0,90]) scale([(wd-sms-ct-pd/2)*0.8,ch*0.7,1])cylinder(d=hole_in_strut,h=st*2);
		}
	
	difference() {
	translate([-st/2-sms,wd-sms,-sh])cube([st+sms*2,sms,sh+ch]);
	translate([st/2+sms,wd-sms,-sh-1]) cylinder(h=sh+ch+2,d=sms*1.99);
	translate([st/-2-sms,wd-sms,-sh-1]) cylinder(h=sh+ch+2,d=sms*1.99);
	}
	
	