tgt=target/release
diff=git --no-pager diff --no-index --word-diff=color --ignore-space-at-eol

rust-src=$(shell find src/ -type f)

scads=$(shell find inputs/ -type f -name "*.scad")
csgs=$(scads:inputs/%.scad=out/%.csg)
csexps=$(scads:inputs/%.scad=out/%.csexp)
jsons=$(scads:inputs/%.scad=out/%.json)

case-studies-scads=$(shell find inputs/case-studies -type f -name "*.scad")
unit-tests-scads=$(shell find inputs/unit-tests -type f -name "*.scad")

expected=$(shell find inputs/ -type f -name "*.expected")
checked=$(expected:inputs/%.expected=out/%.checked)

.PHONY: all compile-csgs compile-csexps case-studies checked unit-tests

all: compile-csexps

jsons: $(jsons)
compile-csgs: $(csgs)
compile-csexps: $(csexps)
case-studies: $(case-studies-scads:inputs/%.scad=out/%.json)
unit-tests: $(unit-tests-scads:inputs/%.scad=out/%.json)
checked: $(checked)

print-%:
	@echo '$*=$($*)'

out/%.csg: inputs/%.scad
	@mkdir -p $(dir $@)
	openscad -o $@ $<

out/%.csexp: out/%.csg $(tgt)/parse-csg
	$(tgt)/parse-csg $< $@

out/%.json out/%.csexp.opt: out/%.csexp $(tgt)/optimize
	$(tgt)/optimize $< out/$*.json
	jq -r .best out/$*.json > out/$*.csexp.opt

out/%.checked: inputs/%.expected out/%
	$(diff) inputs/$*.expected out/$*
	touch $@

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release
