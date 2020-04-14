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
  - Reproducing Table 2 (takes < 5 minutes)
  - Reproducing Figure 14 (takes approx. 1.5 hour)
  - Reproducing Figure 15 (takes < 5 minutes)
  - Validation

* Reusability
  - How to set up Szalinski on a different machine (this is also how
  we set up the VM)
  - How to modify the code

* Notes and remarks

## System requirements

* We provide the artifact as a virtual machine image. To open it you need
  virtual box version `6.1.2`, which can be downloaded
  [here](https://www.virtualbox.org/wiki/Downloads).

* Specs of the machine where we ran the VM:
  Intel i7-8700K (12 threads @ 4.7GHz), 32GiB RAM

## Getting started

* Please download the `.ova` file from the link and open it with Virtual Box by
  going to `File -> import appliance` and giving the path to the `.ova` file
  and clicking on `continue`. In the next window that pops up, click on
  `Import`. It should take a few minutes to import.

**NOTE:** When you import the `.ova` file, we recommend that you
increase the CPU count as much as you can afford.
Similarly, when running `make`, we recommend adding
`make -jN` where `N` is the number of CPUs you allocated to the VM.

* Next, please open the virtual machine image in virtual box by clicking on the
  green `Start` button.

* Login is automatic, but in case needed, the password is: `pldi2020`.

* The terminal should be open at startup. The project repository is already
  cloned.  Navigate to the `szalinski` directory.  All the required packages
  are already installed and Szalinki is already compiled for you, ready to be
  run.

* To allow a quick verification of our artifact, we provided pre-generated data and
results in the VM. You can therefore skip the `make` commands in the instructions
and directly view the results (see below on how to do that).

* As a next step, you can verify that the results are indeed
generated from the data we provided. To do so, delete the
results (`out/aec-table2/table2.csv`, `out/fig14.pdf`) and run the `make`
commands as explained below.

* To run the tool yourself entirely from scratch,
first delete the entire `out` directory and follow the instructions below.

## Running the tools

### Reproducing Table 2
Navigate to the directory that contains the `Makefile` and
type `make out/aec-table2/table2.csv`.
This should take about 3 minutes.
This will reproduce `Table 2` from the paper.
To view the content of the table, type
`cat out/aec-table2/table2.csv | column -t -s,` and compare the numbers
with `Table 2` in the paper.

**NOTE:**
- We have significantly improved Szalinski since the PLDI deadline.
As a result, for several case studies, the numbers in the last three
columns of the table are lower (hence better in this case) than what is
reported in the paper.
- We suspect that different versions of OpenSCAD use
different triangulation algorithms for compiling to mesh.
The version supported by Ubuntu 19.10 (the VM) is different from the
version we used during the deadline because we ran it on a MacOS.
Due to this, the numbers in the `#Tri` column may vary in this artifact.

### Reproducing Figure 14

We have included in the repo the 2,127 examples from Thingiverse that
we evaluated on in the paper.
The remainder of the 12,939 scraped from Thingiverse were either
malformed or used features not supported by Szalinski.
The script (`scripts/scrape-thingiverse.sh`) scrapes models under the
`customizable` category, from the first 500 pages.

*NOTE:* Running this part takes about an hour.
We recommend first reproducing `Figure 15` and
`Table 2`, both of which take much less time.

Navigate to the directory that contains the `Makefile` and type
`make out/fig14.pdf`. Open the generated file in a pdf viewer and
compare with `Figure 14` in the paper.


### Reproducing Figure 15 programs
Navigate to the directory that contains the `Makefile` and
type `make aec-fig15`. This should take less than a minute.
Then look in the `out/aec-fig15` directory. The
optimized programs generated by Szalinski are in the files with extensions
`normal.csexp.opt`. There should be 6 such files. Open them and compare the
content with the programs listed in `Figure 15` of the paper.

**NOTE:**
- The programs in the paper are sugared and represented more
compactly for space.
- `MapI` found in the artifact results corresponds
to `Tabulate` in the paper.
- When comparing the results generated by the artifact
to the programs in `Figure 15` of the paper, it is most important to check
that the high-level structure in terms of `Fold` and `MapI`
synthesized by the artifact matches that reported in the paper.

### Validation

`Section 6` of our paper describes Szalinski's validation process.
We use OpenSCAD to compile CSG programs to meshes and use CGAL to compute
the Hausdorff distance between two meshes.

To validate the programs in `Figure 15`,
run `make out/aec-fig15/hausdorff`. This should terminate in less than 3
minutes. It should show you the names of the 6 examples in `Figure 15` and the
corresponding Hausdorff distances which are close to zero.

We have also validated all our other results reported in the paper.
However, our experience indicates that OpenSCAD's compilation
step is often very slow. Therefore, the other commands
mentioned in the instruction for reproducing the results
do not perform validation by default.

You can validate any example from our evaluation by typing:
 `make out/dir_name/example_name.normal.diff`, where
`dir_name` can be `aec-table2`, `aec_fig15` or `thingiverse`, and
`example_name` is the name of whatever example you choose.
Then open the generated `.diff` file and check
that the Hausdorff distance is within some epsilon of 0.

**NOTE:** For many example, CGAL crashes or is slow at computing the Hausdorff distance.
For these, we recommend a manual validation if you are interested.
In order to validate an example, type the following:
`make out/dir_name/example_name.diff.scad`. You can open the generated `.scad`
file in OpenSCAD (already installed in the VM). In OpenSCAD, click on the
`Render` button (the second button from the right) in the toolbar.
You should either see nothing rendered or some residual thin walls that are
artifacts of rounding error prevalent in OpenSCAD.

## Reproducibility

Here we provide instructions on how to start using Szalinski including
installation and changing the rules and features of the Caddy language.

### Setup instructions

Following are the steps for setting up Szalinski
from scratch on a different machine that runs Ubuntu 19.10.

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

* Install [OpenSCAD](https://www.openscad.org/) by typing
  `sudo apt-get install openscad`

* Install git by typing `sudo apt install git`

* Install pip by typing `sudo apt install python3-pip` and then
install `numpy` by typing `pip3 install numpy` and `matplotlib` by typing
`pip3 install matplotlib`

* We have made a [github release](https://github.com/uwplse/szalinski/tree/pldi2020-aec)
for the PLDI AEC from where you can get the source.

* Navigate to the project directory where the `Makefile` is
and run the tool as described above.

### Changing Caddy and modifying the rules

* The Caddy language is defined in `cad.rs` in the `src` directory.
A simple feature you can add is support for a new primitive or new
transformations. You can also change the costs of various language
constructs. The definition of the `cost` function starts at line `267`.

* As we described in the paper, to verify the correctness of Szalinski,
we evaluate Caddy programs to flat Core Caddy and pretty print to CSG. This
code is in `eval.rs`.

* `solve.rs` and `permute.rs` contains code that solves for first and second
degree polynomials in Cartesian and Spherical coordinates, and performs
partitioning and permutations of lists.

* The rewrites rules are in `rules.rs`. Syntactic rewrites are
written using the `rw!` macro. Each rewrite as a name, a left hand side,
and a right hand side. You can add / remove rules to see how that affects
the final Caddy output of Szalinski. For example, if you comment out the
rules for inverse transformations, they will not be propagated and
eliminated, and therefore the quality of Szalinski's output will not be
as good.

## Notes and remarks

Szalinski is implemented in [Rust](https://www.rust-lang.org/).
As mentioned in `Section 6` of the paper,
it uses [OpenSCAD](https://www.openscad.org/)
to compile CSG programs to triangular meshes, and
[CGAL](https://www.cgal.org/) to compute the
Hausdorff distance between two meshes.
