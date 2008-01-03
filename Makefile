thesis:
	pdflatex thesis
	latex_count=3 ; \
	while egrep -is '(rerun|undefined references)' thesis.log \
		&& [ $$latex_count -gt 0 ] ;\
	do \
		echo "Rerunning latex..." ;\
		pdflatex thesis ;\
		latex_count=`expr $$latex_count - 1` ;\
	 done

bib:
	bibtex thesis
	pdflatex thesis
	latex_count=3 ; \
	while egrep -is '(rerun|undefined references)' thesis.log \
	then \
		echo "Rerunning latex..." ;\
		pdflatex thesis ;\
		latex_count=`expr $$latex_count - 1` ;\
	fi

index:
	makeindex thesis
	pdflatex thesis
	latex_count=3 ; \
	while egrep -is '(rerun|undefined references)' thesis.log \
	then \
		echo "Rerunning latex..." ;\
		pdflatex thesis ;\
		latex_count=`expr $$latex_count - 1` ;\
	fi

clean:
	for file in `ls thesis.{aux,bbl,blg,brf,idx,ilg,lof,log,lol,lot,out} 2>/dev/null`; \
		do rm $$file; \
	done

open:
	open thesis.pdf
