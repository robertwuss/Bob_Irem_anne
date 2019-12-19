#include <XM430.h>
#include <SoftwareSerial.h>



int Val_X[] = {
  1195,
  1194,
  1195,
  1194,
  1194,
  1195,
  1195,
  1195,
  1195,
  1195,
  1195,
  1195,
  1196,
  1197,
  1197,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1198,
  1199,
  1201,
  1203,
  1207,
  1211,
  1216,
  1224,
  1234,
  1241,
  1248,
  1256,
  1269,
  1279,
  1289,
  1299,
  1307,
  1317,
  1328,
  1338,
  1350,
  1359,
  1368,
  1381,
  1395,
  1412,
  1430,
  1448,
  1467,
  1488,
  1507,
  1531,
  1557,
  1583,
  1607,
  1630,
  1656,
  1685,
  1715,
  1748,
  1780,
  1813,
  1843,
  1879,
  1907,
  1938,
  1967,
  1989,
  2008,
  2022,
  2040,
  2057,
  2077,
  2097,
  2115,
  2135,
  2148,
  2161,
  2170,
  2179,
  2188,
  2191,
  2188,
  2177,
  2160,
  2136,
  2097,
  2056,
  2014,
  1958,
  1911,
  1853,
  1789,
  1728,
  1678,
  1619,
  1564,
  1522,
  1478,
  1432,
  1397,
  1357,
  1320,
  1282,
  1250,
  1211,
  1182,
  1152,
  1125,
  1098,
  1074,
  1051,
  1029,
  1016,
  1008,
  1004,
  1001,
  997  ,
  990 ,
  982 ,
  971 ,
  960 ,
  948 ,
  940 ,
  937 ,
  936 ,
  935 ,
  935 ,
  935 ,
  935 ,
  935 ,
  936 ,
  939 ,
  945 ,
  954 ,
  962 ,
  968 ,
  971 ,
  969 ,
  968 ,
  967 ,
  967 ,
  967 ,
  966 ,
  960 ,
  951 ,
  942 ,
  929 ,
  911 ,
  892 ,
  869 ,
  845 ,
  815 ,
  780 ,
  752 ,
  719 ,
  693 ,
  676 ,
  659 ,
  645 ,
  632 ,
  622 ,
  607 ,
  591 ,
  570 ,
  549 ,
  528 ,
  507 ,
  488 ,
  470 ,
  453 ,
  439 ,
  432 ,
  430 ,
  431 ,
  435 ,
  444 ,
  455 ,
  467 ,
  478 ,
  492 ,
  505 ,
  519 ,
  536 ,
  554 ,
  579 ,
  597 ,
  616 ,
  636 ,
  656 ,
  677 ,
  703 ,
  723 ,
  749 ,
  767 ,
  790 ,
  810 ,
  832 ,
  856 ,
  880 ,
  905 ,
  925 ,
  948 ,
  968 ,
  991 ,
  1020,
  1043,
  1067,
  1091,
  1112,
  1133,
  1154,
  1176,
  1196,
  1212,
  1231,
  1248,
  1267,
  1288,
  1309,
  1330,
  1350,
  1376,
  1398,
  1424,
  1449,
  1471,
  1500,
  1521,
  1546,
  1574,
  1599,
  1622,
  1644,
  1668,
  1695,
  1717,
  1744,
  1765,
  1794,
  1820,
  1851,
  1881,
  1907,
  1939,
  1965,
  1987,
  2015,
  2037,
  2064,
  2085,
  2105,
  2122,
  2137,
  2148,
  2160,
  2170,
  2177,
  2180,
  2184,
  2186,
  2187,
  2190,
  2190,
  2190,
  2191,
  2193,
  2194,
  2195,
  2196,
  2197,
  2197,
  2197,
  2195,
  2193,
  2190,
  2185,
  2177,
  2168,
  2154,
  2143,
  2127,
  2114,
  2095,
  2080,
  2063,
  2048,
  2036,
  2028,
  2023,
  2022,
  2021,
  2020,
  2018,
  2015,
  2010,
  2002,
  1992,
  1979,
  1966,
  1954,
  1941,
  1928,
  1918,
  1908,
  1900,
  1888,
  1869,
  1852,
  1832,
  1810,
  1791,
  1768,
  1751,
  1730,
  1708,
  1680,
  1645,
  1625,
  1603,
  1583,
  1564,
  1549,
  1538,
  1521,
  1505,
  1489,
  1466,
  1443,
  1415,
  1382,
  1354,
  1330,
  1308,
  1274,
  1224,
  1172,
  1125,
  1091,
  1051,
  1019,
  994 ,
  960 ,
  925 ,
  867 ,
  810 ,
  766 ,
  736 ,
  710 ,
  684 ,
  664 ,
  649 ,
  637 ,
  627 ,
  624 ,
  625 ,
  630 ,
  639 ,
  654 ,
  677 ,
  694 ,
  702 ,
  705 ,
  701 ,
  688 ,
  676 ,
  667 ,
  660 ,
  656 ,
  656 ,
  658 ,
  658 ,
  658 ,
  659 ,
  661 ,
  669 ,
  690 ,
  717 ,
  743 ,
  777 ,
  811 ,
  854 ,
  887 ,
  929 ,
  961 ,
  980 ,
  1001,
  1033,
  1074,
  1125,
  1175,
  1213,
  1249,
  1285,
  1322,
  1346,
  1373,
  1396,
  1414,
  1436,
  1453,
  1476,
  1497,
  1511,
  1529,
  1548,
  1564,
  1585,
  1615,
  1642,
  1665,
  1686,
  1705,
  1721,
  1737,
  1750,
  1760,
  1769,
  1775,
  1775,
  1769,
  1761,
  1744,
  1719,
  1687,
  1653,
  1625,
  1583,
  1537,
  1505,
  1464,
  1415,
  1377,
  1331,
  1290,
  1262,
  1227,
  1202,
  1177,
  1154,
  1128,
  1108,
  1093,
  1079,
  1068,
  1061,
  1059,
  1060,
  1065,
  1073,
  1086,
  1110,
  1148,
  1197,
  1235,
  1281,
  1313,
  1350,
  1375,
  1411,
  1431,
  1448,
  1459,
  1459,
  1454,
  1446,
  1435,
  1426,
  1417,
  1413,
  1411,
  1411,
  1412,
  1410,
  1408,
  1407,
  1407,
  1406,
  1403,
  1398,
  1393,
  1386,
  1374,
  1355,
  1337,
  1329,
  1320,
  1307,
  1294,
  1281,
  1271,
  1266,
  1264,
  1261,
  1255,
  1250,
  1248,
  1246,
  1245,
  1243,
  1240,
  1238,
  1235,
  1233,
  1230,
  1228,
  1226,
  1224,
  1220,
  1218,
  1216,
  1214,
  1212,
  1210,
  1208,
  1206,
  1204,
  1202,
  1200,
  1198,
  1196,
  1195

};
int Val_Y[] = {
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2265,
  2264,
  2265,
  2264,
  2264,
  2264,
  2263,
  2263,
  2263,
  2263,
  2263,
  2263,
  2262,
  2261,
  2260,
  2257,
  2254,
  2250,
  2245,
  2237,
  2228,
  2218,
  2206,
  2193,
  2177,
  2160,
  2141,
  2121,
  2100,
  2078,
  2057,
  2037,
  2020,
  2008,
  1996,
  1986,
  1974,
  1963,
  1951,
  1936,
  1919,
  1901,
  1879,
  1855,
  1830,
  1805,
  1778,
  1750,
  1724,
  1699,
  1676,
  1655,
  1637,
  1619,
  1601,
  1582,
  1562,
  1542,
  1521,
  1499,
  1477,
  1457,
  1440,
  1426,
  1414,
  1405,
  1397,
  1390,
  1384,
  1378,
  1373,
  1367,
  1361,
  1353,
  1344,
  1334,
  1326,
  1317,
  1311,
  1307,
  1306,
  1307,
  1310,
  1314,
  1318,
  1324,
  1331,
  1339,
  1349,
  1361,
  1374,
  1389,
  1409,
  1429,
  1453,
  1482,
  1514,
  1550,
  1586,
  1620,
  1656,
  1693,
  1728,
  1763,
  1798,
  1834,
  1874,
  1913,
  1952,
  1990,
  2027,
  2064,
  2103,
  2138,
  2172,
  2206,
  2238,
  2268,
  2295,
  2319,
  2340,
  2357,
  2373,
  2385,
  2394,
  2398,
  2398,
  2397,
  2394,
  2387,
  2378,
  2367,
  2351,
  2332,
  2312,
  2288,
  2263,
  2236,
  2210,
  2185,
  2161,
  2138,
  2113,
  2086,
  2059,
  2030,
  2003,
  1978,
  1953,
  1933,
  1913,
  1892,
  1869,
  1847,
  1827,
  1808,
  1789,
  1771,
  1757,
  1742,
  1730,
  1716,
  1706,
  1697,
  1691,
  1682,
  1675,
  1668,
  1661,
  1653,
  1645,
  1637,
  1630,
  1621,
  1609,
  1595,
  1580,
  1562,
  1548,
  1535,
  1527,
  1525,
  1523,
  1520,
  1515,
  1508,
  1499,
  1487,
  1477,
  1468,
  1455,
  1444,
  1432,
  1423,
  1416,
  1410,
  1406,
  1404,
  1403,
  1401,
  1398,
  1395,
  1392,
  1390,
  1388,
  1386,
  1386,
  1386,
  1387,
  1389,
  1392,
  1395,
  1399,
  1403,
  1405,
  1407,
  1408,
  1407,
  1405,
  1403,
  1398,
  1396,
  1393,
  1392,
  1390,
  1390,
  1389,
  1390,
  1389,
  1390,
  1390,
  1392,
  1395,
  1399,
  1403,
  1408,
  1414,
  1420,
  1426,
  1435,
  1444,
  1454,
  1466,
  1480,
  1494,
  1511,
  1529,
  1546,
  1566,
  1586,
  1607,
  1628,
  1648,
  1668,
  1687,
  1703,
  1718,
  1730,
  1741,
  1749,
  1756,
  1763,
  1770,
  1778,
  1786,
  1795,
  1806,
  1818,
  1830,
  1847,
  1863,
  1882,
  1902,
  1924,
  1946,
  1969,
  1994,
  2018,
  2040,
  2060,
  2080,
  2095,
  2108,
  2120,
  2128,
  2137,
  2147,
  2156,
  2164,
  2173,
  2181,
  2190,
  2200,
  2210,
  2220,
  2230,
  2239,
  2250,
  2257,
  2263,
  2266,
  2270,
  2272,
  2274,
  2276,
  2277,
  2277,
  2278,
  2279,
  2281,
  2287,
  2293,
  2299,
  2307,
  2323,
  2333,
  2343,
  2354,
  2364,
  2372,
  2380,
  2387,
  2390,
  2391,
  2391,
  2389,
  2387,
  2381,
  2376,
  2371,
  2366,
  2359,
  2344,
  2331,
  2313,
  2300,
  2272,
  2245,
  2224,
  2192,
  2171,
  2135,
  2090,
  2040,
  1989,
  1938,
  1883,
  1847,
  1811,
  1755,
  1707,
  1658,
  1627,
  1603,
  1590,
  1587,
  1595,
  1623,
  1642,
  1668,
  1697,
  1746,
  1804,
  1864,
  1930,
  1995,
  2038,
  2082,
  2141,
  2201,
  2240,
  2276,
  2315,
  2368,
  2420,
  2453,
  2484,
  2517,
  2561,
  2586,
  2618,
  2644,
  2655,
  2663,
  2666,
  2665,
  2659,
  2653,
  2647,
  2642,
  2637,
  2627,
  2618,
  2602,
  2577,
  2555,
  2516,
  2486,
  2441,
  2391,
  2356,
  2301,
  2247,
  2211,
  2172,
  2117,
  2061,
  2008,
  1954,
  1901,
  1852,
  1802,
  1752,
  1718,
  1684,
  1630,
  1595,
  1542,
  1511,
  1475,
  1448,
  1433,
  1430,
  1433,
  1446,
  1463,
  1475,
  1487,
  1502,
  1512,
  1530,
  1549,
  1563,
  1583,
  1595,
  1608,
  1622,
  1644,
  1658,
  1674,
  1690,
  1705,
  1719,
  1742,
  1760,
  1776,
  1791,
  1806,
  1830,
  1858,
  1889,
  1907,
  1934,
  1950,
  1969,
  1982,
  1999,
  2012,
  2022,
  2043,
  2058,
  2082,
  2110,
  2136,
  2165,
  2193,
  2211,
  2226,
  2239,
  2249,
  2257,
  2257,
  2254,
  2248,
  2241,
  2229,
  2217,
  2207,
  2202,
  2198,
  2196,
  2195,
  2195,
  2197,
  2199,
  2203,
  2208,
  2214,
  2218,
  2223,
  2229,
  2233,
  2237,
  2238,
  2239,
  2242,
  2244,
  2246,
  2248,
  2250,
  2251,
  2252,
  2258,
  2259,
  2260,
  2261,
  2262,
  2263,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264,
  2264
};

float x;
float y;
float easing = 0.19;
float easing_time = 90;

int x_Out;
int y_Out;

int numRows = 529;



//Software Serial (RX, TX)
SoftwareSerial toRS485(11, 10);

//motorID
byte servo1 = 0x16;
byte servo2 = 0x18;

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
    gimbal.Goto(servo1, constrain (x_Out,430,2198));
    gimbal.Goto(servo2, constrain (y_Out, 1306, 2666));
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