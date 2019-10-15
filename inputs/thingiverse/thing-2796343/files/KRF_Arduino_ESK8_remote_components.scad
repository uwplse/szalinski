//TeamKRF   8/20/2018
//Scoo_B_SK8 Arduino ESK8 Remote Components



//$fn=90;
//electronics
JoyStick = 1;  //"0"=NO / "1"=YES
NANO     = 1;  //"0"=NO / "1"=YES 
nRF24L01 = 1;  //"0"=NO / "1"=YES
Charger  = 1;  //"0"=NO / "1"=YES
Lipo     = 1;  //"0"=NO / "1"=YES

if (JoyStick == 1){
translate([80,-4.5,7]){
rotate([0,0,90])
Joy_Stick();
}
}
if (NANO == 1){
translate([0,0,0]){
rotate([0,0,0])
Nano();
}
}
if (nRF24L01 == 1){
translate([47,17,1.5]){
rotate([0,180,180])
nRF24();
}
}
if (Charger == 1){
translate([-1,18,-2]){
rotate([180,0,0])
charge();
}
}
if (Lipo == 1){
translate([24,0,-6]){
rotate([0,0,0])
lipo();
}
}
////////////////////////////////////////////////////////////   lipo
module lipo(){
translate([0,0,0]){
cube([23,18,4]);
}
}
////////////////////////////////////////////////////////////    charge
module charge(){
difference(){
//circuit board
translate([0,0,0]){
cube([23,18,2]);
}
//holes
translate([2,2,-1]){
cylinder(r=1, 4, $fn=9);
}
translate([2,16,-1]){
cylinder(r=1, 4, $fn=9);
}
translate([21,2,-1]){
cylinder(r=1, 4, $fn=9);
}
translate([21,16,-1]){
cylinder(r=1, 4, $fn=9);
}
}
//USB port
translate([0,5,2]){
cube([5,8,2]);
}
//MCU
translate([10,3,2]){
cube([7,5,1.5]);
}
//caps
translate([18,6,2]){
cube([2,4,1.5]);
}
translate([7,4.5,2]){
cube([2,4,1.5]);
}
//resistors & LEDs
translate([15,14,2]){
cube([2,3,1]);
}
translate([15,10,2]){
cube([2,3,1]);
}
translate([12,14,2]){
cube([2,3,1]);
}
translate([12,10,2]){
cube([2,3,1]);
}
translate([7,11,2]){
cube([2,4,1]);
}
}
//////////////////////////////////////////////////////////////   nRF24
module nRF24(){
difference(){
//circuit board
translate([0,0,0]){
cube([29,16,2]);
}
//antenna
translate([27.5,0.25,1.8]){
cube([0.5,3.5,1]);
}
translate([27.5,5,1.8]){
cube([0.5,2,1]);
}
translate([27.5,8,1.8]){
cube([0.5,2,1]);
}
translate([27.5,11,1.8]){
cube([0.5,2,1]);
}
translate([21,3.5,1.8]){
cube([0.5,2,1]);
}
translate([21,6.5,1.8]){
cube([0.5,2,1]);
}
translate([21,9.5,1.8]){
cube([0.5,2,1]);
}
translate([21,3.5,1.8]){
cube([7,0.5,1]);
}
translate([21,5,1.8]){
cube([7,0.5,1]);
}
translate([21,6.5,1.8]){
cube([7,0.5,1]);
}
translate([21,8,1.8]){
cube([7,0.5,1]);
}
translate([21,9.5,1.8]){
cube([7,0.5,1]);
}
translate([21,11,1.8]){
cube([7,0.5,1]);
}
translate([16,13,1.8]){
cube([12,0.5,1]);
}
translate([18,5,1.8]){
cube([0.5,8,1]);
}
}
//MCU
translate([10,8,1]){
cube([3,3,2]);
}
//crystal
translate([7,1,1]){
cube([8,3,3]);
}
//pins
translate([0,3,-3]){
NRFpins();
}
}
/////////////////////////////////////////////////////////    nRfpins
module NRFpins(){
translate([1,3,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([1,5.5,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([1,8,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([1,10.5,-1]){////////////////////////////
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([3.5,3,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([3.5,5.5,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([3.5,8,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([3.5,10.5,-1]){//////////////////////////////
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
}
////////////////////////////////////////////////////////////////   NANO
module Nano(){
//circuit board
translate([0,0,0]){
cube([43,18,2]);
}
translate([1,0,0]){
nanopins();
}
translate([1,16,0]){
nanopins();
}
translate([38.5,3.5,0]){
SPI_pins();
}
//USB port
translate([-1,6.5,2]){
cube([5,5,3]);
}
//MCU
translate([14,4,2]){
rotate([0,0,45])
cube([7,7,1]);
}
//resset button
translate([23,6.5,2]){
cube([3,5,3]);
}
translate([23.5,7,3.5]){
cube([2,4,2]);
}
}
/////////////////////////////////////////////////////////   SPI_pins
module SPI_pins(){
translate([1,3,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([1,5.5,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([1,8,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([3.5,3,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([3.5,5.5,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([3.5,8,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
}
//////////////////////////////////////////////////////////   nanopins
module nanopins(){
translate([3,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([5.5,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([8,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([10.5,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([13,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([15.5,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([18,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([20.5,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([23,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([25.5,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([28,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([30.5,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([33,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([35.5,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([38,1,-1]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
}
////////////////////////////////////////////////////////    joystick
module Joy_Stick(){
translate([0,0,0]){
base();
}
translate([13.5,17,10]){
top();
}
}
module top(){
difference(){
translate([0,0,0]){
rotate([0,0,0])
sphere(r=15);
}
translate([-20,-20,-15]){
cube([40,40,20]);
}
}
translate([0,0,14]){
rotate([0,0,0])
cylinder(r=3, 4, $fn=9);
}
translate([0,0,-6]){
knob();
}
}
module knob(){
difference(){
translate([0,0,20]){
rotate([0,0,0])
sphere(r=10);
}
translate([-15,-15,-16]){
cube([40,40,40]);
}
}
}
module base(){
//circuit board
difference(){
translate([0,0,0]){
cube([27,34,2]);
}
translate([3.5,2.5,-1]){
rotate([0,0,0])
cylinder(r=1.5, 4, $fn=9);
}
translate([23.5,2.5,-1]){
rotate([0,0,0])
cylinder(r=1.5, 4, $fn=9);
}
translate([3.5,30,-1]){
rotate([0,0,0])
cylinder(r=1.5, 4, $fn=9);
}
translate([23.5,30,-1]){
rotate([0,0,0])
cylinder(r=1.5, 4, $fn=9);
}
}
//2axis potentiometer
translate([5.5,9,2]){
cube([16,16,13]);
}
//Z button
translate([0,13.5,2]){
cube([11,7,3]);
}
translate([1,14.5,5]){
cube([6,5,2]);
}
translate([3.5,17,7]){
rotate([0,0,0])
cylinder(r=2, 1, $fn=30);
}
//button post
translate([2,17,9.5]){
rotate([90,0,90])
cylinder(r=1.5, 5, $fn=30);
}
//Xpot
difference(){
translate([8,7,2.5]){
cube([11,2,12]);
}
translate([12.5,7,7]){
cube([2,2,4]);
}
}
//Ypot
difference(){
translate([21.5,11.5,2.5]){
cube([2,11,12]);
}
translate([21.5,16,7]){
cube([2,2,4]);
}
}
translate([7.5,32,2]){
connector_pins();
}
//joyxpins
module connector_pins(){
translate([0,0,-3]){
Pins();
}
translate([3,0,-3]){
Pins();
}
translate([6,0,-3]){
Pins();
}
translate([9,0,-3]){
Pins();
}
translate([12,0,-3]){
Pins();
}
}
//joyxpins
module Pins(){
translate([0,0,0]){
rotate([0,0,0])
cylinder(r=0.5, 7, $fn=9);
}
translate([0,7.75,7]){
rotate([90,0,0])
cylinder(r=0.5, 8, $fn=9);
}
}
}