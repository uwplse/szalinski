CC_WITH_FLAGS ?= g++ -lCGAL -lgmp -lmpfr

tgt=target/release
diff=git --no-pager diff --no-index --word-diff=color --ignore-space-at-eol

rust-src=$(shell find src/ -type f)

scads=$(shell find inputs -type f -name "*.scad")
csgs=$(scads:inputs/%.scad=out/%.csg)
csexps=$(scads:inputs/%.scad=out/%.csexp)
jsons=$(scads:inputs/%.scad=out/%.json)
diffs=$(scads:inputs/%.scad=out/%.diff)

expected=$(shell find inputs -type f -name "*.expected")
checked=$(expected:inputs/%.expected=out/%.checked)

everything=$(diffs)


.PHONY: all compile-csgs compile-csexps case-studies checked unit-tests

all: $(everything)

jsons: $(jsons)
diffs: $(diffs)
compile-csgs: $(csgs)
compile-csexps: $(csexps)
checked: $(checked)
in_offs: $(scads:inputs/%.scad=out/%.in.off)

case-studies: $(filter out/case-studies/%, $(everything))
unit-tests: $(filter out/unit-tests/%, $(everything))
inverse-csg: $(filter out/inverse-csg/%, $(everything))

export OPENSCADPATH=.

# don't delete anything in the out directory please, Make
.PRECIOUS: out/%.csg out/%.csexp out/%.json out/%.csexp.opt out/%.opt.scad out/%.in.off out/%.opt.off out/%.checked

print-%:
	@echo '$*=$($*)'

out/%.csg: inputs/%.scad
	@mkdir -p $(dir $@)
	openscad -o $@ $<

out/%.csexp: out/%.csg $(tgt)/parse-csg
	$(tgt)/parse-csg $< $@

out/%.json: out/%.csexp $(tgt)/optimize
	$(tgt)/optimize $< $@

out/%.csexp.opt: out/%.json
	jq -r .final_expr $< > $@

out/%.opt.scad: out/%.json
	jq -r .final_scad $< > $@

out/%.in.off: out/%.csg
	openscad -o $@ $< 2>> out/openscad.log

out/%.opt.off: out/%.opt.scad out/%.csexp.opt
	openscad -o $@ $< 2>> out/openscad.log

out/%.diff: scripts/compare_mesh.sh out/compare_mesh out/%.in.off out/%.opt.off
	./scripts/compare_mesh.sh out/$*.in.off out/$*.opt.off $@

out/%.checked: inputs/%.expected out/%
	$(diff) inputs/$*.expected out/$*
	touch $@

out/case-studies/report.csv: ./scripts/report.py $(filter out/case-studies/%, $(jsons) $(diffs))
	./scripts/report.py --output $@ $(filter out/case-studies/%, $(jsons))
out/inverse-csg/report.csv: ./scripts/report.py $(filter out/inverse-csg/%, $(jsons) $(diffs))
	./scripts/report.py --output $@ $(filter out/inverse-csg/%, $(jsons))
out/reincarnate/report.csv: ./scripts/report.py $(filter out/reincarnate/%, $(jsons) $(diffs))
	./scripts/report.py --output $@ $(filter out/reincarnate/%, $(jsons))
out/reincarnate-new/report.csv: ./scripts/report.py $(filter out/reincarnate-new/%, $(jsons) $(diffs))
	./scripts/report.py --output $@ $(filter out/reincarnate-new/%, $(jsons))
out/latex-drawing/report.csv: ./scripts/report.py $(filter out/latex-drawing/%, $(jsons) $(diffs))
	./scripts/report.py --output $@ $(filter out/latex-drawing/%, $(jsons))
out/thingiverse/report.csv: ./scripts/report.py $(filter out/thingiverse/%, $(jsons) $(diffs))
	./scripts/report.py --output $@ $(filter out/thingiverse/%, $(jsons))
out/report.csv: ./scripts/report.py $(jsons) $(diffs)
	./scripts/report.py --output $@ $(jsons)

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release

out/compare_mesh: scripts/compare_mesh.cpp
	$(CC_WITH_FLAGS) $< -O2 -o $@
