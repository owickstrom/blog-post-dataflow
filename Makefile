.PHONY: all
all: my-diagram.png my-diagram-times.png my-diagram-seq.png my-diagram.json

my-diagram.png: my-diagram.flow
	dataflow dfd $< | dot -Tpng -o $@

my-diagram-times.png: my-diagram.flow
	dataflow dfd $< | dot \
		-Tpng \
		-Gfontname="Times" \
		-Nfontname="Times" \
		-Efontname="Times" \
		-o $@

my-diagram-seq.png: my-diagram.flow
	dataflow seq $< | java \
		-Djava.awt.headless=true \
		-jar plantuml.jar \
		-tpng \
		-pipe > $@

my-diagram.json: my-diagram.flow
	dataflow json $< > $@

.PHONY: watch
watch:
	grip post.md
