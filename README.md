# PLDI 2020 AEC, Paper\# 471

NOTE: In the rest of this document, we refer to our tool as `Szalinski`.
In our submission, we called it `Albatross` for anonymity.

## Goals of the artifact

In our paper, we evaluated the following about Szalinski (`Section 7`):

1. End-to-End: we ran Szalinski on the flat CSG outputs of a mesh decompiler
   (Reincarnate). The results are in `Table 2`.

2. Scalability: we evaluated Szalinski on a large dataset of models scraped
   from a popular online repository (Thingiverse). The results are in `Figure
   14` (first three box plots).

3. Sensitivity: we evaluated the usefulness of Szalinski's two main features:
   CAD rewrites and Inverse Transformations. The results are in `Figure 14`
   (last two box plots).

In support of these results, this artifact reproduces `Table 2` and `Figure
14`. In addition, it also generates the output programs in `Figure 15` that are
used in the case studies.


This document contains the following parts:

* System requirements

* Getting started

* How to run Szalinski
  - Reproducing Table 2
  - Reproducing Figure 14
  - Reproducing Figure 15
  - Validation

* How to set up Szalinski on a different machine (this is also how we set up
  the VM)

* Notes and remarks

## System requirements

* We provide the artifact as a virtual machine image. To open it you need
  virtual box version `6.1.2`, which can be downloaded
  [here](https://www.virtualbox.org/wiki/Downloads).

* In the machine where we tested the VM, we have 16 GB RAM and 250 GB hard
  disk.

## Getting started

* Please download the `.ova` file from the link and open it with Virtual Box by
  going to `File -> import appliance` and giving the path to the `.ova` file
  and clicking on `continue`. In the next window that pops up, click on
  `Import`. It should take a few minutes to import.

* Next, please open the virtual machine image in virtual box by clicking on the
  green `Start` button.

* Login is automatic, but in case needed, the password is: `pldi2020`.

* The terminal should be open at startup. The project repository is already
  cloned.  Navigate to the `albatross` directory.  All the required packages
  are already installed. Type `make`.


## Running the tools

### Reproducing Table 2
Navigate to the directory that contains the `Makefile` and
type `make out/aec-table2/table2.csv`.
This will reproduce `Table 2` from the paper.
To view the content of the table, type
`cat out/aec-table2/table2.csv | column -t -s,` and compare the numbers
with `Table 2` in the paper.

NOTE: Our tool has significantly improved since the PLDI deadline.
As a result, for several case studies, the numbers in the last three
columns of the table are lower (hence better in this case) than what is
reported in the paper.


### Reproducing Figure 14
Navigate to the directory that contains the `Makefile` and type
`make out/fig14.pdf`. Open the generated file in a pdf viewer and
compare with `Figure 14` in the paper.


### Reproducing Figure 15 programs
Navigate to the directory that contains the `Makefile` and
type `make aec-fig15`. Then look in the `out/aec-fig15` directory. The
optimized programs generated by Szalinski are in the files with extensions
`normal.csexp.opt`. There should be 6 such files. Open them and compare the
content with the programs listed in `Figure 15` of the paper.

NOTE: The programs in the paper are sugared and represented more
compactly for space. Further, `MapI` found the artifact results corresponds
to `Tabulate` in the paper.
When comparing the results generated by the artifact
to the programs in `Figure 15` of the paper, it is most important to check
that the high-level structure in terms of `Fold` and `MapI`
synthesized by the artifact matches that reported in the paper.

### Validation

`Section 6` of our paper describes Szalinski's validation process.
We use OpenSCAD to compile CSG programs to meshes and use CGAL to compute
the Hausdorff distance between two meshes.
We validated all our results reported in the paper.
Our experience indicates that OpenSCAD's compilation
step is often very slow. Therefore, the commands
mentioned in the above steps do not perform validation.
We encourage you to validate whichever example you like.
In order validate an example, type the following:
`make out/dir_name/example_name.diff.scad`. You can open the generated `.scad`
file in OpenSCAD (already installed in the VM). In OpenSCAD, click on the
`Render` button (the second button from the right) in the toolbar.
You should either see nothing rendered or some residual thin walls that are
artifacts of rounding error prevalent in OpenSCAD.

## Setup instructions (for setting up Szalinski on a different machine that runs Ubuntu 18.04.4 LTS)

* Install rust. Type `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
  in the terminal and follow the subsequent instructions. The version we used is `1.41.0`.
  See`https://www.rust-lang.org/tools/install` for more information.

* Make sure you configure your current shell by typing: `source $HOME/.cargo/env`
  (the Rust installation will prompt you to do this).

* Install make by typing: `sudo apt-get install make`

* Install g++ by typing: `sudo apt-get install g++`

* Install jq by typing: `sudo apt-get install jq`
 
* Install [CGAL](https://www.cgal.org/download/linux.html) by typing
  `sudo apt-get install libcgal-dev`

* Install [OpenSCAD](https://www.openscad.org/).
We followed the instructions [here](http://ubuntuhandbook.org/index.php/2019/01/install-openscad-ubuntu-18-10-18-04/).
In short: the following steps should suffice:
```
$ sudo add-apt-repository ppa:openscad/releases
$ sudo apt-get update
$ sudo apt-get install openscad
```

* Clone the repo [here](TODO AEC REPO)

* Navigate to the project directory where the `Makefile` is, and type `make` to build it.

## Notes and remarks

Szalinski is implemented in [Rust](https://www.rust-lang.org/).
As mentioned in `Section 6` of the paper,
it uses [OpenSCAD](https://www.openscad.org/)
to compile CSG programs to triangular meshes, and
[CGAL](https://www.cgal.org/) to compute the
Hausdorff distance between two meshes.

