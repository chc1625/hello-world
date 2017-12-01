获取字符串长度
string="abcd"
echo ${#string} #输出 4
提取子字符串
以下实例从字符串第 2 个字符开始截取 4 个字符：

string="runoob is a great site"
echo ${string:1:4} # 输出 unoo
查找子字符串
查找字符 "i 或 s" 的位置：

string="runoob is a great company"
echo `expr index "$string" is`  # 输出 8

使用@符号可以获取数组中的所有元素，例如：

echo ${array_name[@]}


# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}

