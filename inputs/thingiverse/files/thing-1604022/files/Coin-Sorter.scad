DQ=25; //diameter of quarters
HQ=69; //height of $10 of quarters

DN=21.5; //diameter of nickles
HN=73; //height of $2 of nickles

DP=19; //diameter of pennies
HP=73; //height of $.5 of pennies

DD=18; //diameter of dimes
HD=66; //height of $5 of dimes

union() {
 difference() {
 cylinder(h=30, r1=38, r2=63, center=false);
 translate([0,0,-1])
 cylinder(h=32, r1=35, r2=60, center=false);
 } //catcher cone
 
 
 intersection() {
 cylinder(h=30, r1=38, r2=63, center=false);
 
 translate([0,0,15])
 cube(size = [125,3,30], center = true);
 }
 intersection() {
 cylinder(h=30, r1=38, r2=63, center=false);
  
 translate([0,0,15])
 cube(size = [3,125,30], center = true);
 }
  // dividers
 
 difference() {
 union() {
 cylinder(h=3, r=38, center=false);

 translate([(DQ/2)+1.5,(DQ/2)+1.5,-75])
 cylinder(h=75, r=(DQ+4)/2, center=false); //.25
 
 translate([-(DN/2)-1.5,(DN/2)+1.5,-75])
 cylinder(h=75, r=13.5, center=false); //.5
 
 translate([-(DP/2)-1.5,-(DP/2)-1.5,-75])
 cylinder(h=75, r=12.5, center=false); //.01
 
 translate([(DD/2)+1.5,-(DD/2)-1.5,-75])
 cylinder(h=75, r=12, center=false); //.1
 } //outer
 translate([(DQ/2)+1.5,(DQ/2)+1.5,-HQ+3.1])
 cylinder(h=HQ, r=DQ/2, center=false); //.25
 
 translate([-(DN/2)-1.5,(DN/2)+1.5,-HN+3.1])
 cylinder(h=HN, r=DN/2, center=false); //.5
 
 translate([-(DP/2)-1.5,-(DP/2)-1.5,-HP+3.1])
 cylinder(h=HP, r=DP/2, center=false); //.01
 
 translate([(DD/2)+1.5,-(DD/2)-1.5,-HD+3.1])
 cylinder(h=HD, r=DD/2, center=false); //.1
 } //inner
 }