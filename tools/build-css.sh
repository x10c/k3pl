#!/bin/bash

function build_css {
	CFG=$1
	IN=$2
	OUT=$3

	echo ""
	echo "config = ${CFG}"
	echo "input  = ${IN}"
	echo "output = ${OUT}"
	echo ""

	rm -f ${IN};
	rm -f ${OUT};

	cat ${CFG} | while read cssfile cssimage; do
		echo "[${cssfile}]  in  [${cssimage}]";
		cat ${cssfile} | sed "s,\.\.,${cssimage}," >> ${IN};
	done;

	mv ${IN} ${OUT}

	#csstidy ${MAIN_IN} \
	#--discard_invalid_properties=false \
	#--preserve_css=true \
	#--sort_properties=true \
	#--optimise_shorthands=2 \
	#--case_properties=2 \
	#--merge_selectors=2 \
	#${MAIN_OUT}
}

MAIN_CFG=module-main-css
MAIN_IN=module-main-css.all
MAIN_OUT=../css/main.css

INDEX_CFG=index-css
INDEX_IN=index.css
INDEX_OUT=../css/index.css

build_css ${MAIN_CFG} ${MAIN_IN} ${MAIN_OUT}
build_css ${INDEX_CFG} ${INDEX_IN} ${INDEX_OUT}
