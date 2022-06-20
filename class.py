str='1\n2\n3\n4\n5\n3'
y=3
f=str.splitlines()
h=[int(i) for i in f]
incentive=0
k=y
for i in range(len(str)-y-1):
    try:
        po=h[k-y:k]
        if len(po)%2==0:
            mid=(len(po) / 2) -1
            midvalue=po[int(mid)]
            if midvalue<po[-1]:
                incentive+=1
        else:
            mid = (len(po) / 2) - 0.5
            print(po[int(mid)])
            midvalue = po[int(mid)]
            if midvalue < po[-1]:
                incentive += 1
        k+=1
    except:
        break

print("INCENTIVE IS",incentive)