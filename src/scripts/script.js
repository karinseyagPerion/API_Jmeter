var asExpectedValue = "As Expected";
var result_table = document.getElementById('result_table');

createResultBtn("resultName");
result_table.style.display="block";
checkAgainEquals();

function checkAgainEquals(){//chech if there is values that equals with ignore case
var expectedToBe = "Value expected to be '";
var actualToBe = " but found '";
var uls = document.getElementsByClassName("resultfailureMessage");

    for (var i = 0; i < uls.length; i++) {
            var failureElements = uls[i].getElementsByTagName("li");
            for (var j = 0; j < failureElements.length; j++) {
			var currentElem = failureElements[j];
			
                var text = currentElem.innerHTML;
				if(text.substring(0,expectedToBe.length)==expectedToBe){
				var expected =text.substring(expectedToBe.length,text.indexOf("',"));
				var actual = text.substring(text.lastIndexOf(actualToBe)+actualToBe.length,text.lastIndexOf("'"));  //extract the values
				if(expected.toLowerCase()==actual.toLowerCase()){// lower case to ignore the case
				currentElem.innerHTML=asExpectedValue;
				currentElem.className = currentElem.className+"-["+text+"]";
				}
            }else{if(text==""){//if there is no text , its meem that the values are equals
			currentElem.innerHTML=asExpectedValue;
			}
			
			}
			}
}

}

function createResultBtn(className) {
    var uls = document.getElementsByClassName(className);

    for (var i = 0; i < uls.length; i++) {
        var input = document.createElement("input");
        input.value = "Click To View Results";
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
creteResultPage(testName,status,assertions_names,results);
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

function creteResultPage(testName,status,assertions_names,results){
            result_table.style.display="none";
            var body = document.getElementsByTagName("body")[0];
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
					status_resualt.style.backgroundColor="#9acd32";
					}else{
					result_result.innerHTML=innerText;
                    status_resualt.innerHTML="false";
					status_resualt.style.backgroundColor="#FF0000";
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
var btn1 = createBackBtn(result_table,table);
var btn2 = createBackBtn(result_table,table);
body.appendChild(btn1);
            body.appendChild(table);
			body.appendChild(btn2);
        }
		
		function backToDefaultPage(event,result_table,table){
		if(event.keyCode=='69'||event.keyCode=='0'){
		var parent = table.parentNode;
			parent.removeChild(table);
			var btns = document.getElementsByClassName("Back_Btn");
			var size = btns.length;
			for(var i=0;i<size;i++){
			parent.removeChild(btns[0]);
			}
            result_table.style.display="block";
			}
		}
		
function createBackBtn(result_table,table){
		var input = document.createElement("input");
		 input.className = "Back_Btn";
        input.value = "Back";
        input.type = "button";
        input.onclick = function(){
		var parent = table.parentNode;
			parent.removeChild(table);
			var btns = document.getElementsByClassName("Back_Btn");
			var size = btns.length;
			for(var i=0;i<size;i++){
			parent.removeChild(btns[0]);
			}
            result_table.style.display="block";
		};
		return input;
		}
