// Author: Tiago Charters de Azevedo 
// Maintainer: Tiago Charters de Azevedo 

// Copyright (c) - 2014 Tiago Charters de Azevedo

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3, or (at your option)
// any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor,
// Boston, MA 02110-1301, USA.

// Commentary:
// https://en.wikipedia.org/wiki/Torus_knot

// Usage:  see below.

// Returns the i-the  N linearly spaced elements between XMIN and XMAX.
// The endpoints are always included in the range.
function linspace(xmin,xmax,n,i)=xmin+i*(xmax-xmin)/n;

// Converts from rads to degs.
function deg(x)=180*x/3.141592653589793;

// Torus knots (P,Q)

p=2;//[2:40]
q=5;//[2:40]
radius=50;//[10:100]
thickness=25;//[1:100]
number_of_segments=100;//[100:1000]

torus="No";// [Yes,No]

value_of_fa=12;//[3,6,12]
$fa=value_of_fa;

function r(t)=2+cos(q*deg(t));
function coordinates(t)=radius*[r(t)*cos(p*deg(t)),
    r(t)*sin(p*deg(t)),
    -sin(q*deg(t))];
function varradius(t)=thickness;


// Main module:
// tmin = inicial parameter value
// tmax = end parameter value
// n = number of segments (spheres used)


module knot(tmin=0,tmax=2*3.1415926,n=20){
    for (i=[0:n-1]){
	hull(){
 	    translate(coordinates(linspace(tmin,tmax,n,i))){
 		sphere(r=varradius(linspace(tmin,tmax,n,i)));}
	    translate(coordinates(linspace(tmin,tmax,n,i+1))){
		sphere(r=varradius(linspace(tmin,tmax,n,i+1)));}}}}

		    

//--------------------------------------------------------------------------------


// Make Knot! Have fun.

if(torus=="Yes"){
    rotate_extrude(convexity = 10){
	translate([2*radius, 0, 0]){
	    circle(r= radius); }}
    knot(tmin=0,tmax=2*3.1415926,n=number_of_segments);}
else{
    knot(tmin=0,tmax=2*3.1415926,n=number_of_segments);}


