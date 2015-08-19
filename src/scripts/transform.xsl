<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html>
<head></head>
<body>
<h2>Test Results</h2>

<table id="result_table" style="display:none" class="sortable" cellpadding="2" cellspacing="2" border="1">
<thread>
<tr bgcolor="#9acd32">
<th id="test_id" style="text-align:left">Test id</th> 
<th id="test_name" style="text-align:left">Test Name</th> 
<th id="request_url" style="text-align:left">Request URL</th>
<th id="is_pass" style="text-align:left">Is Pass</th>
<th id="elapsed_time" style="text-align:left">Elapsed Time(ms)</th>
<th id="response_code" style="text-align:left">Response Code</th>
<th id="json_path_assertion_name" style="text-align:left">JSON Path Assertion Name</th>
<th id="failure_message" style="text-align:left">Failure Message</th>
</tr>
</thread>
<xsl:for-each select="testResults/httpSample">
<tr>
<td><xsl:value-of select="position()" /></td>
<td><xsl:value-of select="current()/@lb"/></td>
<td><xsl:value-of select="java.net.URL"/></td> 
<td><xsl:value-of select="current()/@s"/></td>
<td><xsl:value-of select="current()/@t"/></td>
<td><xsl:value-of select="current()/@rc"/></td>
<td class="resultName">
<xsl:if test="assertionResult/name">
<ul style="display:none">
<xsl:for-each select="assertionResult">
<li class="name"><xsl:value-of select="name"/></li>
</xsl:for-each>
</ul>
</xsl:if>
</td>
<td class="resultfailureMessage">
<xsl:if test="assertionResult/failureMessage">
<ul style="display:none">
<xsl:for-each select="assertionResult">
<li class="failureMessage"><xsl:value-of select="failureMessage"/></li>
</xsl:for-each>
</ul>
</xsl:if>
</td>
</tr>
</xsl:for-each>
</table>
<script type="text/javascript"><![CDATA[
var failureMessage = document.getElementsByClassName('failureMessage');
var assertionName = document.getElementsByClassName('name');
var elemToDelete = [];
var elemToDelete2 = [];
var asExpectedValue = "As Expected";
var resultName =  document.getElementsByClassName('resultName');
var resultfailureMessage =  document.getElementsByClassName('resultfailureMessage');
var assertion_name = [];
var failure_message = [];


//hideAllUl();
//checkAgainEquals();

var result_table = document.getElementById('result_table');
createResultBtn("resultName");
createResultBtn("resultfailureMessage");
result_table.style.display="block";

checkAgainEquals();

function checkAgainEquals(){
var expectedToBe = "Value expected to be '";
var actualToBe = " but found '";

 var uls = document.getElementsByClassName("resultfailureMessage");

    for (var i = 0; i < uls.length; i++) {
	console.log("row  "+i);
            var failureElements = uls[i].getElementsByTagName("li");
            for (var j = 0; j < failureElements.length; j++) {
			var currentElem = failureElements[j];
			
                var text = currentElem.innerHTML;
				if(text.substring(0,expectedToBe.length)==expectedToBe){
				var expected =text.substring(expectedToBe.length,text.indexOf("',"));
				var actual = text.substring(text.lastIndexOf(actualToBe)+actualToBe.length,text.lastIndexOf("'")); 
				console.log("j  "+j);
				console.log("expected  "+expected);
				console.log("actual  "+actual);
				if(expected.toLowerCase()==actual.toLowerCase()){
				currentElem.innerHTML=asExpectedValue;
				currentElem.className = currentElem.className+"-["+text+"]";
				}
            }else{if(text==""){
			currentElem.innerHTML=asExpectedValue;
			}
			
			}
			}
}

}

function hideAllUl(){
    var uls = document.getElementsByTagName("ul");
    for(var i = 0;i<uls.length;i++){
        uls[i].style.display= "none";
    }
}

function createResultBtn(className) {
    var uls = document.getElementsByClassName(className);

    for (var i = 0; i < uls.length; i++) {
        var input = document.createElement("input");
        input.value = "result";
        input.type = "button";
		 var parent1 = uls[i].parentNode;
		  var tds1 = parent1.getElementsByTagName("td");
		  var status1 = tds1[3].innerHTML;
        input.onclick = function clickOnResult() {
            var parent = this.parentNode.parentNode;
		 var tds = parent.getElementsByTagName("td");
            var testName = tds[1];
            var status = tds[3];
            var assertionNameWrapper = tds[6];
            var failureWrapper = tds[7];
           
            var allassertionNameElements = assertionNameWrapper.getElementsByTagName("li");
            var failureElements = failureWrapper.getElementsByTagName("li");
            var assertions_names = [];
            var results = [];
            for (var i = 0; i < allassertionNameElements.length; i++) {
                var text = allassertionNameElements[i].innerHTML;
                assertions_names.push(text);
            }
            for (var i = 0; i < failureElements.length; i++) {
                var text = failureElements[i].innerHTML;
                results.push(text);
            }
creteHtmlFile(testName,status,assertions_names,results);
        }
		console.log("status--"+status1);
		if(status1=="true"){
		input.style.backgroundColor="#00CC00";
		}else{
		input.style.backgroundColor="#FF0000";
		}
 uls[i].appendChild(input);
    }
}

        function creteHtmlFile(testName,status,assertions_names,results){
            var tab = document.getElementsByClassName("sortable")[0];
            tab.style.display="none";
            var body = document.getElementsByTagName("body")[0];
            var h1 = document.createElement("h1");
            var h2 = document.createElement("h2");
            var table = document.createElement("table");
            table.className ='sortableR';
            table.cellPadding="2";
            table.cellSpacing="2";
            table.border="1";


            var  thead= document.createElement("thead");
            var tr = document.createElement("tr");
            tr.style.backgroundColor= "#33CCFF";
			  var assertion_id = document.createElement("th");
            assertion_id.style.textAlign ="left";
            assertion_id.id="assertion_id";
			
            var status = document.createElement("th");
            status.style.textAlign ="left";
            status.id="status";
            var assertion_name = document.createElement("th");
            assertion_name.style.textAlign ="left";
            assertion_name.id="assertion_name";
            var result = document.createElement("th");
            result.style.textAlign ="left";
            result.id="result";
			assertion_id.innerHTML="ID";
				status.innerHTML="Status";
				assertion_name.innerHTML="Assertion Name";
				result.innerHTML="Results";
				tr.appendChild(assertion_id);
			tr.appendChild(status);
            tr.appendChild(assertion_name);
            tr.appendChild(result);
            thead.appendChild(tr);
            var tbody = document.createElement("tbody");

            for(var i = 0;i<results.length;i++){
                var tr = document.createElement("tr");
				  var assertion_id_resualt = document.createElement("td");
                assertion_id_resualt.id = "assertion_id_"+(i+1);
				 assertion_id_resualt.innerHTML=(i+1);
                var status_resualt = document.createElement("td");
                status_resualt.id = "status_resualt_"+(i+1);
                var assertion_name_result = document.createElement("td");
                assertion_name_result.id = "assertion_name_result"+(i+1);

                var result_result = document.createElement("td");
                result_result.id = "result_result"+(i+1);
				var innerText = results[i];
				console.log("innerText-"+innerText);
                if(innerText==""||innerText==asExpectedValue){
                    result_result.innerHTML=asExpectedValue;
                    status_resualt.innerHTML="true";
					tr.style.backgroundColor="#00CC00";
					}else{
					result_result.innerHTML=innerText;
                    status_resualt.innerHTML="false";
					tr.style.backgroundColor="#FF0000";
					}
                assertion_name_result.innerHTML=assertions_names[i];
				tr.appendChild(assertion_id_resualt);
                tr.appendChild(status_resualt);
                tr.appendChild(assertion_name_result);
                tr.appendChild(result_result);
                tbody.appendChild(tr);
            }
            table.appendChild(thead);
            table.appendChild(tbody);
var btn1 = createBackBtn(tab,table);
var btn2 = createBackBtn(tab,table);
body.appendChild(btn1);
            body.appendChild(table);
			body.appendChild(btn2);
        }
		
		
		function createBackBtn(tab,table){
		var input2 = document.createElement("input");
		 input2.className = "Back_Btn";
        input2.value = "Back";
        input2.type = "button";
        input2.onclick = function() {
			var parent = table.parentNode;
			parent.removeChild(table);
			var btns = document.getElementsByClassName("Back_Btn");
			var size = btns.length;
			for(var i=0;i<size;i++){
			parent.removeChild(btns[0]);
			}
            tab.style.display="block";
        }	
		return input2;
		}
]]>
</script>
</body>
</html>

</xsl:template>
</xsl:stylesheet>