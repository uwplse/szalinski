scads=$(shell find inputs/ -type f -name "*.scad")
csgs=$(scads:inputs/%.scad=out/csgs/%.csg)
csexps=$(scads:inputs/%.scad=out/csexps/%.csexp)

.PHONY: all compile-csgs compile-csexps

all: compile-csexps
compile-csgs: $(csgs)
compile-csexps: $(csexps)

print-%:
	@echo '$*=$($*)'

out/csgs/%.csg: inputs/%.scad
	@mkdir -p $(dir $@)
	openscad -o $@ $<

out/csexps/%.csexp: out/csgs/%.csg ./target/debug/parse-csg
	@mkdir -p $(dir $@)
	./target/debug/parse-csg $< $@

./target/debug/parse-csg: src/bin/parse-csg.rs
	cargo build
