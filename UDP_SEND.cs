using System.Collections;
using UnityEngine;
using System;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Threading;




public class UDPServer : MonoBehaviour
{
    private static int localPort;

    private string IP;
    int port;
    IPEndPoint remoteEndPoint;

    UdpClient client;
    string strMessage = " ";
    PrintGazePosition gaze;
    GameObject gazeGameObject;

    private static void Main()
    {
        UDPServer sendObj = new UDPServer();
        sendObj.init();
        sendObj.sendEndless("  endless infos \n");
    }


    public void Start()
    {
        init();
        gazeGameObject = GameObject.Find("GazePlot");
        gaze = gazeGameObject.transform.GetComponent<PrintGazePosition>();
    }

    //private QRotation ValToArduino;

    void Update()
    {
        strMessage = gaze.xCoord.text + "," + gaze.yCoord.text; // if this doesnt work try     gaze.xCoord.ToString(); and in processing you have to divide the value by ","
        sendString(strMessage);
        Debug.Log("Sending value  " + strMessage);
    }


    public void init()
    {
        print("UDPSend.init()");

        // Your IP Adress and the Port Number
        IP = "127.0.0.1"; // 1 model
        port = 8888;


        remoteEndPoint = new IPEndPoint(IPAddress.Parse(IP), port);
        client = new UdpClient();

        print("Sending to " + IP + "  :  " + port);
        print("Testing:  nc -lu " + IP + " : " + port);
    }

    private void inputFromConsole()
    {
        try
        {
            string text;
            do
            {
                text = Console.ReadLine();


                if (text != " ")
                {
                    byte[] data = Encoding.UTF8.GetBytes(text);

                    client.Send(data, data.Length, remoteEndPoint);
                }
            } while (text != " ");
        }
        catch (Exception err)
        {
            print(err.ToString());
        }
    }

    private void sendString(string message)
    {
        try
        {
            byte[] data = Encoding.UTF8.GetBytes(message);

            client.Send(data, data.Length, remoteEndPoint);
        }
        catch (Exception err)
        {
            print(err.ToString());
        }
    }


    private void sendEndless(string testStr)
    {
        do
        {
            sendString(testStr);
        } while (true);
    }
}
