PANDOC=pandoc

EXCLUDED_MD = README.md
MD          = $(filter-out $(EXCLUDED_MD), $(shell ls *.md))
DOC_MD      = $(filter-out $(EXCLUDED_MD), $(shell ls *.doc.md))
SLIDE_MD    = $(filter-out $(EXCLUDED_MD), $(shell ls *.slide.md))

SLIDE       = $(SLIDE_MD:.slide.md=.slide.pdf) 
DOC         = $(DOC_MD:.doc.md=.doc.pdf) 
BACKUP      = $(MD:.md=.md.bak~)
HEADERS     = beamer_header.tex doc_header.tex

all: $(SLIDE) $(DOC) 

#my_header.tex 


%.md.bak~: %.md
	cp $< $@

%.slide.pdf: %.slide.md
	pandoc $(notdir $<)  -o $@ \
		--latex-engine=lualatex \
		-t beamer \
		-V theme:Madrid \
		-V colortheme:dolphin \
		--listings --mathjax --jsmath \
		-H beamer_header.tex 

%.doc.pdf: %.doc.md
	pandoc $(notdir $<)  -o $@ \
		--latex-engine=lualatex \
		--listings --mathjax --jsmath  \
		-H doc_header.tex 

%.tex:
	wget https://github.com/tachi-hi/my_pandoc_beamer_template/raw/master/$<

clean:
	rm $(SLIDE) $(DOC)
