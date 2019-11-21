/* [Spool] */
D_out=199; //spool outer diameter
D_in=80;   //spool inner diameter
W=66.5;    //spool width
/* [PLA] */
dia=1.75;  //PLA line diameter
vof=0.75;  //packing efficiency
/* [Ruler] */
rule_w=25; //rule width
rule_t=3;  //rule thickness
rule_h=30; //rule head
base_width_ratio=0.8; //base width ratio

    module base(W,rule_w,rule_t,rule_h,base_width_ratio){
    cube(size=[W*base_width_ratio,rule_h,rule_t]);
    }

    
    module rule(W,D_out,D_in,rule_w,rule_t,rule_h){
    cube(size=[rule_w,rule_h+(D_out-D_in)*0.5,rule_t]);
    }

pi=3.14159265358979; //pi
    
fl_0=0; //meter
    
fl_25=25; //meter
    
fl_50=50; //meter

fl_100=100; //meter

fl_200=200; //meter

fl_300=300; //meter
    
 module p1(fl_0,rule_t){
     p_0=(D_out-sqrt((((0.25*pi*dia*dia*fl_0*1000)/vof)/W+0.25*pi*D_in*D_in)*4/pi))/2-rule_t/4;
    translate([0,p_0,0])
     cube(size=[0.5*rule_t,0.5*rule_t,rule_t]);  
    }  
 module p2(fl_0,rule_t){
     p_0=(D_out-sqrt((((0.25*pi*dia*dia*fl_0*1000)/vof)/W+0.25*pi*D_in*D_in)*4/pi))/2-rule_t/4;
    translate([0,p_0,0])
     cube(size=[0.5*rule_t,0.5*rule_t,rule_t]);
     
     translate([0.5*rule_t+(fl_0/50)*(rule_w-2.0*rule_t),p_0+0.25*rule_t,0])
     
     cylinder(rule_t,rule_t/2,rule_t/2,$fn=10);
      
    }

 module p3(fl_0,rule_t){
    p_0=(D_out-sqrt((((0.25*pi*dia*dia*fl_0*1000)/vof)/W+0.25*pi*D_in*D_in)*4/pi))/2-rule_t/4;
     translate([0,p_0,0])
     cube(size=[0.5*rule_t,0.5*rule_t,rule_t]);
     
    translate([0.5*rule_t+(fl_0/300)*(rule_w-2.5*rule_t),p_0-0.25*rule_t,0])
     
      cube(size=[rule_t,rule_t,rule_t]);
    }
    
    difference(){
    union(){
        base(W,rule_w,rule_t,rule_h,base_width_ratio);
        rule(W,D_out,D_in,rule_w,rule_t,rule_h);
        }
        
    p1(fl_0,rule_t); 
    p2(fl_25,rule_t);    
    p2(fl_50,rule_t);     
    p3(fl_100,rule_t);     
    p3(fl_200,rule_t);       
    p3(fl_300,rule_t);    
    }
    
    
