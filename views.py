import string
from django.contrib import messages
from django.shortcuts import render,redirect
from .models import *
from django.conf import settings
from admins.models import *
from audit.models import *
from bank.models import *
import random,hmac
import PyPDF2
from hashlib import *


# Create your views here.
def home(request):
    return render(request,'user/home.html')

def bankuser(request):
    return render(request, 'user/bank/bank.html')

def audituser(request):
    return render(request, 'user/audit/audit.html')

def login(request,login):
    if request.method =='POST':
        if login == 'login':
            try:
                email = request.POST['email']
                password = request.POST['password']
                area = request.POST['area']
                detail=user.objects.get(email=email,password=password,area=area)
                if area == 'BANK':
                    request.session['user']=detail.userid
                    messages.success(request, "SUCCESSFULLY LOGGED IN AS BANK USER")
                    return redirect('/bankuser')
                else:
                    request.session['user'] = detail.userid
                    messages.success(request, "SUCCESSFULLY LOGGED IN AS AUDIT USER")
                    return redirect('/audituser')
            except:
                messages.success(request, "INVALID EMAIL ID OR PASSWORD")
                return redirect('/login/login')
        else:
            name= request.POST['name']
            email = request.POST['email']
            password = request.POST['password']
            area = request.POST['area']
            userid=''
            for i in range(5):
                userid+=str(random.randint(0,9))
            useraccess(name=name,email=email,password=password,area=area,userid=userid).save()
            messages.success(request, "DETAIL HAS BEEN REGISTERED SUCCESSFULLY")
            return redirect('/')
    return render(request,'user/login.html',{'login':login})

def auditfiletable(request):
    users=user.objects.get(userid=request.session['user'])
    lists=requiredlist.objects.filter(userid=request.session['user']).values('requestid').distinct()
    return render(request,'user/audit/auditfiletable.html',{'list':lists,'u':users})

def auditfile(request,requestid):
    lists=requiredlist.objects.filter(requestid=requestid)
    return render(request, 'user/audit/auditfile.html', {'list': lists,'requestid':requestid})

def typeview(request):
    req = requirements.objects.all().order_by('type')
    return render(request,'user/audit/typeview.html', {'list': req})

def upload(request,requestid):
    if request.method== 'POST':
        lists = requiredlist.objects.filter(userid=request.session['user'],requestid=requestid)
        for i in lists:
            file=request.FILES[f'{i.list}']
            ac = requiredlist.objects.get(userid=request.session['user'], list=i.list)
            ac.file = file
            ac.save()
            #name=request.FILES[f'{i.list}'].name
            print(ac.file)
            files = open(f'{settings.MEDIA_ROOT}/{ac.file}', 'rb')
            pdfReader = PyPDF2.PdfFileReader(files)
            r = pdfReader.numPages
            data = ''
            for p in range(r):
                data += pdfReader.getPage(p).extractText()
            length = len(data) // 4
            f1 = 0
            f2 = length
            initial = ''
            for j in range(4):
                data1 = data[f1:f2]
                f3 = length
                ran = ''
                for k in range(5):
                    ran += str(random.randint(0, 9))
                if j==0:
                    ac.key = ran
                    ac.save()
                    d = hmac.new(ran.encode(), data1.encode(), sha512).hexdigest()
                    node1(key=ran,hashvalue=d,filename=i.list).save()
                    initial=d
                elif j==1:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node2(key=initial, hashvalue=d, filename=i.list).save()
                    initial = d
                elif j==2:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node3(key=initial, hashvalue=d, filename=i.list).save()
                    initial = d
                elif j==3:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node4(key=initial, hashvalue=d, filename=i.list).save()
                    initial = d
                f1 += f3
                f2 += f3
    messages.success(request, "DOCUMENTS ARE UPLOADED SUCCESSFULLY")
    return redirect('/auditfile')

def create(request):
    if request.method=='POST':
        userid = request.session['user']
        name=request.POST['name']
        fname = request.POST['fname']
        street= request.POST['street']
        place= request.POST['place']
        country=request.POST['country']
        code = request.POST['code']
        phone= request.POST['phone']
        email= request.POST['email']
        address=f'{street}, {place}, {country}, {code}'
        aadhaar=request.FILES['aadhaar']
        pan = request.FILES['pan']
        photo = request.FILES['photo']
        ada = ''.join(random.sample(string.digits, k=5))
        bankaccount(userid=request.session['user'],name=name,fathername=fname,email=email,uploadid=ada,contact=phone,address=address,aadhaar=aadhaar,pancard=pan,photo=photo).save()
        ac=bankaccount.objects.get(uploadid=ada)
        li=[ac.aadhaar,ac.pancard,ac.photo]
        list2=[f'{userid} AADHAAR',f'{userid} PAN',f'{userid} PHOTO',]
        for i in range(3):
            files = open(f'{settings.MEDIA_ROOT}/{li[i]}', 'rb')
            pdfReader = PyPDF2.PdfFileReader(files)
            r = pdfReader.numPages
            data = ''
            for p in range(r):
                data += pdfReader.getPage(p).extractText()
            length = len(data) // 4
            f1 = 0
            f2 = length
            initial = ''
            for j in range(4):
                data1 = data[f1:f2]
                f3 = length
                ran = ''
                for k in range(5):
                    ran += str(random.randint(0, 9))
                if j == 0:
                    if i==0:
                        ac.aadhaarkey=ran
                    elif i==1:
                        ac.pancardkey = ran
                    else:
                        ac.photokey=ran
                    ac.save()
                    d = hmac.new(ran.encode(), data1.encode(), sha512).hexdigest()
                    node1(key=ran, hashvalue=d, filename=list2[i]).save()
                    initial = d
                elif j == 1:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node2(key=initial, hashvalue=d, filename=list2[i]).save()
                    initial = d
                elif j == 2:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node3(key=initial, hashvalue=d, filename=list2[i]).save()
                    initial = d
                elif j == 3:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node4(key=initial, hashvalue=d, filename=list2[i]).save()
                    initial = d
                f1 += f3
                f2 += f3
        messages.success(request, "DOCUMENTS ARE UPLOADED SUCCESSFULLY")
    return render(request,'user/bank/create.html')

def status(request):
    stat=user.objects.get(userid=request.session['user'])
    return render(request,'user/bank/status.html',{'status':stat})

def schemes(request):
    l=scheme.objects.all()
    k = schemeupload.objects.all()
    list = []
    dic = {'name': [], 'definition': [], 'documentneeded': [], 'status': []}
    for i in range(len(l)):
        dic = {}
        dic['name'] = l[i].name
        dic['definition'] = l[i].definition
        dic['documentneeded'] = l[i].documentneeded
        dic['status'] = 0
        for j in k:
            print(l[i].name == j.schemename)
            print(j.userid,str(request.session['user']))
            if l[i].name == j.schemename and j.userid == str(request.session['user']):
                dic['status'] = 1
        list.append(dic)
    return render(request,'user/bank/scheme.html',{'scheme':list})

def uploadscheme(request,scheme):
    if request.method == 'POST':
        schemename =scheme
        userid=request.session['user']
        name = request.POST['name']
        email = request.POST['email']
        dob = request.POST['dob']
        number = request.POST['number']
        patta = request.FILES['patta']
        chitta = request.FILES['chitta']
        ada = ''.join(random.sample(string.digits, k=5))
        schemeupload(schemename=schemename,name=name,email=email,dob=dob,contact=number,uploadid=ada,patta=patta,chitta=chitta,userid=request.session['user']).save()
        ac = schemeupload.objects.get(uploadid=ada)
        li = [ac.patta, ac.chitta]
        list2 = [f'{userid} PATTA', f'{userid} CHITTA' ]
        for i in range(2):
            files = open(f'{settings.MEDIA_ROOT}/{li[i]}', 'rb')
            pdfReader = PyPDF2.PdfFileReader(files)
            r = pdfReader.numPages
            data = ''
            for p in range(r):
                data += pdfReader.getPage(p).extractText()
            length = len(data) // 4
            f1 = 0
            f2 = length
            initial = ''
            for j in range(4):
                data1 = data[f1:f2]
                f3 = length
                ran = ''
                for k in range(5):
                    ran += str(random.randint(0, 9))
                if j == 0:
                    if i==0:
                        ac.pattakey=ran
                    else:
                        ac.chittakey=ran
                    ac.save()
                    d = hmac.new(ran.encode(), data1.encode(), sha512).hexdigest()
                    node1(key=ran, hashvalue=d, filename=list2[i]).save()
                    initial = d
                elif j == 1:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node2(key=initial, hashvalue=d, filename=list2[i]).save()
                    initial = d
                elif j == 2:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node3(key=initial, hashvalue=d, filename=list2[i]).save()
                    initial = d
                elif j == 3:
                    d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                    node4(key=initial, hashvalue=d, filename=list2[i]).save()
                    initial = d
                f1 += f3
                f2 += f3
        messages.success(request, "DOCUMENTS ARE UPLOADED SUCCESSFULLY")
    return render(request,'user/bank/schemeupload.html',{'scheme':scheme})

def loans(request):
    l=loan.objects.all()
    k=loanupload.objects.all()
    list=[]
    dic={'type':[],'definition':[],'needfilename':[],'status':[]}
    for i in range(len(l)):
        dic={}
        dic['type']=l[i].type
        dic['definition']=l[i].definition
        dic['needfilename']=l[i].needfilename
        dic['status']=0
        for j in k:
            if l[i].needfilename == j.loantype and j.userid==str(request.session['user']):
                dic['status']=1
        list.append(dic)
    return render(request,'user/bank/loan.html',{'loan':l,'dic':list})

def uploadloan(request,loan):
    if request.method == 'POST':
        userid = request.session['user']
        name = request.POST['name']
        email = request.POST['email']
        dob = request.POST['dob']
        number = request.POST['number']
        document = request.FILES['doc']
        ada = ''.join(random.sample(string.digits, k=5))
        loanupload(loantype=loan,name=name,email=email,dob=dob,contact=number,uploadid=ada,document=document,userid=request.session['user']).save()
        ac = loanupload.objects.get(uploadid=ada)
        li = ac.document
        list2 = f'{userid} {ac.loantype}'
        files = open(f'{settings.MEDIA_ROOT}/{li}', 'rb')
        pdfReader = PyPDF2.PdfFileReader(files)
        r = pdfReader.numPages
        data = ''
        for p in range(r):
            data += pdfReader.getPage(p).extractText()
        length = len(data) // 4
        f1 = 0
        f2 = length
        initial = ''
        for j in range(4):
            data1 = data[f1:f2]
            f3 = length
            ran = ''
            for k in range(5):
                ran += str(random.randint(0, 9))
            if j == 0:
                ac.key = ran
                ac.save()
                d = hmac.new(ran.encode(), data1.encode(), sha512).hexdigest()
                node1(key=ran, hashvalue=d, filename=list2).save()
                initial = d
            elif j == 1:
                d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                node2(key=initial, hashvalue=d, filename=list2).save()
                initial = d
            elif j == 2:
                d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                node3(key=initial, hashvalue=d, filename=list2).save()
                initial = d
            elif j == 3:
                d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                node4(key=initial, hashvalue=d, filename=list2).save()
                initial = d
            f1 += f3
            f2 += f3
        messages.success(request, "DOCUMENTS ARE UPLOADED SUCCESSFULLY")
    return render(request,'user/bank/loanupload.html',{'loan':loan})

def logout(request):
    del request.session['user']
    messages.success(request, "SUCCESSFULLY LOGGED OUT")
    return redirect('/')