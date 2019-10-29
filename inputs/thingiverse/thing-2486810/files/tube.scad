//A simple tube designed to connect the head of the massager to the
//Handle.

//Designed to be printed in TPU or another flexible material

thickness = 2;
length =  70;
id = 15;
$fn = 50;

difference(){

    cylinder(h = length, d = id + 2 * thickness);
    cylinder(h = length, d = id);

}