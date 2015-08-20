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
<th id="result_btn_header" style="text-align:left">Result</th>
<th id="json_path_assertion_name" style="text-align:left;display:none">JSON Path Assertion Name</th>
<th id="failure_message" style="text-align:left;display:none">Failure Message</th>
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
<td style="display:none" class="resultfailureMessage">
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
<script type="text/javascript" src="../../ws/src/scripts/script.js">

</script>
</body>
</html>

</xsl:template>
</xsl:stylesheet>