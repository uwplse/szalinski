
/*  
    Written by Hendrik Schreutelkamp <info@schreutelkamp.net>   
    This is a housing for a 12V and 5V mod* for a HP PS 3381 1C1 powersupply using xt60 connector an USB port.
    To the extent possible under law, the author(s) have dedicated all
    copyright and related and neighboring rights to this software to the
    public domain worldwide. This software is distributed without any
    warranty.

    You should have received a copy of the CC0 Public Domain
    Dedication along with this software.
    If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
    
  
*/

difference() {
//main case
cube([16,65,30]);
    translate([1,1,0])cube([14,63,16]);
    translate([1,9,0])cube([8.5,16.5,100]);
    translate([2.5,30,0])cube([5.8,13.2,200]);
    translate([1,44,0])cube([14,20,28]);
    translate([11,1,0])cube([4,63,28]);
    translate([1,1,0])cube([14,6,28]);
   
   
    //imprints
    rotate(90,0,0)translate([10.5,-15,30])linear_extrude(1)text( "-12V+", size=4);
rotate(90,0,0)translate([29.5,-15,30])linear_extrude(1)text( "5V 5A", size=4);
    
    
   
    }




//left latch
difference() {
translate([-19.38--16,7,1.6])cylinder(  2, d=8.5  );
    translate([-19.38--16,7,1.6])cylinder(  2, d=5  );
}
//right latch
difference() {
translate([-19.38--16,57.5,1.6])cylinder(  2, d=8.5  );
translate([-19.38--16,57.5,1.6])cylinder(  2, d=5  );
}






    
