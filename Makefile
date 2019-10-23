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

out/%.diff: scripts/check_diff.py out/compare_mesh out/%.in.off out/%.opt.off
	out/compare_mesh out/$*.in.off out/$*.opt.off $@ 1000 0.01

out/%.checked: inputs/%.expected out/%
	$(diff) inputs/$*.expected out/$*
	touch $@

out/case-studies/report: $(filter out/case-studies/%, $(jsons))
	./scripts/report.py $^

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release

out/compare_mesh: scripts/compare_mesh.cpp
	$(CC_WITH_FLAGS) $< -O2 -o $@
