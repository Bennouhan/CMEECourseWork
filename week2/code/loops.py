
"""Examples of for and while loops"""


# FOR loops in Python
for i in range(5):
    print(i)

my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)
#k could be anything; for thing in my list print thing, l in list print l
#for implicit loop, can be anything. more complex with functions
total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)

# WHILE loops  in Python
z = 0
while z < 100:
    z = z + 1
    print(z)

# b = True
# while b:
#     print("GERONIMO! infinite loop! ctrl+c to stop!")
#was annoying