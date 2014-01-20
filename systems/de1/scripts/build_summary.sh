#!/bin/bash

FITTER_REPORT_START=$(cat ${BUILD_ROOT}/bld-quartus/de1.fit.rpt | grep -nr "; Fitter Summary" | gawk '{print $1}' FS=":")
FITTER_REPORT_END=$(cat ${BUILD_ROOT}/bld-quartus/de1.fit.rpt | grep -nr "; Fitter Settings" | gawk '{print $1}' FS=":")

FITTER_REPORT_START=$(($FITTER_REPORT_START - 1))
FITTER_REPORT_END=$(($FITTER_REPORT_END - 4))

echo -e "\033[31m" 
sed -n ${FITTER_REPORT_START},${FITTER_REPORT_END}p ${BUILD_ROOT}/bld-quartus/de1.fit.rpt


FMAX_REPORT_START=$(cat ${BUILD_ROOT}/bld-quartus/de1.sta.rpt | grep -nr "; Slow Model Fmax Summary" | gawk '{print $1}' FS=":")
FMAX_REPORT_END=$(cat ${BUILD_ROOT}/bld-quartus/de1.sta.rpt | grep -nr "This panel reports FMAX" | gawk '{print $1}' FS=":")

FMAX_REPORT_START=$(($FMAX_REPORT_START - 1))
FMAX_REPORT_END=$(($FMAX_REPORT_END - 1))

echo
sed -n ${FMAX_REPORT_START},${FMAX_REPORT_END}p ${BUILD_ROOT}/bld-quartus/de1.sta.rpt
echo -e "\033[0m" 
