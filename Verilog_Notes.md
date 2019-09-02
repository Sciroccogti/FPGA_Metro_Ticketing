# Verilog 学习笔记
[HDLBits](https://hdlbits.01xz.net/wiki)是一个优质的 *Verilog* 学习网站。

## 基础
### 模块
```verilog
module top_module(
    input in, in2,
    output out 
    input wire [2:0] intv);
    assign one = 1'b1; // 未定义时默认为0
    assign out = one;
endmodule
```

### 变量
#### assign 赋值
每个wire仅能assign一次
```verilog
assign a = 0;
assign b = a;
assign {c, d} = {a, b};
assign e = 3'b101; // 3个二进制
```

#### wire 变量
初值默认为0
```verilog
wire a;
wire b = a;
```

#### reg 寄存器
初值随机

#### vector 数组
数组在定义之初使用的顺序决定了此后该数组的访问方式，永远不能更改。
```verilog
wire [7:0] a,a1; // 两者长度为8，亦可作[0:2]，[3:-2]
assign b = a[1];
assign {c2, c1, c0} = a[3:1]; // 部分选中在等号两侧均可使用
assign dup = {{2{a, b, c}}, d}; // abcabcd
```
>   A note on wire vs. reg: The left-hand-side of an assign statement must be a net type (e.g., wire), while the left-hand-side of a procedural assignment (in an always block) must be a variable type (e.g., reg). These types (wire vs. reg) have nothing to do with what hardware is synthesized, and is just syntax left over from Verilog's use as a hardware simulation language.
### 运算符
#### 按位
非：`~`
与：`&`
或：`|`
异或：`^`

#### 算数
非零为真，零为假。将数组看作一个整体。
非：`!`
与：`&&`
或：`||`

## 模块进阶
```verilog
module mod_a ( input in1, input in2, output out );
    // Module body
endmodule
```

### 子模块 自顶向下
连接模块时只需关注接口。构建模块层次时需要在模块中实例化另一个模块，但不是在当前模块中实现。

将wire连接到接口有两种方法：
1.  通过位置
    *   ```mod_a instance1 (wa, wb, wc);```类似新建类
2.  通过名字
    *   ```mod_a instance2 (.out(wc), .in1(wa), .in2(wb));```加`.`就是通过名字

参数可以留空，譬如有三个参数的，第三个可以不写，也无需逗号。

![](https://hdlbits.01xz.net/mw/images/c/c0/Module.png)

## 步骤
always，initial，task，function

步骤内的赋值不得加`assign`，步骤外的赋值则必须加。

### always
```verilog
assign out1 = a & b | c ^ d;
always @(*) out2 = a & b | c ^ d; // 两者等价
```

`always @(*)`即刻触发

`always @(posedge clk)`上升沿触发

*always* 中不得实例化模块，请转用*generate*。

### for
```verilog
always @(*)
begin
for (int i = 0; i < 8; i++)
    out[i] = in[8 - i -1];
end
```

### if
```verilog
always @(sel or a or b)
begin
  if (sel == 1)
    f = a;
  else
    f = b;
end
```

### case
```verilog
always @(*)
    case(sel)
        2'h0: q = d;
        2'h1: q = o1;
        2'h2: q = o2;
        2'h3: q = o3;
        2'h4, 2'h5: q = o4;
        default: q = 0;
    endcase
```

### casez
*casez*中，`z`用于匹配任意值。例如`2'bz1`匹配`01,11`。

同理，*casex*亦然。

其中，`c`也能在*casex*、*casez*中用于替换`z`、`x`。

### generate
```verilog
    generate
        genvar i;
        for (i = 1; i < 100; i++) begin : add // add是本block名字
            myadd inst1 (a[i], b[i], cout[i - 1], cout[i], sum[i]);
        end
    endgenerate
```

## 其它特性
### 条件运算符`?`
```verilog
condition ? if_true : if_false
```

### 简写运算符
```verilog
& a[3:0]     // AND: a[3]&a[2]&a[1]&a[0]. Equivalent to (a[3:0] == 4'hf)
| b[3:0]     // OR:  b[3]|b[2]|b[1]|b[0]. Equivalent to (b[3:0] != 4'h0)
^ c[2:0]     // XOR: c[2]^c[1]^c[0]
```

## 常见错误
### 闩锁

