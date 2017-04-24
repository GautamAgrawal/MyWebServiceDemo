<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyWebServiceDemoConsumer._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
            <Services>
                <asp:ServiceReference Path="http://localhost/WebServiceForBlog/MyService.asmx" />
            </Services>
        </asp:ScriptManager>
        <div>
            <table>
                <tr>
                    <td>First Number:
                    </td>
                    <td>
                        <input type="text" id="txtFirstNum" />
                    </td>
                </tr>
                <tr>
                    <td>Second Number:
                    </td>
                    <td>
                        <input type="text" id="txtSecondNum" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" onclick="AddNumber();" value="Add" />
                    </td>
                    <td id="tdSum">
                        <div id="divSum1"></div>
                        <div id="divSum2"></div>
                        <div id="divSum3"></div>
                        <div id="divSum4"></div>
                        <div id="divSum5"></div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script type="text/javascript" src="Scripts/jquery-1.7.1.js"></script>
    <script type="text/javascript" src="Scripts/json2.js"></script>
    <script type="text/javascript">
        function AddNumber() {
            var FirstNum = $('#txtFirstNum').val();
            var SecondNum = $('#txtSecondNum').val();

            $.ajax({
                type: "POST",
                url: "http://localhost/WebServiceForBlog/MyService.asmx/SumOfNums",
                data: "First=" + FirstNum + "&Second=" + SecondNum, // the data in form-encoded format, it would appear on a querystring
                //contentType: "application/x-www-form-urlencoded; charset=UTF-8", // form encoding is by default so you don't need to supply it
                dataType: "text",
                crossDomain: true,
                success: function (data) {
                    $('#divSum1').html(data);
                }
            });

            // i/p in JSON format, response as JSON object
            $.ajax({
                type: "POST",
                url: "http://localhost/WebServiceForBlog/MyService.asmx/SumOfNums",
                data: "{First:" + FirstNum + ",Second:" + SecondNum + "}",
                contentType: "application/json; charset=utf-8",// What I am passing
                dataType: "json", // What I am expecting
                crossDomain: true,
                success: function (data) {
                    $('#divSum2').html(data.d);
                }
            });

            // i/p as JSON object, response as plain text
            $.ajax({
                type: "POST",
                url: "http://localhost/WebServiceForBlog/MyService.asmx/SumOfNums",
                data: { First: FirstNum, Second: SecondNum },
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                crossDomain: true,
                dataType: "text",
                success: function (data) {
                    $("#divSum3").html(data);
                }
            });

            // I/p parameters are passed as stringified json object
            var ObjSum = new Object();
            ObjSum.First = FirstNum;
            ObjSum.Second = SecondNum;

            $.ajax({
                type: "POST",
                url: "http://localhost/WebServiceForBlog/MyService.asmx/GetSumThroughObject",
                data: "JsonStr=" + JSON.stringify(ObjSum),
                dataType: "text",
                crossDomain: true,
                success: function (data) {
                    $('#divSum4').html($(data).find('Sum').text());
                }
            });

            // directly making SOAP-XML request
            // Copy the SOAP envelop from test page & replace placeholders(data types) with actual value
            var SoapMessage = '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> \
                                      <soap:Body> \
                                        <SumOfNums xmlns="http://tempuri.org/"> \
                                          <First>'+ FirstNum + '</First> \
                                          <Second>'+ SecondNum + '</Second> \
                                        </SumOfNums> \
                                      </soap:Body> \
                                    </soap:Envelope>';
            $.ajax({
                url: "http://localhost/WebServiceForBlog/MyService.asmx?op=SumOfNums",
                type: "POST",
                dataType: "xml",
                data: SoapMessage,
                complete: ShowResult,
                contentType: "text/xml; charset=utf-8"
            });


        }
        function ShowResult(xmlHttpRequest, status) {
            var SoapResponse = $(xmlHttpRequest.responseXML).find('SumOfNumsResult').text();
            $('#divSum5').html(SoapResponse);
        }
    </script>
</body>
</html>

