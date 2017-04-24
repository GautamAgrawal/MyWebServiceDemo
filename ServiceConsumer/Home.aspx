<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ServiceConsumer.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>First Number:</td>
                <td><input type="text" id="txtFirstNum" runat="server" /></td>
            </tr>
            <tr>
                <td>Second Number:</td>
                <td><input type="text" id="txtSecondNum" runat="server" /></td>
            </tr>
            <tr>
                <td><input type="button" onserverclick="AddNumber" value="Add" runat="server" /></td>
                <td id="tdSum">
                    <div id="divSum" runat="server"></div>
                    <div id="divSumThroughJson" runat="server"></div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
