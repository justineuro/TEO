#!/bin/bash
###
# Filename: makeEoHtml-tab-R.sh  
# Description: Bash script for generating, in Rmarkdown format, phrases, 
# and translations for Esperanto exercises.  Input from CSV file;  
# delimeters should be double-quotes (").
#
# Usage: ./makeEoHtml-tab-R.sh <filename.csv>
# 	where <filename.csv> is the CSV file created containing phrases
#		with translations; output filename is <filename-tab.Rmd>
#
# Created:	11.06.2018 18:58:25
# Revised:	
### 
#----------------------------------------------------------------------------------
# create output file Rmd; temporary auxilliary file
# if output file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
filen="${1/.csv/}-tab.Rmd"
filea="${1/csv/}axl"
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi

#----------------------------------------------------------------------------------
# create cat-to-output-file function
#----------------------------------------------------------------------------------
catToFile(){
	cat >> $filen << EOT
$1
EOT
}

ind=0
while read lN
do
#echo ${lN[*]}
echo "lNs=(${lN[*]})" > $filea 
source ./$filea
#echo ${lNs[1]}

if [ "$ind" == "0" ]; then 
catToFile "---
title: \"\" #\"${filen/.Rmd/}\"
author: \"\" #\"JLAUro\"
date: \"\" #\"June 7, 2018\"
output: 
  html_document:
    #css: bootstrap/bootstrap-cerulean-grn99.min.css
    #javascript: js/hideshow.js
    #theme: cerulean
    highlight: tango
    #toc: true
    #toc_float: 
    #  collapsed: false
    #mathjax: \"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML\"
    #mathjax: \"file:///sdcard//MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML\"
---

\`\`\`{r setup, include=FALSE}
knitr::opts_chunk\$set(echo = TRUE)
\`\`\`

<style>
a, body { 
color: #005500; 
font-size: 12px; 
}	

a:visited { color: #009900; }

[id^='tr'] {
display: none;
}

mark {
padding: 3px 3px;
text-align: left;
font-style: italic;
font-size: 10px;
background-color: #007700;
color: white;
margin-top: 0px;
margin-left: 5px;
}

</style>

<script type='text/javascript'>
function toggle_visibility(id) {
var e = document.getElementById(id);
e.style.display = ((e.style.display!='block') ? 'block' : 'none');
}
</script>

<br/><br/>

<p>
<h4>${lNs[0]} - ${lNs[1]} <br/></h4>
<a id='r0' href='#' onclick=\"toggle_visibility('tr0');\">
Click for Instructions.</a>
<div id='tr0'>
&nbsp;
<mark>Click on each link to toggle the English translation.  Reload page to turn off all translations.</mark>
</div>
</p>

<table width='100%' border='5px' cellspacing='5px' cellpadding='5px'>
<tr id='r1'>"
rowN=1
rowl1=0
ind=$((ind + 1))
continue
fi

if [ "$((ind % 4))" != "0" ]; then
catToFile "<td align='center' valign='middle'><a id='item${ind}' href='#r${rowl1}' onclick=\"toggle_visibility('tr${ind}');\">${lNs[0]}</a>
<div id='tr${ind}'><mark>${lNs[1]}</mark></div></td>
"
else
catToFile "<td align='center' valign='middle'><a id='item${ind}' href='#r${rowl1}' onclick=\"toggle_visibility('tr${ind}');\">${lNs[0]}</a>
<div id='tr${ind}'><mark>${lNs[1]}</mark></div></td>
</tr>
<tr id='r$[rowN+1]'>
"
rowl1=${rowN}
rowN=$((rowN + 1))
fi
ind=$((ind + 1))
done < $1

catToFile "</tr>
</table>
"
rm ./$filea
#
##
###
