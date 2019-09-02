# FPGA_Metro_Ticketing
本项目选用*Verilog* 语言，借助 *Vivado 2019.1* 在 *NEXYS4* 上实现

## 设计要求
### 基本功能
尝试模拟南京地铁售票系统
1.  分硬币，纸币（5，10，20）；
2.  自行编码进行站点设置，共四条线；
3.  通过案件设置4条线中任意一站为当前站；
4.  两种选票方式：
    1.  乘客已知所需费用，直接选择票价；
    2.  乘客通过选定出站点，确定票价；
    选择票数，显示购票信息；
5.  投币完成后出票并一次性找零；
6.  投币期间可按取消键一次性退出钱币。

### 附加功能
1.  如何区分硬币、纸币；
2.  显示的多样性和直观；
3.  找零是否有找零原则。

## 项目设计
- [ ] 使用VGA显示南京市地铁线路图（仅限1、2、3、4号线）
- [ ] 建立地铁线路数学模型
- [ ] 建立最优路径选择系统
- [ ] 建立站点选择系统

## 项目建立
[Vivado 与 NEXYS4 初级教程](https://www.instructables.com/id/Simple-Logic-Design-w-Digilent-Nexys-4-Field-Progr/?_ga=2.251523534.955351035.1566793875-532926585.1566119725)

## 参考项目
*   [东南大学信息学院大三短学期FPGA课程设计——售货机](https://github.com/Quzard/FPGA_Vending_Machine)
*   [官方例程1：音乐循环者？](https://github.com/Digilent/Nexys-4-DDR-Music-Looper)
*   [官方例程2：传感器](https://github.com/Digilent/Nexys-4-DDR-XADC)
*   [官方例程3：键盘](https://github.com/Digilent/Nexys-4-DDR-Keyboard)
