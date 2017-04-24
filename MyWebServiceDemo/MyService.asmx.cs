using System.Web.Script.Serialization;
using System.Web.Services;

namespace MyWebServiceDemo
{
    // Use "Namespace" attribute with an unique name, to make service uniquely discoverable
    [WebService(Namespace = "http://tempuri.org/")]
    // To indicate service confirms to "WsiProfiles.BasicProfile1_1" standard, 
    // if not, it will throw compile time error
    [WebServiceBinding(ConformsTo = WsiProfiles.None)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class MyService : WebService
    {
        // Takes 2 int values & returns their summation
        [WebMethod]
        public int SumOfNums(int First, int Second)
        {
            return First + Second;
        }

        // Takes a stringified Json object & returns an object of SumClass
        [WebMethod(MessageName = "GetSumThroughObject")]
        public SumClass SumOfNums(string JsonStr)
        {
            var ObjSerializer = new JavaScriptSerializer();
            var ObjSumClass = ObjSerializer.Deserialize<SumClass>(JsonStr);
            return new SumClass().GetSumClass(ObjSumClass.First, ObjSumClass.Second);
        }
    }

    /// <summary>
    /// Normal class, an instance of which will be returned by service
    /// </summary>
    public class SumClass
    {
        public int First, Second, Sum;

        public SumClass GetSumClass(int Num1, int Num2)
        {
            var ObjSum = new SumClass
            {
                Sum = Num1 + Num2,
            };
            return ObjSum;
        }
    }
}
