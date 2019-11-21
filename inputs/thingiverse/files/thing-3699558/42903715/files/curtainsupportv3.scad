//Pole support, looks good prevents twisting

Supl= 100;//length of the support
pold= 28.1;//pole diameter
tol=1; //tolerance, practice piece came out at 27.5mm - this is a problem with the printer. printers routinely print holes undersized.
FN =360;//global number for the number of sides in a circle 
fudge = 1/cos(180/FN);//theoretical correction to make the hole the right size
poldx = pold*fudge+tol;//theoretical correction to make the hole the right size
echo (poldx);
dim = poldx;//dimension of the cube that is subtracted so that the pole can be taken in and out easily. 
//cutaway ();
//insert ();
body ();
module insert (dim=poldx-2) {
difference (){
    translate ([0,0,75]) rotate ([180,0,0]) body ();
    translate ([0,0,0]) cutaway ();}}

module cutaway () {
translate ([0,0,75]) rotate ([180,0,0])
difference () {
body ();
translate ([0,-poldx/2,0]) cube ([110,dim,dim], center=true);
translate ([0,-poldx/2,-dim/2]) rotate ([0,90,0]) cylinder (h=110,d=dim/10, $fn=100, center = true); 
translate ([0,-poldx/2,dim/2]) rotate ([0,90,0]) cylinder (h=110,d=dim/10, $fn=100, center = true);    
    }}




module body () {
difference () {
union (){
resize([100,50,50]) sphere (20, $fn=FN);
support ();}
translate ([-100,0,0]) rotate ([0,90,0]) cylinder (h = 200, d=poldx, $fn=FN, centre =true); 
}}

module support () {
difference () {
union () {
resize ([80,30,70]) cylinder (h=70,d=30, $fn=100);
translate ([0,0,45]) resize ([110,70,0]) cylinder (h=30, d1= 30, d2=70, $fn=FN);}
translate ([0,25,30]) cylinder (h=100,d=6);
translate ([0,-25,30]) cylinder (h=100,d=6);
translate ([0,25,30]) cylinder (h=40,d=11);
translate ([0,-25,30]) cylinder (h=40,d=11);

}}