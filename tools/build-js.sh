#!/bin/bash

IN=()
OUT=""

function build_js {
	echo ""
	echo "output : ${OUT}"
	echo ""

	rm -f ${OUT}

	for i in "${IN[@]}"; do
		echo "merging [$i]"
		cat $i >> ${OUT}
		echo -e "\n" >> ${OUT}
	done
}

#
# index: extjs + jquery + k3pl
#
function build_index_all_js {
	IN=(
		"../extjs/adapter/ext/ext-base.js"
		"../extjs/ext-all.js"
		"../extjs/ux/carousel/carousel.js"
		"../js/jquery-1.9.1.min.js"
	)

	OUT="../js/index-all.js"

	build_js
}

#
# highcharts
#
function build_highcharts_js {
	IN=(
		"../extjs/adapter/highcharts/extjs-highcharts-adapter.js"
		"../highcharts/highcharts.js"
		"../highcharts/modules/exporting.js"
		"../extjs/ux/HighChart.js"
	)

	OUT="../highcharts/highcharts-all.js"

	build_js
}

#
# extjs
#
function build_extjs_all_js {
	IN=(
		"../extjs/adapter/ext/ext-base.js"
		"../extjs/ext-all.js"
		"../extjs/ux/RowEditor.js"
		"../extjs/ux/Spinner.js"
		"../extjs/ux/SpinnerField.js"
		"../extjs/ux/GridSummary.js"
		"../extjs/ux/GroupSummary.js"
		"../extjs/ux/ColumnHeaderGroup.js"
		"../extjs/ux/LockingGridView.js"
		"../extjs/ux/PagingStore.js"
		"../extjs/ux/data_drop_plugin/Override.js"
		"../extjs/ux/data_drop_plugin/Ext.ux.DataDrop.js"
		"../extjs/ux/ext_ux_exporter/Exporter-all.js"
		"../extjs/ux/gridfilters/menu/RangeMenu.js"
		"../extjs/ux/gridfilters/menu/ListMenu.js"
		"../extjs/ux/gridfilters/GridFilters.js"
		"../extjs/ux/gridfilters/filter/Filter.js"
		"../extjs/ux/gridfilters/filter/StringFilter.js"
		"../extjs/ux/gridfilters/filter/DateFilter.js"
		"../extjs/ux/gridfilters/filter/ListFilter.js"
		"../extjs/ux/gridfilters/filter/NumericFilter.js"
		"../extjs/ux/gridfilters/filter/BooleanFilter.js"
	)

	OUT="../extjs/extjs-ux-all.js"

	build_js
}

case $1 in
	all)	build_index_all_js
		build_highcharts_js
		build_extjs_all_js
		;;
	index)
		build_index_all_js
		;;
	highcharts)
		build_highcharts_js
		;;
	extjs)
		build_extjs
		;;
esac
