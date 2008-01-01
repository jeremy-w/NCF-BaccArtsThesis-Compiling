thesis:
	pdflatex thesis
	latex_count=5 ; \
	while grep -is 'rerun' thesis.log \
		&& [ $$latex_count -gt 0 ] ;\
	do \
		echo "Rerunning latex..." ;\
		pdflatex thesis ;\
		latex_count=`expr $$latex_count - 1` ;\
	 done

bib:
	bibtex thesis
	pdflatex thesis
	if egrep -s 'Rerun (LaTeX|to get cross-references right)' thesis.log \
	then \
		echo "Rerunning latex..." ;\
		pdflatex thesis ;\
	fi

index:
	makeindex thesis
	pdflatex thesis
	if egrep -s 'Rerun (LaTeX|to get cross-references right)' thesis.log \
	then \
		echo "Rerunning latex..." ;\
		pdflatex thesis ;\
	fi

clean:
	for file in `ls thesis.{aux,bbl,blg,brf,idx,ilg,lof,log,lol,lot,out} 2>/dev/null`; \
		do rm $$file; \
	done
