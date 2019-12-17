#include <XM430.h>
#include <SoftwareSerial.h>



int Val_X[] = {
  999  ,
999 ,
999 ,
999 ,
999 ,
999 ,
999 ,
999 ,
999 ,
999 ,
999 ,
999 ,
1000,
1005,
1010,
1015,
1020,
1025,
1025,
1025,
1025,
1025,
1001,
1000,
1000,
1000,
990 ,
990 ,
990 ,
1001,
1001,
1010 ,
1020,
1020 ,
1020 ,
1030 ,
1050 ,
1060 ,
1070 ,
1080 ,
1090 ,
1100 ,
1100 ,
1120 ,
1120 ,
1120 ,
1120 ,
1100 ,
1090 ,
1080 ,
1070 ,
1060 ,
1050,
1040 ,
1030,
1020,
1000 ,
1000,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
995 ,
994 ,
995 ,
995 ,
994 ,
994 ,
994 ,
994 ,
994 ,
994 ,
995 ,
996 ,
996 ,
997 ,
996 ,
997 ,
997 ,
997 ,
997 ,
996 ,
996 ,
996 ,
997 ,
996 ,
996 ,
997 ,
996 ,
996 ,
996 ,
996 ,
996 ,
997 ,
997 ,
997 ,
997 ,
997 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
996 ,
1000 ,
1010,
1010,
1020 ,
1030 ,
1020 ,
1020,
1010 ,
1010 ,
1010,
1000 ,
1000 ,
1000 ,
995 ,
995 ,
996 ,
997 ,
998 ,
999 
};
int Val_Y[] = {
  2080,
2077,
2072,
2068,
2061,
2056,
2049,
2038,
2025,
2007,
1985,
1935,
1896,
1854,
1821,
1790,
1758,
1727,
1696,
1667,
1640,
1615,
1590,
1568,
1545,
1522,
1497,
1475,
1453,
1433,
1416,
1389,
1377,
1370,
1365,
1360,
1357,
1358,
1361,
1371,
1381,
1396,
1412,
1430,
1450,
1471,
1493,
1518,
1543,
1568,
1594,
1622,
1651,
1678,
1705,
1731,
1756,
1780,
1803,
1827,
1848,
1868,
1887,
1924,
1937,
1941,
1941,
1936,
1925,
1908,
1886,
1862,
1835,
1804,
1774,
1743,
1714,
1686,
1659,
1632,
1607,
1583,
1560,
1539,
1521,
1502,
1487,
1471,
1457,
1443,
1427,
1410,
1393,
1376,
1361,
1346,
1334,
1324,
1318,
1319,
1323,
1335,
1351,
1371,
1393,
1421,
1451,
1483,
1517,
1551,
1583,
1614,
1642,
1669,
1695,
1717,
1738,
1758,
1779,
1801,
1823,
1874,
1902,
1920,
1933,
1941,
1945,
1949,
1958,
1969,
1983,
1998,
2014,
2030,
2047,
2065,
2082,
2100,
2116,
2131,
2145,
2158,
2167,
2172,
2173,
2170,
2167,
2150,
2140,
2130,
2120,
2110,
2100,
2090,
2085,
2080,
2080,
2080,
2080,
2080,
2080,
2080
};

float x;
float y;
float easing = 0.19;
float easing_time = 90;

int x_Out;
int y_Out;

int numRows = 162;



//Software Serial (RX, TX)
SoftwareSerial toRS485(11, 10);

//motorID
byte servo1 = 0x17;
byte servo2 = 0x15;

XM430 gimbal(&toRS485);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //Start the Serial communication: One for the Nano communication, and the other for the RS485
  
  gimbal.BeginRS485(1000000);
  //Enable Torque, without this function the motors will not move.
  gimbal.TorqueEnable(servo1, ON);
  gimbal.TorqueEnable(servo2, ON);


}

void loop() {
  x = Val_X[0];
  y = Val_Y[0];


  for (int i = 0; i < numRows; i++) {
    //eases data to write to servo
    float targetX = Val_X[i];
    float dx = targetX - x;
    x += dx * easing;
    x_Out = round(x);


    float targetY = Val_Y[i];
    float dy = targetY - y;
    y += dy * easing;
    y_Out = round(y);

    Serial.println (y_Out);
    gimbal.Goto(servo1, constrain (x_Out, 950, 1060));
    gimbal.Goto(servo2, constrain (y_Out, 1300, 2128));
    delay(1);
  }


  //  int  x_diff =  Val_X[0] - Val_X[numRows];
  //  int  y_diff =  Val_Y[0] - Val_Y[numRows];
  //
  //  for (int i = 0; i < easing_time; i++)
  //  {
  //    x_Out = Val_X[numRows] + (x_diff * (i / easing_time));
  //    y_Out = Val_Y[numRows] + (y_diff * (i / easing_time));
  //    gimbal.Goto(servo1, x_Out);
  //    gimbal.Goto(servo2, y_Out);
  //  }
  //
  //  x_Out = Val_X[0];
  //  y_Out = Val_Y[0];


}
