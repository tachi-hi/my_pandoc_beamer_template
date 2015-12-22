PANDOC=pandoc

EXCLUDED_MD=README.md
MD=$(filter-out $(EXCLUDED_MD), $(shell ls *.md))
TARGET=$(MD:.md=.pdf) 

all: my_header.tex $(TARGET) 


%.pdf: %.md
	pandoc $(notdir $<)  -o $@ \
		--latex-engine=lualatex \
		-t beamer \
		-V theme:Madrid \
		-V colortheme:dolphin \
		--listings --mathjax --jsmath \
		-H my_header.tex

my_header.tex:
	wget https://github.com/tachi-hi/my_pandoc_beamer_template/raw/master/my_header.tex

clean:
	rm -$(TARGET)


