# Use it to generate feedback as well
import pandas as pd
import numpy as np
import random
import datetime 
df = pd.DataFrame(columns = ['Id','Text','Status','Filed_date_time','Handled_date_time','EMPLOYEESID','USERID'])
text = ['Horrible Service.','Faulty Product.','Slow delivery','Bad shop','Bad packet', 'Rude delivery man'
'Seal broken','Bad product','Broken product','Charged extra','Delivery man broke the pack',
'Delivery man broke the pack, did not get package', 'Too late for delivery',
'Your company is a joke. Useless people in management. Bad experience']

for i in range(1,120):
    complaint = random.choice(text)
    employee = random.randint(1,7)
    user = random.randint(40,47)
    filed_dd, filed_yy , filed_hh, filed_min = 1+i//10, 2019, random.randint(10,21), random.randint(10,50)
    filed_mm = 12
    filed_date = f"{filed_mm}-{filed_dd}-{filed_yy} {filed_hh}:{filed_min}:00.000"
    handled_dd, handled_yy , handled_hh, handled_min = filed_dd +random.randint(1,5), 2019, random.randint(10,21), random.randint(10,50)
    handled_mm = filed_mm
    handled_date = f"{handled_mm}-{handled_dd}-{handled_yy} {handled_hh}:{handled_min}:00.000"
    df.loc[i] = [i]+[complaint,"addressed",filed_date,handled_date,employee,user]
    arr = [i]+[complaint,"addressed",filed_date,handled_date,employee,user]

    print (f"({arr[0]},'{str(arr[1])}','{str(arr[2])}','{str(arr[3])}','{str(arr[4])}',{arr[5]},{arr[6]}),")
    #print(tuple(['comp'+str(i)]+[complaint,"addressed",filed_date,handled_date,employee,user]))

for i in range(1,30):
    complaint = random.choice(text)
    employee = random.randint(1,10)
    user = random.randint(40,50)
    filed_dd, filed_yy , filed_hh, filed_min = i//10 + 1, 2020, random.randint(10,21), random.randint(10,50)
    filed_mm = 1
    filed_date = f"{filed_mm}-{filed_dd}-{filed_yy} {filed_hh}:{filed_min}:00.000"
    df.loc[119+i] = [119+i]+[complaint,"pending",filed_date,"NULL",employee,user]
    arr = [119+i]+[complaint,"pending",filed_date,"NULL",employee,user]
    print (f"({arr[0]},'{str(arr[1])}','{str(arr[2])}','{str(arr[3])}',{str(arr[4])},{arr[5]},{arr[6]}),")
    #print(tuple(['comp'+str(119+i)]+[complaint,"pending",filed_date,"NULL",employee,user]))