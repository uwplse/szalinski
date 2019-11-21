// Version 2.0
// Updates from previous version:
// Add base hole for reinforcement with metal rod
// Add base cutting mode

$fn=100+0;

// Choose to generate the base or the end
Mode = "Base"; // [Base,End]

// Base width (millimeter) larger than device thickness
BaseWidth = 10; // [6:12]
// Base thickness (millimeter) thicker is stronger
BaseThickness = 7; // [4:8]
// Base height (millimeter) block view if too high
BaseHeight = 15; // [5:17]

// Base length (millimeter) needed when generating the base
BaseLength = 190; // [180:300]

// Base hole radius (millimeter) specify when you want to add metal rod inside the base hole for re-inforcement
BaseHoleRadius = 3; // [0:3.5]

// Choose Yes to cut the base at middle - so that you can print 2 halves of the base, one normal half + one mirrored half
BaseCut = "Yes"; // [Yes,No]
// Choose Yes to get the mirror image of the base
BaseMirror = "No"; // [Yes,No]

// Assembly Tolerance (milimeter) adjust if fitting of the base and the end is not good

Tolerance = 0; //[-2:0.1:2]

// Device thickness (millimeter) this and below parameters needed when generating the end
DeviceThickness = 9; // [5:15]
// End Length (millimeter) block view if too lengthy
EndLength = 15; // [10:23]
// End Spacer (millimeter) raise device to unblock view
EndSpacer = 5; // [0:10]
    
if (Mode == "Base")
    {
        if (BaseMirror=="Yes")
        {
        mirror([1,0,0])all(aw=BaseWidth,at=BaseThickness,ah=BaseHeight,ac=BaseLength-177);
        } else {
        all(aw=BaseWidth,at=BaseThickness,ah=BaseHeight,ac=BaseLength-177);            
        }
    } 
else 
    {
        end(thick=DeviceThickness,deep=EndLength,w=BaseWidth-1+Tolerance,t=BaseThickness,h=BaseHeight,s=EndSpacer-1.01);
    }

module end(thick=8,deep=15,w=8.9,t=5.5,h=15,s=5)
{
   translate([18,-22.7,3])rotate(acos(7/7.8)-5,[0,0,1])
difference()
{
    translate([15,12-(20-2*w),0.5+deep/2])rotate(90,[1,0,0])la2(H=2*w+s,L=deep-5,T=w-1);
    translate([15,13-(20-2*w),0.5+deep/2])rotate(90,[1,0,0])la2(H=2*w,L=deep-5+0.01,T=w-1+0.01);
    translate([15-(w+t)/2.0+1,20-h,5])rotate(90,[1,0,0])la(H=20,L=40,T=t+0.5);
translate([15+(w+t)/2.0-1,20-h,5])rotate(90,[1,0,0])la(H=20,L=40,T=t+0.5);
}
    difference()
    {
translate([35,-25,1])cylinder(h=deep,r=20);
       
       translate([13.9,-23.4,0])rotate(acos(7/7.8)-5,[0,0,1])rotate(90,[1,0,0])for (i=[+0.5:2.7:deep+3])
{
translate([19-(w/2+t)+1.0,i,8.32-(15-h)/2])rotate(45,[0,0,1])cube([2,2,h+4],center=true);  
translate([19+(w/2+t)-1.0,i,8.32-(15-h)/2])rotate(45,[0,0,1])cube([2,2,h+4],center=true);
translate([19-(w/2+t)+1.0+1,i+1.5,8.32-(15-h)/2])cube([2,2,h+4],center=true); 
translate([19+(w/2+t)-1.0-1,i+1.5,8.32-(15-h)/2])cube([2,2,h+4],center=true); 
}
 
translate([0,0,-4])
rotate(90,[1,0,0])
translate([14.4,0,24.2])
rotate(acos(7/7.8)-5,[0,1,0])
translate([19,35,15])
rotate(90,[1,0,0])
la(H=20,L=30,T=thick);  

translate([0,0,-4])
rotate(90,[1,0,0])
translate([14.4,0,24.2])
rotate(acos(7/7.8)-5,[0,1,0])
translate([19,35,-4])
rotate(90,[1,0,0])
la(H=20,L=30,T=8);  
   
translate([18,-22.7,0])rotate(acos(7/7.8)-5,[0,0,1])
{        
translate([-10,2,0])cube(50);
translate([15-(w+t)/2.0+1,20-h,5])rotate(90,[1,0,0])la(H=20,L=40,T=t+0.5);
translate([15+(w+t)/2.0-1,20-h,5])rotate(90,[1,0,0])la(H=20,L=40,T=t+0.5);
translate([15,13,5])rotate(90,[1,0,0])la2(H=20,L=30,T=w-1);
translate([-32,-20,0])cube(30);
translate([32,-20,0])cube(30);
    }
}
}

module all(aw=8.9,at=5.5,ah=15,ac=80) 
difference()
{
union()
{
translate([0,0,-4])
rotate(90,[1,0,0])
difference()
{
union()
{
translate([0,-12.5,0])nen(w=129,s=60,hh=ac);
translate([12.,0,24.2])rotate(acos(7/7.8)-5,[0,1,0])do(w=aw,t=at,h=ah,c=ac);
}
translate([60/2,ac+175-60,11.5])rotate(90,[1,0,0])cylinder(h=ac+1080,r=BaseHoleRadius);
}
translate([0,2.1,0]) de2(ac);
}
translate([21,-15.,-132+50])cylinder(h=ac+177,r=BaseHoleRadius); 
if (BaseCut=="Yes") {
    translate([0,0,-250-81+129/2])cube(500,center=true);
}
}


module de2(ac)
{
difference()
{
union()
{
translate([21,-17,-131+50])cylinder(h=ac+175,r=6);  
for(i=[0:4:20])
{
translate([i+6,0,-131+50])cylinder(h=129,r=2.8);    
}
translate([6,-2.8,-131+50])cube([24,2.8*2,129]);
translate([6,-2.8,-131+50])rotate(10,[0,0,1])cube([12,2.8*2,129]);
translate([16,-2,-131+50])rotate(5,[0,0,1])cube([14.5,2.8*2,129]);
}
translate([6,0,-131+49])cylinder(h=138,r=1.5); 
translate([6,-0.5,-131+49])rotate(1,[0,0,1])cube([110,0.5,139]);
translate([6,-0.375,-131+49])rotate(1.75,[0,0,1])cube([110,0.5,139]);
translate([6,-0.25,-131+49])rotate(2.5,[0,0,1])cube([110,0.5,139]);
translate([6,-0.125,-131+49])rotate(2.75,[0,0,1])cube([110,0.5,139]);
translate([6,0,-131+49])rotate(3.5,[0,0,1])cube([110,0.5,139]);

translate([0,-1,49])rotate(-55,[1,0,0])cube(50,centre=true); 
translate([0,42,-110.5])rotate(5,[0,0,1])rotate(55,[1,0,0])cube(50,centre=true);    

translate([-30,5,-16.5])rotate(90,[1,0,0])cylinder(h=10,r=40);
}
}


module nut(a=20)
{
translate([12.5,-20,0])rotate(a,[0,1,0])translate([2.5,10,19])translate([-5,0,0])rotate(90,[0,1,0])cylinder(h=5,r=1.6);    
translate([12.5,-20,0])rotate(a,[0,1,0])translate([2.5,10,19])difference(){sphere(r=3);translate([-5,0,0])cube(10,center=true);}    
}

module nen(w=80,s=60,hh=80)
{
union()
{
difference()
{
union()
{
translate([s/2,w/2,2])rotate(90,[1,0,0])
    cylinder(h=w,r=4);   
translate([s/2,hh+175-64.5,13.0])rotate(90,[1,0,0])
    cylinder(h=hh+175,r=8);
translate([s/2,0,5])cube([8,w,6],center=true);
}
translate([0,0,66])cube([100,500,100],center=true);
}
}
}

module do(t=5.5,a=0,h=15,w=8.9,c=80)
{

difference()
{
union()
{
difference()
{
translate([11,-40-54+17-0,-5])cube([16,c+120+127-90+12+6,10]);
translate([19,105+c,5])rotate(90,[1,0,0])cylinder(h=130+500,r=w/2);
}
translate([13+w+t-(w-8)/2-(t-4)/2,-18.5+29+c/2,0])la(H=h,L=138+c+37,T=t,A=a);
translate([13-(w-8)/2-(t-4)/2,-18.5+29+c/2,0])la(H=h,L=138+c+37,T=t,A=a);
}

translate([9.1-(t-4)-(w-8)/2,-80,-10])cube([2,179+c,100]);
translate([11+w+2*t-0.1-(t-4)-(w-8)/2,-80,-10])cube([2,179+c,100]);
for (i=[-81:2.7:280])
{
translate([11.1-(t-4)-(w-8)/2,i,5])rotate(45,[0,0,1])cube([2,2,100],center=true);  
  translate([11+w+2*t-0.1-(t-4)-(w-8)/2,i,5])rotate(45,[0,0,1])cube([2,2,100],center=true);  
}

}
}

module la(H=20,L=10,T=4,A=0)
{
rotate(A,[0,1,0]) union()
{
translate([0,0,H/2])cube([T,L,H],center=true);
translate([0,L/2,H])rotate(90,[1,0,0])
    cylinder(h=L,r=T/2);
translate([0,L/2,0])rotate(90,[1,0,0])
    cylinder(h=L,r=T/2);
}    
}

module la2(H=20,L=10,T=4,A=0)
{
rotate(A,[0,1,0]) difference()
{
translate([0,0,H/2])cube([T,L,H],center=true);
translate([0,L/2+0.1,H])rotate(90,[1,0,0])
    cylinder(h=L+0.2,r=T/2);
translate([0,L/2+0.1,0])rotate(90,[1,0,0])
    cylinder(h=L+0.2,r=T/2);
}    
}