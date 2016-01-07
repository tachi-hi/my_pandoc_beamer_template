PANDOC=pandoc

EXCLUDED_MD=README.md
MD=$(filter-out $(EXCLUDED_MD), $(shell ls *.md))
SLIDE=$(MD:.md=.slide.pdf) 
DOC=$(MD:.md=.doc.pdf) 
HEADERS=beamer_header.tex doc_header.tex

all: $(SLIDE) $(DOC) 

#my_header.tex 


%.slide.pdf: %.md
	pandoc $(notdir $<)  -o $@ \
		--latex-engine=lualatex \
		-t beamer \
		-V theme:Madrid \
		-V colortheme:dolphin \
		--listings --mathjax --jsmath \
		-H beamer_header.tex &

%.doc.pdf: %.md
	pandoc $(notdir $<)  -o $@ \
		--latex-engine=lualatex \
		--listings --mathjax --jsmath  \
		-H doc_header.tex &

%.tex:
	wget https://github.com/tachi-hi/my_pandoc_beamer_template/raw/master/$<

clean:
	rm -$(TARGET)


